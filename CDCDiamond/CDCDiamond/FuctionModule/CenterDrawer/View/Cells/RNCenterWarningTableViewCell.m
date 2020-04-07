//
//  RNCenterWarningTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/7/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNCenterWarningTableViewCell.h"

@interface RNCenterWarningTableViewCell ()
{
    UIImageView *_icon;
    UILabel *_title;
    UILabel *_subtitle;
}

@end

@implementation RNCenterWarningTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = UIColor.whiteColor;
        _icon = [UIImageView new];
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        _icon.image = [UIImage imageNamed:@"iocn_warn"];
        _title = [UILabel yz_labelWithText:RNLocalized(@"Transaction Warning") textColor:[RNGlobalUIStandard defaultTableViewSubTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        _subtitle = [UILabel yz_labelWithText:@"" textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14] numberOfLines:0 textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:bottomView];
        [bottomView addSubview:_icon];
        [bottomView addSubview:_title];
        [bottomView addSubview:_subtitle];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        }];
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).offset(10);
            make.top.equalTo(bottomView.mas_top).offset(13);
            make.size.mas_equalTo(CGSizeMake(24, 24));
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_icon.mas_right).offset(10);
            make.right.equalTo(bottomView.mas_right).offset(-10);
            make.top.equalTo(self->_icon.mas_top);
        }];
        
        [_subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_icon.mas_right).offset(10);
            make.right.equalTo(bottomView.mas_right).offset(-10);
            make.top.equalTo(self->_title.mas_bottom).offset(13);
            make.bottom.equalTo(bottomView.mas_bottom).offset(-13);
        }];
    }
    return self;
}


- (void)setWarnstring:(NSString *)warnstring {
    _warnstring = warnstring;
    _subtitle.text = warnstring;
    _title.text = RNLocalized(@"Transaction Warning");
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
