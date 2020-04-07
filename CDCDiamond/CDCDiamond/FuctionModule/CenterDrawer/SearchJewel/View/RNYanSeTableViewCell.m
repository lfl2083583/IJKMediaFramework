//
//  RNYanseTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNYanseTableViewCell.h"
#import "RNChooseView.h"

@interface RNYanseTableViewCell ()<RNChooseViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *titleLB;


@property (weak, nonatomic) IBOutlet UILabel *qiangduLB;
@property (weak, nonatomic) IBOutlet UILabel *banseLB;
@property (weak, nonatomic) IBOutlet UILabel *yanseLB;

@property (weak, nonatomic) IBOutlet UIView *qiangduView;
@property (weak, nonatomic) IBOutlet UIView *banseView;
@property (weak, nonatomic) IBOutlet UIView *yanseView;
@property (weak, nonatomic) IBOutlet UIView *otherView;

@property (nonatomic, strong) RNChooseView *qiangduV;
@property (nonatomic, strong) RNChooseView *banseV;
@property (nonatomic, strong) RNChooseView *yanseV;
@property (nonatomic, strong) RNChooseView *otherV;

@property (nonatomic, strong) NSArray *yanse1Array;
@property (nonatomic, strong) NSArray *qiangduArray;
@property (nonatomic, strong) NSArray *nanseArray;
@property (nonatomic, strong) NSArray *yanse2Array;

@end

@implementation RNYanseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLB.text = RNLocalized(@"Color");
    self.qiangduLB.text = RNLocalized(@"Fancy Color Instensity");
    self.banseLB.text = RNLocalized(@"Fancy Color Oventone");
    self.yanseLB.text = RNLocalized(@"Fancy Color");
    
    [self.whiteBtn setTitle:RNLocalized(@"White") forState:UIControlStateNormal];
    [self.beautifulBtn setTitle:RNLocalized(@"Fine") forState:UIControlStateNormal];
    
    
    [self.whiteBtn setBackgroundImage:[UIImage graphicsImageWithColor:UIColor.whiteColor rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateNormal];
    [self.whiteBtn setBackgroundImage:[UIImage graphicsImageWithColor:[RNGlobalUIStandard defaultMainColor] rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateSelected];
    [self.whiteBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.whiteBtn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    
    [self.beautifulBtn setBackgroundImage:[UIImage graphicsImageWithColor:UIColor.whiteColor rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateNormal];
    [self.beautifulBtn setBackgroundImage:[UIImage graphicsImageWithColor:[RNGlobalUIStandard defaultMainColor] rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateSelected];
    [self.beautifulBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.beautifulBtn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    
    self.whiteBtn.selected = YES;
    
    
    self.qiangduV = [[RNChooseView alloc] initWithChooses:@[@"Faint",@"Very Light",@"Light",@"Fancy Light",@"Fancy",@"Fancy Dark", @"Fancy Intense", @"Fancy Vivid", @"Fancy Deep"] rect:CGRectMake(24, 117, App_Frame_Width-48, 44)];
    self.qiangduV.hidden = YES;
    self.qiangduV.delegate = self;
    [self.contentView addSubview:self.qiangduV];
    
    self.banseV = [[RNChooseView alloc] initWithChooses:@[@"None",@"Yellow",@"Yellowish",@"Pink",@"Pinkish",@"Blue", @"Bluish", @"Red", @"Reddish",@"Green",@"Greenish",@"Purple",@"Purplish",@"Orange",@"Orangey",@"Violet",@"Gray",@"Grayish",@"Black",@"Brown",@"Brownish",@"Champagne",@"Cognac",@"Chameleon",@"White",@"Other"] rect:CGRectMake(24, 197, App_Frame_Width-48, 44)];
    self.banseV.hidden = YES;
    self.banseV.delegate = self;
    [self.contentView addSubview:self.banseV];
    
    self.yanseV = [[RNChooseView alloc] initWithChooses:@[@"Yellow",@"Pink",@"Blue", @"Red",@"Green",@"Purple",@"Orange",@"Violet",@"Gray",@"Black",@"Brown",@"Champagne",@"Cognac",@"Chameleon",@"White",@"Other"] rect:CGRectMake(24, 275, App_Frame_Width-48, 44)];
    self.yanseV.hidden = YES;
    self.yanseV.delegate = self;
    [self.contentView addSubview:self.yanseV];
    
    self.otherV = [[RNChooseView alloc] initWithChooses:@[@"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"] rect:CGRectMake(24, 90, App_Frame_Width-48, 44)];
    self.otherV.hidden = NO;
    self.otherV.delegate = self;
    [self.contentView addSubview:self.otherV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setSingleEnable:(BOOL)singleEnable {
    _singleEnable = singleEnable;
//    self.qiangduV.singleChoose = singleEnable;
//    self.banseV.singleChoose = singleEnable;
//    self.yanseV.singleChoose = singleEnable;
    self.otherV.singleChoose = singleEnable;
}

- (void)setYanseType:(int)yanseType {
    _yanseType = yanseType;
    if (yanseType == 0) {
        
        self.qiangduLB.hidden = YES;
        self.yanseLB.hidden = YES;
        self.banseLB.hidden = YES;
        self.qiangduV.hidden = YES;
        self.yanseV.hidden = YES;
        self.banseV.hidden = YES;
        self.otherV.hidden = NO;
        self.whiteBtn.selected = YES;
        self.beautifulBtn.selected = NO;
        
        
        
        if (self.addModel) {
            self.addModel.F_FANCYCCOLORIMENSTFY = @"";
            self.addModel.F_FANCYCCOLOROVERTONE = @"";
            self.addModel.F_FANCYCCOLOR1 = @"";
            
        }
        
        if (self.jewelModel) {
            self.jewelModel.fancyccolor1 = @"";
            self.jewelModel.fancyccolorovertone = @"";
            self.jewelModel.fancyccolorimenstfy = @"";
        }
        self.qiangduV.defaultChooses = @[];
        self.banseV.defaultChooses = @[];
        self.yanseV.defaultChooses = @[];
    } else {
        
        self.qiangduLB.hidden = NO;
        self.yanseLB.hidden = NO;
        self.banseLB.hidden = NO;
        self.banseV.hidden = NO;
        self.yanseV.hidden = NO;
        self.qiangduV.hidden = NO;
        self.otherV.hidden = YES;
        self.whiteBtn.selected = NO;
        self.beautifulBtn.selected = YES;
        
        if (self.addModel) {
            self.addModel.F_COLOR = @"";
        }
        if (self.jewelModel) {
            self.jewelModel.color = @"";
        }
        
        self.otherV.defaultChooses = @[];
    }
}


- (IBAction)colorTypeClick:(UIButton *)sender {
    if (self.addModel) {
        self.addModel.F_ISCZ = [NSString stringWithFormat:@"%@", [sender isEqual:self.whiteBtn]?@"0":@"1"];
    }
    if (self.jewelModel) {
        self.jewelModel.iscz = [sender isEqual:self.whiteBtn]?0:1;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(onYanseTableViewCellIsColorDiamondsClick:)]) {
        [self.delegate onYanseTableViewCellIsColorDiamondsClick:self.addModel?self.addModel:self.jewelModel];
    }
}

- (void)setJewelModel:(RNSearchJewelModel *)jewelModel {
    _jewelModel = jewelModel;
    
    self.yanseType = jewelModel.iscz;
    if ([Utility isString:self.jewelModel.fancyccolorimenstfy]) {
        NSArray *list1 = [self.jewelModel.fancyccolorimenstfy componentsSeparatedByString:@","];
        self.qiangduV.defaultChooses = list1;
    } else{
        self.qiangduV.defaultChooses = @[];
    }
    if ([Utility isString:self.jewelModel.fancyccolorovertone]) {
        NSArray *list2 = [self.jewelModel.fancyccolorovertone componentsSeparatedByString:@","];
        self.banseV.defaultChooses = list2;
    } else {
       self.banseV.defaultChooses = @[];
    }
    
    if ([Utility isString:self.jewelModel.fancyccolor1]) {
        NSArray *list4 = [self.jewelModel.fancyccolor1 componentsSeparatedByString:@","];
        self.yanseV.defaultChooses = list4;
    } else {
        self.yanseV.defaultChooses = @[];
    }
    
    if ([Utility isString:self.jewelModel.color]) {
        NSArray *list3 = [self.jewelModel.color componentsSeparatedByString:@","];
        self.otherV.defaultChooses = list3;
    } else {
        self.otherV.defaultChooses = @[];
    }
}


- (void)setAddModel:(RNBuyRequestAddModel *)addModel {
    _addModel = addModel;
    
    if ([Utility isString:addModel.F_ISCZ]) {
        self.yanseType = ([[NSString stringWithFormat:@"%@",addModel.F_ISCZ] isEqualToString:@"true"] || [[NSString stringWithFormat:@"%@",addModel.F_ISCZ] isEqualToString:@"1"])?1:0;
    } else {
        self.yanseType = 0;
    }
    if ([Utility isString:self.addModel.F_FANCYCCOLORIMENSTFY]) {
        NSArray *list1 = [self.addModel.F_FANCYCCOLORIMENSTFY componentsSeparatedByString:@","];
        self.qiangduV.defaultChooses = list1;
    } else{
        self.qiangduV.defaultChooses = @[];
    }
    if ([Utility isString:self.addModel.F_FANCYCCOLOROVERTONE]) {
        NSArray *list2 = [self.addModel.F_FANCYCCOLOROVERTONE componentsSeparatedByString:@","];
        self.banseV.defaultChooses = list2;
    } else {
       self.banseV.defaultChooses = @[];
    }
    if ([Utility isString:self.addModel.F_COLOR1]) {
        NSArray *list3 = [self.addModel.F_COLOR1 componentsSeparatedByString:@","];
        self.otherV.defaultChooses = list3;
    } else {
        self.otherV.defaultChooses = @[];
    }
    if ([Utility isString:self.addModel.F_FANCYCCOLOR1]) {
        NSArray *list4 = [self.addModel.F_FANCYCCOLOR1 componentsSeparatedByString:@","];
        self.yanseV.defaultChooses = list4;
    } else {
        self.yanseV.defaultChooses = @[];
    }
}


#pragma mark - RNChooseViewDelegate

- (void)onChooseViewDidSeletedOptions:(NSArray *)options chooseView:(nonnull RNChooseView *)chooseView {
    if ([chooseView isEqual:self.qiangduV]) {
        NSMutableArray *muArr = [NSMutableArray array];
//        NSArray *list = @[@"Faint",@"Very Light",@"Light",@"Fancy Light",@"Fancy",@"Fancy Dark", @"Fancy Intense", @"Fancy Vivid", @"Fancy Deep"];
//        for (NSNumber *number in options) {
//            if ([number intValue] > 0) {
//                [muArr addObject:[list objectAtIndex:[number intValue]-1]];
//            }
//        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(onYanseTableViewCellBetifulClickWhiteClickQiangDu:)]) {
            [self.delegate onYanseTableViewCellBetifulClickWhiteClickQiangDu:options];
        }
    } else if ([chooseView isEqual:self.banseV]) {
//        NSMutableArray *muArr = [NSMutableArray array];
//        NSArray *list = @[@"None",@"Yellow",@"Yellowish",@"Pink",@"Pinkish",@"Blue", @"Bluish", @"Red", @"Reddish",@"Green",@"Greenish",@"Purple",@"Purplish",@"Orange",@"Orangey",@"Violet",@"Gray",@"Grayish",@"Black",@"Brown",@"Brownish",@"Champagne",@"Cognac",@"Chameleon",@"Violetish",@"White"];
//        for (NSNumber *number in options) {
//            if ([number intValue] > 0) {
//                [muArr addObject:[list objectAtIndex:[number intValue]-1]];
//            }
//        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(onYanseTableViewCellBetifulClickWhiteClickBnanse:)]) {
            [self.delegate onYanseTableViewCellBetifulClickWhiteClickBnanse:options];
        }
    } else if ([chooseView isEqual:self.yanseV]) {
//        NSMutableArray *muArr = [NSMutableArray array];
//        NSArray *list = @[@"Yellow",@"Pink",@"Blue", @"Red",@"Green",@"Purple",@"Orange",@"Violet",@"Gray",@"Black",@"Brown",@"Champagne",@"Cognac",@"Chameleon",@"White"];
//        for (NSNumber *number in options) {
//            if ([number intValue] > 0) {
//                [muArr addObject:[list objectAtIndex:[number intValue]-1]];
//            }
//        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(onYanseTableViewCellBetifulClickWhiteClickColors:)]) {
            [self.delegate onYanseTableViewCellBetifulClickWhiteClickColors:options];
        }
    } else if ([chooseView isEqual:self.otherV]) {
//        NSMutableArray *muArr = [NSMutableArray array];
//        NSArray *list = @[@"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
//        for (NSNumber *number in options) {
//            if ([number intValue] > 0) {
//                [muArr addObject:[list objectAtIndex:[number intValue]-1]];
//            }
//        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(onYanseTableViewCellBetifulClickWhiteClickYanse:)]) {
            [self.delegate onYanseTableViewCellBetifulClickWhiteClickYanse:options];
        }
    }
}

@end
