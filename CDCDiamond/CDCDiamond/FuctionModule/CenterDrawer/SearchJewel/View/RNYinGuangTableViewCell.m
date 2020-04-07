//
//  RNYinGuangTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/7.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNYinGuangTableViewCell.h"
#import "RNChooseView.h"

@interface RNYinGuangTableViewCell ()<RNChooseViewDelegate>
@property (nonatomic, strong) RNChooseView *choose1;
@property (nonatomic, strong) RNChooseView *choose2;

@end

@implementation RNYinGuangTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, App_Frame_Width-12, 36)];
        label.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        label.text = RNLocalized(@"Fluorescence");
        label.textColor = UIColorFromRGB(0x030303);
        [self.contentView addSubview:label];
        
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = UIColor.whiteColor;
        bottomView.frame = CGRectMake(12, 36, App_Frame_Width-24, 162);
        [self.contentView addSubview:bottomView];
        
        UILabel *qiangduLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 4, App_Frame_Width-48, 29)];
        qiangduLabel.font = [UIFont yz_PingFangSC_RegularFontOfSize:12];
        qiangduLabel.text = RNLocalized(@"Strength");
        qiangduLabel.textColor = UIColorFromRGB(0x999999);
        [bottomView addSubview:qiangduLabel];
        
        NSArray *qiangduArray = @[@"None", @"Slight", @"Very Slight", @"Faint", @"Medium", @"Strong", @"Very Strong"];

        RNChooseView *choose1 = [[RNChooseView alloc] initWithChooses:qiangduArray rect:CGRectMake(12, 33, App_Frame_Width - 48, 44)];
        choose1.delegate = self;
        self.choose1 = choose1;
        [bottomView addSubview:choose1];
        
        UILabel *yanselabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(choose1.frame), App_Frame_Width, 29)];
        yanselabel.font = [UIFont yz_PingFangSC_RegularFontOfSize:12];
        yanselabel.text = RNLocalized(@"Color");
        yanselabel.textColor = UIColorFromRGB(0x999999);
        [bottomView addSubview:yanselabel];
        
        NSArray *yanseArray = @[@"Blue", @"Yellow", @"Green", @"Red", @"Orange", @"White"];
        RNChooseView *choose2 = [[RNChooseView alloc] initWithChooses:yanseArray rect:CGRectMake(12, CGRectGetMaxY(yanselabel.frame), App_Frame_Width - 48, 44)];
        choose2.delegate = self;
        self.choose2 = choose2;
        [bottomView addSubview:choose2];

    }
    return self;
}

- (void)setJewelModel:(RNSearchJewelModel *)jewelModel {
    _jewelModel = jewelModel;
    if ([Utility isString:self.jewelModel.fluorescent]) {
        self.choose1.defaultChooses = [self.jewelModel.fluorescent componentsSeparatedByString:@","];
    } else {
        self.choose1.defaultChooses = @[];
    }
    if ([Utility isString:self.jewelModel.fluorescentcorol]) {
        self.choose2.defaultChooses = [self.jewelModel.fluorescentcorol componentsSeparatedByString:@","];
    } else {
        self.choose2.defaultChooses = @[];
    }
}


#pragma mark - RNChooseViewDelegate

- (void)onChooseViewDidSeletedOptions:(NSArray *)options chooseView:(RNChooseView *)chooseView {
    if ([chooseView isEqual:self.choose1]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onsearchYinGuangTableViewCellDidChooseYingGuangQiangdu:)]) {
            [self.delegate onsearchYinGuangTableViewCellDidChooseYingGuangQiangdu:options];
        }
        return;
    }
    if ([chooseView isEqual:self.choose2]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onsearchYinGuangTableViewCellDidChooseYingGuangYanse:)]) {
            [self.delegate onsearchYinGuangTableViewCellDidChooseYingGuangYanse:options];
        }
    }
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
