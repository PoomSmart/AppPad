#import <SpringBoard/SBApplication.h>
#import <SpringBoard/SBApplicationInfo.h>
#import <theos/IOSMacros.h>

static BOOL shouldEnableForBundleIdentifier(NSString *bundleIdentifier) {
    NSDictionary *prefs = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.ps.apppad"];
    NSArray <NSString *> *value = [prefs objectForKey:@"AppPad"];
    return ![value containsObject:bundleIdentifier];
}

%hook UIApplication

- (BOOL)_shouldBigify {
    return shouldEnableForBundleIdentifier(NSBundle.mainBundle.bundleIdentifier);
}

%end

%group SB

%hook SBApplicationInfo

- (BOOL)disableClassicMode {
    return shouldEnableForBundleIdentifier(self.bundleIdentifier) ? YES : %orig;
}

- (BOOL)wantsFullScreen {
    return shouldEnableForBundleIdentifier(self.bundleIdentifier) ? NO : %orig;
}

- (BOOL)_supportsApplicationType:(int)type {
    return %orig(type & 2 && shouldEnableForBundleIdentifier(self.bundleIdentifier) ? 1 : type);
}

%end

%hook SBApplication

- (BOOL)_supportsApplicationType:(int)type {
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