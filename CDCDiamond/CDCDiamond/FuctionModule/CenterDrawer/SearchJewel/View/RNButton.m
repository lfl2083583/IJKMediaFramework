//
//  RNButton.m
//  RapNet
//
//  Created by liufulin on 2019/10/8.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNButton.h"

@implementation RNButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat x = App_Frame_Width / 6.0 + 7;
        self.badgeContentView = [[UIView alloc] initWithFrame:CGRectMake(x, 7, 60, 40)];
        [self addSubview:self.badgeContentView];
        self.badgeView = [JTBadgeView viewWithBadgeTip:@""];
        self.badgeView.hidden = YES;
        [self.badgeContentView addSubview:self.badgeView];
        
        _icon = [[UIImageView alloc] init];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        _icon.clipsToBounds = YES;
        [self addSubview:_icon];
        
        _contentLab = [[UILabel alloc] init];
        _contentLab.numberOfLines = 0;
        _contentLab.font = [UIFont yz_PingFangSC_RegularFontOfSize:14.f];
        _contentLab.textAlignment = NSTextAlignmentCenter;
        _contentLab.textColor = UIColorFromRGB(0x333333);
        [self addSubview:_contentLab];
        
        [self layoutViews];
    }
    return self;
}

- (void)layoutViews {
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.equalTo(self.icon.mas_bottom).offset(8);
    }];
}
@end


@implementation RNTopBottomStypeBtn

- (void)layoutViews {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(-15);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(15);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

@end
