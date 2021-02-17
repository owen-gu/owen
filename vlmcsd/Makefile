include $(TOPDIR)/rules.mk

PKG_NAME:=vlmcsd
PKG_VERSION:=svn1113
PKG_RELEASE:=1

PKG_MAINTAINER:=fuyumi <280604399@qq.com>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/cokebar/vlmcsd.git
PKG_SOURCE_VERSION:=8fff445a290cb6f2929ae593f0e0e5ad722c1927

PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR)-$(PKG_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)
PKG_BUILD_PARALLEL:=1


include $(INCLUDE_DIR)/package.mk

define Package/vlmcsd
	SECTION:=net
	CATEGORY:=Network
	TITLE:=vlmcsd for openwrt
	URL:=https://forums.mydigitallife.info/threads/50234-Emulated-KMS-Servers-on-non-Windows-platforms
	DEPENDS:=+libc +libpthread
endef

MAKE_FLAGS += \
	VLMCSD_VERSION="$(PKG_VERSION)" \
	vlmcsd

define Package/vlmcsd/description
	vlmcsd for openwrt-$(BOARD)
endef

define Package/vlmcsd/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vlmcsd $(1)/usr/sbin/vlmcsd
endef

define Package/vlmcsd/prerm
#!/bin/sh
	if [ -f /etc/dnsmasq.conf ]; then
		sed -i '/^srv-host=_vlmcs\._tcp/d' /etc/dnsmasq.conf
	fi
	if [ -n "$$(awk '/vlmcsd\.log/{print $$0}' /etc/crontabs/root)" ];then
		sed -i '/vlmcsd\.log/d' /etc/crontabs/root >/dev/null 2>&1
	fi
	rm -rf /var/log/vlmcsd.log 2>/dev/null
	if pidof vlmcsd >/dev/null; then
	killall vlmcsd
	fi
	exit 0
endef

$(eval $(call BuildPackage,vlmcsd))
