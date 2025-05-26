#!/bin/bash

# Modify default IP
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/luci2/bin/config_generate
sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

# Modify default theme
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
sed -i 's/OpenWrt/OneCloud/g' package/base-files/files/bin/config_generate

# 修改默认主机名
sed -i '/uci commit system/i\uci set system.@system[0].hostname='OneCloud'' package/lean/default-settings/files/zzz-default-settings

# 加入编译者信息
sed -i "s/OpenWrt /svefnz build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 替换终端为bash
sed -i 's/\/bin\/ash/\/bin\/bash/' package/base-files/files/etc/passwd

# 网络配置信息，将从 zzz-default-settings 文件的第2行开始添加
sed -i "2i # network config" ./package/lean/default-settings/files/zzz-default-settings
# 默认 IP 地址，旁路由时不会和主路由的 192.168.1.1 冲突
sed -i "3i uci set network.lan.ipaddr='192.168.1.2'" ./package/lean/default-settings/files/zzz-default-settings
sed -i "4i uci set network.lan.proto='static'" ./package/lean/default-settings/files/zzz-default-settings # 静态 IP
sed -i "5i uci set network.lan.type='bridge'" ./package/lean/default-settings/files/zzz-default-settings  # 接口类型：桥接
sed -i "6i uci set network.lan.ifname='eth0'" ./package/lean/default-settings/files/zzz-default-settings  # 网络端口：默认 eth0，第一个接口
sed -i "7i uci set network.lan.netmask='255.255.255.0'" ./package/lean/default-settings/files/zzz-default-settings    # 子网掩码
sed -i "8i uci set network.lan.gateway='192.168.1.1'" ./package/lean/default-settings/files/zzz-default-settings  # 默认网关地址（主路由 IP）
sed -i "9i uci set network.lan.dns='192.168.1.1'" ./package/lean/default-settings/files/zzz-default-settings  # 默认上游 DNS 地址
sed -i "10i uci commit network\n" ./package/lean/default-settings/files/zzz-default-settings
