//
//  RNLeftSideTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/7/22.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNLeftSideTableViewCell.h"

@implementation RNLeftSideTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.contentLB];
        [self.contentView addSubview:self.line];

        [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(50.f);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.mas_left).offset(50.f);
            make.right.mas_equalTo(self.contentView);
        }];
        
        self.backgroundColor = UIColor.whiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (UILabel *)contentLB {
    if (!_contentLB) {
        _contentLB = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLB.font = [RNGlobalUIStandard defaultTableViewTextFont];
        _contentLB.textColor = [RNGlobalUIStandard defaultTableViewTextColor];
    }
    return _contentLB;
}


- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_right"]];
    }
    return _arrowImgView;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = RGBOF(0xe6e6e6);
    }
    return _line;
}

@end


@implementation RNLeftSideImgTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imgView];
        
        [self.contentView addSubview:self.arrowImgView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(24, 24));
            make.left.equalTo(self.mas_left).offset(10.f);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [self.contentLB mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(10.f);
            make.right.equalTo(self.mas_right).offset(-10.f);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-15);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.right.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    self.imgView.image = image;
}


- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}

@end
