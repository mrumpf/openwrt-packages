#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=m3ddity-player
PKG_VERSION:=0.1.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-src.tar.bz2
PKG_SOURCE_URL:=http://www.jcoderz.org/repos/openwrt/$(PKG_NAME)/$(PKG_VERSION)/
PKG_MD5SUM:=1200e1057e5472ef7e08eb9dea4bc0dc

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

TARGET_LDFLAGS+=\
	-Wl,-rpath-link=$(STAGING_DIR)/usr/lib

define Package/m3ddity-player
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=A MP3 player which implements the UPnP media renderer interface
  URL:=http://www.jcoderz.org/m3dditiez/wiki/m3ddity-player
  DEPENDS:=+libgupnp +libgupnp-av +gstreamer +gstreamer-utils
endef

define Package/m3ddity-player/description
The m3ddity-player is a MP3 player with a UPnP Media Rendere interface. It can be controlled by UPnPlay on Android for example.
endef

CONFIGURE_CMD =./autogen.sh

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Package/m3ddity-player/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/bin/m3ddity-player \
		$(1)/usr/bin/
endef

$(eval $(call BuildPackage,m3ddity-player))

