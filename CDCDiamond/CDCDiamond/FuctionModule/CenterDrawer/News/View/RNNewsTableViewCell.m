//
//  RNNewsTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/9/26.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNNewsTableViewCell.h"
#import "RNNewsModel.h"

@implementation RNNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        
        _icon = [UIImageView new];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        _icon.layer.borderWidth = 0.5;
        _icon.layer.borderColor = RGBOF(0xe6e6e6).CGColor;
        _icon.layer.cornerRadius = 5.f;
        _icon.layer.masksToBounds = YES;
        _icon.clipsToBounds = YES;
        
        _titleLB = [UILabel yz_labelWithText:@"" textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14] numberOfLines:2 textAlignment:NSTextAlignmentLeft];
        
        
        _subtitleLB = [UILabel yz_labelWithText:@"" textColor:[RNGlobalUIStandard defaultTableViewSubTextColor] textFont:[UIFont yz_PingFangSC_MediumFontOfSize:12] numberOfLines:1 textAlignment:NSTextAlignmentLeft];
        
        _line = [UIView new];
        _line.backgroundColor = RGBOF(0xe6e6e6);
        
        [bottomView addSubview:_icon];
        [bottomView addSubview:_titleLB];
        [bottomView addSubview:_subtitleLB];
        [bottomView addSubview:_line];
        
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).offset(10);
            make.right.equalTo(self.icon.mas_left).offset(-20);
            make.top.equalTo(bottomView.mas_top).offset(13);
        }];
        
        [_subtitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).offset(10);
            make.right.equalTo(self.icon.mas_left).offset(-20);
            make.bottom.equalTo(bottomView.mas_bottom).offset(-13);
        }];
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(bottomView.mas_right).offset(-10);
            make.top.equalTo(bottomView.mas_top).offset(13);
            make.bottom.equalTo(bottomView.mas_bottom).offset(-13);
            make.width.mas_equalTo(105);
        }];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.equalTo(bottomView.mas_left).offset(10);
            make.right.equalTo(bottomView.mas_right);
            make.bottom.equalTo(bottomView.mas_bottom);
        }];
    }
    return self;
}

- (void)setNewsModel:(RNNewsModel *)newsModel {
    _newsModel = newsModel;
    _titleLB.text = newsModel.F_BIGTITLE;
    _subtitleLB.text = newsModel.F_AUTHOR;
    
    if (newsModel.F_NEWSIMG && KFormat(newsModel.F_NEWSIMG).length) {
        [_icon setHidden:NO];
        [_icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", newsModel.F_NEWSIMG]] placeholderImage:[UIImage imageNamed:@"default_diamond"]];
    } else {
        [_icon setHidden:YES];
    }
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
