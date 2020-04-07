//
//  MMBarButtonItem.h
//  MMSideslipDrawer
//
//  Created by LEA on 2017/2/17.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMBarButtonItem : UIBarButtonItem

@property (nonatomic, strong) UIImage *btImage;
@property (nonatomic, strong) NSString *btTitle;
@property (nonatomic, strong) UIColor *titleColor;

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action;

@end
