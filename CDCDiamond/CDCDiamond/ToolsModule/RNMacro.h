//
//  RNMacro.h
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#ifndef RNMacro_h
#define RNMacro_h

#define rn_dispatch_main_sync(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define rn_dispatch_main_async(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define rn_dispatch_background_async(block)\
if ([NSThread isMainThread]) {\
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);\
} else {\
block();\
}

#define rn_dispatch_background_sync(block)\
if ([NSThread isMainThread]) {\
dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);\
} else {\
block();\
}

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

#define kBase

//发送通知
#define KPostNotification(name, obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#define ImageName(image) [UIImage imageNamed:image]

//语言改变通知
static NSString *const RNLanguageChangedNotification = @"ZTBLanguageChangedNotification"; //
//当前语言
static NSString *const appLanguage = @"appLanguage";
#define RNLocalized(key)  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"Localizable"]

#define APP_Frame_Height [UIScreen mainScreen].bounds.size.height
#define App_Frame_Width  [UIScreen mainScreen].bounds.size.width

#define kIsIphone4s    (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 480)))
#define kIsIphone5     (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568)))
#define kIsIphone6     (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 667)))
#define kIsIphone6p    (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736)))
#define kIsIphonex     (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)))

#define kStatusBarHeight   (kIsIphonex ? 44.f : 20.f)
#define kTopBarHeight      (44.f)
#define kBottomBarHeight   (kIsIphonex ? 83.f : 49.f)

#define IOS7  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define IOS8  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#define IOS9  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? YES : NO)
#define IOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0 ? YES : NO)
#define IOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0 ? YES : NO)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBoraAlpha(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define RGBCOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#ifdef DEBUG
#define RNConfiguration @"DEBUG"
#else
#define RNConfiguration @"RELEASE"
#endif

/**
 *    @brief    GCD
 */
#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
//@"http://119.23.20.238:8088/" //@"http://119.23.20.238:8088/"//
#define BaseServer @"https://hn.createddiamonds.com:8088/"//@"http://172.31.76.28:8088/" // 服务器地址

/**
 * 快捷拼接字符串
 */
#define KStringFormat(s, c)         [NSString stringWithFormat:@"%@%@",s,c]
#define KFormat(s)                  [NSString stringWithFormat:@"%@",s]
#define KFormatInteger(s)           [NSString stringWithFormat:@"%ld",s]
#define KFormatInt(s)               [NSString stringWithFormat:@"%d",s]
#define KFormatLong(s)              [NSString stringWithFormat:@"%lld",s]

#endif /* RNMacro_h */
