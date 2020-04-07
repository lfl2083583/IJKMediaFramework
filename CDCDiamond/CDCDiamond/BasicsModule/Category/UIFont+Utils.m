//
//  UIFont+Utils.m
//  TPSLIVE
//
//  Created by Leaf on 2019/7/8.
//  Copyright © 2019 HS. All rights reserved.
//

#import "UIFont+Utils.h"

@implementation UIFont (Utils)

#pragma mark - PingFangSC 字体
+ (UIFont *)yz_PingFangSC_RegularFontOfSize:(CGFloat)fontSize {
    if (fontSize <= 0) {
        fontSize = 15;
    }
    return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
}

+ (UIFont *)yz_PingFangSC_MediumFontOfSize:(CGFloat)fontSize {
    if (fontSize <= 0) {
        fontSize = 15;
    }
    return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
}

+ (UIFont *)yz_PingFangSC_SemiboldFontOfSize:(CGFloat)fontSize {
    if (fontSize <= 0) {
        fontSize = 15;
    }
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
}


#pragma mark - DIN Alternate 字体
/** DINAlternate 字体, Bold 字重 */
+ (UIFont *)yz_DINAlternate_BoldFontOfSize:(CGFloat)fontSize {
    if (fontSize <= 0) {
        fontSize = 16;
    }
    return [UIFont fontWithName:@"DINAlternate-Bold" size:fontSize];
}

@end
