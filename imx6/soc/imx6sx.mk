#
# SoC-specific compile-time definitions.
#

BOARD_SOC_TYPE := IMX6SX
BOARD_HAVE_VPU := false
HAVE_FSL_IMX_GPU2D := true
HAVE_FSL_IMX_GPU3D := true
HAVE_FSL_IMX_IPU := false
HAVE_FSL_IMX_PXP := true
-include external/fsl_imx_omx/codec_env.mk
TARGET_GRALLOC_VERSION := v2
TARGET_HIGH_PERFORMANCE := false
TARGET_HWCOMPOSER_VERSION = v1.3
TARGET_HAVE_VIV_HWCOMPOSER = true
TARGET_FSL_IMX_2D := GPU2D
USE_OPENGL_RENDERER := true
TARGET_CPU_SMP := false

