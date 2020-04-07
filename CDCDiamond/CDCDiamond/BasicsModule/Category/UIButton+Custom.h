//
//  UIButton+Custom.h
//  ECGoudeli
//
//  Created by Leaf on 2017/9/7.
//  Copyright © 2017年 Leaf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZButton: UIButton;

@end

@interface UIButton (Custom)

#pragma mark - 文字
/**
 自定义 文字带切圆角 UIButton

 @param title 文字
 @param color 文字颜色
 @param font 字体大小
 @param radius 切圆角弧度
 @return 返回 button 对象
 */
+(instancetype)yz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color Font:(CGFloat)font cornerRadius:(CGFloat)radius;

/**
 自定义 纯文字 文字加粗 UIButton
 
 @param title 文字
 @param color 文字颜色
 @param boldFont 加粗文字大小
 @return button 对象
 */
+(instancetype)yz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color sizeBoldFont:(CGFloat)boldFont;

/**
 自定义 纯文字 UIButton

 @param title 文字
 @param color 文字颜色
 @param font 文字大小
 @return button 对象
 */
+(instancetype)yz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color Font:(CGFloat)font;

/**
 自定义纯文字btn，默认和选择颜色

 @param title 文字
 @param norColor 默认文字颜色
 @param selColor 选中文字颜色
 @param font 字体大小
 @return 自定义 btn
 */
+(instancetype)yz_buttonWithTitle:(NSString *)title titleColorNormal:(UIColor *)norColor titleColorSelected:(UIColor *)selColor Font:(CGFloat)font;

#pragma mark - 图片
/** 背景图片 */
+(instancetype)yz_buttonWithBackgroundImageStr:(NSString *)imgStr;
/**
 自定义图片 btn
 
 @param imgStr  图片名称
 @return 自定义的 btn
 */
+(instancetype)yz_buttonWithImageStr:(NSString *)imgStr;

/**
 自定义图片 btn，默认和选择图片
 
 @param norStr 默认图片
 @param selStr 选中图片
 @return 自定义的 btn
 */
+(instancetype)yz_buttonWithImageStrNor:(NSString *)norStr selImageStr:(NSString *)selStr;


#pragma mark - 文字图片
/** 默认图片和title 、默认titleColor、字体大小 */
+(instancetype)yz_buttonWithImageStrNor:(NSString *)norStr title:(NSString *)title titleColorNormal:(UIColor *)color Font:(CGFloat)font;

/** 背景图片和title 、默认titleColor、字体大小 */
+(instancetype)yz_buttonWithBackgroundImageStrNor:(NSString *)norStr title:(NSString *)title titleColorNormal:(UIColor *)color Font:(CGFloat)font;


#pragma mark - 自定义 文字字体

+(instancetype)yz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color textFont:(UIFont *)font;

+(instancetype)yz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color textFont:(UIFont *)font cornerRadius:(CGFloat)radius;

+(instancetype)yz_buttonWithTitle:(NSString *)title titleColorNormal:(UIColor *)norColor titleColorSelected:(UIColor *)selColor textFont:(UIFont *)font;

/** 默认图片和title 、默认titleColor、字体大小 */
+(instancetype)yz_buttonWithImageStrNor:(NSString *)norStr title:(NSString *)title titleColorNormal:(UIColor *)color textFont:(UIFont *)font;

/** 背景图片和title 、默认titleColor、字体大小 */
+(instancetype)yz_buttonWithBackgroundImageStrNor:(NSString *)norStr title:(NSString *)title titleColorNormal:(UIColor *)color textFont:(UIFont *)font;

/** 带有渐变色背景图片的按钮 size图片大小 */
- (void)yz_buttonWithGradientBackgroundImageSize:(CGSize)size;

@end
