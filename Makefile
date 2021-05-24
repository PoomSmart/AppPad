export PREFIX = $(THEOS)/toolchain/Xcode11.xctoolchain/usr/bin/
TARGET = iphone:latest:9.0
PACKAGE_VERSION = 1.0.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AppPad

AppPad_FILES = Tweak.x
AppPad_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += AppPadBundle

include $(THEOS_MAKE_PATH)/aggregate.mk
