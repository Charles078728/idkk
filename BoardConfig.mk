# SPDX-License-Identifier: Apache-2.0
# Device: Tecno BF7 (Spark Go 2023)
# SoC  : MediaTek MT6761 (Helio A22)
# TWRP device tree — fill in values marked [VERIFY] from your stock firmware

LOCAL_PATH := device/tecno/TECNO-BF7

# ─── Architecture ───────────────────────────────────────────────────────────
TARGET_ARCH         := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI      := arm64-v8a
TARGET_CPU_ABI2     :=
TARGET_CPU_VARIANT  := cortex-a53

TARGET_2ND_ARCH         := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI      := armeabi-v7a
TARGET_2ND_CPU_ABI2     := armeabi
TARGET_2ND_CPU_VARIANT  := cortex-a53

# ─── Bootloader ─────────────────────────────────────────────────────────────
TARGET_BOOTLOADER_BOARD_NAME := mt6761
TARGET_NO_BOOTLOADER         := true

# ─── Platform ───────────────────────────────────────────────────────────────
TARGET_BOARD_PLATFORM         := mt6761
TARGET_BOARD_PLATFORM_GPU     := mali-g52

# ─── Kernel (prebuilt) ──────────────────────────────────────────────────────
# Extract from stock boot.img with: magiskboot unpack boot.img
# Then copy kernel → prebuilt/kernel
TARGET_PREBUILT_KERNEL                := $(LOCAL_PATH)/prebuilt/kernel
TARGET_PREBUILT_DTB                   := $(LOCAL_PATH)/prebuilt/dtb.img   # [VERIFY] may be inside boot.img
BOARD_PREBUILT_DTBOIMAGE              := $(LOCAL_PATH)/prebuilt/dtbo.img  # [VERIFY]

BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 \
                        androidboot.selinux=permissive

BOARD_KERNEL_BASE          := 0x40000000
BOARD_KERNEL_PAGESIZE      := 2048
BOARD_KERNEL_OFFSET        := 0x00008000
BOARD_RAMDISK_OFFSET       := 0x11b00000
BOARD_KERNEL_SECOND_OFFSET := 0x00f00000
BOARD_KERNEL_TAGS_OFFSET   := 0x07880000
BOARD_DTB_OFFSET           := 0x07880000

# [VERIFY] these with magiskboot unpack output:
BOARD_KERNEL_IMAGE_NAME    := Image.gz

BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

# ─── Partitions ─────────────────────────────────────────────────────────────
# [VERIFY] sizes with: adb shell cat /proc/partitions  OR  blockdev --getsize64 /dev/block/...
BOARD_FLASH_BLOCK_SIZE           := 131072          # 128KB (pagesize * 64)

# A/B (Virtual A/B on MT6761 Android 12 may still use legacy A/B — confirm below)
AB_OTA_UPDATER      := true
AB_OTA_PARTITIONS   := boot vendor_boot system vendor product odm

# Dynamic partitions (Android 12 almost certainly uses this)
BOARD_SUPER_PARTITION_SIZE            := 3221225472  # [VERIFY] typically 3 GiB on BF7
BOARD_SUPER_PARTITION_GROUPS          := main
BOARD_MAIN_SIZE                       := 3217031168  # super - 4MB overhead
BOARD_MAIN_PARTITION_LIST             := system vendor product odm

# Boot / vendor_boot
BOARD_BOOT_HEADER_VERSION   := 4  # [VERIFY] — Android 12 GKI uses v4; legacy may use v2
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x06000000  # 96 MiB [VERIFY]
BOARD_BOOTIMAGE_PARTITION_SIZE        := 0x02000000  # 32 MiB [VERIFY]

# ─── Recovery ───────────────────────────────────────────────────────────────
# Ramdisk is in vendor_boot on GKI devices; set accordingly
TARGET_RECOVERY_FSTAB           := $(LOCAL_PATH)/recovery/root/system/etc/recovery.fstab
BOARD_USES_RECOVERY_AS_BOOT     := true  # [VERIFY] — true if no separate recovery partition

# ─── File system ────────────────────────────────────────────────────────────
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_EXT4           := true
TARGET_USERIMAGES_USE_F2FS           := true

# ─── TWRP-specific ──────────────────────────────────────────────────────────
TW_THEME                    := portrait_hdpi
TW_SCREEN_BLANK_ON_BOOT    := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

TW_BRIGHTNESS_PATH          := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS           := 2047
TW_DEFAULT_BRIGHTNESS       := 1200

TW_NO_FASTBOOT_BOOT         := true   # prevents reboot-to-system loop on MT6761

TW_INCLUDE_RESETPROP        := true
TW_INCLUDE_REPACKTOOLS      := true
TW_INCLUDE_LIBRESETPROP     := true

TW_EXTRA_LANGUAGES          := false
TW_DEFAULT_LANGUAGE         := en

# A/B boot control (matches AB_OTA_UPDATER)
TW_INCLUDE_AB_ZIPDEC        := true

# Crypto / FBE (Android 12 uses metadata encryption)
TW_INCLUDE_CRYPTO           := true
TW_INCLUDE_CRYPTO_FBE       := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_PARTITION := true

# USB
TW_USE_TOOLBOX              := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun

# MTP
TW_HAS_MTP                 := true

# LogD / Debug
TWRP_INCLUDE_LOGCAT        := true
TARGET_USES_LOGD           := true

# ─── Vendor / MTK blobs ─────────────────────────────────────────────────────
# If decrypt doesn't work, you may need TEE/Trustonic blobs from stock
# TW_OVERRIDE_SYSTEM_PROPS  := "ro.build.version.release=12;ro.build.version.sdk=31"
