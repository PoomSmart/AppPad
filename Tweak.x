#define tweakIdentifier @"com.ps.apppad"

#import <Foundation/Foundation.h>
#import <SpringBoard/SBApplication.h>
#import <AppList/AppList.h>
#import <theos/IOSMacros.h>
#import "../PSPrefs/PSPrefs.x"

@interface SBApplicationInfo : NSObject
@property (nonatomic, copy, readonly) NSString *bundleIdentifier;
@end

static BOOL shouldEnableForBundleIdentifier(NSString *bundleIdentifier) {
	NSDictionary *preferences = Prefs();
	id value = preferences[[@"AppPad-" stringByAppendingString:bundleIdentifier]];
	return value ? ![value boolValue] : YES;
}

%hook UIApplication

- (BOOL)_shouldBigify {
	return shouldEnableForBundleIdentifier(NSBundle.mainBundle.bundleIdentifier);
}

%end

%group SB

%hook SBApplicationInfo

- (bool)disableClassicMode {
	return shouldEnableForBundleIdentifier(self.bundleIdentifier) ? true : %orig;
}

- (bool)wantsFullScreen {
	return shouldEnableForBundleIdentifier(self.bundleIdentifier) ? false : %orig;
}

- (bool)_supportsApplicationType:(int)type {
	return %orig(type & 2 && shouldEnableForBundleIdentifier(self.bundleIdentifier) ? 1 : type);
}

%end

%hook SBApplication

- (bool)_supportsApplicationType:(int)type {
	return %orig(type & 2 && shouldEnableForBundleIdentifier(self.bundleIdentifier) ? 1 : type);
}

- (NSInteger)_defaultClassicMode {
	return shouldEnableForBundleIdentifier(self.bundleIdentifier) ? 0 : %orig;
}

%end

%end

%ctor {
	if (IN_SPRINGBOARD) {
		%init(SB);
	} else {
		%init;
	}
}