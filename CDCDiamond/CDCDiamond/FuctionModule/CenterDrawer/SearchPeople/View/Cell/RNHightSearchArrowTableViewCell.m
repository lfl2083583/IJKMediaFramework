//
//  RNHightSearchArrowTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNHightSearchArrowTableViewCell.h"

@implementation RNHightSearchArrowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
