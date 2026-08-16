
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
