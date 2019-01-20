include $(TOPDIR)/rules.mk

PKG_NAME:=jsoncpp
PKG_VERSION:=1.8
PKG_RELEASE:=4
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/open-source-parsers/jsoncpp.git
PKG_SOURCE_VERSION:=$(PKG_VERSION).$(PKG_RELEASE)

include $(INCLUDE_DIR)/package.mk

define Package/jsoncpp
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=jsoncpp
  DEPENDS:=+libstdcpp
endef

define Package/jsoncpp/description
	jsoncpp
endef

define Build/Compile
	$(TARGET_CXX) $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS) -shared $(PKG_BUILD_DIR)/src/lib_json/*.cpp -I$(PKG_BUILD_DIR)/include -o $(PKG_BUILD_DIR)/libjsoncpp.so -fPIC -std=c++11
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/json
	$(CP) $(PKG_BUILD_DIR)/include/json/* $(1)/usr/include/json/
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/libjsoncpp.so $(1)/usr/lib/
endef

define Package/jsoncpp/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libjsoncpp.so $(1)/usr/lib/
endef

$(eval $(call BuildPackage,jsoncpp))
