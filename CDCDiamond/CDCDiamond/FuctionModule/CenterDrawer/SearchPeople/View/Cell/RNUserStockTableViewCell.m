//
//  RNUserStockTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/21.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNUserStockTableViewCell.h"


@interface RNUserStockTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *LB1;
@property (weak, nonatomic) IBOutlet UILabel *LB2;
@property (weak, nonatomic) IBOutlet UILabel *LB3;
@property (weak, nonatomic) IBOutlet UILabel *LB4;
@property (weak, nonatomic) IBOutlet UILabel *LB5;
@property (weak, nonatomic) IBOutlet UILabel *LB6;

@property (weak, nonatomic) IBOutlet UILabel *LB7;
@property (weak, nonatomic) IBOutlet UILabel *LB8;
@property (weak, nonatomic) IBOutlet UILabel *LB9;
@property (weak, nonatomic) IBOutlet UILabel *LB10;
@property (weak, nonatomic) IBOutlet UILabel *LB11;
@property (weak, nonatomic) IBOutlet UILabel *LB12;

@end

@implementation RNUserStockTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.LB7.text = RNLocalized(@"Inventory");
    self.LB8.text = RNLocalized(@"List Diamonds");
    self.LB9.text = RNLocalized(@"The Match");
    self.LB10.text = RNLocalized(@"Available List");
    self.LB11.text = RNLocalized(@"White");
    self.LB12.text = RNLocalized(@"Iridescence");
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}



- (void)setUserInfo:(RNUserInfo *)userInfo {
    [super setUserInfo:userInfo];
    _LB2.text = userInfo.ptcNum;
    _LB4.text = userInfo.ppcNum;
    _LB6.text = userInfo.ptcNum;
    
    _LB1.text = userInfo.ptbNum;
    _LB3.text = userInfo.ppbNum;
    _LB5.text = userInfo.cbbNum;
}

@end
