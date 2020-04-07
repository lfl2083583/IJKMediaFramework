//
//  RNUserScoreTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/21.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNUserScoreTableViewCell.h"
#import "RNUserInfo.h"

@interface RNUserScoreTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

@property (weak, nonatomic) IBOutlet UILabel *LB1;
@property (weak, nonatomic) IBOutlet UILabel *LB2;
@property (weak, nonatomic) IBOutlet UILabel *LB3;
@property (weak, nonatomic) IBOutlet UILabel *LB4;


@end

@implementation RNUserScoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.leftBtn setSelected:YES];
    [self.rightBtn setSelected:NO];
    [self.leftBtn setTitleColor:RGBOF(0x366B9D) forState:UIControlStateSelected];
    [self.rightBtn setTitleColor:RGBOF(0x366B9D) forState:UIControlStateSelected];
    self.leftBtn.layer.borderColor = RGBOF(0x366B9D).CGColor;
    
    self.LB1.text = RNLocalized(@"Company Score");
    self.LB2.text = RNLocalized(@"Positive");
    self.LB3.text = RNLocalized(@"Reverse");
    self.LB4.text = RNLocalized(@"Score");
    
    [self.leftBtn setTitle:RNLocalized(@"Last 12 Months") forState:UIControlStateNormal];
    [self.rightBtn setTitle:RNLocalized(@"All The Time") forState:UIControlStateNormal];
    
    self.memberLB.text = RNLocalized(@"Members");
    // Initialization code

}

- (void)setUserInfo:(RNUserInfo *)userInfo {
    [super setUserInfo:userInfo];
    self.scoreLB.text = [NSString stringWithFormat:@"%@%%", userInfo.TIme12];
    if (self.userInfo.TIme12 && [KFormat(self.userInfo.TIme12) intValue] > 0) {
        self.fontLB.text = [NSString stringWithFormat:@"%@", self.userInfo.TIme12];
        self.backLB.text = [NSString stringWithFormat:@"%d", 100-[KFormat(self.userInfo.TIme12) intValue]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)scoreBtnClick:(UIButton *)sender {
    [self.leftBtn setSelected:NO];
    [self.rightBtn setSelected:NO];
    self.leftBtn.layer.borderColor = UIColor.clearColor.CGColor;
    self.rightBtn.layer.borderColor = UIColor.clearColor.CGColor;
    [sender setSelected:YES];
    sender.layer.borderColor = RGBOF(0x366B9D).CGColor;

    if ([sender isEqual:self.leftBtn]) {
        self.scoreLB.text = [NSString stringWithFormat:@"%@%%", self.userInfo.TIme12];
        if (self.userInfo.TIme12 && [KFormat(self.userInfo.TIme12) intValue] > 0) {
            self.fontLB.text = [NSString stringWithFormat:@"%@", self.userInfo.TIme12];
            self.backLB.text = [NSString stringWithFormat:@"%d", 100-[KFormat(self.userInfo.TIme12) intValue]];
        } else {
            self.fontLB.text = @"0";
            self.backLB.text = @"0";
        }
        
    } else {
        self.scoreLB.text = [NSString stringWithFormat:@"%@%%", self.userInfo.TImeAll];
        if (self.userInfo.TImeAll && [KFormat(self.userInfo.TImeAll) intValue] > 0) {
            self.fontLB.text = [NSString stringWithFormat:@"%@", self.userInfo.TImeAll];
            self.backLB.text = [NSString stringWithFormat:@"%d", 100-[KFormat(self.userInfo.TImeAll) intValue]];
        } else {
            self.fontLB.text = @"0";
            self.backLB.text = @"0";
        }
    }
}

@end
