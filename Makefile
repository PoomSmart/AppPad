ARCHS = armv7 arm64 arm64e
TARGET = iphone:latest:9.0
PACKAGE_VERSION = 0.0.2

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AppPad

AppPad_FILES = Tweak.x
AppPad_LIBRARIES = applist
AppPad_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp Resources/AppPad.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/AppPad.plist$(ECHO_END)
