#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/lge/timelm

BUILD_BROKEN_DUP_RULES := true

# A/B
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    recovery \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a55

# Audio
AUDIO_FEATURE_ENABLED_AAC_ADTS_OFFLOAD := true
AUDIO_FEATURE_ENABLED_AUDIOSPHERE := true
AUDIO_FEATURE_ENABLED_COMPRESS_VOIP := false
AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT := true
AUDIO_FEATURE_ENABLED_EXTN_FORMATS := true
AUDIO_FEATURE_ENABLED_FM_POWER_OPT := true
AUDIO_FEATURE_ENABLED_HDMI_SPK := true
AUDIO_FEATURE_ENABLED_INSTANCE_ID := true

# Audio - Sound Trigger
BOARD_SUPPORTS_SOUND_TRIGGER := true
BOARD_SUPPORTS_OPENSOURCE_STHAL := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := kona
TARGET_NO_BOOTLOADER := true

# Display
TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE := true

# Gralloc: resolve impl-defined + UBWC + 10-bit buffers to TP10_UBWC (CamX asks for
# these when recording HDR video; without it the buffer size is too small)
SOONG_CONFIG_qtidisplay += target_uses_tp10_ubwc_for_10bit
SOONG_CONFIG_qtidisplay_target_uses_tp10_ubwc_for_10bit := true
TARGET_SCREEN_DENSITY := 420
MAX_VIRTUAL_DISPLAY_DIMENSION := 4096
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# Filesystem
TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/config.fs

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    hardware/lge/vintf/device_framework_matrix.xml

# Kernel
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_CMDLINE := \
    androidboot.memcg=1 \
    msm_rtb.filter=0x237 \
    service_locator.enable=1 \
    swiotlb=2048 \
    loop.max_part=7 \
    androidboot.usbcontroller=a600000.dwc3 \
    kpti=off \
    cgroup.memory=nokmem,nosocket \
    androidboot.hardware=timelm \
    androidboot.init_fatal_reboot_target=recovery
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_DTB_OFFSET := 0x01f00000
TIMELM_PREBUILT_KERNEL_DIR := kernel/lge/sm8250
TARGET_PREBUILT_KERNEL := $(TIMELM_PREBUILT_KERNEL_DIR)/Image.gz
BOARD_PREBUILT_DTBIMAGE_DIR := $(TIMELM_PREBUILT_KERNEL_DIR)/dtb
BOARD_PREBUILT_DTBOIMAGE := $(TIMELM_PREBUILT_KERNEL_DIR)/dtbo.img
# The qcom Make modules read the kernel uapi from KERNEL_OBJ/usr only with
# this set; vendor/aospa sets it only for kernels built from source.
TARGET_COMPILE_WITH_MSM_KERNEL := true
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE) --pagesize $(BOARD_KERNEL_PAGESIZE) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) --kernel_offset $(BOARD_KERNEL_OFFSET) --dtb_offset $(BOARD_DTB_OFFSET) --header_version $(BOARD_BOOT_HEADER_VERSION)

# Kernel modules
# The vendor drivers ride in the boot ramdisk during the msm-5.15 port: there
# is no vendor_boot, so the build puts the vendor ramdisk modules in the boot
# ramdisk and first stage init loads them in this order.
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := \
    sched-walt.ko \
    qcom_lpm.ko \
    msm_kgsl.ko \
    audio_q6_pdr.ko \
    audio_q6_notifier.ko \
    audio_snd_event.ko \
    audio_apr.ko \
    audio_adsp_loader.ko \
    audio_q6.ko \
    audio_bolero_cdc.ko \
    audio_es9218.ko \
    audio_wcd9xxx.ko \
    audio_mbhc.ko \
    audio_wcd_core.ko \
    audio_swr.ko \
    audio_wcd938x.ko \
    audio_wsa881x.ko \
    audio_wsa883x.ko \
    audio_machine.ko \
    audio_pinctrl_lpi.ko \
    audio_pinctrl_wcd.ko \
    audio_platform.ko \
    audio_swr_ctrl.ko \
    audio_rx_macro.ko \
    audio_stub.ko \
    audio_tfa9878.ko \
    audio_tx_macro.ko \
    audio_va_macro.ko \
    audio_wcd938x_slave.ko \
    audio_wsa_macro.ko \
    cnss_utils.ko \
    btpower.ko \
    wlan_firmware_service.ko \
    cnss_plat_ipc_qmi_svc.ko \
    cnss_prealloc.ko \
    cnss_nl.ko \
    cnss2.ko \
    qca_cld3_qca6390.ko \
    rmnet_ctl.ko \
    rmnet_core.ko \
    camera.ko \
    et713.ko \
    cxd22xx.ko \
    msm-vidc.ko \
    msm-cvp.ko \
    qce50_dlkm.ko \
    qcedev-mod_dlkm.ko \
    smcinvoke_dlkm.ko
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := \
    $(addprefix $(TIMELM_PREBUILT_KERNEL_DIR)/modules/,$(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD))

# Media
TARGET_MEDIA_COMPONENT_VARIANT := media-legacy

# Partitions
BOARD_USES_METADATA_PARTITION := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_INCLUDE_RECOVERY_DTBO := true

# Partitions - Dynamic AB
BOARD_LGE_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext odm product vendor
BOARD_SUPER_PARTITION_GROUPS := lge_dynamic_partitions
BOARD_SUPER_PARTITION_SIZE := 21474836480
BOARD_LGE_DYNAMIC_PARTITIONS_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_SIZE) / 2 - 4194304 ) # 20.0 GiB / 2 - 4 MiB
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := kona

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/init/fstab.timelm
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_F2FS := true

# Recovery - UFS: msm-5.15 has the upstream UFS BSG (ufs-bsg0, scsi/scsi_bsg_ufs.h)
SOONG_CONFIG_NAMESPACES += ufsbsg
SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# SEPolicy
include device/qcom/sepolicy_vndr/SEPolicy.mk
include hardware/lge/sepolicy/SEPolicy.mk

# Vendor SPL
VENDOR_SECURITY_PATCH := 2023-07-01

# Verified Boot
BOARD_AVB_ENABLE := true

ifneq (,$(AVB_CUSTOM_KEY_PATH))
BOARD_AVB_ALGORITHM := $(AVB_CUSTOM_ALGORITHM)
BOARD_AVB_KEY_PATH := $(AVB_CUSTOM_KEY_PATH)
else
AVB_CUSTOM_ALGORITHM := SHA256_RSA2048
AVB_CUSTOM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
endif

ifneq ($(WITH_AVB),true)
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
endif

BOARD_AVB_VBMETA_SYSTEM := system vendor product
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := $(AVB_CUSTOM_ALGORITHM)
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := $(AVB_CUSTOM_KEY_PATH)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 1

# WiFi
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wlan"
WIFI_DRIVER_STATE_OFF := "OFF"
WIFI_DRIVER_STATE_ON := "ON"
WIFI_FEATURE_HOSTAPD_11AX := true
WIFI_HIDL_FEATURE_AWARE := true
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION := VER_0_8_X
QC_WIFI_HIDL_FEATURE_DUAL_AP := true
CONFIG_ACS := true

# Inherit the proprietary files
include vendor/lge/timelm/BoardConfigVendor.mk
