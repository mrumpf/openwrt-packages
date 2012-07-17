#
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=m3player
PKG_VERSION:=0.1.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.jcoderz.org/repos/openwrt/$(PKG_NAME)/$(PKG_VERSION)/
PKG_MD5SUM:=cad21868eb942ea1ecb7982ce2b5851e

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

TARGET_LDFLAGS+=\
	-Wl,-rpath-link=$(STAGING_DIR)/usr/lib

define Package/m3player
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=A MP3 player which implements the UPnP media renderer interface
  URL:=http://www.jcoderz.org/m3dditiez/wiki/m3ddity-player
  DEPENDS:=+libgupnp +libgupnp-av +gstreamer +gstreamer-utils
endef

define Package/m3player/description
The m3player is a MP3 player with a UPnP Media Rendere interface. It can be controlled by UPnPlay on Android for example.
endef

CONFIGURE_CMD =./autogen.sh

define Build/Configure
        $(call Build/Configure/Default, \
        )
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		all install
endef

define Package/m3player/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/m3player $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/hotplug.d/button
	$(CP) $(PKG_INSTALL_DIR)/etc/hotplug.d/button/buttons $(1)/etc/hotplug.d/button/

	$(INSTALL_DIR) $(1)/etc/m3player
	$(CP) $(PKG_INSTALL_DIR)/etc/m3player/m3player.ini $(1)/etc/m3player/

	$(INSTALL_DIR) $(1)/usr/share/m3player
	$(CP) $(PKG_INSTALL_DIR)/usr/share/m3player/*.xml $(1)/usr/share/m3player/
endef

$(eval $(call BuildPackage,m3player))

