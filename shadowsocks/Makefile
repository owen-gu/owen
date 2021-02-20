#
# Copyright (C) 2017-2019 Yousong Zhou <yszhou4tech@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

# Checklist when bumping versions
#
# - update cipher list by checking src/crypto.c:crypto_init()
# - check if default mode has changed from being tcp_only
#
PKG_NAME:=shadowsocks-libev
PKG_VERSION:=3.3.5
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/shadowsocks/shadowsocks-libev/releases/tag/v$(PKG_VERSION)
PKG_HASH:=72d7d9217ce2a8a59dc647e8f1fbbd77f7cd30aa

PKG_MAINTAINER:=Yousong Zhou <yszhou4tech@gmail.com>

PKG_LICENSE:=GPL-3.0+
PKG_LICENSE_FILES:=LICENSE

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1
PKG_BUILD_DEPENDS:=c-ares pcre

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocks/Default
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Lightweight Secured Socks5 Proxy $(2)
	URL:=https://github.com/shadowsocks/
	VARIANT:=$(1)
	DEPENDS:=+libcares +libev +libmbedtls +libpcre +libpthread +libsodium +zlib
endef

Package/shadowsocks = $(call Package/shadowsocks/Default,openssl,(OpenSSL),+libopenssl)


define Package/shadowsocks/description
Shadowsocks is a lightweight secured socks5 proxy for embedded devices and low end boxes.
endef

define Package/shadowsocks/conffiles
/etc/shadowsocks.json
endef


CONFIGURE_ARGS += --disable-ssp --disable-documentation --disable-assert


define Package/shadowsocks/install
  $(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/shadowsocks.config $(1)/etc/config/shadowsocks
	$(INSTALL_BIN) ./files/shadowsocks.init $(1)/etc/init.d/shadowsocks
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-local $(1)/usr/bin/sslocal
endef



$(eval $(call BuildPackage,shadowsocks))
