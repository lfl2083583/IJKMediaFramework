//
//  RNPositionTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNPositionTableViewCell.h"

@implementation RNPositionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.countryBtn setTitle:RNLocalized(@"Country/Region") forState:UIControlStateNormal];
    [self.proviceBtn setTitle:RNLocalized(@"State/Province") forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)countryClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onPositionTableViewCellCountryClick:)]) {
        [self.delegate onPositionTableViewCellCountryClick:sender];
    }
    
}

- (IBAction)proviceClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onPositionTableViewCellProviceBtnClick:)]) {
        [self.delegate onPositionTableViewCellProviceBtnClick:sender];
    }
}

@end
