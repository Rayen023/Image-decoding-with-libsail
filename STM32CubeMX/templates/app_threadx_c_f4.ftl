[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_threadx.c
  * @author  MCD Application Team
  * @brief   ThreadX applicative file
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

/* Includes ------------------------------------------------------------------*/
#include "app_threadx.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */
[#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = "1" ]

[#compress]

[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "AZRTOS_APP_MEM_ALLOCATION_METHOD"]
      [#assign AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL = value]
    [/#if]

    [#if name == "TX_LOW_POWER"]
      [#assign TX_LOW_POWER_value = value]
    [/#if]

    [#if name == "TX_LOW_POWER_TIMER_SETUP"]
      [#assign TX_LOW_POWER_TIMER_SETUP_value = value]
    [/#if]

    [#if name == "TX_LOW_POWER_USER_ENTER"]
      [#assign TX_LOW_POWER_USER_ENTER_value = value]
    [/#if]

    [#if name == "TX_LOW_POWER_USER_EXIT"]
      [#assign TX_LOW_POWER_USER_EXIT_value = value]
    [/#if]

    [#if name == "TX_LOW_POWER_USER_TIMER_ADJUST"]
      [#assign TX_LOW_POWER_USER_TIMER_ADJUST_value = value]
    [/#if]

  [/#list]
[/#if]
[/#list]
[/#compress]
/**
  * @brief  Application ThreadX Initialization.
  * @param memory_ptr: memory pointer
  * @retval int
  */
UINT App_ThreadX_Init(VOID *memory_ptr)
{
  UINT ret = TX_SUCCESS;
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0"]
  TX_BYTE_POOL *byte_pool = (TX_BYTE_POOL*)memory_ptr;
[/#if]

  /* USER CODE BEGIN App_ThreadX_Init */
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL  != "0"]
  (void)byte_pool;
[/#if]
  /* USER CODE END App_ThreadX_Init */

  return ret;
}

/**
  * @brief  MX_ThreadX_Init
  * @param  None
  * @retval None
  */
void MX_ThreadX_Init(void)
{
  /* USER CODE BEGIN  Before_Kernel_Start */

  /* USER CODE END  Before_Kernel_Start */

  tx_kernel_enter();

  /* USER CODE BEGIN  Kernel_Start_Error */

  /* USER CODE END  Kernel_Start_Error */
}

[#if TX_LOW_POWER_value == "1"]

[#if TX_LOW_POWER_TIMER_SETUP_value != " " && TX_LOW_POWER_TIMER_SETUP_value != ""]

/**
  * @brief  ${TX_LOW_POWER_TIMER_SETUP_value}
  * @param  count : TX timer count
  * @retval None
  */
void ${TX_LOW_POWER_TIMER_SETUP_value}(ULONG count)
{
  /* USER CODE BEGIN  ${TX_LOW_POWER_TIMER_SETUP_value} */

  /* USER CODE END  ${TX_LOW_POWER_TIMER_SETUP_value} */
}
[/#if]

[#if TX_LOW_POWER_USER_ENTER_value != " " && TX_LOW_POWER_USER_ENTER_value != ""]

/**
  * @brief  ${TX_LOW_POWER_USER_ENTER_value}
  * @param  None
  * @retval None
  */
void ${TX_LOW_POWER_USER_ENTER_value}(void)
{
  /* USER CODE BEGIN  ${TX_LOW_POWER_USER_ENTER_value} */

  /* USER CODE END  ${TX_LOW_POWER_USER_ENTER_value} */
}
[/#if]

[#if TX_LOW_POWER_USER_EXIT_value != " " && TX_LOW_POWER_USER_EXIT_value != ""]

/**
  * @brief  ${TX_LOW_POWER_USER_EXIT_value}
  * @param  None
  * @retval None
  */
void ${TX_LOW_POWER_USER_EXIT_value}(void)
{
  /* USER CODE BEGIN  ${TX_LOW_POWER_USER_EXIT_value} */

  /* USER CODE END  ${TX_LOW_POWER_USER_EXIT_value} */
}
[/#if]

[#if TX_LOW_POWER_USER_TIMER_ADJUST_value != " " && TX_LOW_POWER_USER_TIMER_ADJUST_value != ""]

/**
  * @brief  ${TX_LOW_POWER_USER_TIMER_ADJUST_value}
  * @param  None
  * @retval Amount of time (in ticks)
  */
ULONG ${TX_LOW_POWER_USER_TIMER_ADJUST_value}(void)
{
  /* USER CODE BEGIN  ${TX_LOW_POWER_USER_TIMER_ADJUST_value} */
  return 0;
  /* USER CODE END  ${TX_LOW_POWER_USER_TIMER_ADJUST_value} */
}
[/#if]

[/#if]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
