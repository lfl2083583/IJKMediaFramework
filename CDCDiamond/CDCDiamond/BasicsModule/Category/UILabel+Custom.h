//
//  UILabel+Custom.h
//  ECGoudeli
//
//  Created by Leaf on 2017/9/12.
//  Copyright © 2017年 Leaf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Custom)

/**
 自定义 Label

 @param text  文本
 @param color 文本颜色
 @param font  文本字体大小
 @return 返回自定义的 label 对象
 */
+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color sizeFont:(CGFloat)font;

/**
 自定义粗体 Label
 
 @param text  文本
 @param color 文本颜色
 @param font  文本字体大小(粗体)
 @return 返回自定义的 label 对象
 */
+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color sizeBoldFont:(CGFloat)font;

/**
 自定义 label 行数

 @param text 文本
 @param color 文本颜色
 @param font 文本字体
 @param lines 文本行数
 @return  label 对象
 */
+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color sizeFont:(CGFloat)font numberOfLines:(CGFloat)lines;

/**
 自定义 label 对齐方式

 @param text 文本
 @param color 文本颜色
 @param font 文本字体
 @param lines 文本行数
 @param alignment 文本对齐方式
 @return  label 对象
 */
+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color sizeFont:(CGFloat)font numberOfLines:(CGFloat)lines textAlignment:(NSTextAlignment)alignment;

+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color sizeBoldFont:(CGFloat)font numberOfLines:(CGFloat)lines textAlignment:(NSTextAlignment)alignment;



#pragma mark - 自定义字体

+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font;

+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font numberOfLines:(CGFloat)lines;

+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font numberOfLines:(CGFloat)lines textAlignment:(NSTextAlignment)alignment;

@end
