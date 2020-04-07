//
//  RNMessageListTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/11/20.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNMessageListTableViewCell.h"

@interface RNMessageListTableViewCell ()
@property (strong, nonatomic) UILabel *titleLB;
@property (strong, nonatomic) UILabel *timeLB;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UILabel *contentLB;
@property (strong, nonatomic) UIView *line;


@end

@implementation RNMessageListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLB = [UILabel yz_labelWithText:@"" textColor:RGBOF(0x222222) textFont:[UIFont systemFontOfSize:14.f] numberOfLines:0 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_titleLB];
        
        _timeLB = [UILabel yz_labelWithText:@"" textColor:RGBOF(0x999999) textFont:[UIFont systemFontOfSize:14.f] numberOfLines:0 textAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:_timeLB];
        
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = RGBOF(0xf6f6f6);
        [self.contentView addSubview:_bottomView];
        
        _contentLB = [UILabel yz_labelWithText:@"" textColor:RGBOF(0x222222) textFont:[UIFont systemFontOfSize:14.f] numberOfLines:0 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_contentLB];
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBOF(0xe6e6e6);
        [self.contentView addSubview:_line];
        
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-115);
        }];
        
        [_contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.titleLB.mas_bottom).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        }];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.bottom.mas_equalTo(self.contentView);
        }];
        
        [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.centerY.equalTo(self.titleLB.mas_centerY);
            make.width.mas_equalTo(100);
        }];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.top.equalTo(self.titleLB.mas_bottom).offset(5);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setModel:(RNMessageListModel *)model {
    self.titleLB.text = [KFormat(model.F_TITLE) stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    self.timeLB.text = model.F_TIME;
    if (model.isOpen) {
        NSString *content = [KFormat(model.F_CONTENTS) stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        self.contentLB.text = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        [self.contentLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLB.mas_bottom).offset(10);
        }];
        self.bottomView.hidden = NO;
    } else {
        self.contentLB.text = @"";
        [self.contentLB mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLB.mas_bottom).offset(0);
        }];
        self.bottomView.hidden = YES;
    }
    
    self.titleLB.textColor = (model.isRead)?RGBOF(0x999999):RGBOF(0x222222);
    self.contentLB.textColor = (model.isRead)?RGBOF(0x999999):RGBOF(0x222222);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
