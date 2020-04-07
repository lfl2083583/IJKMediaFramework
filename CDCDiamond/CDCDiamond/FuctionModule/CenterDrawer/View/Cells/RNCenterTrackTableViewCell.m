//
//  RNCenterTrackTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/7/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNCenterTrackTableViewCell.h"

@implementation RNCenterTrackTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, App_Frame_Width - 20, 60)];
        bottomView.backgroundColor = UIColor.whiteColor;
        bottomView.layer.cornerRadius = 4.f;
        bottomView.layer.borderColor = RGBOF(0xe6e6e6).CGColor;
        bottomView.layer.borderWidth = 0.5f;
        bottomView.layer.masksToBounds = YES;
        [self.contentView addSubview:bottomView];
        
        UILabel *titleLab = [UILabel yz_labelWithText:RNLocalized(@"Tracked Diamonds") textColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_MediumFontOfSize:15]];
        titleLab.frame = CGRectMake(15, 0, App_Frame_Width - 20, 60);
        [bottomView addSubview:titleLab];
        _titleLab = titleLab;
        
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_right"]];
        arrow.frame = CGRectMake(bottomView.width - 28, (bottomView.height - 16) / 2.0, 16, 16);
        [bottomView addSubview:arrow];
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
