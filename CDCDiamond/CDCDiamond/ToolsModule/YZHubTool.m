//
//  YZHubTool.m
//  ECGoudeli
//
//  Created by Leaf on 2017/8/10.
//  Copyright © 2017年 Leaf. All rights reserved.
//

#import "YZHubTool.h"
#import "SVProgressHUD.h"

#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define DEFAULT_TEXT_BLACK_COLOR kColorFromRGB(0x333333)
#define DEFAULT_LINE_GRAY_COLOR kColorFromRGB(0xebefed)
//延迟方法 去掉svp 提示的效果
#define SVPdelay(time) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((time) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{[SVProgressHUD dismiss];})

// 背景视图的宽度/高度
#define BGVIEW_WIDTH 100.0f
// 文字大小
#define TEXT_SIZE 16.0f
// 圆角大小
#define CornerRadius 4.f

@implementation YZHubTool

#pragma mark - 建议使用的方法
/** 请求超时专用 */
+ (void)showRequestTimeout{
    [self hide];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setViewForExtension:[UIApplication sharedApplication].keyWindow];
    [SVProgressHUD showImage:ImageName(@"") status:@"请求超时"];
    [SVProgressHUD setCornerRadius:CornerRadius];
    SVPdelay(2);
}

+ (void)showText:(NSString *)text{
    [self hide];
    if (!(text && [text isKindOfClass:[NSString class]] && text.length)) return;
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setViewForExtension:[UIApplication sharedApplication].keyWindow];
    [SVProgressHUD showImage:ImageName(@"") status:text];
    [SVProgressHUD setCornerRadius:CornerRadius];
    SVPdelay(1);
}

+ (void)showText:(NSString *)text delay:(int)second{
    [self hide];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setViewForExtension:[UIApplication sharedApplication].keyWindow];
    [SVProgressHUD showImage:ImageName(@"") status:text];
    [SVProgressHUD setCornerRadius:CornerRadius];
    SVPdelay(second);
}

+ (void)showLoadingStatus:(NSString *)text{
    [self hide];
    [SVProgressHUD setViewForExtension:[UIApplication sharedApplication].keyWindow];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD showWithStatus:text];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setCornerRadius:CornerRadius];
}

+ (void)showText:(NSString *)text backgroundColor:(UIColor *)backgroundColor {
    [self hide];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:backgroundColor];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setViewForExtension:[UIApplication sharedApplication].keyWindow];
    [SVProgressHUD showImage:ImageName(@"") status:text];
    [SVProgressHUD setCornerRadius:CornerRadius];
    SVPdelay(1);
}


/** 转菊花、有遮挡 */
+ (void)ShowToLoading{
    [self hide];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.1]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setViewForExtension:[UIApplication sharedApplication].keyWindow];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setCornerRadius:CornerRadius];
    [SVProgressHUD show];
}

/********************  项目使用上面两个 ********************/

+ (void)showFailureText:(NSString *)text{
    [self hide];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setViewForExtension:kKeyWindow];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD showErrorWithStatus:text];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setCornerRadius:CornerRadius];
    SVPdelay(1.5);
}

+ (void)showSuccessText:(NSString *)text{
    [self hide];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setViewForExtension:kKeyWindow];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD showSuccessWithStatus:text];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setCornerRadius:CornerRadius];
    SVPdelay(1.5);
}

+ (void)showLoadingText:(NSString *)text view:(UIView*)view{
    [self hide];
    [SVProgressHUD setViewForExtension:view];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD showWithStatus:text];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setCornerRadius:CornerRadius];
}

+ (void)ShowToWindow{
    [self hide];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.1]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setViewForExtension:[UIApplication sharedApplication].keyWindow];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setCornerRadius:CornerRadius];
    [SVProgressHUD show];
}

+(void)showText:(NSString*)text view:(UIView*)view{
    [self hide];
    [SVProgressHUD setViewForExtension:view];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showImage:ImageName(@"") status:text];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setCornerRadius:CornerRadius];
}

+(void)showProgress:(float)value view:(UIView*)view text:(NSString*)text{
    [SVProgressHUD setViewForExtension:view];
    [SVProgressHUD setForegroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD showProgress:value status:text];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    [SVProgressHUD setCornerRadius:CornerRadius];
}

+(void)showProgress:(float)value view:(UIView*)view text:(NSString*)text backgroundColor:(UIColor *)backgroundColor {
    [SVProgressHUD setViewForExtension:view];
    [SVProgressHUD setCornerRadius:CornerRadius];
    [SVProgressHUD setForegroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [SVProgressHUD showProgress:value status:text];
    [SVProgressHUD setBackgroundColor:backgroundColor];
}

+ (void)hide {
    [SVProgressHUD dismiss];
}

@end
