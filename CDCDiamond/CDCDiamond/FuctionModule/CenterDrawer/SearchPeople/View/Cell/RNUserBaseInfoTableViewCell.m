//
//  RNUserBaseInfoTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/21.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNUserBaseInfoTableViewCell.h"

@interface RNUserBaseInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *userIDLB;
@property (weak, nonatomic) IBOutlet UILabel *companyTypeLB;
@property (weak, nonatomic) IBOutlet UILabel *btn1;
@property (weak, nonatomic) IBOutlet UILabel *btn2;
@property (weak, nonatomic) IBOutlet UILabel *btn3;

@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation RNUserBaseInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.lb1.text = RNLocalized(@"Members");
    self.lb2.text = RNLocalized(@"Score");
    self.lb3.text = RNLocalized(@"Diamond");
    // Initialization codeM
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setUserInfo:(RNUserInfo *)userInfo {
    [super setUserInfo:userInfo];
    
    self.titleLB.text = userInfo.F_COMNAME;
    self.userIDLB.text = [NSString stringWithFormat:@"CDC ID %@", userInfo.UF_USERNAME];
    NSString *compayType = (userInfo.F_COMPANYTYPENAME && [userInfo.F_COMPANYTYPENAME isKindOfClass:[NSString class]] && ![userInfo.F_COMPANYTYPENAME isEqualToString:@"null"])?userInfo.F_COMPANYTYPENAME:@"";
    self.companyTypeLB.text = [NSString stringWithFormat:@"%@ %@", RNLocalized(@"Company Type"), [Utility fomateString:compayType]];
    
    
    self.btn2.text = (userInfo.UF_SCORE && [userInfo.UF_SCORE isKindOfClass:[NSString class]] && ![userInfo.UF_SCORE isEqualToString:@"null"])?userInfo.UF_SCORE:@"0";
    self.btn3.text = userInfo.AllNum;
    
    if (userInfo.months && [userInfo.months integerValue] > 0 && [userInfo.months integerValue] < 12) {
        self.btn1.text = KFormat(userInfo.months);
        self.timeLab.text = @"Months";
    } else if (userInfo.months && [userInfo.months integerValue] >= 12) {
        self.btn1.text = [NSString stringWithFormat:@"%ld", [userInfo.months integerValue]/12];
        self.timeLab.text = @"Years";
    }
}

@end
