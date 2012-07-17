#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gssdp
PKG_VERSION:=0.11.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://ftp.gnome.org/pub/GNOME/sources/gssdp/0.11/
PKG_SHA256SUM:=45b9e41f1e94ddf596d92668bccd0a42de07e99bc2d66d6ea7c70a1ea509e7f1

#PKG_BUILD_DEPENDS:=libsoup glib2 $(ICONV_DEPENDS)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

TARGET_LDFLAGS+=\
	-Wl,-rpath-link=$(STAGING_DIR)/usr/lib

define Package/libgssdp
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Library for resource discovery and announcement over SSDP
  URL:=http://www.gupnp.org/
  DEPENDS:=+libsoup +glib2
endef

define Package/libgssdp/description
GUPnP is an elegant, object-oriented open source framework for creating UPnP devices and control points, written in C using GObject and libsoup. The GUPnP API is intended to be easy to use, efficient and flexible. It provides the same set of features as libupnp, but shields the developer from most of UPnP's internals.
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/{lib/pkgconfig,include/gssdp-1.0/libgssdp}

	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/libgssdp-1.0.{so*,la,a} \
		$(1)/usr/lib/

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/lib/pkgconfig/*.pc \
		$(1)/usr/lib/pkgconfig/

	$(INSTALL_DATA) \
		$(PKG_INSTALL_DIR)/usr/include/gssdp-1.0/libgssdp/*.h \
		$(1)/usr/include/gssdp-1.0/libgssdp/
endef

define Package/libgssdp/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/libgssdp-1.0.so* \
		$(1)/usr/lib/
endef

$(eval $(call BuildPackage,libgssdp))

