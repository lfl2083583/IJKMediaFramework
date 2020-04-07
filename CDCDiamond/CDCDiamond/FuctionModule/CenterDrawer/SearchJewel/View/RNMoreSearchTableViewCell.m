//
//  RNMoreSearchTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/30.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNMoreSearchTableViewCell.h"
#import "ZTTextField.h"
#import "RNOptionChooseView.h"
#import "PopoverView.h"
#import "RNChooseView.h"

@interface RNMoreSearchTableViewCell ()<RNChooseViewDelegate>

@property (weak, nonatomic) IBOutlet ZTTextField *rapIDTF;
@property (weak, nonatomic) IBOutlet ZTTextField *banhaoTF;
@property (weak, nonatomic) IBOutlet ZTTextField *taimianleftTF;
@property (weak, nonatomic) IBOutlet ZTTextField *taimianrightTF;
@property (weak, nonatomic) IBOutlet ZTTextField *shenduTF;
@property (weak, nonatomic) IBOutlet ZTTextField *shendurightTF;
@property (weak, nonatomic) IBOutlet ZTTextField *changeduleftTF;
@property (weak, nonatomic) IBOutlet ZTTextField *changedurightTF;
@property (weak, nonatomic) IBOutlet ZTTextField *kanduleftTF;
@property (weak, nonatomic) IBOutlet ZTTextField *kandurightTF;
@property (weak, nonatomic) IBOutlet ZTTextField *sdleftTF;
@property (weak, nonatomic) IBOutlet ZTTextField *sdrightTF;
@property (weak, nonatomic) IBOutlet ZTTextField *bilileftTF;
@property (weak, nonatomic) IBOutlet ZTTextField *birightTF;


@property (weak, nonatomic) IBOutlet UIButton *zhengshuBtn;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (weak, nonatomic) IBOutlet ZTTextField *bianhaoTF;
@property (weak, nonatomic) IBOutlet UIButton *minyaoweiBtn;
@property (weak, nonatomic) IBOutlet UIButton *maxyaoweiBtn;
@property (weak, nonatomic) IBOutlet ZTTextField *minGuangaoTF;
@property (weak, nonatomic) IBOutlet ZTTextField *maxGuangaoTF;
@property (weak, nonatomic) IBOutlet ZTTextField *minGuanjiaoTF;
@property (weak, nonatomic) IBOutlet ZTTextField *maxGuanjiaoTF;
@property (weak, nonatomic) IBOutlet ZTTextField *minDishenTF;
@property (weak, nonatomic) IBOutlet ZTTextField *maxDishenTF;
@property (weak, nonatomic) IBOutlet ZTTextField *minDijiaoTF;
@property (weak, nonatomic) IBOutlet ZTTextField *maxDijiaoTF;
@property (weak, nonatomic) IBOutlet UIButton *minHundunTF;
@property (weak, nonatomic) IBOutlet UIButton *maxHundunTF;

@property (weak, nonatomic) IBOutlet UILabel *eysLB;
@property (weak, nonatomic) IBOutlet UILabel *neihanLB;
@property (weak, nonatomic) IBOutlet UILabel *whiteneihanLB;
@property (weak, nonatomic) IBOutlet UILabel *blackneihanLB;
@property (weak, nonatomic) IBOutlet UILabel *yichuliLB;
@property (weak, nonatomic) IBOutlet UILabel *baohanyichuliLB;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (nonatomic, strong) RNChooseView *shadowV;

@property (weak, nonatomic) IBOutlet UILabel *maijiaLB;
@property (weak, nonatomic) IBOutlet UILabel *cangkuLB;
@property (weak, nonatomic) IBOutlet UILabel *taimianLB;
@property (weak, nonatomic) IBOutlet UILabel *shenduLB;
@property (weak, nonatomic) IBOutlet UILabel *yaoweiLB;
@property (weak, nonatomic) IBOutlet UILabel *celiangLB;
@property (weak, nonatomic) IBOutlet UILabel *changduLB;
@property (weak, nonatomic) IBOutlet UILabel *kuanduLB;
@property (weak, nonatomic) IBOutlet UILabel *shenLB;
@property (weak, nonatomic) IBOutlet UILabel *biliLB;
@property (weak, nonatomic) IBOutlet UILabel *guangaoLB;
@property (weak, nonatomic) IBOutlet UILabel *guanjiaoLB;
@property (weak, nonatomic) IBOutlet UILabel *dijiaoLB;
@property (weak, nonatomic) IBOutlet UILabel *dishenLB;
@property (weak, nonatomic) IBOutlet UILabel *shadowLB;
@property (weak, nonatomic) IBOutlet UILabel *hundunLB;

@property (weak, nonatomic) IBOutlet UILabel *hanLB;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UILabel *weijianLB;

@property (weak, nonatomic) IBOutlet UIButton *btn7;
@property (weak, nonatomic) IBOutlet UIButton *btn8;
@property (weak, nonatomic) IBOutlet UIButton *btn9;
@property (weak, nonatomic) IBOutlet UILabel *diamondNumberLB;

@end

@implementation RNMoreSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.moreSearchBtn setTitle:RNLocalized(@"Advanced Search") forState:UIControlStateNormal];
    self.maijiaLB.text = RNLocalized(@"Seller");
    self.cangkuLB.text = RNLocalized(@"Warehouse number");
    self.taimianLB.text = RNLocalized(@"Table Percentage");
    self.banhaoTF.placeholder = RNLocalized(@"Warehouse number");
    self.taimianleftTF.placeholder = RNLocalized(@"Any");
    self.taimianrightTF.placeholder = RNLocalized(@"Any");
    self.shenduLB.text = RNLocalized(@"Depth Percentage");
    self.shenduTF.placeholder = RNLocalized(@"Any");
    self.shendurightTF.placeholder = RNLocalized(@"Any");
    self.yaoweiLB.text = RNLocalized(@"Waistline");
    self.celiangLB.text = RNLocalized(@"Measure");
    self.changduLB.text = RNLocalized(@"Length");
    self.changeduleftTF.placeholder = RNLocalized(@"Any");
    self.changedurightTF.placeholder = RNLocalized(@"Any");
    self.kuanduLB.text = RNLocalized(@"Width");
    self.kanduleftTF.placeholder = RNLocalized(@"Any");
    self.kandurightTF.placeholder = RNLocalized(@"Any");
    self.shenLB.text = RNLocalized(@"Depth");
    self.shenduTF.placeholder = RNLocalized(@"Any");
    self.sdleftTF.placeholder = RNLocalized(@"Any");
    self.sdrightTF.placeholder = RNLocalized(@"Any");
    self.shendurightTF.placeholder = RNLocalized(@"Any");
    self.biliLB.text = RNLocalized(@"Proportion");
    self.bilileftTF.placeholder = RNLocalized(@"Any");
    self.birightTF.placeholder = RNLocalized(@"Any");
    self.guangaoLB.text = RNLocalized(@"Crown Height Percentage");
    self.minGuangaoTF.placeholder = RNLocalized(@"Any");
    self.maxGuangaoTF.placeholder = RNLocalized(@"Any");
    self.guanjiaoLB.text = RNLocalized(@"Crown Angle");
    self.minGuanjiaoTF.placeholder = RNLocalized(@"Any");
    self.maxGuanjiaoTF.placeholder = RNLocalized(@"Any");
    self.dishenLB.text = RNLocalized(@"Percentage of bottom depth");
    self.minDishenTF.placeholder = RNLocalized(@"Any");
    self.maxDishenTF.placeholder = RNLocalized(@"Any");
    self.dijiaoLB.text = RNLocalized(@"At the bottom of the Angle");
    self.minDijiaoTF.placeholder = RNLocalized(@"Any");
    self.maxDijiaoTF.placeholder = RNLocalized(@"Any");
    self.shadowLB.text = RNLocalized(@"Eliminate Shadow");
    self.hundunLB.text = RNLocalized(@"Chaos");
    self.hanLB.text = RNLocalized(@"Inclusions");
    [self.btn1 setTitle:RNLocalized(@"Choose Clean To The Naked Eye") forState:UIControlStateNormal];
    [self.btn2 setTitle:RNLocalized(@"Select The External Inclusions") forState:UIControlStateNormal];
    [self.btn3 setTitle:RNLocalized(@"Choose White Inclusions") forState:UIControlStateNormal];
    [self.btn4 setTitle:RNLocalized(@"Choose Black Inclusions") forState:UIControlStateNormal];
    [self.btn5 setTitle:RNLocalized(@"Processed Only") forState:UIControlStateNormal];
    [self.btn6 setTitle:RNLocalized(@"Contains Processed") forState:UIControlStateNormal];
    [self.btn7 setTitle:RNLocalized(@"Certificate Of The Scanning") forState:UIControlStateNormal];
    [self.btn8 setTitle:RNLocalized(@"Diamond Images") forState:UIControlStateNormal];
    self.weijianLB.text = RNLocalized(@"Contains The File");
    self.diamondNumberLB.text = [NSString stringWithFormat:@"CDC %@", RNLocalized(@"Diamond number")];
    self.bianhaoTF.placeholder = [NSString stringWithFormat:@"%@ CDC %@", RNLocalized(@"Please enter the"),RNLocalized(@"Diamond number")];
    
    
    // Initialization code
    self.shadowV = [[RNChooseView alloc] initWithChooses:@[@"Any" ,@"None White",@"No Brown",@"No Yellow",@"No Green",@"No Grey",@"No Black", @"No Pink", @"No Blue"] rect:CGRectMake(0, 0, App_Frame_Width-24, 44)];
    self.shadowV.delegate = self;
    [self.shadowView addSubview:self.shadowV];
}

- (void)setModel:(RNSearchJewelModel *)model {
    _model = model;
    self.rapIDTF.text = self.model.usercomid;
    self.banhaoTF.text = self.model.gupcode;
    self.taimianleftTF.text = self.model.bottom;
    self.taimianrightTF.text = self.model.bottommax;
    self.shenduTF.text = self.model.depth;
    self.shendurightTF.text = self.model.depthmax;
    self.changeduleftTF.text = self.model.chang;
    self.changedurightTF.text = self.model.changmax;
    self.kanduleftTF.text = self.model.kuan;
    self.kandurightTF.text = self.model.kuanmax;
    self.sdleftTF.text = self.model.gao;
    self.sdrightTF.text = self.model.gaomax;
    self.bilileftTF.text = self.model.radio;
    self.birightTF.text = self.model.radiomax;
    self.minGuanjiaoTF.text = self.model.guanjiao;
    self.maxGuanjiaoTF.text = self.model.guangaomax;
    self.minGuangaoTF.text = self.model.guangao;
    self.maxGuangaoTF.text = self.model.guangaomax;
    self.minDishenTF.text = self.model.tingsheng;
    self.maxDishenTF.text = self.model.tingshengmax;
    self.minDijiaoTF.text = self.model.tingjiao;
    self.maxDijiaoTF.text = self.model.tingjiaomax;
    self.bianhaoTF.text = self.model.diaNO;
    [self.zhengshuBtn setSelected:[[NSString stringWithFormat:@"%@", model.reportfile] isEqualToString:@"true"]?YES:NO];
    [self.imgBtn setSelected:[[NSString stringWithFormat:@"%@", model.imgfile] isEqualToString:@"true"]?YES:NO];
    [self.videoBtn setSelected:[[NSString stringWithFormat:@"%@", model.videofile] isEqualToString:@"true"]?YES:NO];
    
    if ([Utility isString:self.model.waisttj]) {
        [self.minyaoweiBtn setTitle:self.model.waisttj forState:UIControlStateNormal];
    }
    
    if ([Utility isString:self.model.waisttjmax]) {
        [self.maxyaoweiBtn setTitle:self.model.waisttjmax forState:UIControlStateNormal];
    }
    
    //[self.minHundunTF setTitle:<#(nullable NSString *)#> forState:<#(UIControlState)#>]
    //self.maxHundunTF setTitle:<#(nullable NSString *)#> forState:<#(UIControlState)#>
    if ([Utility isString:self.model.eyeclean]) {
        NSArray *array = [self.model.eyeclean componentsSeparatedByString:@","];
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            self.eysLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            [self.eysLB setHidden:NO];
        } else {
            [self.eysLB setHidden:YES];
        }
    } else {
        [self.eysLB setHidden:YES];
    }
    
    if ([Utility isString:self.model.centerinclusion]) {
        NSArray *array = [self.model.centerinclusion componentsSeparatedByString:@","];
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            [self.neihanLB setHidden:NO];
            self.neihanLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
        } else {
            [self.neihanLB setHidden:YES];
        }
    } else{
        [self.neihanLB setHidden:YES];
    }
    
    if ([Utility isString:self.model.whiteinclusions]) {
        NSArray *array = [self.model.whiteinclusions componentsSeparatedByString:@","];
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            self.whiteneihanLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            [self.whiteneihanLB setHidden:NO];
        } else {
            [self.whiteneihanLB setHidden:YES];
        }
    } else {
        [self.whiteneihanLB setHidden:YES];
    }
    
    if ([Utility isString:self.model.blackinclusions]) {
        NSArray *array = [self.model.blackinclusions componentsSeparatedByString:@","];
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            self.blackneihanLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            [self.blackneihanLB setHidden:NO];
        } else {
            [self.blackneihanLB setHidden:YES];
        }
    } else {
        [self.blackneihanLB setHidden:YES];
    }
    
    if ([Utility isString:self.model.jxhandle]) {
        NSArray *array = [self.model.jxhandle componentsSeparatedByString:@","];
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            self.yichuliLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            [self.yichuliLB setHidden:NO];
        } else {
            [self.yichuliLB setHidden:YES];
        }
    } else {
        [self.yichuliLB setHidden:YES];
    }
    
    if ([Utility isString:self.model.bkhandle]) {
        NSArray *array = [self.model.bkhandle componentsSeparatedByString:@","];
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            self.baohanyichuliLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            [self.baohanyichuliLB setHidden:NO];
        } else {
            [self.baohanyichuliLB setHidden:YES];
        }
    } else {
        [self.baohanyichuliLB setHidden:YES];
    }
    
    if ([Utility isString:model.shadecos]) {
        NSArray *array = [model.shadecos componentsSeparatedByString:@","];
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            self.shadowV.defaultChooses = array;
        }
    }
}

- (IBAction)rapIDChanged:(ZTTextField *)sender {
    //self.model.usercomid = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMoreRapIDChanged:)]) {
        [self.delegate onSearchMoreRapIDChanged:sender.text];
    }
}

- (IBAction)stockChaned:(ZTTextField *)sender {
    //self.model.gupcode = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMoreStockChaned:)]) {
        [self.delegate onSearchMoreStockChaned:sender.text];
    }
}

- (IBAction)minTaimainChange:(ZTTextField *)sender {
    //self.model.bottom = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMinTaimainChanged:)]) {
        [self.delegate onSearchMinTaimainChanged:sender.text];
    }
}

- (IBAction)maxTaiminChanged:(ZTTextField *)sender {
    //self.model.bottommax = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMaxTaimainChanged:)]) {
           [self.delegate onSearchMaxTaimainChanged:sender.text];
    }
}

- (IBAction)minshenduChanged:(ZTTextField *)sender {
    //self.model.depth = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMinshenduChanged:)]) {
        [self.delegate onSearchMinshenduChanged:sender.text];
    }
}

- (IBAction)maxshenduChaned:(ZTTextField *)sender {
    //self.model.depthmax = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMaxshenduChanged:)]) {
        [self.delegate onSearchMaxshenduChanged:sender.text];
    }
}

- (IBAction)minchangChanged:(ZTTextField *)sender {
    //self.model.chang = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMinchangChanged:)]) {
        [self.delegate onSearchMinchangChanged:sender.text];
    }
}
- (IBAction)maxchangChaned:(ZTTextField *)sender {
    //self.model.changmax = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMaxchangChanged:)]) {
        [self.delegate onSearchMaxchangChanged:sender.text];
    }
}

- (IBAction)minkuanduChanged:(ZTTextField *)sender {
   // self.model.kuan = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMinkuanduChanged:)]) {
        [self.delegate onSearchMinkuanduChanged:sender.text];
    }
}

- (IBAction)maxkuanduChaned:(ZTTextField *)sender {
    //self.model.kuanmax = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMaxkuanduChanged:)]) {
        [self.delegate onSearchMaxkuanduChanged:sender.text];
    }
}


- (IBAction)minshengduChaned:(ZTTextField *)sender {
    //self.model.gao = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMinGaoChanged:)]) {
        [self.delegate onSearchMinGaoChanged:sender.text];
    }
}
- (IBAction)maxshengduChaned:(ZTTextField *)sender {
    //self.model.gaomax = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMaxGaoChanged:)]) {
        [self.delegate onSearchMaxGaoChanged:sender.text];
    }
}
- (IBAction)minbiliChanged:(ZTTextField *)sender {
    //self.model.radio = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMinbiliChanged:)]) {
        [self.delegate onSearchMinbiliChanged:sender.text];
    }
    
}
- (IBAction)maxbiliChanged:(ZTTextField *)sender {
    //self.model.radiomax = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMaxbiliChanged:)]) {
        [self.delegate onSearchMaxbiliChanged:sender.text];
    }
}

- (IBAction)mainguanjiaoChanged:(ZTTextField *)sender {
    //self.model.guanjiao = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMinguanjiaoChanged:)]) {
        [self.delegate onSearchMinguanjiaoChanged:sender.text];
    }
}

- (IBAction)maxguanjiaoChanged:(ZTTextField *)sender {
    //self.model.guanjiaomax = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMaxguanjiaoChanged:)]) {
        [self.delegate onSearchMaxguanjiaoChanged:sender.text];
    }
}

- (IBAction)mindishenChaned:(ZTTextField *)sender {
    //self.model.tingsheng = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMindishenChaned:)]) {
        [self.delegate onSearchMindishenChaned:sender.text];
    }
}

- (IBAction)maxdishenChaned:(ZTTextField *)sender {
    //self.model.tingshengmax = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMaxdishenChaned:)]) {
        [self.delegate onSearchMaxdishenChaned:sender.text];
    }
}
- (IBAction)dijiaoChanged:(ZTTextField *)sender {
    //self.model.tingjiao = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMindijiaoChanged:)]) {
        [self.delegate onSearchMindijiaoChanged:sender.text];
    }
}
- (IBAction)maxdijiaoChanged:(ZTTextField *)sender {
    //self.model.tingjiaomax = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMaxdijiaoChanged:)]) {
        [self.delegate onSearchMaxdijiaoChanged:sender.text];
    }
}

- (IBAction)moreSearchBtn:(UIButton *)sender {
    self.moreContentView.hidden = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(moreSearchTableViewCellDidClickMoreBtn:)]) {
        [self.delegate moreSearchTableViewCellDidClickMoreBtn:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)saomiaoBtnClick:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchSaomiaoChanged:)]) {
        [self.delegate onSearchSaomiaoChanged:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", sender.isSelected == YES?@"true":@"false"]]];
    }
    //self.model.reportfile = [NSString stringWithFormat:@"%d", sender.isSelected];
}

- (IBAction)jwewelImgBtn:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchJewelImgChanged:)]) {
        [self.delegate onSearchJewelImgChanged:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", sender.isSelected == YES?@"true":@"false"]]];
    }
    //self.model.diaNO = [NSString stringWithFormat:@"%d", sender.isSelected];
}

- (IBAction)videoClick:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    //self.model.videofile = [NSString stringWithFormat:@"%d", sender.isSelected];
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchVideoEnable:)]) {
        [self.delegate onSearchVideoEnable:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", sender.isSelected == YES?@"true":@"false"]]];
    }
}

- (IBAction)eyeClick:(UIButton *)sender {
    __weak typeof(self)weakself = self;
    RNOptionChooseView *chooseView = [[RNOptionChooseView alloc] initWithTopSpace:120];
    [chooseView showWithDataSource:@[@"Yes", @"Borderline", @"No"] chooseBlock:^(NSArray * _Nonnull array) {
        //weakself.model.eyeclean = [array componentsJoinedByString:@","];
        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(onSearchEyeChanged:)]) {
            [weakself.delegate onSearchEyeChanged:[array componentsJoinedByString:@","]];
        }
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            weakself.eysLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            [weakself.eysLB setHidden:NO];
        } else {
            [weakself.eysLB setHidden:YES];
        }
    } defaultArray:@[]];
}

- (IBAction)leftYaoweiClick:(UIButton *)sender {
    __weak typeof(self)weakself = self;
    NSArray *titles = @[@"Extr. Thin", @"Very Thin", @"Thin", @"Slightly Thin", @"Medium", @"Slightly Thick", @"Thick", @"Very Thick", @"Extr. Thick"];
       PopoverView *popveView = [PopoverView popoverView];
       popveView.showShade = YES;
       NSMutableArray *array = [NSMutableArray array];
       for (NSString *str in titles) {
           PopoverAction *action  = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action) {
               [sender setTitle:action.title forState:UIControlStateNormal];
               //weakself.model.waisttj = action.title;
               if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(onSearchMinyaoweiChanged:)]) {
                   [weakself.delegate onSearchMinyaoweiChanged:action.title];
               }
           }];
           [array addObject:action];
       }
       [popveView showToView:sender withActions:array];
}

- (IBAction)rightYaoweiClick:(UIButton *)sender {
    __weak typeof(self)weakself = self;
    NSArray *titles = @[@"Extr. Thin", @"Very Thin", @"Thin", @"Slightly Thin", @"Medium", @"Slightly Thick", @"Thick", @"Very Thick", @"Very Thick"];
       PopoverView *popveView = [PopoverView popoverView];
       popveView.showShade = YES;
       NSMutableArray *array = [NSMutableArray array];
       for (NSString *str in titles) {
           PopoverAction *action  = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action) {
               [sender setTitle:action.title forState:UIControlStateNormal];
               //weakself.model.waisttjmax = action.title;
               if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(onSearchMaxyaoweiChanged:)]) {
                   [weakself.delegate onSearchMaxyaoweiChanged:action.title];
               }
           }];
           [array addObject:action];
       }
       [popveView showToView:sender withActions:array];
}


- (IBAction)neihanClick:(UIButton *)sender {
    __weak typeof(self)weakself = self;
    RNOptionChooseView *chooseView = [[RNOptionChooseView alloc] initWithTopSpace:120];
    [chooseView showWithDataSource:@[@"None", @"Light", @"Medium", @"Heavy",@"Open Table Small", @"Open Table Medium", @"Open Table Large", @"Open Crown Small", @"Open Crown Small", @"Open Crown Large", @"Open Pavilion Small", @"Open Pavilion Medium", @"Open Pavilion Large", @"Open Girdle Small", @"Open Girdle Medium", @"Open Girdle Large"] chooseBlock:^(NSArray * _Nonnull array) {
        //weakself.model.centerinclusion = [array componentsJoinedByString:@","];
        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(onSearchNeihanChanged:)]) {
            [weakself.delegate onSearchNeihanChanged:[array componentsJoinedByString:@","]];
        }
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            weakself.neihanLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            [weakself.neihanLB setHidden:NO];
        } else {
            [weakself.neihanLB setHidden:YES];
        }
    } defaultArray:@[]];
}
- (IBAction)whiteNeihanClick:(UIButton *)sender {
    __weak typeof(self)weakself = self;
    RNOptionChooseView *chooseView = [[RNOptionChooseView alloc] initWithTopSpace:120];
    [chooseView showWithDataSource:@[@"None", @"White Inclusions None", @"White Table Meaningles", @"White Table Small", @"White Table Medium", @"White Table Large", @"White Crown Meaningless", @"White Crown Small", @"White Crown Medium", @"White Crown Large"] chooseBlock:^(NSArray * _Nonnull array) {
        //weakself.model.whiteinclusions = [array componentsJoinedByString:@","];
        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(onSearchWhiteNeihanChanged:)]) {
            [weakself.delegate onSearchWhiteNeihanChanged:[array componentsJoinedByString:@","]];
        }
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            weakself.whiteneihanLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            [weakself.whiteneihanLB setHidden:NO];
        } else {
            [weakself.whiteneihanLB setHidden:YES];
        }
    } defaultArray:@[]];
    
}

- (IBAction)blackNeihanClick:(UIButton *)sender {
    __weak typeof(self)weakself = self;
    RNOptionChooseView *chooseView = [[RNOptionChooseView alloc] initWithTopSpace:120];
    [chooseView showWithDataSource:@[@"Any", @"None", @"Light", @"Medium", @"Heavy",@"Black Table Meaningless", @"Black Table Small", @"Black Table Medium", @"Black Table Large", @"Black Crown Meaningless", @"Black Crown Small", @"Black Crown Medium",@"Black Crown Large"] chooseBlock:^(NSArray * _Nonnull array) {
        //weakself.model.blackinclusions = [array componentsJoinedByString:@","];
        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(onSearchBlackNeihanChanged:)]) {
            [weakself.delegate onSearchBlackNeihanChanged:[array componentsJoinedByString:@","]];
        }
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            weakself.blackneihanLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            [weakself.blackneihanLB setHidden:NO];
        } else {
            [weakself.blackneihanLB setHidden:YES];
        }
    } defaultArray:@[]];
}


- (IBAction)leftHundunClick:(UIButton *)sender {
    __weak typeof(self)weaself = self;
    NSArray *titles = @[@"None", @"Light", @"Medium", @"Heavy"];
    PopoverView *popveView = [PopoverView popoverView];
    popveView.showShade = YES;
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in titles) {
        PopoverAction *action  = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action) {
            [sender setTitle:action.title forState:UIControlStateNormal];
            if (weaself.delegate && [weaself.delegate respondsToSelector:@selector(onSearchMinhundunChanged:)]) {
                [weaself.delegate onSearchMinhundunChanged:action.title];
            }
        }];
        [array addObject:action];
    }
    [popveView showToView:sender withActions:array];
}


- (IBAction)rightHundunClick:(UIButton *)sender {
    __weak typeof(self)weaself = self;
    NSArray *titles = @[@"None", @"Light", @"Medium", @"Heavy"];
    PopoverView *popveView = [PopoverView popoverView];
    popveView.showShade = YES;
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in titles) {
        PopoverAction *action  = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action) {
            [sender setTitle:action.title forState:UIControlStateNormal];
            if (weaself.delegate && [weaself.delegate respondsToSelector:@selector(onSearchMaxhundunChanged:)]) {
                [weaself.delegate onSearchMaxhundunChanged:action.title];
            }
        }];
        [array addObject:action];
    }
    [popveView showToView:sender withActions:array];
}

- (IBAction)yichuliClick:(UIButton *)sender {
    __weak typeof(self)weaself = self;
    RNOptionChooseView *chooseView = [[RNOptionChooseView alloc] initWithTopSpace:120];
    [chooseView showWithDataSource:@[@"LD", @"IRR", @"ColorEnhanced",@"CE", @"HPHT", @"Other"] chooseBlock:^(NSArray * _Nonnull array) {
        //weaself.model.jxhandle = [array componentsJoinedByString:@","];
        if (weaself.delegate && [weaself.delegate respondsToSelector:@selector(onSearchYichuliChanged:)]) {
            [weaself.delegate onSearchYichuliChanged:[array componentsJoinedByString:@","]];
        }
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            weaself.yichuliLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            [weaself.yichuliLB setHidden:NO];
        } else {
            [weaself.yichuliLB setHidden:YES];
        }
    } defaultArray:@[]];
}
- (IBAction)hanyichuliClick:(UIButton *)sender {
    __weak typeof(self)weaself = self;
    RNOptionChooseView *chooseView = [[RNOptionChooseView alloc] initWithTopSpace:120];
    [chooseView showWithDataSource:@[@"LD", @"IRR", @"ColorEnhanced",@"CE", @"HPHT", @"Other"] chooseBlock:^(NSArray * _Nonnull array) {
        //weaself.model.bkhandle = [array componentsJoinedByString:@","];
        if (weaself.delegate && [weaself.delegate respondsToSelector:@selector(onSearchHanYichuliChanged:)]) {
            [weaself.delegate onSearchHanYichuliChanged:[array componentsJoinedByString:@","]];
        }
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            weaself.baohanyichuliLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
            [weaself.baohanyichuliLB setHidden:NO];
        } else {
            [weaself.baohanyichuliLB setHidden:YES];
        }
    } defaultArray:@[]];
}
- (IBAction)bianhaoTFChanged:(UITextField *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchBianhaoChanged:)]) {
        [self.delegate onSearchBianhaoChanged:sender.text];
    }
    
   
}
- (IBAction)minGuangaoTFChanged:(UITextField *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMinGuanGaoChanged:)]) {
        [self.delegate onSearchMinGuanGaoChanged:sender.text];
    }
}

- (IBAction)maxGuangaoTFChanged:(UITextField *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchMaxGuanGaoChanged:)]) {
        [self.delegate onSearchMaxGuanGaoChanged:sender.text];
    }
}


#pragma mark - RNChooseViewDelegate

- (void)onChooseViewDidSeletedOptions:(NSArray *)options chooseView:(RNChooseView *)chooseView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onSearchShadowChanged:)]) {
        [self.delegate onSearchShadowChanged:[options componentsJoinedByString:@","]];
    }
}

@end
