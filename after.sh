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
