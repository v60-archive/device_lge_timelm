#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit from device
$(call inherit-product, device/lge/timelm/device.mk)

# Inherit some common OrangeFox stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := twrp_timelm
PRODUCT_DEVICE := timelm
PRODUCT_BRAND := lge
PRODUCT_MANUFACTURER := LGE
PRODUCT_MODEL := LM-V600

PRODUCT_GMS_CLIENTID_BASE := android-lge

PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceName=timelm \
    BuildDesc="timelm-user 13 TKQ1.220829.002 2318902104908 release-keys" \
    BuildFingerprint=lge/timelm/timelm:13/TKQ1.220829.002/2318902104908:user/release-keys

PRODUCT_SYSTEM_NAME := timelm
PRODUCT_SYSTEM_DEVICE := timelm
PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_DEVICE=$(PRODUCT_SYSTEM_DEVICE) \
    TARGET_PRODUCT=$(PRODUCT_SYSTEM_NAME)
