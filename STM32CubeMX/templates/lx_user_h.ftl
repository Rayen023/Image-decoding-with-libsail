[#ftl]
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


/**************************************************************************/
/**************************************************************************/
/**                                                                       */
/** LevelX Component                                                       */
/**                                                                       */
/**   User Specific                                                       */
/**                                                                       */
/**************************************************************************/
/**************************************************************************/

#ifndef LX_USER_H
#define LX_USER_H

[#compress]

[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "LX_DIRECT_READ"]
      [#assign LX_DIRECT_READ_value = value]
    [/#if]

    [#if name == "LX_FREE_SECTOR_DATA_VERIFY"]
      [#assign LX_FREE_SECTOR_DATA_VERIFY_value = value]
    [/#if]

    [#if name == "LX_NAND_SECTOR_MAPPING_CACHE_SIZE"]
      [#assign LX_NAND_SECTOR_MAPPING_CACHE_SIZE_value = value]
    [/#if]

    [#if name == "LX_NAND_FLASH_DIRECT_MAPPING_CACHE"]
      [#assign LX_NAND_FLASH_DIRECT_MAPPING_CACHE_value = value]
    [/#if]

    [#if name == "LX_NOR_DISABLE_EXTENDED_CACHE"]
      [#assign LX_NOR_DISABLE_EXTENDED_CACHE_value = value]
    [/#if]

    [#if name == "LX_NOR_EXTENDED_CACHE_SIZE"]
      [#assign LX_NOR_EXTENDED_CACHE_SIZE_value = value]
    [/#if]

    [#if name == "LX_NOR_SECTOR_MAPPING_CACHE_SIZE"]
      [#assign LX_NOR_SECTOR_MAPPING_CACHE_SIZE_value = value]
    [/#if]

    [#if name == "LX_THREAD_SAFE_ENABLE"]
      [#assign LX_THREAD_SAFE_ENABLE_value = value]
    [/#if]

  [/#list]
[/#if]
[/#list]
[/#compress]

/* Defined, this option bypasses the NOR flash driver read routine in favor or reading
   the NOR memory directly, resulting in a significant performance increase.
*/
[#if LX_DIRECT_READ_value == "1"]
#define LX_DIRECT_READ
[#else]
/* #define LX_DIRECT_READ */
[/#if]

/* Defined, this causes the LevelX NOR instance open logic to verify free NOR
   sectors are all ones.
*/
[#if LX_FREE_SECTOR_DATA_VERIFY_value == "1"]
#define LX_FREE_SECTOR_DATA_VERIFY
[#else]
/* #define LX_FREE_SECTOR_DATA_VERIFY */
[/#if]

/* By default this value is 128 and defines the logical sector mapping cache size.
   Large values improve performance, but cost memory. The minimum size is 8 and
   all values must be a power of 2.
*/
[#if LX_NAND_SECTOR_MAPPING_CACHE_SIZE_value == "128"]
/* #define LX_NAND_SECTOR_MAPPING_CACHE_SIZE         128 */
[#else]
#define LX_NAND_SECTOR_MAPPING_CACHE_SIZE         ${LX_NAND_SECTOR_MAPPING_CACHE_SIZE_value}
[/#if]

/* Defined, this creates a direct mapping cache, such that there are no cache misses.
   It also requires that LX_NAND_SECTOR_MAPPING_CACHE_SIZE represents the exact number
   of total pages in your flash device.
*/
[#if LX_NAND_FLASH_DIRECT_MAPPING_CACHE_value == "1"]
#define LX_NAND_FLASH_DIRECT_MAPPING_CACHE
[#else]
/* #define LX_NAND_FLASH_DIRECT_MAPPING_CACHE */
[/#if]

/* Defined, this disabled the extended NOR cache.  */
[#if LX_NOR_DISABLE_EXTENDED_CACHE_value == "1"]
#define LX_NOR_DISABLE_EXTENDED_CACHE
[#else]
/* #define LX_NOR_DISABLE_EXTENDED_CACHE */
[/#if]

/* By default this value is 8, which represents a maximum of 8 sectors that
   can be cached in a NOR instance.
*/
[#if LX_NOR_EXTENDED_CACHE_SIZE_value == "8"]
/* #define LX_NOR_EXTENDED_CACHE_SIZE         8 */
[#else]
#define LX_NOR_EXTENDED_CACHE_SIZE         ${LX_NOR_EXTENDED_CACHE_SIZE_value}
[/#if]

/* By default this value is 16 and defines the logical sector mapping cache size.
   Large values improve performance, but cost memory. The minimum size is 8 and all
   values must be a power of 2.
*/
[#if LX_NOR_SECTOR_MAPPING_CACHE_SIZE_value == "16"]
/* #define LX_NOR_SECTOR_MAPPING_CACHE_SIZE         16 */
[#else]
#define LX_NOR_SECTOR_MAPPING_CACHE_SIZE         ${LX_NOR_SECTOR_MAPPING_CACHE_SIZE_value}
[/#if]

/* Defined, this makes LevelX thread-safe by using a ThreadX mutex object
   throughout the API.
*/
[#if LX_THREAD_SAFE_ENABLE_value == "1"]
#define LX_THREAD_SAFE_ENABLE
[#else]
/* #define LX_THREAD_SAFE_ENABLE */
[/#if]

#endif
