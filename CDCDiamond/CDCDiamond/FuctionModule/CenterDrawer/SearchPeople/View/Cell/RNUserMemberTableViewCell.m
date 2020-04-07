//
//  RNUserMemberTableViewCell.m
//  RapNet
//
//  Created by jt on 2019/11/5.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNUserMemberTableViewCell.h"
#import "RNUserModel.h"

@interface RNUserMemberTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;
@property (weak, nonatomic) IBOutlet UILabel *markLB;

@end

@implementation RNUserMemberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUserInfo:(RNUserInfo *)userInfo {
    [super setUserInfo:userInfo];
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    RNUserModel *model = self.userInfo.list[index];
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:model.F_HEADIMG]];
    self.nameLB.text = model.F_NAME;
    self.phoneLB.text = model.UF_PHONE;
    self.markLB.text = RNLocalized(@"Primary member");
    
    if ([KFormat(model.F_ISZHU) isEqualToString:@"1"]) {
        self.markLB.hidden = NO;
        CGSize size1 = [Utility getTextString:KFormat(model.F_NAME) textFont:[UIFont systemFontOfSize:14] frameWidth:App_Frame_Width attributedString:nil];
        CGSize size2 = [Utility getTextString:RNLocalized(@"Primary member") textFont:[UIFont systemFontOfSize:14] frameWidth:App_Frame_Width attributedString:nil];
        [self.markLB setX:self.nameLB.x+size1.width+15];
        [self.markLB setWidth:size2.width+8];
    } else {
        self.markLB.hidden = YES;
    }
    
}

@end
