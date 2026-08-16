# SPDX-License-Identifier: Apache-2.0

# Inherit from TWRP base
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, vendor/twrp/config/common.mk)
# Inherit from TECNO-BF7 device
$(call inherit-product, device/tecno/BF7/device.mk)

# Device identifier
PRODUCT_DEVICE   := BF7
PRODUCT_NAME     := twrp_BF7
PRODUCT_MODEL    := TECNO BF7
PRODUCT_BRAND := TECNO
PRODUCT_MANUFACTURER := TECNO

PRODUCT_GMS_CLIENTID_BASE := android-tecno

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="TECNO-BF7-user 12 SP1A.210812.016 release-keys" \
    BUILD_FINGERPRINT="TECNO/TECNO-BF7/TECNO-BF7:12/SP1A.210812.016/$(shell date -u +%Y%m%d):user/release-keys"
