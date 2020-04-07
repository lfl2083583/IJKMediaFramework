//
//  RNCenterNavView.h
//  RapNet
//
//  Created by jt on 2019/11/25.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RNCenterNavViewDelegate <NSObject>

- (void)onLeftMenueClick;
- (void)onRightMenueClick;

@end

@interface RNCenterNavView : UIView

@property (nonatomic, weak) id<RNCenterNavViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
