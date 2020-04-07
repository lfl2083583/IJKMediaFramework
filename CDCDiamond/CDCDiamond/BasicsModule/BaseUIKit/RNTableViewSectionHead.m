//
//  RNTableViewSectionHead.m
//  RapNet
//
//  Created by liufulin on 2019/7/22.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNTableViewSectionHead.h"

@implementation RNTableViewSectionHead

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.contentLB];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30.f, 30.f));
            make.left.equalTo(self.contentView.mas_left).offset(10.f);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageView.mas_right).offset(10.f);
            make.right.equalTo(self.contentView.mas_right).offset(-10.f);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imageView;
}

- (UILabel *)contentLB {
    if (!_contentLB) {
        _contentLB = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLB.font = [RNGlobalUIStandard defaultTableViewTextFont];
    }
    return _contentLB;
}

@end
