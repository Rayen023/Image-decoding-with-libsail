[#ftl]
[#compress]

[#assign  sd_init = 1]
[#assign  sd_dma = 0]
[#assign  glue_api = "HAL_API_DMA"]
[#assign  txrx_cmplt = "TxSem"]
[#assign  is_stand = 1]

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

    [#if name == "FX_DRIVER_SD_INIT"]
      [#assign sd_init = value]
    [/#if]

    [#if name == "FX_SD_GLUE_FUNCTION_IMPLEMENTATION"]
      [#assign glue_api = value]
    [/#if]

    [#if name == "FX_SD_TRANSFER_CMPLT_NOTIF"]
      [#assign txrx_cmplt = value]
    [/#if]

  [/#list]
[/#if]
[/#list]

[#if glue_api == "HAL_API_DMA"]
[#assign  sd_dma = 1]
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef FX_STM32_SD_DRIVER_H
#define FX_STM32_SD_DRIVER_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "fx_api.h"
#include "${FamilyName?lower_case}xx_hal.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

[#if txrx_cmplt != "Custom"]
  [#if is_stand == 0 && txrx_cmplt == "TxSem"]
extern TX_SEMAPHORE transfer_semaphore;
  [#else]
extern UINT read_transfer_completed;
extern UINT write_transfer_completed;
  [/#if]
[/#if]

/* Exported constants --------------------------------------------------------*/

/* Default timeout used to wait for fx operations */
[#if is_stand == 1]
#define FX_STM32_SD_DEFAULT_TIMEOUT                      (10000)
[#else]
#define FX_STM32_SD_DEFAULT_TIMEOUT                      (10 * TX_TIMER_TICKS_PER_SECOND)
[/#if]

/* Let the filex low-level driver initialize the SD driver */
#define FX_STM32_SD_INIT                                 ${sd_init}

/* Use the SD DMA API */
#define FX_STM32_SD_DMA_API                              ${sd_dma}

/* SDIO instance to be used by FileX */
#define FX_STM32_SD_INSTANCE                             0

/* Default sector size, used by the driver */
#define FX_STM32_SD_DEFAULT_SECTOR_SIZE                  512

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */


/* Get the current time in ticks */
[#if is_stand == 1]
/* USER CODE BEGIN FX_STM32_SD_CURRENT_TIME_HAL */

#define FX_STM32_SD_CURRENT_TIME()                                   HAL_GetTick()

/* USER CODE END FX_STM32_SD_CURRENT_TIME_HAL */
[#else]
/* USER CODE BEGIN FX_STM32_SD_CURRENT_TIME_TX */

#define FX_STM32_SD_CURRENT_TIME()                                   tx_time_get()

/* USER CODE END FX_STM32_SD_CURRENT_TIME_TX */
[/#if]


/* Macro called before initializing the SD driver
 * e.g. create a semaphore used for transfer notification */
[#if glue_api != "HAL_API_POLLING" && txrx_cmplt == "TxSem" && is_stand == 0]
/* USER CODE BEGIN FX_STM32_SD_PRE_INIT_TX */

#define FX_STM32_SD_PRE_INIT(_media_ptr)                do { \
                                                          if (tx_semaphore_create(&transfer_semaphore, "sd transfer semaphore", 1) != TX_SUCCESS) \
                                                          { \
                                                            _media_ptr->fx_media_driver_status = FX_IO_ERROR; \
                                                          } \
                                                        } while(0)

/* USER CODE END FX_STM32_SD_PRE_INIT_TX */
[#else]
/* USER CODE BEGIN FX_STM32_SD_PRE_INIT */

#define  FX_STM32_SD_PRE_INIT(_media_ptr)

/* USER CODE END FX_STM32_SD_PRE_INIT */
[/#if]


/* Macro called after initializing the SD driver */
/* USER CODE BEGIN FX_STM32_SD_POST_INIT */

#define FX_STM32_SD_POST_INIT(_media_ptr)

/* USER CODE END FX_STM32_SD_POST_INIT */


/* Macro called after the SD deinit */
[#if glue_api != "HAL_API_POLLING" && txrx_cmplt == "TxSem" && is_stand == 0]
/* USER CODE BEGIN FX_STM32_SD_POST_DEINIT_TX */

#define FX_STM32_SD_POST_DEINIT(_media_ptr)             do { \
                                                          tx_semaphore_delete(&transfer_semaphore); \
                                                        } while(0)

/* USER CODE END FX_STM32_SD_POST_DEINIT_TX */
[#else]
/* USER CODE BEGIN FX_STM32_SD_POST_DEINIT */

#define FX_STM32_SD_POST_DEINIT(_media_ptr)

/* USER CODE END FX_STM32_SD_POST_DEINIT */
[/#if]


/* Macro called after the abort request */
/* USER CODE BEGIN FX_STM32_SD_POST_ABORT */

#define FX_STM32_SD_POST_ABORT(_media_ptr)

/* USER CODE END FX_STM32_SD_POST_ABORT */


/* Macro called before performing read operation */
[#if glue_api == "HAL_API_POLLING" || txrx_cmplt == "Custom"]
/* USER CODE BEGIN FX_STM32_SD_PRE_READ_TRANSFER */

#define FX_STM32_SD_PRE_READ_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_SD_PRE_READ_TRANSFER */
[#else]
  [#if txrx_cmplt == "VarFlag" || is_stand == 1]
/* USER CODE BEGIN FX_STM32_SD_PRE_READ_TRANSFER_FLG */

#define FX_STM32_SD_PRE_READ_TRANSFER(_media_ptr)       do { \
                                                          read_transfer_completed = 0; \
                                                        } while(0)

/* USER CODE END FX_STM32_SD_PRE_READ_TRANSFER_FLG */
  [#else]
/* USER CODE BEGIN FX_STM32_SD_PRE_READ_TRANSFER_DMA */

#define FX_STM32_SD_PRE_READ_TRANSFER(_media_ptr)       do { \
                                                          if(tx_semaphore_get(&transfer_semaphore, FX_STM32_SD_DEFAULT_TIMEOUT) != TX_SUCCESS) \
                                                          { \
                                                            return FX_IO_ERROR; \
                                                          } \
                                                        } while(0)

/* USER CODE END FX_STM32_SD_PRE_READ_TRANSFER_DMA */
  [/#if]
[/#if]


/* Macro called after performing read operation */
[#if glue_api == "HAL_API_POLLING" || is_stand == 1 || txrx_cmplt != "TxSem"]
/* USER CODE BEGIN FX_STM32_SD_POST_READ_TRANSFER */

#define FX_STM32_SD_POST_READ_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_SD_POST_READ_TRANSFER */
[#else]
/* USER CODE BEGIN FX_STM32_SD_POST_READ_TRANSFER_TX */

#define FX_STM32_SD_POST_READ_TRANSFER(_media_ptr)      do { \
                                                          if(tx_semaphore_put(&transfer_semaphore) != TX_SUCCESS) \
                                                          { \
                                                            return FX_IO_ERROR; \
                                                          } \
                                                        } while(0)

/* USER CODE END FX_STM32_SD_POST_READ_TRANSFER_TX */
[/#if]


/* Macro for read error handling */
[#if glue_api == "HAL_API_POLLING" || is_stand == 1 || txrx_cmplt != "TxSem"]
/* USER CODE BEGIN FX_STM32_SD_READ_TRANSFER_ERROR */

#define FX_STM32_SD_READ_TRANSFER_ERROR(_status_)

/* USER CODE END FX_STM32_SD_READ_TRANSFER_ERROR */
[#else]
/* USER CODE BEGIN FX_STM32_SD_READ_TRANSFER_ERROR_TX */

#define FX_STM32_SD_READ_TRANSFER_ERROR(_status_)       do { \
                                                          tx_semaphore_put(&transfer_semaphore); \
                                                          _status_ = FX_IO_ERROR; \
                                                        } while(0)

/* USER CODE END FX_STM32_SD_READ_TRANSFER_ERROR_TX */
[/#if]


/* Define how to notify about Read completion operation */
[#if glue_api == "HAL_API_POLLING" || txrx_cmplt == "Custom"]
/* USER CODE BEGIN FX_STM32_SD_READ_CPLT_NOTIFY */

#define FX_STM32_SD_READ_CPLT_NOTIFY()

/* USER CODE END FX_STM32_SD_READ_CPLT_NOTIFY */
[#else]
  [#if is_stand == 1 || txrx_cmplt != "TxSem"]
/* USER CODE BEGIN FX_STM32_SD_READ_CPLT_NOTIFY_FLG */

#define FX_STM32_SD_READ_CPLT_NOTIFY()                  do { \
                                                          UINT start = FX_STM32_SD_CURRENT_TIME(); \
                                                          while(FX_STM32_SD_CURRENT_TIME() - start < FX_STM32_SD_DEFAULT_TIMEOUT) \
                                                          { \
                                                            if (read_transfer_completed == 1) \
                                                            break; \
                                                          } \
                                                          if (read_transfer_completed == 0) \
                                                            return FX_IO_ERROR;\
                                                        } while(0)

/* USER CODE END FX_STM32_SD_READ_CPLT_NOTIFY_FLG */
  [#else]
/* USER CODE BEGIN FX_STM32_SD_READ_CPLT_NOTIFY_TX */

#define FX_STM32_SD_READ_CPLT_NOTIFY()                  do { \
                                                          if(tx_semaphore_get(&transfer_semaphore, FX_STM32_SD_DEFAULT_TIMEOUT) != TX_SUCCESS) \
                                                          { \
                                                            return FX_IO_ERROR; \
                                                          } \
                                                        } while(0)

/* USER CODE END FX_STM32_SD_READ_CPLT_NOTIFY_TX */
  [/#if]
[/#if]


/* Define how to notify about write completion operation */
[#if glue_api == "HAL_API_POLLING" || txrx_cmplt == "Custom"]
/* USER CODE BEGIN FX_STM32_SD_WRITE_CPLT_NOTIFY */

#define FX_STM32_SD_WRITE_CPLT_NOTIFY()

/* USER CODE END FX_STM32_SD_WRITE_CPLT_NOTIFY */
[#else]
  [#if is_stand == 1 || txrx_cmplt != "TxSem"]
/* USER CODE BEGIN FX_STM32_SD_WRITE_CPLT_NOTIFY_FLG */
#define FX_STM32_SD_WRITE_CPLT_NOTIFY()                 do { \
                                                          UINT start = HAL_GetTick(); \
                                                          while( HAL_GetTick() - start < FX_STM32_SD_DEFAULT_TIMEOUT) \
                                                          { \
                                                            if (write_transfer_completed == 1) \
                                                            break; \
                                                          } \
                                                          if (write_transfer_completed == 0) \
                                                            return FX_IO_ERROR;\
                                                        } while(0)
/* USER CODE END FX_STM32_SD_WRITE_CPLT_NOTIFY_FLG */
  [#else]
/* USER CODE BEGIN FX_STM32_SD_WRITE_CPLT_NOTIFY_TX */

#define FX_STM32_SD_WRITE_CPLT_NOTIFY                   FX_STM32_SD_READ_CPLT_NOTIFY

/* USER CODE END FX_STM32_SD_WRITE_CPLT_NOTIFY_TX */
  [/#if]
[/#if]


/* Macro called before performing write operation */
[#if glue_api == "HAL_API_POLLING" || txrx_cmplt == "Custom"]
/* USER CODE BEGIN FX_STM32_SD_PRE_WRITE_TRANSFER */

#define FX_STM32_SD_PRE_WRITE_TRANSFER(_media_ptr)

/* USER CODE END FX_STM32_SD_PRE_WRITE_TRANSFER */
[#else]
  [#if is_stand == 1 || txrx_cmplt != "TxSem"]
/* USER CODE BEGIN FX_STM32_SD_PRE_WRITE_TRANSFER_FLG */

#define FX_STM32_SD_PRE_WRITE_TRANSFER(_media_ptr)       do { \
                                                          write_transfer_completed = 0; \
                                                        } while(0)

/* USER CODE END FX_STM32_SD_PRE_WRITE_TRANSFER_FLG */
  [#else]
/* USER CODE BEGIN FX_STM32_SD_PRE_WRITE_TRANSFER_TX */

#define FX_STM32_SD_PRE_WRITE_TRANSFER                  FX_STM32_SD_PRE_READ_TRANSFER

/* USER CODE END FX_STM32_SD_PRE_WRITE_TRANSFER_TX */
  [/#if]
[/#if]


/* Macro called after performing write operation */
/* USER CODE BEGIN FX_STM32_SD_POST_WRITE_TRANSFER */

#define FX_STM32_SD_POST_WRITE_TRANSFER                 FX_STM32_SD_POST_READ_TRANSFER

/* USER CODE END FX_STM32_SD_POST_WRITE_TRANSFER */


/* Macro for write error handling */
/* USER CODE BEGIN FX_STM32_SD_WRITE_TRANSFER_ERROR */

#define FX_STM32_SD_WRITE_TRANSFER_ERROR                FX_STM32_SD_READ_TRANSFER_ERROR

/* USER CODE END FX_STM32_SD_WRITE_TRANFSER_ERROR */


/* Exported functions prototypes ---------------------------------------------*/

INT fx_stm32_sd_init(UINT instance);
INT fx_stm32_sd_deinit(UINT instance);

INT fx_stm32_sd_get_status(UINT instance);

INT fx_stm32_sd_read_blocks(UINT instance, UINT *buffer, UINT start_block, UINT total_blocks);
INT fx_stm32_sd_write_blocks(UINT instance, UINT *buffer, UINT start_block, UINT total_blocks);


VOID fx_stm32_sd_driver(FX_MEDIA *media_ptr);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif

#endif /* FX_STM32_SD_DRIVER_H */
