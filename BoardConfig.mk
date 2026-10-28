#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/lge/timelm

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# This is not a Xiaomi Device
OF_DISABLE_MIUI_SPECIFIC_FEATURES=1

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

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := kona
TARGET_NO_BOOTLOADER := true

# Display
TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE := true
TARGET_SCREEN_DENSITY := 420
MAX_VIRTUAL_DISPLAY_DIMENSION := 4096
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
OF_SCREEN_H := 2400
OF_STATUS_H := 100

# Filesystem
TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/config.fs

DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml

# Kernel
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_CMDLINE := \
    androidboot.memcg=1 \
    lpm_levels.sleep_disabled=1 \
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
BOARD_KERNEL_IMAGE_NAME := Image.gz
TARGET_KERNEL_CONFIG := timelm_defconfig
TARGET_KERNEL_SOURCE := kernel/lge/sm8250
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE) --pagesize $(BOARD_KERNEL_PAGESIZE) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) --kernel_offset $(BOARD_KERNEL_OFFSET) --dtb_offset $(BOARD_DTB_OFFSET) --header_version $(BOARD_BOOT_HEADER_VERSION)

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

# Partitions - Dynamic AB
BOARD_LGE_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext odm product vendor
BOARD_SUPER_PARTITION_GROUPS := lge_dynamic_partitions
BOARD_SUPER_PARTITION_SIZE := 21474836480
BOARD_LGE_DYNAMIC_PARTITIONS_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_SIZE) / 2 - 4194304 )  # 20.0 GiB / 2 - 4 MiB
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
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_F2FS := true

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

# TWRP/OrangeFox Configuration
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXCLUDE_APEX := true
TW_NO_LEGACY_PROPS := true
TW_HAS_EDL_MODE := false

TW_FRAMERATE := 60
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047 #  1023
TW_DEFAULT_BRIGHTNESS := 420

# Vibrator
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := "IVibrator/vibratorfeature"

TARGET_RECOVERY_DEVICE_MODULES += libexpat
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libexpat.so

AB_OTA_UPDATER := true
TW_INCLUDE_REBOOT_BOOTLOADER := true
TW_INCLUDE_REBOOT_FASTBOOT_BOOTLOADER := true

OF_AB_DEVICE_WITH_RECOVERY_PARTITION := 1
OF_USE_MAGISKBOOT := 1
OF_USE_MAGISKBOOT_FOR_ALL_PATCHES := 1
OF_DONT_PATCH_ENCRYPTED_DEVICE := 1
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
OF_SKIP_FBE_DECRYPTION := 0
OF_NO_RELOAD_AFTER_DECRYPTION := 1
OF_FIX_DECRYPTION_ON_DATA_MEDIA := 1
OF_USE_SYSTEM_FINGERPRINT := 1
OF_DEFAULT_KEYMASTER_VERSION := 4.0

TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
OF_ENABLE_LPTOOLS := 1
TW_USE_FSCRYPT_POLICY := 2

TW_CRYPTO_FS_TYPE := "f2fs"
TW_CRYPTO_REAL_BLKDEV := "/dev/block/bootdevice/by-name/userdata"
TW_CRYPTO_MNT_POINT := "/data"
TW_CRYPTO_FS_OPTIONS := "noatime,nosuid,nodev,discard,reserve_root=32768,resgid=1065,fsync_mode=nobarrier,inlinecrypt,inlinecrypt_optimized"
TW_CRYPTO_FS_FLAGS := "0x00000406"
TW_CRYPTO_KEY_LOC := "footer"

TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_USES_MKE2FS := true
TW_NO_SCREEN_BLANK := true
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true

TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.product;ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental;ro.product.device=ro.product.system.device;ro.product.model=ro.product.system.model;ro.product.name=ro.product.system.name"

BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SUPPRESS_SECURE_ERASE := true
TW_USE_LEGACY_BATTERY_SERVICES := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_FUSE_EXFAT := true
TW_INCLUDE_FUSE_NTFS := true
TW_NO_EXFAT_FUSE := true
TW_EXCLUDE_ENCRYPTED_BACKUPS := false

TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# Include QTI Keymaster, QSeecom, and Cryptographic modules in recovery ramdisk
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hardware.gatekeeper@1.0-impl-qti \
    android.hardware.gatekeeper@1.0-service-qti \
    android.hardware.keymaster@4.0-service-qti \
    libqtikeymaster4 \
    libkeymasterdeviceutils \
    libkeymasterutils \
    libkeymasterprovision \
    libqcbor \
    libspcom \
    libQSEEComAPI \
    libdiag \
    libdrmfs \
    libion \
    libxml2 \
    qseecomd \
    vendor.qti.hardware.qseecom@1.0 \
    vendor.qti.hardware.qseecom@1.0-service
