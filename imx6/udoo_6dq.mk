# This is a FSL Android Reference Design platform based on i.MX6Q ARD board
# It will inherit from FSL core product which in turn inherit from Google generic

$(call inherit-product, device/udoo/imx6/imx6.mk)

# Overrides
PRODUCT_NAME := udoo_6dq
PRODUCT_DEVICE := udoo_6dq
PRODUCT_MODEL := UDOO-MX6DQ

# initrc files
PRODUCT_COPY_FILES += \
    device/udoo/udoo_6dq/initrc/init.rc:root/init.freescale.rc \
    device/udoo/udoo_6dq/initrc/init.i.MX6Q.rc:root/init.freescale.i.MX6Q.rc \
    device/udoo/udoo_6dq/initrc/init.i.MX6DL.rc:root/init.freescale.i.MX6DL.rc \
    device/udoo/udoo_6dq/initrc/init.i.MX6QP.rc:root/init.freescale.i.MX6QP.rc

# Wi-Fi firmware
PRODUCT_COPY_FILES += \
    device/udoo/common/wifi/firmware/rt5370/rt2870.bin:system/etc/firmware/rt2870.bin

# Audio
USE_XML_AUDIO_POLICY_CONF := 1
PRODUCT_COPY_FILES += \
    device/udoo/udoo_6dq/audio/audio_effects.conf:system/etc/audio_effects.conf \
    device/udoo/udoo_6dq/audio/audio_policy.conf:system/etc/audio_policy.conf \
    device/udoo/udoo_6dq/audio/audio_policy_configuration.xml:system/etc/audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:system/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:system/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:system/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:system/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:system/etc/audio_policy_volumes.xml

# VPU firmware
PRODUCT_COPY_FILES += \
    external/linux-firmware-imx/firmware/vpu/vpu_fw_imx6d.bin:system/lib/firmware/vpu/vpu_fw_imx6d.bin \
    external/linux-firmware-imx/firmware/vpu/vpu_fw_imx6q.bin:system/lib/firmware/vpu/vpu_fw_imx6q.bin

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    device/udoo/udoo_6dq/required_hardware.xml:system/etc/permissions/required_hardware.xml

PRODUCT_PACKAGES += \
    libEGL_VIVANTE \
    libGLESv1_CM_VIVANTE \
    libGLESv2_VIVANTE \
    gralloc_viv.imx6 \
    hwcomposer_viv.imx6 \
    hwcomposer_fsl.imx6 \
    libGAL \
    libGLSLC \
    libVSC \
    libg2d \
    libgpuhelper

PRODUCT_COPY_FILES += \
    device/fsl-proprietary/gpu-viv/lib/egl/egl.cfg:system/lib/egl/egl.cfg

# Overlays
DEVICE_PACKAGE_OVERLAYS := device/udoo/udoo_6dq/overlay
