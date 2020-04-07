//
//  RNButton.h
//  RapNet
//
//  Created by liufulin on 2019/10/8.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTBadgeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNButton : UIButton

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) JTBadgeView *badgeView;
@property (nonatomic, strong) UIView *badgeContentView;
@end


@interface RNTopBottomStypeBtn : RNButton



@end

NS_ASSUME_NONNULL_END
