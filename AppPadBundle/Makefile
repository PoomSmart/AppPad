TARGET := iphone:clang:latest:9.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = AppPadBundle

AppPadBundle_FILES = AppPadRootListController.m
AppPadBundle_FRAMEWORKS = UIKit
AppPadBundle_PRIVATE_FRAMEWORKS = Preferences
AppPadBundle_EXTRA_FRAMEWORKS = AltList
AppPadBundle_INSTALL_PATH = /Library/PreferenceBundles
AppPadBundle_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
