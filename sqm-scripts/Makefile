#
# Copyright (C) 2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sqm-scripts
PKG_SOURCE_VERSION:=ab567ef870c844918e51239c2cdb34e88a8191be
PKG_VERSION:=1.4.1
PKG_RELEASE:=8

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/owen-gu/sqm-scripts


PKG_MAINTAINER:=Toke Høiland-Jørgensen <toke@toke.dk>
PKG_LICENSE:=GPL-2.0-only

include $(INCLUDE_DIR)/package.mk

define Package/sqm-scripts
  SECTION:=net
  CATEGORY:=Base system
  DEPENDS:=+tc +kmod-sched-core +kmod-ifb +iptables \
	+iptables-mod-ipopt +iptables-mod-conntrack-extra \
	+kmod-sched-cake-virtual
  TITLE:=SQM Scripts (QoS)
  PKGARCH:=all
endef

define Package/sqm-scripts/description
 A set of scripts that does simple SQM configuration.
endef

define Package/sqm-scripts/conffiles
/etc/config/sqm
/etc/sqm/sqm.conf
endef

define Package/sqm-scripts/install
	make -C $(PKG_BUILD_DIR) DESTDIR=$(1) PLATFORM=openwrt install
endef

$(eval $(call BuildPackage,sqm-scripts))
