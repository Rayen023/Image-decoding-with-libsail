[#ftl]

/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_azure_rtos.h
  * @author  MCD Application Team
  * @brief   azure_rtos application header file
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
#ifndef APP_AZURE_RTOS_H
#define APP_AZURE_RTOS_H
#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "app_azure_rtos_config.h"
[#assign GEN_TX_INIT_CODE = "false"]
[#assign GEN_FX_INIT_CODE = "false"]
[#assign GEN_NX_INIT_CODE = "false"]
[#assign GEN_UX_HOST_INIT_CODE = "false"]
[#assign GEN_UX_DEVICE_INIT_CODE = "false"]
[#if RTEdatas??]
[#list RTEdatas as define]
[#if define?contains("THREADX_ENABLED")]
[#assign GEN_TX_INIT_CODE = "true"]
[/#if]
[#if define?contains("FILEX_ENABLED")]
[#assign GEN_FX_INIT_CODE = "true"]
[/#if]
[#if define?contains("NETXDUO_ENABLED")]
[#assign GEN_NX_INIT_CODE = "true"]
[/#if]
[#if define?contains("USBXHOST_ENABLED")]
[#assign GEN_UX_HOST_INIT_CODE = "true"]
[/#if]
[#if define?contains("USBXDEVICE_ENABLED")]
[#assign GEN_UX_DEVICE_INIT_CODE = "true"]
[/#if]
[/#list]
[/#if]
[#if GEN_TX_INIT_CODE == "true"]

#include "app_threadx.h"
[/#if]
[#if GEN_FX_INIT_CODE == "true"]

#include "app_filex.h"
[/#if]
[#if GEN_NX_INIT_CODE == "true"]

#include "app_netxduo.h"
[/#if]
[#if GEN_UX_HOST_INIT_CODE == "true"]

#include "app_usbx_host.h"
[/#if]
[#if GEN_UX_DEVICE_INIT_CODE == "true"]

#include "app_usbx_device.h"
[/#if]
/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
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

#endif /* APP_AZURE_RTOS_H */
