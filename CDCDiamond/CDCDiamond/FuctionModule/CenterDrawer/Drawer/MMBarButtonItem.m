//
//  MMBarButtonItem.m
//  MMSideslipDrawer
//
//  Created by LEA on 2017/2/17.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MMBarButtonItem.h"

@implementation MMBarButtonItem

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIFont *font = [UIFont systemFontOfSize:16.0];
    CGFloat textW = [self getTextSize:title font:font maxSize:CGSizeMake(App_Frame_Width, 44)].width;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textW, 44)];
    [btn.titleLabel setFont:font];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [self initWithCustomView:btn];
}

- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [self initWithCustomView:btn];
}

#pragma mark - SETTER
- (void)setBtTitle:(NSString *)btTitle
{
    _btTitle = btTitle;
    UIFont *font = [UIFont systemFontOfSize:16.0];
    CGFloat textW = [self getTextSize:btTitle font:font maxSize:CGSizeMake(App_Frame_Width, 44)].width;
    UIButton *bt = (UIButton *)self.customView;
    bt.frame = CGRectMake(0, 0, textW, 44);
    [bt setTitle:btTitle forState:UIControlStateNormal];
}

- (void)setBtImage:(UIImage *)btImage
{
    _btImage = btImage;
    UIButton *bt = (UIButton *)self.customView;
    bt.frame = CGRectMake(0, 0, btImage.size.width, btImage.size.height);
    [bt setImage:btImage forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    UIButton *bt = (UIButton *)self.customView;
    [bt setTitleColor:titleColor forState:UIControlStateNormal];
}

#pragma mark - 获取文字实际size
- (CGSize)getTextSize:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [text boundingRectWithSize:maxSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:dict
                                         context:nil].size;
    return textSize;
}

@end
