//
//  RNUserCompanyTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/21.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNUserCompanyTableViewCell.h"

@interface RNUserCompanyTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *mobleLB;
@property (weak, nonatomic) IBOutlet UILabel *telphoneLB;
@property (weak, nonatomic) IBOutlet UILabel *webLB;
@property (weak, nonatomic) IBOutlet UILabel *loctionLB;

@property (weak, nonatomic) IBOutlet UILabel *companyLB;
@end

@implementation RNUserCompanyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.companyLB.text = RNLocalized(@"Company details");
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUserInfo:(RNUserInfo *)userInfo {
    [super setUserInfo:userInfo];
    
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", userInfo.UF_PHONE] attributes:attribtDic];
    self.mobleLB.attributedText = attribtStr;
    
    self.telphoneLB.text = userInfo.F_PHONE;
    
    NSMutableAttributedString *webattribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", userInfo.F_WEBSITE] attributes:attribtDic];
    
    NSString *country = [KFormat(userInfo.F_COUNTRY) isEqualToString:@"1"]?@"中国":KFormat(userInfo.F_COUNTRY);
    NSString *city = KFormat(userInfo.F_CITY);
    NSString *address = KFormat(userInfo.F_ADDRESS);
    NSString *webString = country;
    if (city.length && ![city containsString:@"null"]) {
        webString = [NSString stringWithFormat:@"%@，%@",webString, city];
    }
    if (address.length && ![address containsString:@"null"]) {
        webString = [NSString stringWithFormat:@"%@，%@",webString, address];
    }
    self.loctionLB.text = webString;
    
    self.webLB.attributedText = webattribtStr;
}

- (IBAction)phoneClick:(UIButton *)sender {
    if (self.userInfo.F_MAINPHONE.length == 0) {
        return;
    }
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", self.userInfo.F_MAINPHONE];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",callPhone]]];
    
}
- (IBAction)webClick:(UIButton *)sender {
    if (self.userInfo.F_WEBSITE.length == 0) {
        return;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", self.userInfo.F_WEBSITE]]];
}

@end
