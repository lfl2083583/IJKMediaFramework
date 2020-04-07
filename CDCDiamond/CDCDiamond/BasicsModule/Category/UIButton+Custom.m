//
//  UIButton+Custom.m
//  ECGoudeli
//
//  Created by Leaf on 2017/9/7.
//  Copyright © 2017年 Leaf. All rights reserved.
//

#import "UIButton+Custom.h"

@implementation UIButton (Custom)

#pragma mark - 文字
+(instancetype)yz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color Font:(CGFloat)font {
    
    YZButton *btn = [[YZButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    return btn;
}

+(instancetype)yz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color sizeBoldFont:(CGFloat)boldFont {
    
    YZButton *btn = [[YZButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:boldFont];
    return btn;
}

+(instancetype)yz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color Font:(CGFloat)font cornerRadius:(CGFloat)radius {
    YZButton *btn = [self yz_buttonWithTitle:title titleColor:color Font:font];
    btn.layer.cornerRadius = radius;
    btn.layer.masksToBounds = YES;
    
    return btn;
}

+(instancetype)yz_buttonWithTitle:(NSString *)title titleColorNormal:(UIColor *)norColor titleColorSelected:(UIColor *)selColor Font:(CGFloat)font {
    YZButton *btn = [self yz_buttonWithTitle:title titleColor:norColor Font:font];
    [btn setTitleColor:selColor forState:UIControlStateSelected];
    return btn;
}

#pragma mark - 图片
/** 背景图片 */
+(instancetype)yz_buttonWithBackgroundImageStr:(NSString *)imgStr {
    YZButton *btn = [[YZButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    return btn;
}

+(instancetype)yz_buttonWithImageStr:(NSString *)imgStr {
    YZButton *btn = [[YZButton alloc] init];
    [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    return btn;
}

+(instancetype)yz_buttonWithImageStrNor:(NSString *)norStr selImageStr:(NSString *)selStr {
    YZButton *btn = [self yz_buttonWithImageStr:norStr];
    [btn setImage:[UIImage imageNamed:selStr] forState:UIControlStateSelected];
    return btn;
}

#pragma mark - 文字图片
/** 默认图片和title 、默认titleColor、字体大小 */
+(instancetype)yz_buttonWithImageStrNor:(NSString *)norStr title:(NSString *)title titleColorNormal:(UIColor *)color Font:(CGFloat)font{
    YZButton *btn = [self yz_buttonWithImageStr:norStr];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    return btn;
}

/** 背景图片和title 、默认titleColor、字体大小 */
+(instancetype)yz_buttonWithBackgroundImageStrNor:(NSString *)norStr title:(NSString *)title titleColorNormal:(UIColor *)color Font:(CGFloat)font{
    YZButton *btn = [self yz_buttonWithBackgroundImageStr:norStr];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    return btn;
}


#pragma mark - 自定义 文字字体

+(instancetype)yz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color textFont:(UIFont *)font {
    YZButton *btn = [[YZButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}

+(instancetype)yz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)color textFont:(UIFont *)font cornerRadius:(CGFloat)radius {
    YZButton *btn = [self yz_buttonWithTitle:title titleColor:color textFont:font];
    btn.layer.cornerRadius = radius;
    btn.layer.masksToBounds = YES;
    return btn;
}

+(instancetype)yz_buttonWithTitle:(NSString *)title titleColorNormal:(UIColor *)norColor titleColorSelected:(UIColor *)selColor textFont:(UIFont *)font {
    YZButton *btn = [self yz_buttonWithTitle:title titleColor:norColor textFont:font];
    [btn setTitleColor:selColor forState:UIControlStateSelected];
    return btn;
}

/** 默认图片和title 、默认titleColor、字体大小 */
+(instancetype)yz_buttonWithImageStrNor:(NSString *)norStr title:(NSString *)title titleColorNormal:(UIColor *)color textFont:(UIFont *)font {
    YZButton *btn = [self yz_buttonWithImageStr:norStr];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}

/** 背景图片和title 、默认titleColor、字体大小 */
+(instancetype)yz_buttonWithBackgroundImageStrNor:(NSString *)norStr title:(NSString *)title titleColorNormal:(UIColor *)color textFont:(UIFont *)font {
    YZButton *btn = [self yz_buttonWithBackgroundImageStr:norStr];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    return btn;
}

/** 带有渐变色背景图片的按钮 size图片大小 */
- (void)yz_buttonWithGradientBackgroundImageSize:(CGSize)size {
//   UIImage *image = [UIImage createImageSize:size gradientColors:@[MainColor, RGBOF(0xff1971)] percentage:@[@0.4, @1.0] gradientType:YZGradientFromLeftToRight];
//   [self setBackgroundImage:image forState:UIControlStateNormal];
//   [self setBackgroundImage:[UIImage createImageWithColor:RGBOF(0xcccccc)] forState:UIControlStateDisabled];
}


@end

#pragma mark -
@implementation YZButton

-(void)setHighlighted:(BOOL)highlighted {
    
}
@end
