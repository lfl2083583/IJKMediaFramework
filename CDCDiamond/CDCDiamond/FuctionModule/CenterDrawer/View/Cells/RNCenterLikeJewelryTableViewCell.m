//
//  RNCenterJewelryTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/7/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNCenterLikeJewelryTableViewCell.h"

@implementation RNCenterLikeJewelryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *botttomView = [UIView new];
        botttomView.backgroundColor = UIColor.whiteColor;
        
        _focusBtn = [UIButton yz_buttonWithImageStr:@"icon_star"];
        
        _title = [UILabel yz_labelWithText:@"二维火hi我的五毒坎坎坷坷斤斤计较经济基本面哈哈哈哈哈哈哈男男女女或过过过" textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14] numberOfLines:2 textAlignment:NSTextAlignmentLeft];
        
        _subtitle = [UILabel yz_labelWithText:@"啊啊啊啊啊顶顶顶顶订单" textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_SemiboldFontOfSize:12] numberOfLines:1 textAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:botttomView];
        [botttomView addSubview:_focusBtn];
        [botttomView addSubview:_title];
        [botttomView addSubview:_subtitle];
        
        [botttomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        
        [_focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(botttomView.mas_left).offset(15);
            make.top.equalTo(botttomView.mas_top).offset(15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.focusBtn.mas_right).offset(10);
            make.top.equalTo(self.focusBtn.mas_top);
            make.right.equalTo(botttomView.mas_right).offset(-10);
        }];
        
        [_subtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.focusBtn.mas_right).offset(10);
            make.top.equalTo(self.title.mas_bottom).offset(10);
            make.right.equalTo(botttomView.mas_right).offset(-10);
            make.bottom.equalTo(botttomView.mas_bottom).offset(-10);
        }];
    }
    return self;
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
