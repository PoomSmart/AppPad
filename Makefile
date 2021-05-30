export PREFIX = $(THEOS)/toolchain/Xcode11.xctoolchain/usr/bin/
TARGET = iphone:latest:9.0
PACKAGE_VERSION = 1.1.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AppPad

AppPad_FILES = Tweak.x
AppPad_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp -R Resources $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/AppPad$(ECHO_END)
