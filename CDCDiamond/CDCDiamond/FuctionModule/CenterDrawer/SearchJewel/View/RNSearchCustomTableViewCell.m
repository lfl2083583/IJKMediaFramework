//
//  RNSearchCustomTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/7.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNSearchCustomTableViewCell.h"
#import "RNChooseView.h"

@interface RNSearchCustomTableViewCell ()<RNChooseViewDelegate>

@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) RNChooseView *chooseView;

@end

@implementation RNSearchCustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSString *title;
        
        if ([reuseIdentifier isEqualToString:jingDuIndenfier]) {
            title = RNLocalized(@"Clarity");
            self.titlesArray = @[@"FL", @"IF", @"VVS1", @"VVS2", @"VS1", @"VS2", @"SI1", @"SI2", @"SI3", @"I1", @"I2", @"I3"];
        } else if ([reuseIdentifier isEqualToString:xiuShiIndenfier]) {
            title = RNLocalized(@"Modified");
            self.titlesArray = @[@"3EX", @"3VG+", @"EX(VG+)"];
        } else if ([reuseIdentifier isEqualToString:qieKouIndenfier]) {
            title = RNLocalized(@"Cut");
            self.titlesArray = @[@"None", @"Ideal", @"Excellent", @"Very Good", @"Good", @"Fail", @"Poor"];
        } else if ([reuseIdentifier isEqualToString:paoGuangIndenfier]) {
            title = RNLocalized(@"Polishing");
            self.titlesArray = @[@"Ideal", @"Excellent", @"Very Good", @"Good", @"Fail", @"Poor"];
        } else if ([reuseIdentifier isEqualToString:duiChengIndenfier]) {
            title = RNLocalized(@"Symmetry");
            self.titlesArray = @[@"Ideal", @"Excellent", @"Very Good", @"Good", @"Fail", @"Poor"];
        } else if ([reuseIdentifier isEqualToString:jiBieIndenfier]) {
            title = @"RapSpec";
            self.titlesArray = @[@"Rap Spec A1", @"Rap Spec A2",@"Rap Spec A3",@"Rap Spec A4",@"Rap Spec A5",@"Rap Spec B1", @"Rap Spec B2",@"Rap Spec B3",@"Rap Spec B4",@"Rap Spec B5",@"Rap Spec C1", @"Rap Spec C2",@"Rap Spec C3",@"Rap Spec C4",@"Rap Spec C5",];
        } else if ([reuseIdentifier isEqualToString:dengjiIndenfier]) {
            title = RNLocalized(@"Grade Appraisal Report");
            self.titlesArray = @[@"GIA",@"RAP",@"AGS",@"HRD",@"IGI",@"RDC",@"CGL",@"DCLA",@"GCAL",@"GHI",@"IIDGR",@"GSI",@"NGTC",@"PGS",@"NONE",@"IGI-USA"];
        }else if ([reuseIdentifier isEqualToString:yaoweiIndenfier]) {
            title = RNLocalized(@"Waistline");
            self.titlesArray = @[@"Polished", @"Faceted", @"Bruted"];//@[@"Extr. Thin", @"Very Thin", @"Thin", @"Slightly Thin", @"Medium", @"Slightly Thick", @"Thick",@"Very Thick", @"Very Thick"];
        }else if ([reuseIdentifier isEqualToString:jiandiIndenfier]) {
            title = RNLocalized(@"Culet");
            self.titlesArray = @[@"Pointed", @"Chipped", @"Abraded"];
        }else if ([reuseIdentifier isEqualToString:chuliIndenfier]) {
            title = RNLocalized(@"Dispose");
            self.titlesArray = @[@"Ideal", @"Excellent", @"Very Good", @"Good", @"Fail", @"Poor"];
        }
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(0xf8f8f8f8);
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.text = title;
        titleLab.font = [UIFont yz_PingFangSC_RegularFontOfSize:14.f];
        titleLab.textColor = UIColorFromRGB(0x030303);
        titleLab.frame = CGRectMake(12, 0, App_Frame_Width-12, 36);
        titleLab.hidden = [reuseIdentifier isEqualToString:xiuShiIndenfier]?YES:NO;
        [self.contentView addSubview:titleLab];
        
        UIView *bottomView = [UIView new];
        bottomView.frame = CGRectMake(12, 36, App_Frame_Width-24, 68);
        bottomView.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:bottomView];
        
        RNChooseView *chooseView = [[RNChooseView alloc] initWithChooses:self.titlesArray rect:CGRectMake(12, 12, App_Frame_Width - 48, 44) singleChoose:[reuseIdentifier isEqualToString:xiuShiIndenfier]];
        chooseView.delegate = self;
        self.chooseView = chooseView;
        [bottomView addSubview:chooseView];
        
        if ([reuseIdentifier isEqualToString:dengjiIndenfier]) {
            [self getLaboratoryDatas];
        }
    }
    return self;
}

- (void)setSingleEnable:(BOOL)singleEnable {
    _singleEnable = singleEnable;
    self.chooseView.singleChoose = singleEnable;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setIdentifierString:(NSString *)IdentifierString {
    _IdentifierString = IdentifierString;
}

- (void)setJewelModel:(RNSearchJewelModel *)jewelModel {
    _jewelModel = jewelModel;
    
    if ([self.IdentifierString isEqualToString:jingDuIndenfier]) {
        if ([Utility isString:jewelModel.clarity]) {
            self.chooseView.defaultChooses = [jewelModel.clarity componentsSeparatedByString:@","];
        } else {
            self.chooseView.defaultChooses = @[];
        }
    } else if ([self.IdentifierString isEqualToString:qieKouIndenfier]) {
        if ([Utility isString:jewelModel.cut]) {
            self.chooseView.defaultChooses = [jewelModel.cut componentsSeparatedByString:@","];
        } else {
            self.chooseView.defaultChooses = @[];
        }
    } else if ([self.IdentifierString isEqualToString:paoGuangIndenfier]) {
        if ([Utility isString:jewelModel.polished]) {
            self.chooseView.defaultChooses = [jewelModel.polished componentsSeparatedByString:@","];
        } else {
            self.chooseView.defaultChooses = @[];
        }
    } else if ([self.IdentifierString isEqualToString:duiChengIndenfier]) {
        if ([Utility isString:jewelModel.symmetrical]) {
            self.chooseView.defaultChooses = [jewelModel.symmetrical componentsSeparatedByString:@","];
        } else {
            self.chooseView.defaultChooses = @[];
        }
    } else if ([self.IdentifierString isEqualToString:dengjiIndenfier]) {
        if ([RNUserInfo shareUserInfo].laboratoryArray && [RNUserInfo shareUserInfo].laboratoryArray.count) {
            if ([Utility isString:jewelModel.jiandingsuo]) {
               self.chooseView.defaultChooses = [jewelModel.jiandingsuo componentsSeparatedByString:@","];
            } else {
                self.chooseView.defaultChooses = @[];
            }
        } else {
            self.chooseView.defaultChooses = @[];
        }
        
    } 
}

- (void)setAddModel:(RNBuyRequestAddModel *)addModel {
    _addModel = addModel;
    
    if ([self.IdentifierString isEqualToString:jingDuIndenfier]) {
        if ([Utility isString:addModel.F_CLARITY1]) {
            self.chooseView.defaultChooses = [addModel.F_CLARITY1 componentsSeparatedByString:@","];
        } else {
            self.chooseView.defaultChooses = @[];
        }
    } else if ([self.IdentifierString isEqualToString:qieKouIndenfier]) {
        if ([Utility isString:addModel.F_CUT]) {
            self.chooseView.defaultChooses = [addModel.F_CUT componentsSeparatedByString:@","];
        } else {
            self.chooseView.defaultChooses = @[];
        }
    } else if ([self.IdentifierString isEqualToString:paoGuangIndenfier]) {
        if ([Utility isString:addModel.F_POLISHED]) {
            self.chooseView.defaultChooses = [addModel.F_POLISHED componentsSeparatedByString:@","];
        } else {
            self.chooseView.defaultChooses = @[];
        }
    } else if ([self.IdentifierString isEqualToString:duiChengIndenfier]) {
        if ([Utility isString:addModel.F_SYMMETRICAL]) {
            self.chooseView.defaultChooses = [addModel.F_SYMMETRICAL componentsSeparatedByString:@","];
        } else {
            self.chooseView.defaultChooses = @[];
        }
    } else if ([self.IdentifierString isEqualToString:yaoweiIndenfier]) {
        if ([Utility isString:addModel.F_WAISTTJ]) {
           self.chooseView.defaultChooses = [addModel.F_WAISTTJ componentsSeparatedByString:@","];
        } else {
            self.chooseView.defaultChooses = @[];
        }
    } else if ([self.IdentifierString  isEqualToString:jiandiIndenfier]) {
        if ([Utility isString:addModel.F_LOWTIPTJ]) {
            self.chooseView.defaultChooses = [addModel.F_LOWTIPTJ componentsSeparatedByString:@","];
        } else {
            self.chooseView.defaultChooses = @[];
        }
    } else if ([self.IdentifierString  isEqualToString:chuliIndenfier]) {
        if ([Utility isString:addModel.F_HANDLE]) {
            self.chooseView.defaultChooses = [addModel.F_HANDLE componentsSeparatedByString:@","];
        } else {
            self.chooseView.defaultChooses = @[];
        }
    }
}

- (void)getLaboratoryDatas {
    if ([RNUserInfo shareUserInfo].laboratoryArray && [RNUserInfo shareUserInfo].laboratoryArray.count) {
        self.chooseView.chooses = [RNUserInfo shareUserInfo].laboratoryArray;
    } else {
        __weak typeof(self)weakself = self;
        [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/AppSearch?method=onload") parameters:@{@"lang" : [NSString stringWithFormat:@"%d", [RNLanguageManager shareManager].languageType]} success:^(id responseObject, ResponseState state) {
            NSLog(@"%@", responseObject);
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                NSMutableArray *allCountry = [NSMutableArray array];
                
                if (responseObject[@"sys"]) {
                    [allCountry addObjectsFromArray:responseObject[@"sys"]];
                }

                if (allCountry.count) {
                    NSMutableArray *list = [NSMutableArray array];
                    for (NSDictionary *dict in allCountry) {
                        [list addObject:dict[@"F_NAME"]];
                        
                    }
                    [RNUserInfo shareUserInfo].laboratoryArray = list;
                    [[RNUserInfo shareUserInfo] save];
                    
                    weakself.chooseView.chooses = [RNUserInfo shareUserInfo].laboratoryArray;
                    
                }
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

#pragma mark  - RNChooseViewDelegate

- (void)onChooseViewDidSeletedOptions:(NSArray *)options chooseView:(nonnull RNChooseView *)chooseView {
    if ([self.IdentifierString isEqualToString:jingDuIndenfier]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onsearchCustomeTableViewCellDidChooseJingDu:)]) {
            [self.delegate onsearchCustomeTableViewCellDidChooseJingDu:options];
        }
    } else if ([self.IdentifierString  isEqualToString:xiuShiIndenfier]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onsearchCustomeTableViewCellDidXiushi:)]) {
            [self.delegate onsearchCustomeTableViewCellDidXiushi:options];
        }
    } else if ([self.IdentifierString  isEqualToString:qieKouIndenfier]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onsearchCustomeTableViewCellDidChooseQieGe:)]) {
            [self.delegate onsearchCustomeTableViewCellDidChooseQieGe:options];
        }
    } else if ([self.IdentifierString  isEqualToString:paoGuangIndenfier]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onsearchCustomeTableViewCellDidChoosePaoGuang:)]) {
            [self.delegate onsearchCustomeTableViewCellDidChoosePaoGuang:options];
        }
    } else if ([self.IdentifierString  isEqualToString:duiChengIndenfier]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onsearchCustomeTableViewCellDidChooseDuiCheng:)]) {
            [self.delegate onsearchCustomeTableViewCellDidChooseDuiCheng:options];
        }
    } else if ([self.IdentifierString  isEqualToString:jiBieIndenfier]) {
        
    } else if ([self.IdentifierString  isEqualToString:dengjiIndenfier]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onsearchCustomeTableViewCellDidChooseDengJi:)]) {
            [self.delegate onsearchCustomeTableViewCellDidChooseDengJi:options];
        }
    } else if ([self.IdentifierString  isEqualToString:yaoweiIndenfier]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onsearchCustomeTableViewCellDidChooseYaowei:)]) {
            [self.delegate onsearchCustomeTableViewCellDidChooseYaowei:options];
        }
    } else if ([self.IdentifierString  isEqualToString:jiandiIndenfier]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onsearchCustomeTableViewCellDidChooseJiandi:)]) {
            [self.delegate onsearchCustomeTableViewCellDidChooseJiandi:options];
        }
    } else if ([self.IdentifierString  isEqualToString:chuliIndenfier]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onsearchCustomeTableViewCellDidChooseChuli:)]) {
            [self.delegate onsearchCustomeTableViewCellDidChooseChuli:options];
        }
    }
}
@end
