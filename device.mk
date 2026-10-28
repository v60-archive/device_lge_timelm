#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/lge/timelm

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# A/B Postinstall
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    bootctrl.kona \
    bootctrl.kona.recovery

# Update tools
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# Build QTI Keymaster/QSeecom modules into recovery/system packages
PRODUCT_PACKAGES += \
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

# Copy init configs and recovery VINTF manifest into recovery ramdisk
PRODUCT_COPY_FILES += \
    device/lge/timelm/recovery/root/vendor/etc/init/android.hardware.gatekeeper@1.0-service-qti.rc:$(TARGET_COPY_OUT_RECOVERY)/vendor/etc/init/android.hardware.gatekeeper@1.0-service-qti.rc \
    device/lge/timelm/recovery/root/vendor/etc/init/android.hardware.keymaster@4.0-service-qti.rc:$(TARGET_COPY_OUT_RECOVERY)/vendor/etc/init/android.hardware.keymaster@4.0-service-qti.rc \
    device/lge/timelm/recovery/root/vendor/etc/init/qseecomd.rc:$(TARGET_COPY_OUT_RECOVERY)/vendor/etc/init/qseecomd.rc \
    device/lge/timelm/recovery/root/vendor/etc/init/vendor.qti.hardware.qseecom@1.0-service.rc:$(TARGET_COPY_OUT_RECOVERY)/vendor/etc/init/vendor.qti.hardware.qseecom@1.0-service.rc \
    device/lge/timelm/recovery/root/vendor/etc/vintf/manifest.xml:$(TARGET_COPY_OUT_RECOVERY)/vendor/etc/vintf/manifest.xml
