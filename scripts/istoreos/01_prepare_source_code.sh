#!/bin/bash

source ./scripts/funcations.sh

# 开始克隆仓库，并行执行
clone_repo $istoreos_repo istoreos-22.03 openwrt &
clone_repo $immortalwrt_repo master immortalwrt_ma &
clone_repo $immortalwrt_pkg_repo master immortalwrt_pkg &
clone_repo $immortalwrt_luci_repo openwrt-23.05 immortalwrt_luci_23 &
clone_repo $immortalwrt_pkg_repo openwrt-21.02 immortalwrt_pkg_21 &
clone_repo $openwrt_pkg_repo master openwrt_pkg_ma &
clone_repo $lede_repo master lede &
clone_repo $lede_luci_repo master lede_luci &
clone_repo $diskman_repo master diskman &
clone_repo $mosdns_repo v5 mosdns &
clone_repo $mihomo_repo main mihomo &
clone_repo $node_prebuilt_repo packages-22.03 node &
clone_repo $passwall_pkg_repo main passwall_pkg &
clone_repo $passwall_luci_repo main passwall_luci &
clone_repo $v2ray_geodata_repo master v2ray_geodata &
clone_repo $dockerman_repo master dockerman &
# 等待所有后台任务完成
wait

# 修改默认 IP 为 192.168.1.99
sed -i 's# '\''dhcp'\''##' openwrt/target/linux/amlogic/base-files/etc/board.d/02_network
sed -i 's,192.168.100.1,192.168.1.99,g' openwrt/package/istoreos-files/Makefile
# 修改 overlay 分区大小
sed -i 's,2812,1788,' openwrt/target/linux/amlogic/meson/base-files/usr/sbin/install-to-emmc.sh
# 取消 argon 默认主题
sed -i -e '/luci-theme-argon/d' -e '75,83d' openwrt/package/istoreos-files/Makefile
sed -i '65,71d' openwrt/package/istoreos-files/files/etc/uci-defaults/09_istoreos
rm openwrt/package/istoreos-files/files/etc/uci-defaults/99_theme

exit 0
