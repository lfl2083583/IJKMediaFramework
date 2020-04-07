//
//  RNAgencyViewTableViewCell.m
//  RapNet
//
//  Created by tjl on 2019/11/11.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNAgencyViewTableViewCell.h"

@interface RNAgencyViewTableViewCell ()

@property (nonatomic, strong) UILabel *regionLB;
@property (nonatomic, strong) UILabel *agencyNameLB;
@property (nonatomic, strong) UILabel *phoneLB;
@property (nonatomic, strong) UILabel *emailLB;

@end

@implementation RNAgencyViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = RGBOF(0xf1f1f1);
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = WhiteColor;
        self.regionLB = [UILabel yz_labelWithText:@"" textColor:RGBOF(0x333333) textFont:[UIFont yz_PingFangSC_MediumFontOfSize:18]];
        self.agencyNameLB = [UILabel yz_labelWithText:@"" textColor:RGBOF(0x999999) textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14] numberOfLines:0 textAlignment:NSTextAlignmentLeft];
        self.phoneLB = [UILabel yz_labelWithText:@"" textColor:RGBCOLOR(78, 132, 220, 1) textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        self.emailLB = [UILabel yz_labelWithText:@"" textColor:RGBCOLOR(78, 132, 220, 1) textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        
        [self.contentView addSubview:bottomView];
        [bottomView addSubview:self.regionLB];
        [bottomView addSubview:self.agencyNameLB];
        [bottomView addSubview:self.phoneLB];
        [bottomView addSubview:self.emailLB];
        
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.top.equalTo(self.contentView.mas_top);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        [self.regionLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).offset(12);
            make.top.equalTo(bottomView.mas_top).offset(12);
            make.right.equalTo(bottomView.mas_right).offset(-12);
        }];
        
        [self.agencyNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).offset(12);
            make.top.equalTo(self.regionLB.mas_bottom).offset(5);
            make.right.equalTo(bottomView.mas_right).offset(-12);
        }];
        
        [self.phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.agencyNameLB.mas_bottom).offset(5);
            make.left.equalTo(bottomView.mas_left).offset(12);
            make.right.equalTo(bottomView.mas_right).offset(-12);
        }];
        
        [self.emailLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.phoneLB.mas_bottom).offset(5);
            make.left.equalTo(bottomView.mas_left).offset(12);
            make.right.equalTo(bottomView.mas_right).offset(-12);
            make.bottom.equalTo(bottomView.mas_bottom).offset(-12);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        self.contentView.userInteractionEnabled = YES;
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}


- (void)setSource:(id)source {
    _source = source;
    self.regionLB.text = source[@"F_REGION"];
    self.agencyNameLB.text = source[@"F_FDETAILED"];
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", source[@"F_PHONE"]] attributes:attribtDic];
    self.phoneLB.attributedText = attribtStr;
    
    NSMutableAttributedString *attribtStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", source[@"F_MAILBOX"]] attributes:attribtDic];
    self.emailLB.attributedText = attribtStr2;
}

- (void)onTap:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.contentView];
    if (CGRectContainsPoint(self.phoneLB.frame, point)) {
        NSLog(@"电话");
        if (_delegate && [_delegate respondsToSelector:@selector(onPhoneClick:)]) {
            [_delegate onPhoneClick:KFormat(self.source[@"F_PHONE"])];
        }
    } else if (CGRectContainsPoint(self.emailLB.frame, point)) {
        NSLog(@"邮箱");
        if (_delegate && [_delegate respondsToSelector:@selector(onEmailClick:)]) {
            [_delegate onEmailClick:KFormat(self.source[@"F_MAILBOX"])];
        }
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
