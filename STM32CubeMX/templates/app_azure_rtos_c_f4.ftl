[#ftl]

/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_azure_rtos.c
  * @author  MCD Application Team
  * @brief   azure_rtos application implementation file
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

#include "app_azure_rtos.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

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
   [/#list]
[/#if]
[/#list]
[/#compress]
[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL == "1"]
[#if GEN_TX_INIT_CODE == "true"]
/* USER CODE BEGIN TX_Pool_Buffer */
/* USER CODE END TX_Pool_Buffer */
static UCHAR tx_byte_pool_buffer[TX_APP_MEM_POOL_SIZE];
static TX_BYTE_POOL tx_app_byte_pool;

[#assign GEN_TX_INIT_CODE = "false"]
[/#if]
[#if GEN_FX_INIT_CODE == "true"]
/* USER CODE BEGIN FX_Pool_Buffer */
/* USER CODE END FX_Pool_Buffer */
static UCHAR  fx_byte_pool_buffer[FX_APP_MEM_POOL_SIZE];
static TX_BYTE_POOL fx_app_byte_pool;
[#assign GEN_FX_INIT_CODE = "false"]

[/#if]
[#if GEN_NX_INIT_CODE == "true"]
/* USER CODE BEGIN NX_Pool_Buffer */
/* USER CODE END NX_Pool_Buffer */
static UCHAR  nx_byte_pool_buffer[NX_APP_MEM_POOL_SIZE];
static TX_BYTE_POOL nx_app_byte_pool;
[#assign GEN_NX_INIT_CODE = "false"]

[/#if]
[#if GEN_UX_HOST_INIT_CODE == "true"]
/* USER CODE BEGIN UX_HOST_Pool_Buffer */
/* USER CODE END UX_HOST_Pool_Buffer */
static UCHAR  ux_host_byte_pool_buffer[UX_HOST_APP_MEM_POOL_SIZE];
static TX_BYTE_POOL ux_host_app_byte_pool;
[#assign GEN_UX_HOST_INIT_CODE = "false"]

[/#if]
[#if GEN_UX_DEVICE_INIT_CODE == "true"]
/* USER CODE BEGIN UX_Device_Pool_Buffer */
/* USER CODE END UX_Device_Pool_Buffer */
static UCHAR  ux_device_byte_pool_buffer[UX_DEVICE_APP_MEM_POOL_SIZE];
static TX_BYTE_POOL ux_device_app_byte_pool;
[#assign GEN_UX_DEVICE_INIT_CODE = "false"]

[/#if]
[/#if]
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

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

/**
  * @brief  Define the initial system.
  * @param  first_unused_memory : Pointer to the first unused memory
  * @retval None
  */
VOID tx_application_define(VOID *first_unused_memory)
{
  /* USER CODE BEGIN  tx_application_define */

  /* USER CODE END  tx_application_define */

[#if AZRTOS_APP_MEM_ALLOCATION_METHOD_VAL == "1"]
  VOID *memory_ptr;

[#if GEN_TX_INIT_CODE == "true"]
  if (tx_byte_pool_create(&tx_app_byte_pool, "Tx App memory pool", tx_byte_pool_buffer, TX_APP_MEM_POOL_SIZE) != TX_SUCCESS)
  {
    /* USER CODE BEGIN TX_Byte_Pool_Error */

    /* USER CODE END TX_Byte_Pool_Error */
  }
  else
  {
    /* USER CODE BEGIN TX_Byte_Pool_Success */

    /* USER CODE END TX_Byte_Pool_Success */

    memory_ptr = (VOID *)&tx_app_byte_pool;

    if (App_ThreadX_Init(memory_ptr) != TX_SUCCESS)
    {
      /* USER CODE BEGIN  App_ThreadX_Init_Error */

      /* USER CODE END  App_ThreadX_Init_Error */
    }

    /* USER CODE BEGIN  App_ThreadX_Init_Success */

    /* USER CODE END  App_ThreadX_Init_Success */

  }
[/#if]
[#if GEN_FX_INIT_CODE == "true"]

  if (tx_byte_pool_create(&fx_app_byte_pool, "Fx App memory pool", fx_byte_pool_buffer, FX_APP_MEM_POOL_SIZE) != TX_SUCCESS)
  {
    /* USER CODE BEGIN FX_Byte_Pool_Error */

    /* USER CODE END FX_Byte_Pool_Error */
  }
  else
  {
    /* USER CODE BEGIN FX_Byte_Pool_Success */

    /* USER CODE END FX_Byte_Pool_Success */

    memory_ptr = (VOID *)&fx_app_byte_pool;

    if (MX_FileX_Init(memory_ptr) != FX_SUCCESS)
    {
      /* USER CODE BEGIN MX_FileX_Init_Error */

      /* USER CODE END MX_FileX_Init_Error */
    }

    /* USER CODE BEGIN MX_FileX_Init_Success */

    /* USER CODE END MX_FileX_Init_Success */
  }
  [/#if]
[#if GEN_NX_INIT_CODE == "true"]

  if (tx_byte_pool_create(&nx_app_byte_pool, "Nx App memory pool", nx_byte_pool_buffer, NX_APP_MEM_POOL_SIZE) != TX_SUCCESS)
  {
    /* USER CODE BEGIN NX_Byte_Pool_Error */

    /* USER CODE END NX_Byte_Pool_Error */
  }
  else
  {
    /* USER CODE BEGIN TX_Byte_Pool_Success */

    /* USER CODE END TX_Byte_Pool_Success */

    memory_ptr = (VOID *)&nx_app_byte_pool;

    if (MX_NetXDuo_Init(memory_ptr) != NX_SUCCESS)
    {
      /* USER CODE BEGIN MX_NetXDuo_Init_Error */

      /* USER CODE END MX_NetXDuo_Init_Error */
    }

    /* USER CODE BEGIN MX_NetXDuo_Init_Success */

    /* USER CODE END MX_NetXDuo_Init_Success */

  }
  [/#if]
[#if GEN_UX_HOST_INIT_CODE == "true"]

  if (tx_byte_pool_create(&ux_host_app_byte_pool, "Ux App memory pool", ux_host_byte_pool_buffer, UX_HOST_APP_MEM_POOL_SIZE) != TX_SUCCESS)
  {
    /* USER CODE BEGIN TX_Byte_Pool_Error */

    /* USER CODE END TX_Byte_Pool_Error */
  }
  else
  {
    /* USER CODE BEGIN UX_HOST_Byte_Pool_Success */

    /* USER CODE END UX_HOST_Byte_Pool_Success */

    memory_ptr = (VOID *)&ux_host_app_byte_pool;

    if (MX_USBX_Host_Init(memory_ptr) != UX_SUCCESS)
    {
      /* USER CODE BEGIN MX_USBX_Host_Init_Error */

      /* USER CODE END MX_USBX_Host_Init_Error */
    }

    /* USER CODE BEGIN MX_USBX_Host_Init_Success */

    /* USER CODE END MX_USBX_Host_Init_Success */
  }
[/#if]

[#if GEN_UX_DEVICE_INIT_CODE == "true"]
  if (tx_byte_pool_create(&ux_device_app_byte_pool, "Ux App memory pool", ux_device_byte_pool_buffer, UX_DEVICE_APP_MEM_POOL_SIZE) != TX_SUCCESS)
  {
    /* USER CODE BEGIN UX_Device_Byte_Pool_Error */

    /* USER CODE END UX_Device_Byte_Pool_Error */
  }
  else
  {
    /* USER CODE BEGIN UX_Device_Byte_Pool_Success */

    /* USER CODE END UX_Device_Byte_Pool_Success */

    memory_ptr = (VOID *)&ux_device_app_byte_pool;

    if (MX_USBX_Device_Init(memory_ptr) != UX_SUCCESS)
    {
      /* USER CODE BEGIN MX_USBX_Device_Init_Error */

      /* USER CODE END MX_USBX_Device_Init_Error */
    }

    /* USER CODE BEGIN MX_USBX_Device_Init_Success */

    /* USER CODE END MX_USBX_Device_Init_Success */
  }
[/#if]
[#else]
  /*
   * Using dynamic memory allocation requires to apply some changes to the linker file.
   * ThreadX needs to pass a pointer to the first free memory location in RAM to the tx_application_define() function,
   * using the "first_unused_memory" argument.
   * This require changes in the linker files to expose this memory location.
   * For EWARM add the following section into the .icf file:
       place in RAM_region    { last section FREE_MEM };
   * For MDK-ARM
       - either define the RW_IRAM1 region in the ".sct" file
       - or modify the line below in "tx_low_level_initilize.s to match the memory region being used
          LDR r1, =|Image$$RW_IRAM1$$ZI$$Limit|

   * For STM32CubeIDE add the following section into the .ld file:
       ._threadx_heap :
         {
            . = ALIGN(8);
            __RAM_segment_used_end__ = .;
            . = . + 64K;
            . = ALIGN(8);
          } >RAM_D1 AT> RAM_D1
      * The simplest way to provide memory for ThreadX is to define a new section, see ._threadx_heap above.
      * In the example above the ThreadX heap size is set to 64KBytes.
      * The ._threadx_heap must be located between the .bss and the ._user_heap_stack sections in the linker script.
      * Caution: Make sure that ThreadX does not need more than the provided heap memory (64KBytes in this example).
      * Read more in STM32CubeIDE User Guide, chapter: "Linker script".

   * The "tx_initialize_low_level.s" should be also modified to enable the "USE_DYNAMIC_MEMORY_ALLOCATION" flag.
   */

  /* USER CODE BEGIN DYNAMIC_MEM_ALLOC */
  (void)first_unused_memory;
  /* USER CODE END DYNAMIC_MEM_ALLOC */
[/#if]
}

/* USER CODE BEGIN  0 */

/* USER CODE END  0 */
