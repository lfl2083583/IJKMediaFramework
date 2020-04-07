//
//  RNBaseUserInfoTableViewCell.m
//  RapNet
//
//  Created by jt on 2019/11/4.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNBaseUserInfoTableViewCell.h"

@implementation RNBaseUserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUserInfo:(RNUserInfo *)userInfo {
    _userInfo = userInfo;
}

@end
