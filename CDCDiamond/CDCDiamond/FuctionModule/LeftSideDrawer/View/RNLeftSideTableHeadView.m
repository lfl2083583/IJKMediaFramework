//
//  RNLeftSideTableHeadView.m
//  RapNet
//
//  Created by liufulin on 2019/7/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNLeftSideTableHeadView.h"

@interface RNLeftSideTableHeadView ()

@property (nonatomic, strong) UIButton *avatarView;
@property (nonatomic, strong) UIButton *cameraView;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *contentLab;

@end

@implementation RNLeftSideTableHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _avatarView = [UIButton yz_buttonWithImageStr:@"icon_avatar"];
        [_avatarView setImage:ImageName(@"icon_avatar") forState:UIControlStateNormal];
        [_avatarView addTarget:self action:@selector(avatarClick) forControlEvents:UIControlEventTouchUpInside];
        _cameraView = [UIButton yz_buttonWithImageStr:@"icon_carmera"];
        [_cameraView addTarget:self action:@selector(avatarClick) forControlEvents:UIControlEventTouchUpInside];
        _avatarView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarView.layer.cornerRadius = 25;
        _avatarView.layer.borderWidth = 1;
        _avatarView.layer.borderColor = RGBOF(0xe6e6e6).CGColor;
        _avatarView.backgroundColor = RGBCOLOR(226, 226, 226, 1);
        _avatarView.clipsToBounds = YES;
        _nameLab = [UILabel yz_labelWithText:@"" textColor:UIColorFromRGB(0x222222) textFont:[UIFont yz_PingFangSC_MediumFontOfSize:16]];
        _contentLab = [UILabel yz_labelWithText:@"" textColor:UIColorFromRGB(0x999999) textFont:[UIFont yz_PingFangSC_MediumFontOfSize:12] numberOfLines:0];
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = UIColorFromRGB(0xf6f6f6);
        
        [self addSubview:_avatarView];
        [self addSubview:_cameraView];
        [self addSubview:_nameLab];
        [self addSubview:_contentLab];
        [self addSubview:bottomView];
        
        [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        [_cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.avatarView.mas_right).offset(2);
            make.top.equalTo(self.avatarView.mas_top).offset(-2);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarView.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self.avatarView.mas_centerY).offset(-10);
        }];
        
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarView.mas_right).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.nameLab.mas_bottom).offset(5);
        }];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(8);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
        UITapGestureRecognizer *tapGuester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tapGuester.numberOfTapsRequired = 1;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tapGuester];
    }
    return self;
}

- (void)avatarClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSeletedAvatar)]) {
        [self.delegate didSeletedAvatar];
    }
}

- (void)tap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSeletedUserInfo)]) {
        [self.delegate didSeletedUserInfo];
    }
}

- (void)setUserInfo:(RNUserInfo *)userInfo {
    _userInfo = userInfo;
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:userInfo.UF_HEADIMG] forState:UIControlStateNormal];
    [_nameLab setText:userInfo.UF_NAME];
    [_contentLab setText:[NSString stringWithFormat:RNLocalized(@"Membership expires at %@"), KFormat(userInfo.F_ENDTIME).length>10?[KFormat(userInfo.F_ENDTIME) substringToIndex:10]:KFormat(userInfo.F_ENDTIME)]];
}

@end
