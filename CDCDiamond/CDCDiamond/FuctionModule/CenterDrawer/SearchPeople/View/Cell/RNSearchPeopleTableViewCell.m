//
//  RNSearchPeopleTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/14.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNSearchPeopleTableViewCell.h"
#import "RNPeopleModel.h"

@interface RNSearchPeopleTableViewCell ()
{
    UIView  *_bottomView;
    UILabel *_title;
    UILabel *_position;
    UILabel *_positionContent;
    UILabel *_company;
    UILabel *_companyContent;
    UILabel *_score;
    UILabel *_scoreContent;
    UILabel *_rapID;
    UILabel *_rapIDContent;
    
    UIImageView *_arrow;
}

@end

@implementation RNSearchPeopleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        _bottomView = [UIView new];
        _bottomView.backgroundColor = UIColor.whiteColor;
        _bottomView.layer.cornerRadius = 4.f;
        _bottomView.layer.borderWidth = 0.5f;
        _bottomView.layer.borderColor = RGBOF(0xe6e6e6).CGColor;
        _bottomView.layer.masksToBounds = YES;
        _title = [UILabel yz_labelWithText:@"" textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_MediumFontOfSize:16]];
        _position = [UILabel yz_labelWithText:RNLocalized(@"Location") textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        _positionContent = [UILabel yz_labelWithText:@"" textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        _company = [UILabel yz_labelWithText:RNLocalized(@"Company Type") textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        _companyContent = [UILabel yz_labelWithText:@"" textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        _score = [UILabel yz_labelWithText:RNLocalized(@"Score") textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        _scoreContent = [UILabel yz_labelWithText:@"" textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        _rapID = [UILabel yz_labelWithText:@"CDCID" textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        _rapIDContent = [UILabel yz_labelWithText:@"" textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        _arrow = [UIImageView new];
        
        [self.contentView addSubview:_bottomView];
        [_bottomView addSubview:_title];
        [_bottomView addSubview:_position];
        [_bottomView addSubview:_positionContent];
        [_bottomView addSubview:_company];
        [_bottomView addSubview:_companyContent];
        [_bottomView addSubview:_score];
        [_bottomView addSubview:_scoreContent];
        [_bottomView addSubview:_rapID];
        [_bottomView addSubview:_rapIDContent];
        [_bottomView addSubview:_arrow];
        
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).offset(12);
            make.right.equalTo(self.contentView.mas_right).offset(-12);
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_bottomView.mas_left).offset(12);
            make.right.equalTo(self->_bottomView.mas_right).offset(-12);
            make.top.equalTo(self->_bottomView.mas_top).offset(12);
        }];
        
        [_position mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_bottomView.mas_left).offset(12);
            make.width.mas_equalTo(100);
            make.top.equalTo(self->_title.mas_bottom).offset(10);
        }];
        
        [_positionContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_position.mas_right).offset(12);
           make.right.equalTo(self->_bottomView.mas_right).offset(-12);
            make.centerY.equalTo(self->_position.mas_centerY);
        }];
        
        [_company mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_bottomView.mas_left).offset(12);
            make.width.mas_equalTo(100);
            make.top.equalTo(self->_position.mas_bottom).offset(12);
        }];
        
        [_companyContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_company.mas_right).offset(12);
            make.right.equalTo(self->_bottomView.mas_right).offset(-12);
            make.centerY.equalTo(self->_company.mas_centerY);
        }];
        
        [_score mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_bottomView.mas_left).offset(12);
            make.width.mas_equalTo(100);
            make.top.equalTo(self->_company.mas_bottom).offset(12);
        }];
        
        [_scoreContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_score.mas_right).offset(12);
            make.right.equalTo(self->_bottomView.mas_right).offset(-12);
            make.centerY.equalTo(self->_score.mas_centerY);
        }];
        
        [_rapID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_bottomView.mas_left).offset(12);
            make.width.mas_equalTo(100);
            make.top.equalTo(self->_score.mas_bottom).offset(12);
            make.bottom.equalTo(self->_bottomView.mas_bottom).offset(-12);
        }];
        
        [_rapIDContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_rapID.mas_right).offset(12);
            make.right.equalTo(self->_bottomView.mas_right).offset(-5);
            make.centerY.equalTo(self->_rapID.mas_centerY);
        }];
        
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(24, 24));
            make.right.equalTo(self->_bottomView.mas_right).offset(-12);
            make.centerY.equalTo(self->_bottomView.mas_centerY);
        }];
    }
    return self;
}

- (void)setModel:(RNPeopleModel *)model {
    _model = model;
    _title.text = model.F_COMNAME;
    NSString *country = [[model.F_COUNTRYNAME componentsSeparatedByString:@","] firstObject];
    NSString *city = [[model.F_CITYNAME componentsSeparatedByString:@","] firstObject];
    NSString *provice = [[model.F_SHENGNAME componentsSeparatedByString:@","] firstObject];
    _positionContent.text = [self handleCustomeString:[NSString stringWithFormat:@"%@", country]];
    _companyContent.text = [NSString stringWithFormat:@"%@", [self handleCustomeString:model.F_COMPANYTYPE]];
    _scoreContent.text = [NSString stringWithFormat:@"%@%% | %@", [self handleCompanyScore:model.F_SCORE], [self handleCompanyScore:model.F_SCORE]];
    _rapIDContent.text = [NSString stringWithFormat:@"%@", model.F_COMNAME];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *)handleCustomeString:(NSString *)customeString {
    if (customeString && [customeString isKindOfClass:[NSString class]] && ![customeString isEqualToString:@"null"] && customeString.length) {
        return customeString;
    } else {
        return @"-";
    }
}

- (NSString *)handleCompanyScore:(NSString *)companyScore {
    if (companyScore && [companyScore intValue] >= 0) {
        return companyScore;
    } else {
        return @"0";
    }
}

@end
