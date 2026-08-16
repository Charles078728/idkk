#!/usr/bin/env bash
# extract-files.sh
# Run this with your BF7 connected via ADB (rooted or in ADB sideload mode)
# to pull the files needed to complete the device tree.

set -e

ADB="adb"
OUT="./extracted"
mkdir -p "$OUT"

echo "[*] Pulling kernel + boot image components..."
$ADB pull /dev/block/by-name/boot "$OUT/boot.img"          2>/dev/null || echo "  [!] boot: try vendor_boot instead"
$ADB pull /dev/block/by-name/vendor_boot "$OUT/vendor_boot.img" 2>/dev/null || echo "  [!] vendor_boot not found"
$ADB pull /dev/block/by-name/dtbo "$OUT/dtbo.img"          2>/dev/null || echo "  [!] dtbo not found"

echo "[*] Pulling partition table info..."
$ADB shell cat /proc/partitions > "$OUT/partitions.txt"
$ADB shell ls -la /dev/block/by-name/ > "$OUT/by-name.txt"

echo "[*] Pulling key props..."
$ADB shell getprop > "$OUT/getprop.txt"
$ADB shell cat /system/build.prop > "$OUT/build.prop" 2>/dev/null || true
$ADB shell cat /vendor/build.prop > "$OUT/vendor.build.prop" 2>/dev/null || true

echo "[*] Pulling fstab..."
$ADB shell find /vendor /system -name "fstab*" 2>/dev/null | while read f; do
    fname=$(echo "$f" | tr '/' '_')
    $ADB pull "$f" "$OUT/$fname" 2>/dev/null || true
done

echo ""
echo "[✓] Done. Check $OUT/ for extracted files."
echo "    → Unpack boot.img with: magiskboot unpack boot.img"
echo "    → Check by-name.txt to verify /dev/block/by-name/userdata path"
echo "    → Check partitions.txt for partition sizes"
