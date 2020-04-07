 //
//  RNCenterItemTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/7/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNCenterItemTableViewCell.h"
#import "RNHomeModel.h"
#import "RNButton.h"
#define kmaxItem 6
#define kmargin 0.5

NSString static *CenterIconNames[] = {
    @"center_zanshi",
    @"center_liebiao",
    @"icon_star_normal",
    @"center_chazhao",
    @"center_jiage",
    @"center_xiaoxi",
};

@interface RNCenterItemTableViewCell ()

@end

@implementation RNCenterItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, App_Frame_Width - 20, 170)];
        bottomView.backgroundColor = RGBOF(0xe6e6e6);
        bottomView.layer.borderWidth = kmargin;
        bottomView.layer.borderColor =  RGBOF(0xe6e6e6).CGColor;
        bottomView.layer.cornerRadius = 4.f;
        bottomView.layer.masksToBounds = YES;
        [self.contentView addSubview:bottomView];
        
        CGFloat width = (App_Frame_Width - 21) / 3.0;
        CGFloat height = 169 / 2.0;
        
        for (int i = 0; i < kmaxItem; i++) {
            int row = i / 3;
            int cln = i % 3;
            RNTopBottomStypeBtn *menu = [[RNTopBottomStypeBtn alloc] initWithFrame:CGRectMake((width +kmargin) * cln, (height +kmargin) * row, width, height)];
            menu.tag = i+10;
            menu.backgroundColor = UIColor.whiteColor;
            [menu setTitleColor:[RNGlobalUIStandard defaultTableViewTextColor] forState:UIControlStateNormal];
            [bottomView addSubview:menu];
            [menu addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)menuClick:(RNTopBottomStypeBtn *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickItem:)]) {
        [self.delegate didClickItem:(int)sender.tag-10];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCenterMunus:(NSArray<RNMenuModel *> *)centerMunus {
    _centerMunus = centerMunus;
    NSArray *array = @[@"Find Diamonds", @"My List", @"Tracked Diamonds", @"Search People", @"TradeScreen", @"Notifications"];
    for (int i = 0 ; i < centerMunus.count; i ++) {
        RNTopBottomStypeBtn *menu = [self viewWithTag:10+i];
        menu.icon.image = [UIImage imageNamed:CenterIconNames[i]];
        [menu.contentLab setText:RNLocalized(array[i])];
        [menu.contentLab setFont:([RNLanguageManager shareManager].languageType == 2)?[UIFont yz_PingFangSC_RegularFontOfSize:12.f]:[UIFont yz_PingFangSC_RegularFontOfSize:14.f]];
    }
}

- (void)setUnreadCount:(int)unreadCount {
    _unreadCount = unreadCount;
    RNTopBottomStypeBtn *menu = [self viewWithTag:15];
    if (unreadCount > 0) {
        menu.badgeView.hidden = NO;
        menu.badgeView.badgeValue = [NSString stringWithFormat:@"%d", unreadCount];
    } else {
        menu.badgeView.hidden = YES;
        menu.badgeView.badgeValue = @"";
    }
}

@end
