#!/bin/bash
#=================================================
# DIY script
# jsjson@163.com 
#=================================================
##链接
rm -rf package/feeds/packages/containerd
rm -rf package/feeds/packages/runc
rm -rf package/feeds/packages/tini
rm -rf package/feeds/packages/docker-ce
rm -rf package/feeds/packages/libnetwork
ln -s -f ../../../feeds/xiangfeidexiaohuo/docker-op/containerd package/feeds/xiangfeidexiaohuo/containerd
ln -s -f ../../../feeds/xiangfeidexiaohuo/docker-op/docker-ce package/feeds/xiangfeidexiaohuo/docker-ce
ln -s -f ../../../feeds/xiangfeidexiaohuo/docker-op/runc package/feeds/xiangfeidexiaohuo/runc
ln -s -f ../../../feeds/xiangfeidexiaohuo/docker-op/tini package/feeds/xiangfeidexiaohuo/tini
ln -s -f ../../../feeds/xiangfeidexiaohuo/docker-op/libnetwork package/feeds/xiangfeidexiaohuo/libnetwork
ln -s -f ../../../feeds/xiangfeidexiaohuo/k3screenctrl package/feeds/xiangfeidexiaohuo/k3screenctrl               

##补充汉化       
cp -f ./feeds/xiangfeidexiaohuo/files/udpxy.lua ./feeds/luci/applications/luci-app-udpxy/luasrc/model/cbi
cp -f ./feeds/xiangfeidexiaohuo/files/mwan3.po ./feeds/luci/applications/luci-app-mwan3/po/zh-cn
              
 ##配置ip等
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm-k3|TARGET_DEVICES += phicomm-k3| ; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
#sed -i 's/KERNEL_PATCHVER:=4.19/KERNEL_PATCHVER:=5.4/g' target/linux/bcm53xx/Makefile

##取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile

##修复Bypass编译
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}

##加入作者信息
sed -i "s/DISTRIB_REVISION='*.*'/DISTRIB_REVISION='YaoDao $(date +%Y%m%d)'/g" package/lean/default-settings/files/zzz-default-settings

