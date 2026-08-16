# TWRP Device Tree — Tecno BF7 (MT6761, Android 12)

> **Status:** Skeleton — requires hardware-specific values before building

---

## Device Info

| Field | Value |
|---|---|
| Device | Tecno Spark Go 2023 (BF7) |
| Codename | TECNO-BF7 |
| SoC | MediaTek MT6761 (Helio A22) |
| Architecture | arm64 |
| Android | 12 |
| Partitions | A/B + Dynamic (super) |
| Encryption | FBE (aes-256-xts) + Metadata |

---

## Before Building — Verify These Values

### 1. Extract boot image components

```bash
chmod +x extract-files.sh
./extract-files.sh          # with device connected via ADB
```

Then unpack:

```bash
magiskboot unpack extracted/boot.img
# → kernel, dtb, ramdisk.cpio
```

Copy outputs to `prebuilt/`:
```
prebuilt/kernel
prebuilt/dtb.img
prebuilt/dtbo.img
```

---

### 2. Verify kernel offsets

From `magiskboot unpack` output, confirm these match `BoardConfig.mk`:

```
BOARD_KERNEL_BASE
BOARD_KERNEL_OFFSET
BOARD_RAMDISK_OFFSET
BOARD_KERNEL_TAGS_OFFSET
BOARD_KERNEL_PAGESIZE
BOARD_BOOTIMG_HEADER_VERSION
```

---

### 3. Verify partition sizes

```bash
cat extracted/partitions.txt
# OR on device:
adb shell blockdev --getsize64 /dev/block/by-name/boot
adb shell blockdev --getsize64 /dev/block/by-name/super
```

Update in `BoardConfig.mk`:
- `BOARD_BOOTIMAGE_PARTITION_SIZE`
- `BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE`
- `BOARD_SUPER_PARTITION_SIZE`

---

### 4. Verify /data block device path

```bash
cat extracted/by-name.txt | grep userdata
```

Update in `recovery/root/system/etc/recovery.fstab` — the `/data` line.

---

### 5. Verify metadata partition name

```bash
cat extracted/by-name.txt | grep -E "meta|md_udc"
```

Common values on MT6761: `md_udc` or `metadata`. Update fstab accordingly.

---

### 6. Verify boot control HAL version

```bash
grep -i bootctrl extracted/vendor.build.prop
grep "ro.boot.dynamic_partitions" extracted/getprop.txt
```

If `bootctrl` version is `1.1` or `1.2`, update product makefile package accordingly.

---

## Build

```bash
# In TWRP source root (android-12.1 branch recommended for MT6761)
source build/envsetup.sh
lunch omni_TECNO-BF7-eng
mka recoveryimage
```

---

## Known Issues / Notes

| Issue | Fix |
|---|---|
| Reboot-to-system loop | `TW_NO_FASTBOOT_BOOT := true` — already set |
| `/data` mount failure | Verify fstab block path (step 4 above) |
| Boot image > 32 MiB | Reduce kernel + ramdisk or check actual partition size |
| Decrypt broken | May need Trustonic TEE blobs from stock vendor |

---

## References

- [TWRP device tree guide](https://github.com/minimal-manifest-twrp)
- [MTK partition reference](https://github.com/MediaTek-Labs)
- Tecno BF7 XDA thread (search XDA forums)
