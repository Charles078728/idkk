
# Explicitly pull in A/B OTA tools
AB_OTA_UPDATER := true

PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1-service.trustonic \
    bootctrl.mt6761 \
    bootctrl.mt6761.recovery \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-service \
    android.hardware.boot@1.2-impl.recovery \
    vendor.trustonic.tee@1.1-service \
    vendor.mediatek.hardware.keymaster_attestation@1.1-service


# F2FS tools
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# fastbootd (for dynamic partition flashing from recovery)
PRODUCT_PACKAGES += \
    fastbootd
