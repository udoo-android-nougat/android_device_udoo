#
# Product-specific compile-time definitions.
#

include device/udoo/imx6/soc/imx6sx.mk
include device/udoo/imx6/BoardConfigCommon.mk

# udoo_6sx default target for EXT4
BUILD_TARGET_FS ?= ext4

ifeq ($(BUILD_TARGET_DEVICE),sd)
ADDITIONAL_BUILD_PROPERTIES += \
  ro.internel.storage_size=/sys/block/mmcblk0/size \
  ro.boot.storage_type=sd \
  ro.frp.pst=/dev/block/mmcblk0p12
endif

# Build in EXT4
ifeq ($(BUILD_TARGET_FS),ext4)
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_RECOVERY_FSTAB = device/udoo/udoo_6sx/fstab_ext4.freescale
PRODUCT_COPY_FILES += \
  device/udoo/udoo_6sx/fstab_ext4.freescale:root/fstab.freescale
endif

# Build in F2FS
ifeq ($(BUILD_TARGET_FS),f2fs)
TARGET_USERIMAGES_USE_F2FS := true
TARGET_RECOVERY_FSTAB = device/udoo/udoo_6sx/fstab_f2fs.freescale
PRODUCT_COPY_FILES += \
  device/udoo/udoo_6sx/fstab_f2fs.freescale:root/fstab.freescale
endif

TARGET_BOOTLOADER_BOARD_NAME := udoo
PRODUCT_MODEL := udoo-MX6SX

TARGET_BOOTLOADER_POSTFIX := imx

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

BOARD_MODEM_VENDOR := AMAZON

USE_ATHR_GPS_HARDWARE := true
USE_QEMU_GPS_HARDWARE := false

PHONE_MODULE_INCLUDE := flase
#for accelerator sensor, need to define sensor type here
BOARD_HAS_SENSOR := true
SENSOR_MMA8451 := true

# for recovery service
TARGET_SELECT_KEY := 28

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
DM_VERITY_RUNTIME_CONFIG := true

BOARD_KERNEL_CMDLINE := console=ttymxc1,115200 init=/init androidboot.console=ttymxc1 androidboot.dm_verity=disabled consoleblank=0 androidboot.hardware=freescale vmalloc=128M cma=448M

BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/udoo/udoo_6sx/bluetooth

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v1
IMX_CAMERA_HAL_V1 := true
TARGET_VSYNC_DIRECT_REFRESH := true

TARGET_BOOTLOADER_CONFIG := imx6sx:mx6sxudooandroid_config
TARGET_BOARD_DTS_CONFIG := imx6sx:imx6sx-sdb.dtb

BOARD_SEPOLICY_DIRS := \
       device/udoo/imx6/sepolicy \
       device/udoo/udoo_6sx/sepolicy

BOARD_SECCOMP_POLICY += device/udoo/udoo_6sx/seccomp

TARGET_BOARD_KERNEL_HEADERS := device/udoo/common/kernel-headers
