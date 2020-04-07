//
//  UIView+SBConfiguration.m
//  CDPlan
//
//  Created by CD on 2018/6/18.
//  Copyright © 2018年 CD. All rights reserved.
//

#import "UIView+SBConfiguration.h"

@implementation UIView (SBConfiguration)

@dynamic borderColor, borderWidth, cornerRadius, shadowColor, shadowOpacity, shadowOffset;

- (void)setBorderColor:(UIColor *)borderColor {
    [self.layer setBorderColor:borderColor.CGColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    [self.layer setBorderWidth:borderWidth];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [self.layer setCornerRadius:cornerRadius];
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

@end
