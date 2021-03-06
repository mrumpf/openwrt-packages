#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gupnp-dlna
PKG_VERSION:=0.6.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://ftp.gnome.org/pub/GNOME/sources/gupnp-dlna/0.6/
PKG_SHA256SUM:=a67e9b031ddd9dfcfc128a2649e9bbbfeba3362ca9a30c3e30b63285f784f599

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/libgupnp-dlna
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Library for dealing with DLNA-related tasks
  URL:=http://www.gupnp.org/
  DEPENDS:=+libgupnp +gstreamer +gst-plugins-base
endef

define Package/libgupnp-dlna/description
A small utility library that aims to ease the DLNA-related tasks such as media profile guessing, transcoding to a given profile, etc.
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/{lib/pkgconfig,include/gupnp-dlna-1.0/libgupnp-dlna}

	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/libgupnp-dlna-1.0.{so*,la,a} \
		$(1)/usr/lib/

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/lib/pkgconfig/*.pc \
		$(1)/usr/lib/pkgconfig/

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/include/gupnp-dlna-1.0/libgupnp-dlna/*.h \
		$(1)/usr/include/gupnp-dlna-1.0/libgupnp-dlna/
endef

define Package/libgupnp-dlna/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/libgupnp-dlna-1.0.so* \
		$(1)/usr/lib/
endef

$(eval $(call BuildPackage,libgupnp-dlna))

