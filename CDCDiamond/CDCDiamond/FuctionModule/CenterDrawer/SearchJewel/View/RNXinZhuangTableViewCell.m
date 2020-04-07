//
//  RNXinZhuangTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/7.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNXinZhuangTableViewCell.h"
#import "RNButton.h"
#import "RNOptionChooseView.h"
#import "UIImage+Extension.h"

@interface RNXinZhuangTableViewCell ()

@property (nonatomic, strong) NSArray *imgNormalNames;
@property (nonatomic, strong) NSArray *imgSeletedNames;
@property (nonatomic, strong) NSArray *xzkeyArray;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *countLB;

@end

@implementation RNXinZhuangTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.text = RNLocalized(@"Shape");
        titleLab.font = [UIFont yz_PingFangSC_RegularFontOfSize:14.f];
        titleLab.textColor = UIColorFromRGB(0x030303);
        titleLab.frame = CGRectMake(12, 0, App_Frame_Width-12, 40);
        [self.contentView addSubview:titleLab];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(12, 36, App_Frame_Width - 24, 190)];
        bottomView.backgroundColor = UIColor.whiteColor;
        _bottomView = bottomView;
        [self.contentView addSubview:bottomView];
        
        self.imgNormalNames = @[@"icn_round_idle 2",@"icn_princess_idle 2",@"icn_cushion_brilliant_idle 2",@"icn_cushion_modified_idle 2",@"icn_pear_idle 2",@"icn_emerald_idle 2",@"icn_radiant_idle 2",@"icn_oval_idle 2",@"icn_heart_idle 2",@"icn_asscher_idle 2",];
        self.imgSeletedNames = @[@"icn_round_blue 2",@"icn_princess_blue 2",@"icn_cushion_brilliant_blue 2",@"icn_cushion_modified_blue 2",@"icn_pear_blue 2",@"icn_emerald_blue 2",@"icn_radiant_blue 2",@"icn_oval_blue 2",@"icn_heart_blue 2",@"icn_asscher_blue 2"];
        self.xzkeyArray = @[@"Round", @"Princess", @"Cushion Shape", @"Cushion Modified", @"Pear", @"Emerald", @"Radian", @"Oval", @"Heart", @"Asscher",@"Radiant",@"Sq. Emerald",@"Cushion (all)",@"Cushion Brilliant",@"Asscher &amp Sq. Emer",@"Baguette",@"Briolette",@"Bullets",@"European Cut",@"Flanders",@"Half Moon",@"Hexagonal",@"Kite",@"Lozenge",@"Marquise",@"Octagonal",@"Old Miner",@"Other",@"Pentagonal",@"Rose",@"Shield",@"Square",@"Star",@"Tapered Baguette",@"Trapezoid",@"Triangular",@"Trilliant0"];
        //NSArray *titles = @[@"圆形",@"公主型",@"垫型",@"祖母绿型",@"梨型",@"祖母绿型",@"雷地恩形",@"椭圆形",@"心型",@"阿斯切型"];
        CGFloat width = (App_Frame_Width - 24) / 5.0;
        for (int i = 0; i < 10; i++) {
            int clon = i / 5;
            int row = i % 5;
            RNButton *button = [[RNButton alloc] init];
            button.tag = 100+i;
            button.icon.image = [UIImage imageNamed:self.imgNormalNames[i]];
            button.contentLab.text = RNLocalized(self.xzkeyArray[i]);
            button.frame = CGRectMake(width*row, 80*clon, width, 80);
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:button];
        }
        
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xe6e6e6);
        line.frame = CGRectMake(0, 160, App_Frame_Width - 24, 1);
        [bottomView addSubview:line];
        
        UIButton *moreBtn = [[UIButton alloc] init];
        moreBtn.titleLabel.font = [UIFont yz_PingFangSC_RegularFontOfSize:12.f];
        [moreBtn setTitle:RNLocalized(@"More") forState:UIControlStateNormal];
        [moreBtn setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        moreBtn.frame = CGRectMake(0, 160, App_Frame_Width - 24, 30);
        [bottomView addSubview:moreBtn];
        [moreBtn addTarget:self action:@selector(morebtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.countLB = [UILabel yz_labelWithText:@"" textColor:WhiteColor sizeFont:12.f numberOfLines:1 textAlignment:NSTextAlignmentCenter];
        [self.countLB yz_setAllCornerWithCornerRadius:2.f];
        [self.countLB setFrame:CGRectMake(App_Frame_Width-64, 165, 26, 20)];
        [self.countLB setBackgroundColor:RGBOF(0x2AAE33)];
        [self.countLB setHidden:YES];
        [bottomView addSubview:self.countLB];
        
    }
    return self;
}

- (void)morebtnClick { 
    __weak typeof(self)weaself = self;
    RNOptionChooseView *chooseView = [[RNOptionChooseView alloc] initWithTopSpace:120 searchAvaliable:YES];
    chooseView.singleEnable = self.singleEnable;
    NSArray *shapeList = @[@"Radiant",@"Sq. Emerald",@"Cushion (all)",@"Cushion Brilliant",@"Asscher &amp Sq. Emer",@"Baguette",@"Briolette",@"Bullets",@"European Cut",@"Flanders",@"Half Moon",@"Hexagonal",@"Kite",@"Lozenge",@"Marquise",@"Octagonal",@"Old Miner",@"Other",@"Pentagonal",@"Rose",@"Shield",@"Square",@"Star",@"Tapered Baguette",@"Trapezoid",@"Triangular",@"Trilliant0"];
    
    __block NSMutableArray *tempArr = [NSMutableArray array];
    if (self.jewelModel.shape) {
        NSArray *array = [self.jewelModel.shape componentsSeparatedByString:@","];
        for (NSString *string in array) {
            if (![shapeList containsObject:KFormat(string)] && ![KFormat(string) isEqualToString:@""]) {
                [tempArr addObject:string];
            }
        }
    }
    
    [chooseView showWithDataSource:shapeList chooseBlock:^(NSArray * _Nonnull array) {
        if (array) {
            if (weaself.singleEnable && tempArr.count) {
                [tempArr removeAllObjects];
                for (int i = 0; i < 10 ; i++) {
                    RNButton *btn = [weaself.bottomView viewWithTag:100+i];
                    [btn setSelected:NO];
                    btn.icon.image = [UIImage imageNamed:weaself.imgNormalNames[i]];
                    btn.contentLab.textColor = UIColorFromRGB(0x999999);
                }
            }
            for (NSNumber *number in array) {
                [tempArr addObject:shapeList[number.intValue]];
            }
            [weaself.countLB setText:[NSString stringWithFormat:@"%lu", (unsigned long)tempArr.count]];
            [weaself.countLB setHidden:!tempArr.count];
            if (weaself.delegate && [weaself.delegate respondsToSelector:@selector(onXinZhuangTableViewCellSeletedShape:)]) {
                [weaself.delegate onXinZhuangTableViewCellSeletedShape:tempArr];
            }
        }
    } defaultArray:self.jewelModel.shape?[self.jewelModel.shape componentsSeparatedByString:@","]:@[]];
}

- (void)buttonClick:(RNButton *)sender {
    [sender setSelected:!sender.selected];
    NSMutableArray *tempArr = [NSMutableArray array];
    if (self.jewelModel.shape) {
        NSArray *array = [self.jewelModel.shape componentsSeparatedByString:@","];
        for (NSString *string in array) {
            if (![KFormat(string) isEqualToString:@""]) {
                [tempArr addObject:string];
            }
        }
    }
    
    if (self.addModel.F_SHAPE) {
        NSArray *array = [self.addModel.F_SHAPE componentsSeparatedByString:@","];
        for (NSString *string in array) {
            if (![KFormat(string) isEqualToString:@""]) {
                [tempArr addObject:string];
            }
        }
    }
   
    if (!sender.isSelected) {
        sender.icon.image = [UIImage imageNamed:self.imgNormalNames[sender.tag-100]];
        sender.contentLab.textColor = UIColorFromRGB(0x999999);
        NSString *shape = self.xzkeyArray[sender.tag-100];
        if ([tempArr containsObject:KFormat(shape)]) {
            [tempArr removeObject:shape];
        }
    } else {
        if (_singleEnable) {
            [tempArr removeAllObjects];
        }
        sender.icon.image = [[UIImage imageNamed:self.imgNormalNames[sender.tag-100]] imageChangeColor:RGBOF(0x2AAE33)];
        sender.contentLab.textColor = RGBOF(0x2AAE33);
        NSString *shape = self.xzkeyArray[sender.tag-100];
        if (![tempArr containsObject:KFormat(shape)]) {
            [tempArr addObject:shape];
        }
    }
    if (_singleEnable) {
        for (int i = 0; i < 10 ; i++) {
            RNButton *btn = [self.bottomView viewWithTag:100+i];
            if (![btn isEqual:sender]) {
                [btn setSelected:NO];
                btn.icon.image = [UIImage imageNamed:self.imgNormalNames[i]];
                btn.contentLab.textColor = UIColorFromRGB(0x999999);
            }
        }
        [self.countLB setText:[NSString stringWithFormat:@"%d", tempArr.count?1:0]];
        [self.countLB setHidden:!tempArr.count];
    } else {
        [self.countLB setText:[NSString stringWithFormat:@"%ld", tempArr.count]];
        [self.countLB setHidden:!tempArr.count];
    }


    if (self.delegate && [self.delegate respondsToSelector:@selector(onXinZhuangTableViewCellSeletedShape:)]) {
        [self.delegate onXinZhuangTableViewCellSeletedShape:tempArr];
    }
}

- (void)setJewelModel:(RNSearchJewelModel *)jewelModel {
    _jewelModel = jewelModel;
    for (int i = 0; i < 10 ; i++) {
        RNButton *btn = [self.bottomView viewWithTag:100+i];
        [btn setSelected:NO];
        btn.icon.image = [UIImage imageNamed:self.imgNormalNames[i]];
        btn.contentLab.textColor = UIColorFromRGB(0x999999);
    }
    NSString *shape = jewelModel.shape;
    if ([Utility isString:shape]) {
        NSArray *list = [shape componentsSeparatedByString:@","];
        if (list && [list isKindOfClass:[NSArray class]] && list.count) {
            for (id obj in list) {
                NSString *name = [NSString stringWithFormat:@"%@", obj];
                if ([self.xzkeyArray containsObject:name]) {
                    NSInteger index = [self.xzkeyArray indexOfObject:name];
                    RNButton *btn = [self.bottomView viewWithTag:100+index];
                    [btn setSelected:YES];
                    if (index < self.imgSeletedNames.count) {
                        btn.icon.image = [[UIImage imageNamed:self.imgNormalNames[index]] imageChangeColor:RGBOF(0x2AAE33)];
                    }
                    
                    btn.contentLab.textColor = RGBOF(0x2AAE33);
                }
            }
            
        }
    }
    
    NSMutableArray *tempArr = [NSMutableArray array];
    if (jewelModel.shape) {
        NSArray *array = [jewelModel.shape componentsSeparatedByString:@","];
        for (NSString *string in array) {
            if (![KFormat(string) isEqualToString:@""]) {
                [tempArr addObject:string];
            }
        }
    }
    
    if (tempArr.count) {
        [self.countLB setText:[NSString stringWithFormat:@"%ld", tempArr.count]];
        [self.countLB setHidden:NO];
    } else {
        [self.countLB setHidden:YES];
    }
}


- (void)setAddModel:(RNBuyRequestAddModel *)addModel {
    _addModel = addModel;
    for (int i = 0; i < 10 ; i++) {
        RNButton *btn = [self.bottomView viewWithTag:100+i];
        [btn setSelected:NO];
        btn.icon.image = [UIImage imageNamed:self.imgNormalNames[i]];
        btn.contentLab.textColor = UIColorFromRGB(0x999999);
    }
    NSString *shape = addModel.F_SHAPE;
    if ([Utility isString:shape]) {
        NSArray *list = [shape componentsSeparatedByString:@","];
        if (list && [list isKindOfClass:[NSArray class]] && list.count) {
            for (id obj in list) {
                NSString *name = [NSString stringWithFormat:@"%@", obj];
                if ([self.xzkeyArray containsObject:name]) {
                    NSInteger index = [self.xzkeyArray indexOfObject:name];
                    RNButton *btn = [self.bottomView viewWithTag:100+index];
                    [btn setSelected:YES];
                    if (index < self.imgSeletedNames.count) {
                        btn.icon.image = [[UIImage imageNamed:self.imgNormalNames[index]] imageChangeColor:RGBOF(0x2AAE33)];
                    }
                    
                    btn.contentLab.textColor = RGBOF(0x2AAE33);
                }
            }
        }
    }
    
    NSMutableArray *tempArr = [NSMutableArray array];
    if (addModel.F_SHAPE) {
        NSArray *array = [addModel.F_SHAPE componentsSeparatedByString:@","];
        for (NSString *string in array) {
            if (![KFormat(string) isEqualToString:@""]) {
                [tempArr addObject:string];
            }
        }
    }
    
    if (tempArr.count) {
        [self.countLB setText:[NSString stringWithFormat:@"%ld", tempArr.count]];
        [self.countLB setHidden:NO];
    } else {
        [self.countLB setHidden:YES];
    }
}

- (void)setSingleEnable:(BOOL)singleEnable {
    _singleEnable = singleEnable;
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
