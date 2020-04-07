//
//  YZHubTool.h
//  ECGoudeli
//
//  Created by Leaf on 2017/8/10.
//  Copyright © 2017年 Leaf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZHubTool : NSObject
/** 请求超时专用 2秒自动消失 */
+ (void)showRequestTimeout;

/** 在window上添加一个只显示文字的HUD */
+ (void)showText:(NSString *)text;

/** 在window上添加一个只显示文字的HUD 自己设置延时时间消失*/
+ (void)showText:(NSString *)text delay:(int)second;

/** 在window上添加一个提示`失败`的HUD */
+ (void)showFailureText:(NSString *)text;

/** 在window上添加一个提示`成功`的HUD */
+ (void)showSuccessText:(NSString *)text;

/** 在指定视图上添加一个提示`加载中`的HUD, 需要手动关闭 */
+ (void)showLoadingText:(NSString *)text view:(UIView*)view;

/** 在window上添加一个提示`text`的HUD */
+ (void)showLoadingStatus:(NSString *)text;
/**  在window上添加一个提示`text`的HUD  自定义背景色*/
+ (void)showText:(NSString *)text backgroundColor:(UIColor *)backgroundColor;
/** 转菊花、可以点击其他控件 */
+ (void)ShowToWindow;
/** 转菊花、有遮挡 */
+ (void)ShowToLoading;

+(void)showText:(NSString*)text view:(UIView*)view;

/***   进度条    ***/
+(void)showProgress:(float)value view:(UIView*)view text:(NSString*)text;

/***   进度条 (自定义背景色)   ***/
+(void)showProgress:(float)value view:(UIView*)view text:(NSString*)text backgroundColor:(UIColor *)backgroundColor;

/** 手动隐藏HUD */
+ (void)hide;

@end
