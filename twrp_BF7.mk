# SPDX-License-Identifier: Apache-2.0

# Inherit from TWRP base
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

# Device identifier
PRODUCT_DEVICE   := BF7
PRODUCT_NAME     := twrp_BF7
PRODUCT_MODEL    := TECNO BF7
PRODUCT_MANUFACTURER := TECNO

PRODUCT_GMS_CLIENTID_BASE := android-tecno

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="TECNO-BF7-user 12 SP1A.210812.016 release-keys" \
    BUILD_FINGERPRINT="TECNO/TECNO-BF7/TECNO-BF7:12/SP1A.210812.016/$(shell date -u +%Y%m%d):user/release-keys"

# Explicitly pull in A/B OTA tools
AB_OTA_UPDATER := true

PRODUCT_PACKAGES += \
    bootctrl.mt6761 \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-service \
    android.hardware.boot@1.2-impl.recovery

# F2FS tools
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# fastbootd (for dynamic partition flashing from recovery)
PRODUCT_PACKAGES += \
    fastbootd
