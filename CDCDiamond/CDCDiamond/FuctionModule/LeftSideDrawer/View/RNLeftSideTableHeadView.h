//
//  RNLeftSideTableHeadView.h
//  RapNet
//
//  Created by liufulin on 2019/7/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RNUserInfo;

NS_ASSUME_NONNULL_BEGIN

@protocol RNLeftSideTableHeadViewDelegate <NSObject>

- (void)didSeletedAvatar;
- (void)didSeletedUserInfo;

@end

@interface RNLeftSideTableHeadView : UIView

@property (nonatomic, weak) id <RNLeftSideTableHeadViewDelegate> delegate;
@property (nonatomic, strong) RNUserInfo *userInfo;

@end



NS_ASSUME_NONNULL_END
