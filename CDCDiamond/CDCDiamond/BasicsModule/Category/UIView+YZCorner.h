//
//  UIView+YZCorner.h
//  TPSLIVE
//
//  Created by tjl on 2019/8/16.
//  Copyright © 2019 HS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YZCornerPosition) {
    YZCornerPositionTop,
    YZCornerPositionLeft,
    YZCornerPositionBottom,
    YZCornerPositionRight,
    YZCornerPositionWithoutBottomLeft,
    YZCornerPositionAll
};

@interface UIView (YZCorner)

@property (nonatomic, assign) YZCornerPosition yz_cornerPosition;
@property (nonatomic, assign) CGFloat yz_cornerRadius;

- (void)yz_setCornerOnTopWithRadius:(CGFloat)radius;
- (void)yz_setCornerOnLeftWithRadius:(CGFloat)radius;
- (void)yz_setCornerOnBottomWithRadius:(CGFloat)radius;
- (void)yz_setCornerOnRightWithRadius:(CGFloat)radius;
- (void)yz_setCornerOnWithoutBottomLeftWithRadius:(CGFloat)radius;
- (void)yz_setAllCornerWithCornerRadius:(CGFloat)radius;
- (void)yz_setNoneCorner;

@end
