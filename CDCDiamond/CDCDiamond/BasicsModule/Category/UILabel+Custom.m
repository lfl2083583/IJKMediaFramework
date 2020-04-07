//
//  UILabel+Custom.m
//  ECGoudeli
//
//  Created by Leaf on 2017/9/12.
//  Copyright © 2017年 Leaf. All rights reserved.
//

#import "UILabel+Custom.h"

@implementation UILabel (Custom)

+(instancetype)yz_label {
    return [[UILabel alloc] init];
}


+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color sizeFont:(CGFloat)font {
    
    UILabel *label = [self yz_label];
    label.text = text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];

    return label;
}

+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color sizeBoldFont:(CGFloat)font {
    
    UILabel *label = [self yz_label];
    label.text = text;
    label.textColor = color;
    label.font = [UIFont boldSystemFontOfSize:font];
    
    return label;
}

+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color sizeFont:(CGFloat)font numberOfLines:(CGFloat)lines {
    
    UILabel *label = [self yz_labelWithText:text textColor:color sizeFont:font];
    label.numberOfLines = lines;
    return label;
}

+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color sizeFont:(CGFloat)font numberOfLines:(CGFloat)lines textAlignment:(NSTextAlignment)alignment {
    
    UILabel *label = [self yz_labelWithText:text textColor:color sizeFont:font numberOfLines:lines];
    label.textAlignment = alignment;
    return label;
}

+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color sizeBoldFont:(CGFloat)font numberOfLines:(CGFloat)lines textAlignment:(NSTextAlignment)alignment {
    
    UILabel *label = [self yz_labelWithText:text textColor:color sizeBoldFont:font];
    label.numberOfLines = lines;
    label.textAlignment = alignment;
    return label;
}


#pragma mark - 自定义字体

+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font {
    UILabel *label = [self yz_label];
    label.text = text;
    label.textColor = color;
    label.font = font;
    return label;
}

+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font numberOfLines:(CGFloat)lines {
    UILabel *label = [self yz_labelWithText:text textColor:color textFont:font];
    label.numberOfLines = lines;
    return label;
}

+(instancetype)yz_labelWithText:(NSString *)text textColor:(UIColor *)color textFont:(UIFont *)font numberOfLines:(CGFloat)lines textAlignment:(NSTextAlignment)alignment {
    UILabel *label = [self yz_labelWithText:text textColor:color textFont:font numberOfLines:lines];
    label.textAlignment = alignment;
    return label;
}

@end
