//
//  RNUserDefault.m
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNUserDefault.h"

@implementation RNUserDefault

+ (void)setDefaultValue:(id)v forKey:(NSString *)k {
    [[NSUserDefaults standardUserDefaults] setObject:v forKey:k];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)defaultValueForKey:(NSString *)k {
    return [[NSUserDefaults standardUserDefaults] objectForKey:k];
}

+ (void)removeValueForKey:(NSString *)k {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
