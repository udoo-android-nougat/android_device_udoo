#
# Product-specific compile-time definitions.
#

include device/udoo/imx6/soc/imx6sx.mk
include device/udoo/imx6/BoardConfigCommon.mk

# udoo_neo default target for EXT4
BUILD_TARGET_FS ?= ext4

# Build in EXT4
ifeq ($(BUILD_TARGET_FS),ext4)
TARGET_RECOVERY_FSTAB = device/udoo/udoo_neo/fstab_ext4.freescale
PRODUCT_COPY_FILES += \
  device/udoo/udoo_neo/fstab_ext4.freescale:root/fstab.freescale
endif

# Build in F2FS
ifeq ($(BUILD_TARGET_FS),f2fs)
TARGET_RECOVERY_FSTAB = device/udoo/udoo_neo/fstab_f2fs.freescale
PRODUCT_COPY_FILES += \
  device/udoo/udoo_neo/fstab_f2fs.freescale:root/fstab.freescale
endif

# Bootloader (u-boot)
TARGET_BOOTLOADER_CONFIG := imx6sx:mx6sxudooandroid_config
TARGET_BOOTLOADER_BOARD_NAME := UDOO
TARGET_BOOTLOADER_POSTFIX := imx

# Kernel
TARGET_KERNEL_SOURCE := kernel
TARGET_KERNEL_DEFCONF := udoo_sx_android_defconfig
BOARD_KERNEL_IMAGE_NAME := zImage
BOARD_KERNEL_CMDLINE := console=ttymxc1,115200 init=/init androidboot.console=ttymxc1 consoleblank=0 androidboot.hardware=freescale vmalloc=128M cma=448M androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x84800000
LOAD_KERNEL_ENTRY := 0x80008000
TARGET_BOARD_DTS_CONFIG := imx6sx:imx6sx-sdb.dtb
TARGET_BOARD_DTS_FILES := imx6sx-udoo-neo-{basic,basicks,extended,full}{-hdmi,-lvds7,-lvds15,}{-m4,}.dtb
TARGET_BOARD_KERNEL_HEADERS := device/udoo/common/kernel-headers

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

BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/udoo/udoo_neo/bluetooth

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v1
IMX_CAMERA_HAL_V1 := true
TARGET_VSYNC_DIRECT_REFRESH := true

BOARD_SEPOLICY_DIRS := \
       device/udoo/imx6/sepolicy \
       device/udoo/udoo_neo/sepolicy

BOARD_SECCOMP_POLICY += device/udoo/udoo_neo/seccomp
