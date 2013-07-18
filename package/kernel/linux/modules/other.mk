#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

OTHER_MENU:=Other modules

WATCHDOG_DIR:=watchdog


define KernelPackage/bluetooth
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Bluetooth support
  DEPENDS:=@USB_SUPPORT +kmod-usb-core +kmod-crypto-hash
  KCONFIG:= \
	CONFIG_BLUEZ \
	CONFIG_BLUEZ_L2CAP \
	CONFIG_BLUEZ_SCO \
	CONFIG_BLUEZ_RFCOMM \
	CONFIG_BLUEZ_BNEP \
	CONFIG_BLUEZ_HCIUART \
	CONFIG_BLUEZ_HCIUSB \
	CONFIG_BLUEZ_HIDP \
	CONFIG_BT \
	CONFIG_BT_L2CAP=y \
	CONFIG_BT_SCO=y \
	CONFIG_BT_RFCOMM \
	CONFIG_BT_BNEP \
	CONFIG_BT_HCIBTUSB \
	CONFIG_BT_HCIUSB \
	CONFIG_BT_HCIUART \
	CONFIG_BT_HCIUART_H4 \
	CONFIG_BT_HIDP \
	CONFIG_HID_SUPPORT=y
  $(call AddDepends/crc16)
  $(call AddDepends/hid)
  $(call AddDepends/rfkill)
  FILES:= \
	$(LINUX_DIR)/net/bluetooth/bluetooth.ko \
	$(LINUX_DIR)/net/bluetooth/rfcomm/rfcomm.ko \
	$(LINUX_DIR)/net/bluetooth/bnep/bnep.ko \
	$(LINUX_DIR)/net/bluetooth/hidp/hidp.ko \
	$(LINUX_DIR)/drivers/bluetooth/hci_uart.ko \
	$(LINUX_DIR)/drivers/bluetooth/btusb.ko
  AUTOLOAD:=$(call AutoLoad,90,bluetooth rfcomm bnep hidp hci_uart btusb)
endef

define KernelPackage/bluetooth/description
 Kernel support for Bluetooth devices
endef

$(eval $(call KernelPackage,bluetooth))


define KernelPackage/bluetooth-hci-h4p
  SUBMENU:=$(OTHER_MENU)
  TITLE:=HCI driver with H4 Nokia extensions
  DEPENDS:=@TARGET_omap24xx +kmod-bluetooth
  KCONFIG:=CONFIG_BT_HCIH4P
  FILES:=$(LINUX_DIR)/drivers/bluetooth/hci_h4p/hci_h4p.ko
  AUTOLOAD:=$(call AutoLoad,91,hci_h4p)
endef

define KernelPackage/bluetooth-hci-h4p/description
  HCI driver with H4 Nokia extensions
endef

$(eval $(call KernelPackage,bluetooth-hci-h4p))


define KernelPackage/eeprom-93cx6
  SUBMENU:=$(OTHER_MENU)
  TITLE:=EEPROM 93CX6 support
  KCONFIG:=CONFIG_EEPROM_93CX6
  FILES:=$(LINUX_DIR)/drivers/misc/eeprom/eeprom_93cx6.ko
  AUTOLOAD:=$(call AutoLoad,20,eeprom_93cx6)
endef

define KernelPackage/eeprom-93cx6/description
 Kernel module for EEPROM 93CX6 support
endef

$(eval $(call KernelPackage,eeprom-93cx6))


define KernelPackage/eeprom-at24
  SUBMENU:=$(OTHER_MENU)
  TITLE:=EEPROM AT24 support
  KCONFIG:=CONFIG_EEPROM_AT24
  DEPENDS:=+kmod-i2c-core
  FILES:=$(LINUX_DIR)/drivers/misc/eeprom/at24.ko
  AUTOLOAD:=$(call AutoLoad,60,at24)
endef

define KernelPackage/eeprom-at24/description
 Kernel module for most I2C EEPROMs
endef

$(eval $(call KernelPackage,eeprom-at24))


define KernelPackage/eeprom-at25
  SUBMENU:=$(OTHER_MENU)
  TITLE:=EEPROM AT25 support
  KCONFIG:=CONFIG_EEPROM_AT25
  FILES:=$(LINUX_DIR)/drivers/misc/eeprom/at25.ko
  AUTOLOAD:=$(call AutoLoad,61,at25)
endef

define KernelPackage/eeprom-at25/description
 Kernel module for most SPI EEPROMs
endef

$(eval $(call KernelPackage,eeprom-at25))


define KernelPackage/gpio-dev
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Generic GPIO char device support
  DEPENDS:=@GPIO_SUPPORT
  KCONFIG:=CONFIG_GPIO_DEVICE
  FILES:=$(LINUX_DIR)/drivers/char/gpio_dev.ko
  AUTOLOAD:=$(call AutoLoad,40,gpio_dev)
endef

define KernelPackage/gpio-dev/description
  Kernel module to allows control of GPIO pins using a character device.
endef

$(eval $(call KernelPackage,gpio-dev))


define KernelPackage/gpio-mcp23s08
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Microchip MCP23xxx I/O expander
  DEPENDS:=@GPIO_SUPPORT
  KCONFIG:=CONFIG_GPIO_MCP23S08
  FILES:=$(LINUX_DIR)/drivers/gpio/gpio-mcp23s08.ko
  AUTOLOAD:=$(call AutoLoad,40,gpio-mcp23s08)
endef

define KernelPackage/gpio-mcp23s08/description
  Kernel module for Microchip MCP23xxx SPI/I2C I/O expander
endef

$(eval $(call KernelPackage,gpio-mcp23s08))


define KernelPackage/gpio-nxp-74hc164
  SUBMENU:=$(OTHER_MENU)
  TITLE:=NXP 74HC164 GPIO expander support
  KCONFIG:=CONFIG_GPIO_NXP_74HC164
  FILES:=$(LINUX_DIR)/drivers/gpio/nxp_74hc164.ko
  AUTOLOAD:=$(call AutoLoad,99,nxp_74hc164)
endef

define KernelPackage/gpio-nxp-74hc164/description
  Kernel module for NXP 74HC164 GPIO expander
endef

$(eval $(call KernelPackage,gpio-nxp-74hc164))

define KernelPackage/gpio-pcf857x
  SUBMENU:=$(OTHER_MENU)
  DEPENDS:=@GPIO_SUPPORT +kmod-i2c-core
  TITLE:=PCX857x, PCA967x and MAX732X I2C GPIO expanders
  KCONFIG:=CONFIG_GPIO_PCF857X
  FILES:=$(LINUX_DIR)/drivers/gpio/gpio-pcf857x.ko
  AUTOLOAD:=$(call AutoLoad,55,gpio-pcf857x)
endef

define KernelPackage/gpio-pcf857x/description
  Kernel module for PCF857x, PCA{85,96}7x, and MAX732[89] I2C GPIO expanders
endef

$(eval $(call KernelPackage,gpio-pcf857x))

define KernelPackage/lp
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Parallel port and line printer support
  DEPENDS:=@BROKEN
  KCONFIG:= \
	CONFIG_PARPORT \
	CONFIG_PRINTER \
	CONFIG_PPDEV
  FILES:= \
	$(LINUX_DIR)/drivers/parport/parport.ko \
	$(LINUX_DIR)/drivers/char/lp.ko \
	$(LINUX_DIR)/drivers/char/ppdev.ko
  AUTOLOAD:=$(call AutoLoad,50,parport lp)
endef

$(eval $(call KernelPackage,lp))


define KernelPackage/mmc
  SUBMENU:=$(OTHER_MENU)
  TITLE:=MMC/SD Card Support
  KCONFIG:= \
	CONFIG_MMC \
	CONFIG_MMC_BLOCK \
	CONFIG_MMC_DEBUG=n \
	CONFIG_MMC_UNSAFE_RESUME=n \
	CONFIG_MMC_BLOCK_BOUNCE=y \
	CONFIG_MMC_SDHCI=n \
	CONFIG_MMC_TIFM_SD=n \
	CONFIG_MMC_WBSD=n \
	CONFIG_SDIO_UART=n
  FILES:= \
	$(LINUX_DIR)/drivers/mmc/core/mmc_core.ko \
	$(LINUX_DIR)/drivers/mmc/card/mmc_block.ko
  AUTOLOAD:=$(call AutoLoad,90,mmc_core mmc_block,1)
endef

define KernelPackage/mmc/description
 Kernel support for MMC/SD cards
endef

$(eval $(call KernelPackage,mmc))


define KernelPackage/oprofile
  SUBMENU:=$(OTHER_MENU)
  TITLE:=OProfile profiling support
  KCONFIG:=CONFIG_OPROFILE
  FILES:=$(LINUX_DIR)/arch/$(LINUX_KARCH)/oprofile/oprofile.ko
  DEPENDS:=@KERNEL_PROFILING
endef

define KernelPackage/oprofile/description
  Kernel module for support for oprofile system profiling.
endef

$(eval $(call KernelPackage,oprofile))


define KernelPackage/rfkill
  SUBMENU:=$(OTHER_MENU)
  TITLE:=RF switch subsystem support
  KCONFIG:= \
    CONFIG_RFKILL \
    CONFIG_RFKILL_INPUT=y \
    CONFIG_RFKILL_LEDS=y \
    CONFIG_RFKILL_GPIO=y
  FILES:= \
    $(LINUX_DIR)/net/rfkill/rfkill.ko
  AUTOLOAD:=$(call AutoLoad,20,rfkill)
  $(call SetDepends/rfkill,+kmod-input-core)
endef

define KernelPackage/rfkill/description
  Say Y here if you want to have control over RF switches
  found on many WiFi and Bluetooth cards.
endef

$(eval $(call KernelPackage,rfkill))


define KernelPackage/softdog
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Software watchdog driver
  KCONFIG:=CONFIG_SOFT_WATCHDOG
  FILES:=$(LINUX_DIR)/drivers/$(WATCHDOG_DIR)/softdog.ko
  AUTOLOAD:=$(call AutoLoad,50,softdog)
endef

define KernelPackage/softdog/description
 Software watchdog driver
endef

$(eval $(call KernelPackage,softdog))


define KernelPackage/ssb
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Silicon Sonics Backplane glue code
  DEPENDS:=@PCI_SUPPORT @!TARGET_brcm47xx @!TARGET_brcm63xx
  KCONFIG:=\
	CONFIG_SSB \
	CONFIG_SSB_B43_PCI_BRIDGE=y \
	CONFIG_SSB_DRIVER_MIPS=n \
	CONFIG_SSB_DRIVER_PCICORE=y \
	CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y \
	CONFIG_SSB_PCIHOST=y \
	CONFIG_SSB_PCIHOST_POSSIBLE=y \
	CONFIG_SSB_POSSIBLE=y \
	CONFIG_SSB_SPROM=y \
	CONFIG_SSB_SILENT=y
  FILES:=$(LINUX_DIR)/drivers/ssb/ssb.ko
  AUTOLOAD:=$(call AutoLoad,29,ssb)
endef

define KernelPackage/ssb/description
  Silicon Sonics Backplane glue code.
endef

$(eval $(call KernelPackage,ssb))


define KernelPackage/bcma
  SUBMENU:=$(OTHER_MENU)
  TITLE:=BCMA support
  DEPENDS:=@PCI_SUPPORT @!TARGET_brcm47xx
  KCONFIG:=\
	CONFIG_BCMA \
	CONFIG_BCMA_POSSIBLE=y \
	CONFIG_BCMA_BLOCKIO=y \
	CONFIG_BCMA_HOST_PCI_POSSIBLE=y \
	CONFIG_BCMA_HOST_PCI=y \
	CONFIG_BCMA_DRIVER_MIPS=n \
	CONFIG_BCMA_DRIVER_PCI_HOSTMODE=n \
	CONFIG_BCMA_DRIVER_GMAC_CMN=n \
	CONFIG_BCMA_DEBUG=n
  FILES:=$(LINUX_DIR)/drivers/bcma/bcma.ko
  AUTOLOAD:=$(call AutoLoad,29,bcma)
endef

define KernelPackage/bcma/description
   Bus driver for Broadcom specific Advanced Microcontroller Bus Architecture.
endef

$(eval $(call KernelPackage,bcma))


define KernelPackage/wdt-omap
  SUBMENU:=$(OTHER_MENU)
  TITLE:=OMAP Watchdog timer
  DEPENDS:=@(TARGET_omap24xx||TARGET_omap35xx)
  KCONFIG:=CONFIG_OMAP_WATCHDOG
  FILES:=$(LINUX_DIR)/drivers/$(WATCHDOG_DIR)/omap_wdt.ko
  AUTOLOAD:=$(call AutoLoad,50,omap_wdt.ko)
endef

define KernelPackage/wdt-omap/description
  Kernel module for TI omap watchdog timer.
endef

$(eval $(call KernelPackage,wdt-omap))


define KernelPackage/wdt-orion
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Marvell Orion Watchdog timer
  DEPENDS:=@TARGET_orion||TARGET_kirkwood||TARGET_mvebu
  KCONFIG:=CONFIG_ORION_WATCHDOG
  FILES:=$(LINUX_DIR)/drivers/$(WATCHDOG_DIR)/orion_wdt.ko
  AUTOLOAD:=$(call AutoLoad,50,orion_wdt)
endef

define KernelPackage/wdt-orion/description
  Kernel module for Marvell Orion, Kirkwood and Armada XP/370 watchdog timer.
endef

$(eval $(call KernelPackage,wdt-orion))


define KernelPackage/booke-wdt
  SUBMENU:=$(OTHER_MENU)
  TITLE:=PowerPC Book-E Watchdog Timer
  DEPENDS:=@(TARGET_mpc85xx||TARGET_ppc40x||TARGET_ppc44x)
  KCONFIG:=CONFIG_BOOKE_WDT
  FILES:=$(LINUX_DIR)/drivers/$(WATCHDOG_DIR)/booke_wdt.ko
  AUTOLOAD:=$(call AutoLoad,50,booke_wdt)
endef

define KernelPackage/booke-wdt/description
  Kernel module for PowerPC Book-E Watchdog Timer.
endef

$(eval $(call KernelPackage,booke-wdt))


define KernelPackage/pwm
  SUBMENU:=$(OTHER_MENU)
  TITLE:=PWM generic API
  KCONFIG:=CONFIG_GENERIC_PWM
  FILES:=$(LINUX_DIR)/drivers/pwm/pwm.ko
  AUTOLOAD:=$(call AutoLoad,50,pwm)
endef

define KernelPackage/pwm/description
 Kernel module that implement a generic PWM API
endef

$(eval $(call KernelPackage,pwm))


define KernelPackage/pwm-gpio
  SUBMENU:=$(OTHER_MENU)
  TITLE:=PWM over GPIO
  DEPENDS:=+kmod-pwm
  KCONFIG:=CONFIG_GPIO_PWM
  FILES:=$(LINUX_DIR)/drivers/pwm/gpio-pwm.ko
  AUTOLOAD:=$(call AutoLoad,51,gpio-pwm)
endef

define KernelPackage/pwm-gpio/description
 Kernel module to models a single-channel PWM device using a timer and a GPIO pin
endef

$(eval $(call KernelPackage,pwm-gpio))


define KernelPackage/rtc-isl1208
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Intersil ISL1208 RTC support
  $(call AddDepends/rtc)
  DEPENDS+=+kmod-i2c-core
  KCONFIG:=CONFIG_RTC_DRV_ISL1208
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-isl1208.ko
  AUTOLOAD:=$(call AutoLoad,60,rtc-isl1208)
endef

define KernelPackage/rtc-isl1208/description
 Kernel module for Intersil ISL1208 RTC.
endef

$(eval $(call KernelPackage,rtc-isl1208))


define KernelPackage/rtc-marvell
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Marvell SoC built-in RTC support
  $(call AddDepends/rtc)
  DEPENDS+=@TARGET_kirkwood||TARGET_orion||TARGET_mvebu
  KCONFIG:=CONFIG_RTC_DRV_MV
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-mv.ko
  AUTOLOAD:=$(call AutoLoad,60,rtc-mv)
endef

define KernelPackage/rtc-marvell/description
 Kernel module for Marvell SoC built-in RTC.
endef

$(eval $(call KernelPackage,rtc-marvell))

define KernelPackage/rtc-pcf8563
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Philips PCF8563/Epson RTC8564 RTC support
  $(call AddDepends/rtc)
  KCONFIG:=CONFIG_RTC_DRV_PCF8563
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-pcf8563.ko
  AUTOLOAD:=$(call AutoLoad,60,rtc-pcf8563)
endef

define KernelPackage/rtc-pcf8563/description
 Kernel module for Philips PCF8563 RTC chip.
 The Epson RTC8564 should work as well.
endef

$(eval $(call KernelPackage,rtc-pcf8563))


define KernelPackage/rtc-pcf2123
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Philips PCF2123 RTC support
  $(call AddDepends/rtc)
  KCONFIG:=CONFIG_RTC_DRV_PCF2123
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-pcf2123.ko
  AUTOLOAD:=$(call AutoLoad,60,rtc-pcf2123)
endef

define KernelPackage/rtc-pcf2123/description
 Kernel module for Philips PCF2123 RTC chip.
endef

$(eval $(call KernelPackage,rtc-pcf2123))

define KernelPackage/rtc-pt7c4338
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Pericom PT7C4338 RTC support
  $(call AddDepends/rtc,+kmod-i2c-core)
  KCONFIG:=CONFIG_RTC_DRV_PT7C4338
  FILES:=$(LINUX_DIR)/drivers/rtc/rtc-pt7c4338.ko
  AUTOLOAD:=$(call AutoLoad,60,rtc-pt7c4338)
endef

define KernelPackage/rtc-pt7c4338/description
 Kernel module for Pericom PT7C4338 i2c RTC chip.
endef

$(eval $(call KernelPackage,rtc-pt7c4338))


define KernelPackage/mtdtests
  SUBMENU:=$(OTHER_MENU)
  TITLE:=MTD subsystem tests
  KCONFIG:=CONFIG_MTD_TESTS
  FILES:=\
	$(LINUX_DIR)/drivers/mtd/tests/mtd_nandecctest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_oobtest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_pagetest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_readtest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_speedtest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_stresstest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_subpagetest.ko \
	$(LINUX_DIR)/drivers/mtd/tests/mtd_torturetest.ko
endef

define KernelPackage/mtdtests/description
 Kernel modules for MTD subsystem/driver testing.
endef

$(eval $(call KernelPackage,mtdtests))


define KernelPackage/nand
  SUBMENU:=$(OTHER_MENU)
  TITLE:=NAND flash support
  KCONFIG:=CONFIG_MTD_NAND \
	CONFIG_MTD_NAND_IDS \
	CONFIG_MTD_NAND_ECC
  FILES:= \
	$(LINUX_DIR)/drivers/mtd/nand/nand_ids.ko \
	$(LINUX_DIR)/drivers/mtd/nand/nand_ecc.ko \
	$(LINUX_DIR)/drivers/mtd/nand/nand.ko
  AUTOLOAD:=$(call AutoLoad,20,nand_ids nand_ecc nand)
endef

define KernelPackage/nand/description
 Kernel module for NAND support.
endef

$(eval $(call KernelPackage,nand))


define KernelPackage/nandsim
  SUBMENU:=$(OTHER_MENU)
  TITLE:=NAND simulator
  DEPENDS:=+kmod-nand
  KCONFIG:=CONFIG_MTD_NAND_NANDSIM
  FILES:=$(LINUX_DIR)/drivers/mtd/nand/nandsim.ko
endef

define KernelPackage/nandsim/description
 Kernel module for NAND flash simulation.
endef

$(eval $(call KernelPackage,nandsim))

define KernelPackage/serial-8250
  SUBMENU:=$(OTHER_MENU)
  TITLE:=8250 UARTs
  KCONFIG:= CONFIG_SERIAL_8250 \
	CONFIG_SERIAL_8250_NR_UARTS=16 \
  	CONFIG_SERIAL_8250_RUNTIME_UARTS=16 \
  	CONFIG_SERIAL_8250_EXTENDED=y \
  	CONFIG_SERIAL_8250_MANY_PORTS=y \
	CONFIG_SERIAL_8250_SHARE_IRQ=y \
	CONFIG_SERIAL_8250_DETECT_IRQ=n \
	CONFIG_SERIAL_8250_RSA=n
  FILES:=$(LINUX_DIR)/drivers/tty/serial/8250/8250$(if $(call kernel_patchver_ge,3.7),$(if $(call kernel_patchver_le,3.8),_core)).ko
endef

define KernelPackage/serial-8250/description
 Kernel module for 8250 UART based serial ports.
endef

$(eval $(call KernelPackage,serial-8250))


define KernelPackage/regmap
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Generic register map support
  DEPENDS:=+kmod-lib-lzo +kmod-i2c-core
  KCONFIG:=CONFIG_REGMAP \
	   CONFIG_REGMAP_SPI \
	   CONFIG_REGMAP_I2C \
	   CONFIG_SPI=y
  FILES:= \
	$(LINUX_DIR)/drivers/base/regmap/regmap-core.ko \
	$(LINUX_DIR)/drivers/base/regmap/regmap-i2c.ko \
	$(LINUX_DIR)/drivers/base/regmap/regmap-spi.ko
  AUTOLOAD:=$(call AutoLoad,21,regmap-core regmap-i2c regmap-spi)
endef

define KernelPackage/regmap/description
  Generic register map support
endef

$(eval $(call KernelPackage,regmap))

define KernelPackage/ikconfig
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Kernel configuration via /proc/config.gz
  KCONFIG:=CONFIG_IKCONFIG \
	   CONFIG_IKCONFIG_PROC=y
  FILES:=$(LINUX_DIR)/kernel/configs.ko
  AUTOLOAD:=$(call AutoLoad,70,configs)
endef

define KernelPackage/ikconfig/description
	Kernel configuration via /proc/config.gz
endef

$(eval $(call KernelPackage,ikconfig))


define KernelPackage/zram
  SUBMENU:=$(OTHER_MENU)
  TITLE:=ZRAM
  DEPENDS:=@!LINUX_3_3 +kmod-lib-lzo
  KCONFIG:= \
	CONFIG_ZSMALLOC \
	CONFIG_ZRAM \
	CONFIG_ZRAM_DEBUG=n
  FILES:= \
	$(LINUX_DIR)/drivers/staging/zsmalloc/zsmalloc.ko \
	$(LINUX_DIR)/drivers/staging/zram/zram.ko
  AUTOLOAD:=$(call AutoLoad,20,zsmalloc zram)
endef

define KernelPackage/zram/description
 Compressed RAM block device support
endef

$(eval $(call KernelPackage,zram))


define KernelPackage/mvsdio
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Marvell SDIO support
  DEPENDS:=@TARGET_orion||TARGET_kirkwood||TARGET_mvebu +kmod-mmc
  KCONFIG:=CONFIG_MMC_MVSDIO
  FILES:=$(LINUX_DIR)/drivers/mmc/host/mvsdio.ko
  AUTOLOAD:=$(call AutoLoad,91,mvsdio)
endef

define KernelPacakge/mvsdio/description
  Kernel support for the Marvell SDIO controller
endef

$(eval $(call KernelPackage,mvsdio))


define KernelPackage/pps
  SUBMENU:=$(OTHER_MENU)
  TITLE:=PPS support
  KCONFIG:=CONFIG_PPS
  FILES:=$(LINUX_DIR)/drivers/pps/pps_core.ko
  AUTOLOAD:=$(call AutoLoad,17,pps_core,1)
endef

define KernelPacakge/pps/description
  PPS (Pulse Per Second) is a special pulse provided by some GPS
  antennae. Userland can use it to get a high-precision time
  reference.
endef

$(eval $(call KernelPackage,pps))


define KernelPackage/ptp
  SUBMENU:=$(OTHER_MENU)
  TITLE:=PTP clock support
  DEPENDS:=+kmod-pps
  KCONFIG:=CONFIG_PTP_1588_CLOCK
  FILES:=$(LINUX_DIR)/drivers/ptp/ptp.ko
  AUTOLOAD:=$(call AutoLoad,18,ptp,1)
endef

define KernelPacakge/ptp/description
  The IEEE 1588 standard defines a method to precisely
  synchronize distributed clocks over Ethernet networks.
endef

$(eval $(call KernelPackage,ptp))


define KernelPackage/ptp-gianfar
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Freescale Gianfar PTP support
  DEPENDS:=@TARGET_mpc85xx +kmod-gianfar +kmod-ptp
  KCONFIG:=CONFIG_PTP_1588_CLOCK_GIANFAR
  FILES:=$(LINUX_DIR)/drivers/net/ethernet/freescale/gianfar_ptp.ko
  AUTOLOAD:=$(call AutoLoad,51,gianfar_ptp)
endef

define KernelPacakge/ptp-gianfar/description
  Kernel module for IEEE 1588 support for Freescale
  Gianfar Ethernet drivers.
endef

$(eval $(call KernelPackage,ptp-gianfar))

define KernelPackage/random-core
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Hardware Random Number Generator Core support
  KCONFIG:=CONFIG_HW_RANDOM
  FILES:=$(LINUX_DIR)/drivers/char/hw_random/rng-core.ko
  AUTOLOAD:=$(call AutoLoad,10,rng-core)
endef

define KernelPackage/random-core/description
   Kernel module for the HW random number generator core infrastructure
endef

$(eval $(call KernelPackage,random-core))
