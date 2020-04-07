//
//  DAEmptyView.m
//  DQVideo
//
//  Created by tjl on 2019/1/28.
//  Copyright © 2019 daqian. All rights reserved.
//

#import "DAEmptyView.h"

@interface DAEmptyView ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, assign) CGFloat position;
@end

@implementation DAEmptyView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self init_DAEmptyView];
    }
    return self;
}

- (void)init_DAEmptyView {
    
    self.icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_nodata"]];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.icon];
    
    self.tipsLabel = [UILabel yz_labelWithText:RNLocalized(@"No content") textColor:RGB(153, 153, 153) textFont:[UIFont yz_PingFangSC_RegularFontOfSize:13] numberOfLines:1 textAlignment:NSTextAlignmentCenter];
    [self addSubview:self.tipsLabel];
    
    [self setupConstraints];
}

- (void)setupConstraints {
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        if (self.position > 0) {
            make.bottom.mas_equalTo(-self.position);
        } else {
            make.centerY.mas_equalTo(self.mas_centerY).mas_offset(-AUTO_WIDTH(40));
        }
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.tipsLabel.mas_top).mas_offset(-AUTO_WIDTH(20));
    }];
}

- (void)setPosition:(CGFloat)position {
    _position = position;
    [self.tipsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(-self.position);
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *viewReturn =[super hitTest:point withEvent:event];
    if ([viewReturn isKindOfClass:[self class]]) {
        return nil;
    }
    return viewReturn;
}

+ (void)showOnView:(UIView *)view AtPosition:(CGFloat)position {
    DAEmptyView *emptyView = [[DAEmptyView alloc] initWithFrame:view.bounds];
    emptyView.position = position;
    [view addSubview:emptyView];
    [view bringSubviewToFront:emptyView];
}

+ (void)showOnView:(UIView *)view {
    DAEmptyView *emptyView = [[DAEmptyView alloc] initWithFrame:view.bounds];
    [view addSubview:emptyView];
    [view bringSubviewToFront:emptyView];
}

+ (void)hideFromView:(UIView *)view {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[DAEmptyView class]]) {
            [subview removeFromSuperview];
        }
    }
}

@end
