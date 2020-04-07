//
//  YZBuyRequestAddAddressView.m
//  RapNet
//
//  Created by tjl on 2019/11/13.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "YZBuyRequestAddAddressView.h"
@class YZAddressView;

@protocol YZAddressViewDelegate <NSObject>

- (void)onAddressBtnClick:(YZAddressView *)sender;

@end

@interface YZAddressView : UIView

@property (nonatomic, strong) UILabel *addressLB;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, weak) id<YZAddressViewDelegate>delegate;

@end

@implementation YZAddressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.addressLB = [UILabel yz_labelWithText:@"" textColor:RGBOF(0x999999) textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        self.rightBtn = [UIButton yz_buttonWithTitle:@"✛" titleColor:RGBOF(0X999999) textFont:[UIFont yz_PingFangSC_MediumFontOfSize:15]];
        [self.rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = RGBOF(0xe6e6e6);
        
        [self addSubview:self.addressLB];
        [self addSubview:self.rightBtn];
        [self addSubview:self.line];
        
        [self.addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right).offset(-80);
        }];
        
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-8);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.width.mas_equalTo(40);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];
    }
    return self;
}

- (void)rightBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onAddressBtnClick:)]) {
        [self.delegate onAddressBtnClick:self];
    }
}

@end


@interface YZBuyRequestAddAddressView ()<YZAddressViewDelegate>

@property (nonatomic, strong) NSMutableArray *muatableArray;

@end

@implementation YZBuyRequestAddAddressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        YZAddressView *addressView = [[YZAddressView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
        [addressView.addressLB setText:RNLocalized(@"Add The Position")];
        addressView.delegate = self;
        addressView.tag = 999;
        [self.muatableArray addObject:addressView];
        [self addSubview:addressView];
    }
    return self;
}

- (void)setAddressList:(NSMutableArray *)addressList {
    _addressList = addressList;
    if (addressList && [addressList isKindOfClass:[NSArray class]] && [addressList count] && [self.muatableArray count]) {
        
        for (YZAddressView *addressView in self.muatableArray) {
            [addressView setHidden:YES];
            addressView.delegate = nil;
            [addressView removeFromSuperview];
        }
        
        for (int i = 0; i < addressList.count+1; i++) {
            YZAddressView *addressView = [[YZAddressView alloc] initWithFrame:CGRectMake(0, 44*i, self.width, 44)];
            
            
            addressView.delegate = self;
            if (i == addressList.count) {
                [addressView.addressLB setText:RNLocalized(@"Add The Position")];
                [addressView.rightBtn setTitle:@"✛" forState:UIControlStateNormal];
                [addressView setTag:9999];
            } else{
                [addressView.addressLB setText:addressList[i]];
                [addressView.rightBtn setTitle:@"✕" forState:UIControlStateNormal];
                [addressView setTag:100+i];
            }
            [self addSubview:addressView];
            [self.muatableArray addObject:addressView];
        }
    } else {
        for (YZAddressView *addressView in self.muatableArray) {
            [addressView setHidden:YES];
            addressView.delegate = nil;
            [addressView removeFromSuperview];
        }
        YZAddressView *addressView = [[YZAddressView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
        [addressView.addressLB setText:RNLocalized(@"Add The Position")];
        addressView.delegate = self;
        addressView.tag = 999;
        [self.muatableArray addObject:addressView];
        [self addSubview:addressView];
    }
}

#pragma mark - YZAddressViewDelegate

- (void)onAddressBtnClick:(YZAddressView *)sender {
    YZAddressView *lastAddress = [self.muatableArray lastObject];
    if ([sender isEqual:lastAddress]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onBuyRequestAddAddressViewAddAddressClick)]) {
            [self.delegate onBuyRequestAddAddressViewAddAddressClick];
        }
    } else{
        if (self.addressList.count){
            NSInteger i = sender.tag-100;
            [self.addressList removeObjectAtIndex:i];
            if (self.delegate && [self.delegate respondsToSelector:@selector(onBuyRequestAddAddressViewDeleteAddressClick:)]) {
                [self.delegate onBuyRequestAddAddressViewDeleteAddressClick:self.addressList];
            }
        }
    }
}

- (NSMutableArray *)muatableArray {
    if (!_muatableArray) {
        _muatableArray = [NSMutableArray array];
    }
    return _muatableArray;
}
@end
