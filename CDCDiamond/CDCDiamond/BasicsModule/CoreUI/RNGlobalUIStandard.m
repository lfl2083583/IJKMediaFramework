//
//  RNGlobalUIStandard.m
//  RapNet
//
//  Created by liufulin on 2019/7/19.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNGlobalUIStandard.h"

@implementation RNGlobalUIStandard

+ (UIColor *)defaultMainColor {
    return UIColorFromRGB(0x02AA5B);
}

+ (UIFont *)defaultTableViewTextFont {
    return [UIFont systemFontOfSize:16.f];
}

+ (UIColor *)defaultTableViewTextColor {
    return UIColorFromRGB(0x222222);
}

+ (UIColor *)defaultTableViewSubTextColor {
    return UIColorFromRGB(0x999999);
}

@end
