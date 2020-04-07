//
//  DAEmptyView.h
//  DQVideo
//
//  Created by tjl on 2019/1/28.
//  Copyright © 2019 daqian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DAEmptyView : UIView

+ (void)hideFromView:(UIView *)view;
+ (void)showOnView:(UIView *)view;
+ (void)showOnView:(UIView *)view AtPosition:(CGFloat)position;

@end

NS_ASSUME_NONNULL_END
