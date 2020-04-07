//
//  UIFont+Utils.h
//  TPSLIVE
//
//  Created by Leaf on 2019/7/8.
//  Copyright © 2019 HS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (Utils)

#pragma mark - PingFangSC 字体
/** PingFang SC 字体, Regular 字重 */
+ (UIFont *)yz_PingFangSC_RegularFontOfSize:(CGFloat)fontSize;
/** PingFang SC 字体, Medium 字重 */
+ (UIFont *)yz_PingFangSC_MediumFontOfSize:(CGFloat)fontSize;
/** PingFang SC 字体, Semibold 字重 */
+ (UIFont *)yz_PingFangSC_SemiboldFontOfSize:(CGFloat)fontSize;


#pragma mark - DIN Alternate 字体
/** DINAlternate 字体, Bold 字重 */
+ (UIFont *)yz_DINAlternate_BoldFontOfSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
