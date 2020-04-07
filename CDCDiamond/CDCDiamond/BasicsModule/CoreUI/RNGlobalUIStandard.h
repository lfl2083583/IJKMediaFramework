//
//  RNGlobalUIStandard.h
//  RapNet
//
//  Created by liufulin on 2019/7/19.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPSAutoLayoutHelper.h"

NS_ASSUME_NONNULL_BEGIN
#define X_LEADING_MARGIN 15.f;
#define X_SPACE_MARGIN 10.f;

#define KTPSAutoLayoutHelper [TPSAutoLayoutHelper sharedInstance]

#define AUTO_WIDTH(value) [KTPSAutoLayoutHelper autoWidth:value]
#define AUTO_HEIGHT(value) [KTPSAutoLayoutHelper autoHeight:value]

#define MainColor     UIColorFromRGB(0x2AAE33)

// 取色值相关的方法
#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.f \
                                            green:(g)/255.f \
                                             blue:(b)/255.f \
                                            alpha:1.f]

#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.f \
                                            green:(g)/255.f \
                                             blue:(b)/255.f \
                                            alpha:(a)]

#define RGBOF(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                            green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                             blue:((float)(rgbValue & 0xFF))/255.0 \
                                            alpha:1.0]

#define RGBA_OF(rgbValue)   [UIColor colorWithRed:((float)(((rgbValue) & 0xFF000000) >> 24))/255.0 \
                                             green:((float)(((rgbValue) & 0x00FF0000) >> 16))/255.0 \
                                              blue:((float)(rgbValue & 0x0000FF00) >> 8)/255.0 \
                                             alpha:((float)(rgbValue & 0x000000FF))/255.0]

#define RGBAOF(v, a)        [UIColor colorWithRed:((float)(((v) & 0xFF0000) >> 16))/255.0 \
                                            green:((float)(((v) & 0x00FF00) >> 8))/255.0 \
                                             blue:((float)(v & 0x0000FF))/255.0 \
                                            alpha:a]

/* 单一颜色 */
#define RedColor       [UIColor redColor]     // 红色
#define WhiteColor     [UIColor whiteColor]   // 白色
#define BlackColor     [UIColor blackColor]   // 黑色
#define ClearColor     [UIColor clearColor]   // 黑色
#define CyanColor      [UIColor cyanColor];   // 青色


@interface RNGlobalUIStandard : NSObject


+ (UIFont *)defaultTableViewTextFont;
+ (UIColor *)defaultMainColor;
+ (UIColor *)defaultTableViewTextColor;
+ (UIColor *)defaultTableViewSubTextColor;

@end

NS_ASSUME_NONNULL_END
