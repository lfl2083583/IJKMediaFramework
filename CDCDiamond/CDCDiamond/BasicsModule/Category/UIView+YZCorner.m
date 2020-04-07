//
//  UIView+YZCorner.m
//  TPSLIVE
//
//  Created by tjl on 2019/8/16.
//  Copyright © 2019 HS. All rights reserved.
//

#import "UIView+YZCorner.h"
#import <objc/runtime.h>

static NSString * const YZCornerPositionKey = @"YZCornerPositionKey";
static NSString * const YZCornerRadiusKey = @"YZCornerRadiusKey";

@implementation UIView (YZCorner)

@dynamic yz_cornerPosition;
- (YZCornerPosition)yz_cornerPosition
{
    return [objc_getAssociatedObject(self, &YZCornerPositionKey) integerValue];
}

- (void)setYz_cornerPosition:(YZCornerPosition)yz_cornerPosition {
    objc_setAssociatedObject(self, &YZCornerPositionKey, @(yz_cornerPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic yz_cornerRadius;
- (CGFloat)yz_cornerRadius
{
    return [objc_getAssociatedObject(self, &YZCornerRadiusKey) floatValue];
}

- (void)setYz_cornerRadius:(CGFloat)yz_cornerRadius {
    objc_setAssociatedObject(self, &YZCornerRadiusKey, @(yz_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    SEL ori = @selector(layoutSublayersOfLayer:);
    SEL new = NSSelectorFromString([@"hh_" stringByAppendingString:NSStringFromSelector(ori)]);
    hh_swizzle(self, ori, new);
}

void hh_swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    
    method_exchangeImplementations(origMethod, newMethod);
}

- (void)hh_layoutSublayersOfLayer:(CALayer *)layer
{
    [self hh_layoutSublayersOfLayer:layer];
    
    if (self.yz_cornerRadius > 0) {
        
        UIBezierPath *maskPath;
        switch (self.yz_cornerPosition) {
            case YZCornerPositionTop:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                       cornerRadii:CGSizeMake(self.yz_cornerRadius, self.yz_cornerRadius)];
                break;
            case YZCornerPositionLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(self.yz_cornerRadius, self.yz_cornerRadius)];
                break;
            case YZCornerPositionBottom:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.yz_cornerRadius, self.yz_cornerRadius)];
                break;
            case YZCornerPositionRight:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.yz_cornerRadius, self.yz_cornerRadius)];
                break;
            case YZCornerPositionWithoutBottomLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomRight | UIRectCornerTopRight)
                                                       cornerRadii:CGSizeMake(self.yz_cornerRadius, self.yz_cornerRadius)];
                break;
            case YZCornerPositionAll:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerAllCorners
                                                       cornerRadii:CGSizeMake(self.yz_cornerRadius, self.yz_cornerRadius)];
                break;
        }
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)yz_setCornerOnTopWithRadius:(CGFloat)radius
{
    self.yz_cornerPosition = YZCornerPositionTop;
    self.yz_cornerRadius = radius;
}

- (void)yz_setCornerOnLeftWithRadius:(CGFloat)radius
{
    self.yz_cornerPosition = YZCornerPositionLeft;
    self.yz_cornerRadius = radius;
}

- (void)yz_setCornerOnBottomWithRadius:(CGFloat)radius
{
    self.yz_cornerPosition = YZCornerPositionBottom;
    self.yz_cornerRadius = radius;
}

- (void)yz_setCornerOnRightWithRadius:(CGFloat)radius
{
    self.yz_cornerPosition = YZCornerPositionRight;
    self.yz_cornerRadius = radius;
}

- (void)yz_setCornerOnWithoutBottomLeftWithRadius:(CGFloat)radius {
    self.yz_cornerPosition = YZCornerPositionWithoutBottomLeft;
    self.yz_cornerRadius = radius;
}

- (void)yz_setAllCornerWithCornerRadius:(CGFloat)radius
{
    self.yz_cornerPosition = YZCornerPositionAll;
    self.yz_cornerRadius = radius;
}

- (void)yz_setNoneCorner
{
    self.layer.mask = nil;
}

@end
