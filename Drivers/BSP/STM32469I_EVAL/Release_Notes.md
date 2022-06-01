---
pagetitle: Release Notes for STM32469I-EVAL BSP Drivers
lang: en
---
::: {.row}
::: {.col-sm-12 .col-lg-4}

::: {.card .fluid}
::: {.sectione .dark}
<center>
# **Release Notes for STM32469I-EVAL BSP Drivers**
Copyright &copy; \<2015\> STMicroelectronics\
    
[![ST logo](_htmresc/st_logo.png)](https://www.st.com){.logo}
</center>
:::
:::

# License

This software component is licensed by ST under BSD 3-Clause license, the "License"; You may not use this component except in 
compliance with the License. You may obtain a copy of the License at:
<center>
[https://opensource.org/licenses/BSD-3-Clause](http://www.st.com/software_license_agreement_liberty_v2)
</center>

# Purpose

The BSP (Board Specific Package) drivers are parts of the STM32Cube package based on the HAL drivers and provide a set of high level APIs relative to the hardware components and features in the evaluation boards, discovery kits and nucleo boards coming with the STM32Cube package for a given STM32 serie.


The BSP drivers allow a quick access to the boards’ services using high level APIs and without any specific configuration as the link with the HAL and the external components is done in intrinsic within the drivers. 


From project settings points of view, user has only to add the necessary driver’s files in the workspace and call the needed functions from examples. However some low level configuration functions are weak and can be overridden by the applications if user wants to change some BSP drivers default behavior.
:::

::: {.col-sm-12 .col-lg-8}
# Update History

::: {.collapse}
<input type="checkbox" id="collapse-section8" checked aria-hidden="true">
<label for="collapse-section8" aria-hidden="true">__V2.1.0 / 21-March-2019__</label>
<div>			

## Main Changes

-	stm32469i_eval_camera.c/.h:
	-	Support ov5640 camera sensor
-	stm32469i_eval.c/.h:
	-	Add OV5640 I2C address
	-	Update CAMERA IO Read/Write to support ov5640 camera sensor

</div>
:::

::: {.collapse}
<input type="checkbox" id="collapse-section7" checked aria-hidden="true">
<label for="collapse-section7" aria-hidden="true">__V2.0.1 / 21-September-2017__</label>
<div>			

## Main Changes

-	Remove date & version
-	Add general description of BSP drivers
-	stm32469i_eval_audio.c:
	-	Aligned with PDM library v3.0.0
-	stm32469i_eval_lcd.c:
	-	Update  BSP_LCD_DrawBitmap() API to fix functional misbehavior with SW4STM32 Toolchain

## Dependencies

-	This version must be used with v3.0.0 of PDM library

</div>
:::

::: {.collapse}
<input type="checkbox" id="collapse-section6" checked aria-hidden="true">
<label for="collapse-section6" aria-hidden="true">__V2.0.0 / 27-January-2017__</label>
<div>			

## Main Changes

-	stm32469i_eval_sd.c/.h:
	-	Update BSP SD APIs following new HAL SD drivers implementation
	-	Fix BlockSize to 512 bytes
-	stm32469i_eval_ts.c/.h:
	-	Support of FT6336G Touch Screen
-	stm32469i_eval_qspi.c/.h:
	-	QSPI write operation improvement
	-	Update CS High Time
-	stm32469i_eval_sdram.c:
	-	Update SDRAM RowBitsNumbers and ColumnBitsNumber values to address all 32MB memory size. 

## Backward compatibility

-	These BSP drivers break the compatibility with previous versions.

## Dependencies

-	If FatFs is required, "FatFS R0.11  ST modified 20161223" must be used with this version of BSP drivers.

</div>
:::

::: {.collapse}
<input type="checkbox" id="collapse-section5" checked aria-hidden="true">
<label for="collapse-section5" aria-hidden="true">__V1.0.4 / 04-August-2016__</label>
<div>			

## Main Changes

-	stm32469i_eval_lcd.c/.h:
	-	Update DSI initialization
	-	Update LTDC clock value
	-	Update LCD_DSI_PIXEL_DATA_FMT_RBG888 and LCD_DSI_PIXEL_DATA_FMT_RBG565 values

</div>
:::

::: {.collapse}
<input type="checkbox" id="collapse-section4" checked aria-hidden="true">
<label for="collapse-section4" aria-hidden="true">__V1.0.3 / 06-May-2016__</label>
<div>			

## Main Changes

-	stm32469i_eval_camera.h update BSP Camera driver to use the new HAL DCMI API's:
	-	Update BSP_CAMERA_Suspend() API to call HAL_DCMI_Suspend() API
	-	Update BSP_CAMERA_Resume to call HAL_DCMI_Resume() API


</div>
:::

::: {.collapse}
<input type="checkbox" id="collapse-section3" checked aria-hidden="true">
<label for="collapse-section3" aria-hidden="true">__V1.0.2 / 12-January-2016__</label>
<div>			

## Main Changes

-	General updates to fix doxygen errors
-	Add STM32469I_EVAL_BSP_User_Manual.chm file
-	stm32469i_eval_audio.c
	-	Alignment with STM32F4xx_HAL_Driver V1.4.4 
-	stm32469i_eval_qspi.c
	-	Deactivate Timeout in memory mapped mode
	-	Rename BSP_QSPI_MemoryMappedMode() API to BSP_QSPI_EnableMemoryMappedMode() API 
-	stm32469i_eval_lcd.c
	-	BSP_LCD_InitEx() API updated to remove use of intermediate variable Clockratio and improve calculation granularity 

</div>
:::

::: {.collapse}
<input type="checkbox" id="collapse-section2" checked aria-hidden="true">
<label for="collapse-section2" aria-hidden="true">__V1.0.1 / 29-September-2015__</label>
<div>			

## Main Changes

-	stm32469i_eval_lcd.c update:
	-	Add delay within BSP_LCD_Reset() function
-	stm32469i_eval_lcd.h update:
	-	Replace "\" with "/"

</div>
:::

::: {.collapse}
<input type="checkbox" id="collapse-section1" checked aria-hidden="true">
<label for="collapse-section1" aria-hidden="true">__V1.0.0 / 14-August-2015__</label>
<div>			

## Main Changes

-	First official release of the STM32469I-EVAL BSP drivers 

</div>
:::

:::
:::

<footer class="sticky">
For complete documentation on <mark>STM32469I-EVAL</mark> ,
visit: [[www.st.com](http://www.st.com/STM32)]{style="font-color: blue;"}
</footer>
