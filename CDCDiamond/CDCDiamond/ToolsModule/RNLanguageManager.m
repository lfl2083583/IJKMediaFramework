//
//  RNLanguageManager.m
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNLanguageManager.h"

@implementation RNLanguageManager

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static RNLanguageManager *manger = nil;
    dispatch_once(&onceToken, ^{
        manger = [[RNLanguageManager alloc] init];
    });
    return manger;
    
}

- (void)setLanguageForEnglish {
    [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:appLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:RNLanguageChangedNotification object:nil];
}

- (void)setLanguageForChinese {
    [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:appLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:RNLanguageChangedNotification object:nil];
}

- (void)setLanguageForSimplified {
    [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:appLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:RNLanguageChangedNotification object:nil];
}

- (int)languageType {
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:appLanguage];
    if (obj && [KFormat(obj) isEqualToString:@"en"]) {
        return 2;
    } else if ((obj && [KFormat(obj) isEqualToString:@"zh-Hans"])) {
        return 0;
    } else if ((obj && [KFormat(obj) isEqualToString:@"zh-Hant"])) {
        return 1;
    } else {
        return 3;
    }
}


@end
