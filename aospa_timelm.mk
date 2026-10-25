#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

ifeq (aospa_timelm,$(TARGET_PRODUCT))

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from the device configuration.
$(call inherit-product, device/lge/timelm/device.mk)

# Inherit from the AOSPA configuration.
$(call inherit-product, vendor/aospa/target/product/aospa-target.mk)

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := aospa_timelm
PRODUCT_DEVICE := timelm
PRODUCT_MANUFACTURER := LGE
PRODUCT_BRAND := lge
PRODUCT_MODEL := LM-V600

# Bootanimation resolution
TARGET_BOOT_ANIMATION_RES := 1080

PRODUCT_GMS_CLIENTID_BASE := android-lge

PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceName=timelm \
    BuildDesc="timelm-user 13 TKQ1.220829.002 2318902104908 release-keys" \
    BuildFingerprint=lge/timelm/timelm:13/TKQ1.220829.002/2318902104908:user/release-keys

endif
