[#ftl]

/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_azure_rtos_config.h
  * @author  MCD Application Team
  * @brief   azure_rtos config header file
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2021 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_AZURE_RTOS_CONFIG_H
#define APP_AZURE_RTOS_CONFIG_H
#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/

[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = "1"]
[#assign TX_APP_MEM_POOL_SIZE_VAL = "0"]
[#assign FX_APP_MEM_POOL_SIZE_VAL = "0"]
[#assign NX_APP_MEM_POOL_SIZE_VAL = "0"]
[#assign UX_HOST_APP_MEM_POOL_SIZE_VAL = "0"]
[#assign UX_DEVICE_APP_MEM_POOL_SIZE_VAL = "0"]

[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = value]
    [/#if]

    [#if name == "TX_APP_MEM_POOL_SIZE"]
      [#assign TX_APP_MEM_POOL_SIZE_VAL = value]
    [/#if]

    [#if name == "FX_APP_MEM_POOL_SIZE"]
      [#assign FX_APP_MEM_POOL_SIZE_VAL = value]
    [/#if]

    [#if name == "NX_APP_MEM_POOL_SIZE"]
      [#assign NX_APP_MEM_POOL_SIZE_VAL = value]
    [/#if]

    [#if name == "UX_HOST_APP_MEM_POOL_SIZE"]
      [#assign UX_HOST_APP_MEM_POOL_SIZE_VAL = value]
    [/#if]

    [#if name == "UX_DEVICE_APP_MEM_POOL_SIZE"]
      [#assign UX_DEVICE_APP_MEM_POOL_SIZE_VAL = value]
    [/#if]

    [/#list]
[/#if]
[/#list]
[/#compress]

[#assign TX_ENABLED = "false"]
[#assign FX_ENABLED = "false"]
[#assign NX_ENABLED = "false"]
[#assign UX_HOST_ENABLED = "false"]
[#assign UX_DEVICE_ENABLED = "false"]

[#if RTEdatas??]
[#list RTEdatas as define]

[#if define?contains("THREADX_ENABLED")]
[#assign TX_ENABLED = "true"]
[/#if]

[#if define?contains("FILEX_ENABLED")]
[#assign FX_ENABLED = "true"]
[/#if]

[#if define?contains("NETXDUO_ENABLED")]
[#assign NX_ENABLED = "true"]
[/#if]

[#if define?contains("USBXHOST_ENABLED")]
[#assign UX_HOST_ENABLED = "true"]
[/#if]

[#if define?contains("USBXDEVICE_ENABLED")]
[#assign UX_DEVICE_ENABLED = "true"]
[/#if]

[/#list]
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if  AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL == "1"]
/* define the size of static threadX byte memory pools */
[#if TX_ENABLED == "true" && TX_APP_MEM_POOL_SIZE_VAL != "valueNotSetted"]
#define TX_APP_MEM_POOL_SIZE                     ${TX_APP_MEM_POOL_SIZE_VAL}

[/#if]
[#if FX_ENABLED == "true" && FX_APP_MEM_POOL_SIZE_VAL != "valueNotSetted"]
#define FX_APP_MEM_POOL_SIZE                     ${FX_APP_MEM_POOL_SIZE_VAL}

[/#if]
[#if NX_ENABLED == "true" && NX_APP_MEM_POOL_SIZE_VAL != "valueNotSetted" ]
#define NX_APP_MEM_POOL_SIZE                     ${NX_APP_MEM_POOL_SIZE_VAL}

[/#if]
[#if UX_HOST_ENABLED == "true" && UX_HOST_APP_MEM_POOL_SIZE_VAL != "valueNotSetted" ]
#define UX_HOST_APP_MEM_POOL_SIZE                ${UX_HOST_APP_MEM_POOL_SIZE_VAL}

[/#if]
[#if UX_DEVICE_ENABLED == "true" && UX_DEVICE_APP_MEM_POOL_SIZE_VAL != "valueNotSetted" ]
#define UX_DEVICE_APP_MEM_POOL_SIZE              ${UX_DEVICE_APP_MEM_POOL_SIZE_VAL}

[/#if]
[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */


#ifdef __cplusplus
}
#endif

#endif /* APP_AZURE_RTOS_CONFIG_H */
