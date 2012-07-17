#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gupnp-av
PKG_VERSION:=0.9.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://ftp.gnome.org/pub/GNOME/sources/gupnp-av/0.9/
PKG_SHA256SUM:=63b07ee2045f3eb9c3cd9eaf71a042c318823eb2170b5979b2b78c57af886580

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

TARGET_LDFLAGS+=\
        -Wl,-rpath-link=$(STAGING_DIR)/usr/lib

define Package/libgupnp-av
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Library for dealing with UPnP/AV profiles
  URL:=http://www.gupnp.org/
  DEPENDS:=+libgupnp
endef

define Package/libgupnp-av/description
GUPnP A/V is a small utility library that aims to ease the handling and implementation of UPnP A/V profiles.
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/{lib/pkgconfig,include/gupnp-av-1.0/libgupnp-av}

	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/libgupnp-av-1.0.{so*,la,a} \
		$(1)/usr/lib/

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/lib/pkgconfig/*.pc \
		$(1)/usr/lib/pkgconfig/

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/include/gupnp-av-1.0/libgupnp-av/*.h \
		$(1)/usr/include/gupnp-av-1.0/libgupnp-av/
endef

define Package/libgupnp-av/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/libgupnp-av-1.0.so* \
		$(1)/usr/lib/
endef

$(eval $(call BuildPackage,libgupnp-av))

