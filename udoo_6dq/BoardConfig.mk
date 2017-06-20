#
# Product-specific compile-time definitions.
#

include device/udoo/imx6/soc/imx6dq.mk
include device/udoo/imx6/BoardConfigCommon.mk

# udoo_6dq default target for EXT4
BUILD_TARGET_FS ?= ext4

# Build in EXT4
ifeq ($(BUILD_TARGET_FS),ext4)
TARGET_RECOVERY_FSTAB = device/udoo/udoo_6dq/fstab_ext4.freescale
PRODUCT_COPY_FILES += \
  device/udoo/udoo_6dq/fstab_ext4.freescale:root/fstab.freescale
endif

# Build in F2FS
ifeq ($(BUILD_TARGET_FS),f2fs)
TARGET_RECOVERY_FSTAB = device/udoo/udoo_6dq/fstab_f2fs.freescale
PRODUCT_COPY_FILES += \
  device/udoo/udoo_6dq/fstab_f2fs.freescale:root/fstab.freescale
endif

# Bootloader (u-boot)
TARGET_BOOTLOADER_CONFIG := imx6q:udoo_qd_android_config
TARGET_BOOTLOADER_BOARD_NAME := UDOO
TARGET_BOOTLOADER_POSTFIX := imx

# Kernel
TARGET_KERNEL_DEFCONF := udoo_quad_dual_android_defconfig
BOARD_KERNEL_CMDLINE := console=ttymxc1,115200 init=/init vmalloc=128M androidboot.console=ttymxc1 consoleblank=0 androidboot.hardware=freescale cma=448M androidboot.selinux=permissive
TARGET_BOARD_DTS_CONFIG := imx6q:imx6q-udoo-hdmi.dtb
TARGET_BOARD_KERNEL_HEADERS := device/udoo/common/kernel-headers
TARGET_KERNEL_MODULES := \
    arch/arm/boot/dts/imx6dl-udoo-hdmi.dtb:system/dts/imx6dl-udoo-hdmi.dtb \
    arch/arm/boot/dts/imx6dl-udoo-lvds7.dtb:system/dts/imx6dl-udoo-lvds7.dtb \
    arch/arm/boot/dts/imx6dl-udoo-lvds15.dtb:system/dts/imx6dl-udoo-lvds15.dtb \
    arch/arm/boot/dts/imx6q-udoo-hdmi.dtb:system/dts/imx6q-udoo-hdmi.dtb \
    arch/arm/boot/dts/imx6q-udoo-lvds7.dtb:system/dts/imx6q-udoo-lvds7.dtb \
    arch/arm/boot/dts/imx6q-udoo-lvds15.dtb:system/dts/imx6q-udoo-lvds15.dtb

TARGET_RELEASETOOLS_EXTENSIONS := device/udoo/imx6
# UNITE is a virtual device.
BOARD_WLAN_DEVICE            := UNITE
WPA_SUPPLICANT_VERSION       := VER_0_8_UNITE

BOARD_WPA_SUPPLICANT_DRIVER  := NL80211
BOARD_HOSTAPD_DRIVER         := NL80211

BOARD_HOSTAPD_PRIVATE_LIB_BCM               := lib_driver_cmd_bcmdhd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_BCM        := lib_driver_cmd_bcmdhd

BOARD_SUPPORT_BCM_WIFI  := true
#for intel vendor
ifeq ($(BOARD_WLAN_VENDOR),INTEL)
BOARD_HOSTAPD_PRIVATE_LIB                := private_lib_driver_cmd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB         := private_lib_driver_cmd
WPA_SUPPLICANT_VERSION                   := VER_0_8_X
HOSTAPD_VERSION                          := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB         := private_lib_driver_cmd_intel
WIFI_DRIVER_MODULE_PATH                  := "/system/lib/modules/iwlagn.ko"
WIFI_DRIVER_MODULE_NAME                  := "iwlagn"
WIFI_DRIVER_MODULE_PATH                  ?= auto
endif

WIFI_DRIVER_FW_PATH_STA        := "/system/etc/firmware/bcm/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P        := "/system/etc/firmware/bcm/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP         := "/system/etc/firmware/bcm/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_PARAM      := "/sys/module/bcmdhd/parameters/firmware_path"

# for recovery service
TARGET_SELECT_KEY := 28

# we don't support sparse image.
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

# Broadcom BCM4339 BT
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/udoo/udoo_6dq/bluetooth

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v3
IMX_CAMERA_HAL_V3 := true

#define consumer IR HAL support
IMX6_CONSUMER_IR_HAL := false

BOARD_SEPOLICY_DIRS := \
       device/udoo/imx6/sepolicy \
       device/udoo/udoo_6dq/sepolicy

BOARD_SECCOMP_POLICY += device/udoo/udoo_6dq/seccomp
