//
//  RNCenterSectionView.m
//  RapNet
//
//  Created by liufulin on 2019/10/13.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNCenterSectionView.h"

@implementation RNCenterSectionView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _title = [UILabel yz_labelWithText:@"" textColor:[RNGlobalUIStandard defaultTableViewSubTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:16]];
        _sideButton = [UIButton yz_buttonWithTitle:RNLocalized(@"Look All") titleColor:MainColor textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        _sideButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_sideButton addTarget:self action:@selector(sideButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_title];
        [self.contentView addSubview:_sideButton];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(13);
        }];
        
        [_sideButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.centerY.equalTo(self->_title.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        self.contentView.backgroundColor = RGBOF(0xf8f8f8);
    }
    return self;
}

- (void)sideButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickNewsAll)]) {
        [self.delegate didClickNewsAll];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
