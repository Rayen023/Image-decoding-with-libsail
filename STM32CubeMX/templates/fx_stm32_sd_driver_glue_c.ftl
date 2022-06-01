[#ftl]
[#compress]

[#assign  glue_api = "HAL_API_DMA"]
[#assign  txrx_cmplt = "TxSem"]
[#assign  is_stand = 1]
[#assign  mx_sd_init = "void MX_SDIO_SD_Init(void)"]
[#assign  mx_sd_type = "hsd"]

[#if RTEdatas??]
  [#list RTEdatas as define]
    [#if define?contains("THREADX_ENABLED")]
      [#assign is_stand = 0]
    [/#if]
  [/#list]
[/#if]

[#-- Standalone mode support is dropped for now, --]
[#-- following instruction to be remove once support is restored --]
[#assign  is_stand = 0]

[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "FX_SD_GLUE_FUNCTION_IMPLEMENTATION"]
      [#assign glue_api = value]
    [/#if]

    [#if name == "FX_SD_TRANSFER_CMPLT_NOTIF"]
      [#assign txrx_cmplt = value]
    [/#if]

  [/#list]
[/#if]
[/#list]

[#if FamilyName?lower_case == "stm32f4"]
[#assign mx_sd_init = "MX_SDIO_SD_Init"]
[#assign mx_sd_type = "hsd"]
[/#if]
[#if FamilyName?lower_case == "stm32h7"]
[#assign mx_sd_init = "MX_SDMMC1_SD_Init"]
[#assign mx_sd_type = "hsd1"]
[/#if]
[/#compress]
/**************************************************************************/
/*                                                                        */
/*       Copyright (c) Microsoft Corporation. All rights reserved.        */
/*                                                                        */
/*       This software is licensed under the Microsoft Software License   */
/*       Terms for Microsoft Azure RTOS. Full text of the license can be  */
/*       found in the LICENSE file at https://aka.ms/AzureRTOS_EULA       */
/*       and in the root directory of this software.                      */
/*                                                                        */
/**************************************************************************/

#include "fx_stm32_sd_driver.h"

[#if txrx_cmplt != "Custom"]
  [#if is_stand == 0 && txrx_cmplt == "TxSem"]
[#if glue_api == "Custom"]
/* The following semaphore need to be released in the user's custom transfer completion callbacks */
[/#if]
TX_SEMAPHORE transfer_semaphore;
  [#else]
__IO UINT read_transfer_completed;
__IO UINT write_transfer_completed;
  [/#if]
[/#if]

[#if glue_api != "Custom"]
extern SD_HandleTypeDef ${mx_sd_type};
extern void ${mx_sd_init}(void);
[/#if]

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
* @brief Initializes the SD IP instance
* @param UINT instance SD instance to initialize
* @retval 0 on success error value otherwise
*/
INT fx_stm32_sd_init(UINT instance)
{
  INT ret = 0;

[#if glue_api == "Custom"]
  /* USER CODE BEGIN FX_SD_INIT */

  /* USER CODE END FX_SD_INIT */
[#else]
  /* USER CODE BEGIN PRE_FX_SD_INIT */
  UNUSED(instance);
  /* USER CODE END PRE_FX_SD_INIT */

#if (FX_STM32_SD_INIT == 1)
  ${mx_sd_init}();
#endif

  /* USER CODE BEGIN POST_FX_SD_INIT */

  /* USER CODE END POST_FX_SD_INIT */
[/#if]

  return ret;
}

/**
* @brief Deinitializes the SD IP instance
* @param UINT instance SD instance to deinitialize
* @retval 0 on success error value otherwise
*/
INT fx_stm32_sd_deinit(UINT instance)
{
  INT ret = 0;

[#if glue_api == "Custom"]
  /* USER CODE BEGIN FX_SD_DEINIT */

  /* USER CODE END FX_SD_DEINIT */
[#else]
  /* USER CODE BEGIN PRE_FX_SD_DEINIT */
  UNUSED(instance);
  /* USER CODE END PRE_FX_SD_DEINIT */

  if(HAL_SD_DeInit(&${mx_sd_type}) != HAL_OK)
  {
    ret = 1;
  }

  /* USER CODE BEGIN POST_FX_SD_DEINIT */

  /* USER CODE END POST_FX_SD_DEINIT */
[/#if]

  return ret;
}

/**
* @brief Check the SD IP status.
* @param UINT instance SD instance to check
* @retval 0 when ready 1 when busy
*/
INT fx_stm32_sd_get_status(UINT instance)
{
  INT ret = 0;

[#if glue_api == "Custom"]
  /* USER CODE BEGIN GET_STATUS */

  /* USER CODE END GET_STATUS */
[#else]
  /* USER CODE BEGIN PRE_GET_STATUS */
  UNUSED(instance);
  /* USER CODE END PRE_GET_STATUS */

  if(HAL_SD_GetCardState(&${mx_sd_type}) != HAL_SD_CARD_TRANSFER)
  {
    ret = 1;
  }

  /* USER CODE BEGIN POST_GET_STATUS */

  /* USER CODE END POST_GET_STATUS */
[/#if]

  return ret;
}

/**
* @brief Read Data from the SD device into a buffer.
* @param UINT instance SD IP instance to read from.
* @param UINT *buffer buffer into which the data is to be read.
* @param UINT start_block the first block to start reading from.
* @param UINT total_blocks total number of blocks to read.
* @retval 0 on success error code otherwise
*/
INT fx_stm32_sd_read_blocks(UINT instance, UINT *buffer, UINT start_block, UINT total_blocks)
{
  INT ret = 0;

[#if glue_api == "Custom"]
  /* USER CODE BEGIN READ_BLOCKS */

  /* USER CODE END READ_BLOCKS */
[#else]
  /* USER CODE BEGIN PRE_READ_BLOCKS */
  UNUSED(instance);
  /* USER CODE END PRE_READ_BLOCKS */

[#if glue_api == "HAL_API_DMA"]
  if(HAL_SD_ReadBlocks_DMA(&${mx_sd_type}, (uint8_t *)buffer, start_block, total_blocks) != HAL_OK)
  {
    ret = 1;
  }
[/#if]
[#if glue_api == "HAL_API_POLLING"]
  if(HAL_SD_ReadBlocks(&${mx_sd_type}, (uint8_t *)buffer, start_block, total_blocks, FX_STM32_SD_DEFAULT_TIMEOUT) != HAL_OK)
  {
    ret = 1;
  }
[/#if]

  /* USER CODE BEGIN POST_READ_BLOCKS */

  /* USER CODE END POST_READ_BLOCKS */
[/#if]

  return ret;
}

/**
* @brief Write data buffer into the SD device.
* @param UINT instance SD IP instance to write into.
* @param UINT *buffer buffer to write into the SD device.
* @param UINT start_block the first block to start writing into.
* @param UINT total_blocks total number of blocks to write.
* @retval 0 on success error code otherwise
*/
INT fx_stm32_sd_write_blocks(UINT instance, UINT *buffer, UINT start_block, UINT total_blocks)
{
  INT ret = 0;

[#if glue_api == "Custom"]
  /* USER CODE BEGIN WRITE_BLOCKS */

  /* USER CODE END WRITE_BLOCKS */
[#else]
  /* USER CODE BEGIN PRE_WRITE_BLOCKS */
  UNUSED(instance);
  /* USER CODE END PRE_WRITE_BLOCKS */

[#if glue_api == "HAL_API_DMA"]
  if(HAL_SD_WriteBlocks_DMA(&${mx_sd_type}, (uint8_t *)buffer, start_block, total_blocks) != HAL_OK)
  {
    ret = 1;
  }
[/#if]
[#if glue_api == "HAL_API_POLLING"]
  if(HAL_SD_WriteBlocks(&${mx_sd_type}, (uint8_t *)buffer, start_block, total_blocks, FX_STM32_SD_DEFAULT_TIMEOUT) != HAL_OK)
  {
    ret = 1;
  }
[/#if]

  /* USER CODE BEGIN POST_WRITE_BLOCKS */

  /* USER CODE END POST_WRITE_BLOCKS */
[/#if]

  return ret;
}

[#if glue_api == "HAL_API_DMA"]
/**
* @brief SD DMA Tx Transfer completed callbacks
* @param Instance the sd instance
* @retval None
*/
void HAL_SD_TxCpltCallback(SD_HandleTypeDef *hsd)
{
[#if txrx_cmplt == "Custom"]
/* Custom transfer completion notification mechanism goes here */

/* USER CODE BEGIN TX_CMPLT */

/* USER CODE END TX_CMPLT */

[#else]
  /* USER CODE BEGIN PRE_TX_CMPLT */

  /* USER CODE END PRE_TX_CMPLT */

  [#if is_stand == 1 || txrx_cmplt != "TxSem"]
  write_transfer_completed = 1;
  [#else]
  tx_semaphore_put(&transfer_semaphore);
  [/#if]

  /* USER CODE BEGIN POST_TX_CMPLT */

  /* USER CODE END POST_TX_CMPLT */
[/#if]
}

/**
* @brief SD DMA Rx Transfer completed callbacks
* @param Instance the sd instance
* @retval None
*/
void HAL_SD_RxCpltCallback(SD_HandleTypeDef *hsd)
{
[#if txrx_cmplt == "Custom"]
/* Custom transfer completion notification mechanism goes here */

/* USER CODE BEGIN RX_CMPLT */

/* USER CODE END RX_CMPLT */

[#else]
  /* USER CODE BEGIN PRE_RX_CMPLT */

  /* USER CODE END PRE_RX_CMPLT */

  [#if is_stand == 1 || txrx_cmplt != "TxSem"]
  read_transfer_completed = 1;
  [#else]
  tx_semaphore_put(&transfer_semaphore);
  [/#if]

  /* USER CODE BEGIN POST_RX_CMPLT */

  /* USER CODE END POST_RX_CMPLT */
[/#if]
}
[/#if]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */