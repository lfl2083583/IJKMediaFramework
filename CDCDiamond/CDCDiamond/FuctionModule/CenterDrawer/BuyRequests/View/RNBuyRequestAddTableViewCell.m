//
//  RNBuyRequestAddTableViewCell.m
//  RapNet
//
//  Created by jt on 2019/11/10.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNBuyRequestAddTableViewCell.h"
#import "ZTTextField.h"
#import "RNChooseView.h"
#import "RNOptionChooseView.h"
#import "WSDatePickerView.h"

@interface RNBuyRequestAddTableViewCell ()<RNChooseViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *yingguangView;
@property (weak, nonatomic) IBOutlet UIView *shiyanshiClick;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UILabel *postionStatusLB;

@property (nonatomic, strong) RNChooseView *yingguangV;
@property (nonatomic, strong) RNChooseView *shiyanshiV;
@property (weak, nonatomic) IBOutlet ZTTextField *leftTaimianTF;
@property (weak, nonatomic) IBOutlet ZTTextField *rightTaimianTF;
@property (weak, nonatomic) IBOutlet ZTTextField *leftShenduperTF;
@property (weak, nonatomic) IBOutlet ZTTextField *rightShenduperTF;
@property (weak, nonatomic) IBOutlet ZTTextField *leftChangeduTF;
@property (weak, nonatomic) IBOutlet ZTTextField *rightChangduTF;
@property (weak, nonatomic) IBOutlet ZTTextField *leftKuanduTF;
@property (weak, nonatomic) IBOutlet ZTTextField *rightKuanduTF;
@property (weak, nonatomic) IBOutlet ZTTextField *leftShenduTF;
@property (weak, nonatomic) IBOutlet ZTTextField *rightShenduTF;
@property (weak, nonatomic) IBOutlet UIButton *lijiDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *meiriDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *matchBtn;
@property (weak, nonatomic) IBOutlet ZTTextField *remarkTF;


@property (weak, nonatomic) IBOutlet UILabel *LB1;
@property (weak, nonatomic) IBOutlet UILabel *LB2;
@property (weak, nonatomic) IBOutlet UILabel *LB3;
@property (weak, nonatomic) IBOutlet UILabel *LB4;
@property (weak, nonatomic) IBOutlet UILabel *LB5;
@property (weak, nonatomic) IBOutlet UILabel *LB6;
@property (weak, nonatomic) IBOutlet UILabel *LB7;
@property (weak, nonatomic) IBOutlet UILabel *LB8;
@property (weak, nonatomic) IBOutlet UILabel *LB9;
@property (weak, nonatomic) IBOutlet UILabel *LB10;
@property (weak, nonatomic) IBOutlet UILabel *LB11;
@property (weak, nonatomic) IBOutlet UILabel *LB12;
@property (weak, nonatomic) IBOutlet UILabel *LB13;
@property (weak, nonatomic) IBOutlet UILabel *LB14;



@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;




@end

@implementation RNBuyRequestAddTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.LB1.text = RNLocalized(@"Table Percentage");
    self.LB2.text = RNLocalized(@"Depth Percentage");
    self.LB3.text = RNLocalized(@"Measure");
    self.LB4.text = RNLocalized(@"Length");
    self.LB5.text = RNLocalized(@"Width");
    self.LB6.text = RNLocalized(@"Depth");
    self.LB7.text = RNLocalized(@"Laboratory");
    self.LB8.text = RNLocalized(@"Fluorescence");
    self.LB9.text = RNLocalized(@"Location");
    self.LB10.text = RNLocalized(@"Notifications");
    self.LB11.text = RNLocalized(@"Show Only");
    self.LB12.text = RNLocalized(@"Due Date");
    self.LB13.text = RNLocalized(@"Comment");
    self.LB14.text = RNLocalized(@"Certificate");
    
    [self.btn1 setTitle:RNLocalized(@"Seller Location") forState:UIControlStateNormal];
    [self.btn2 setTitle:RNLocalized(@"Send E-mail Daily") forState:UIControlStateNormal];
    [self.btn3 setTitle:RNLocalized(@"Send E-mail Immediately") forState:UIControlStateNormal];
    [self.btn4 setTitle:RNLocalized(@"Matches Only") forState:UIControlStateNormal];
    [self.dateBtn setTitle:RNLocalized(@"Due Date") forState:UIControlStateNormal];
    [self.btn6 setTitle:RNLocalized(@"Whether to get certificate") forState:UIControlStateNormal];
    self.remarkTF.placeholder = RNLocalized(@"Annotation");
    
    self.leftTaimianTF.placeholder = RNLocalized(@"Any");
    self.rightTaimianTF.placeholder = RNLocalized(@"Any");
    self.leftShenduTF.placeholder = RNLocalized(@"Any");
    self.rightShenduTF.placeholder = RNLocalized(@"Any");
    self.leftShenduperTF.placeholder = RNLocalized(@"Any");
    self.rightShenduperTF.placeholder = RNLocalized(@"Any");
    self.leftChangeduTF.placeholder = RNLocalized(@"Any");
    self.rightChangduTF.placeholder = RNLocalized(@"Any");
    self.leftKuanduTF.placeholder = RNLocalized(@"Any");
    self.rightKuanduTF.placeholder = RNLocalized(@"Any");

    NSArray *yingguang = @[@"None", @"Very Slight", @"Very Slight", @"Medium", @"Strong", @"Very Strong"];
    self.yingguangV = [[RNChooseView alloc] initWithChooses:yingguang rect:CGRectMake(0, 0, App_Frame_Width - 24, 44)];
    self.yingguangV.delegate = self;
    [self.yingguangView addSubview:self.yingguangV];
    // Initialization code
    
    NSArray *shiyanshi = @[@"GIA", @"HRD", @"IGI", @"AGS"];
    self.shiyanshiV = [[RNChooseView alloc] initWithChooses:shiyanshi rect:CGRectMake(0, 0, App_Frame_Width - 24, 44)];
    self.shiyanshiV.delegate = self;
    [self.shiyanshiClick addSubview:self.shiyanshiV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setSingleEnable:(BOOL)singleEnable {
    _singleEnable = singleEnable;
    self.yingguangV.singleChoose = singleEnable;
    self.shiyanshiV.singleChoose = singleEnable;
}

- (void)setModel:(RNBuyRequestAddModel *)model {
    _model = model;
    
    self.leftTaimianTF.text = model.F_BOTTOMMIN;
    if ([Utility isString:model.F_BOTTOM]) {
        self.rightTaimianTF.text = KFormat(model.F_BOTTOM);
    } else {
        self.rightTaimianTF.text = @"";
    }
    
    self.leftChangeduTF.text = model.F_CHANGMIN;
    if ([Utility isString:model.F_CHANG]) {
        self.rightChangduTF.text = KFormat(model.F_CHANG);
    } else {
        self.rightChangduTF.text = @"";
    }
    self.leftKuanduTF.text = model.F_KUANMIN;
    
    if ([Utility isString:model.F_KUAN]) {
        self.rightKuanduTF.text = KFormat(model.F_KUAN);
    } else {
        self.rightKuanduTF.text = @"";
    }
      
    self.leftShenduTF.text = model.F_GAOMIN;
    
    if ([Utility isString:model.F_GAO]) {
        self.rightShenduTF.text = KFormat(model.F_GAO);
    } else {
        self.rightShenduTF.text = @"";
    }
    
    self.leftShenduperTF.text = model.F_DEPTHPERCENTAGEMIN;
    
     
    if ([Utility isString:model.F_DEPTHPERCENTAGE]) {
        self.rightShenduperTF.text = KFormat(model.F_DEPTHPERCENTAGE);
    } else {
        self.rightShenduperTF.text = @"";
    }
    
    if ([Utility isString:model.F_LABORATORY]) {
        NSArray *array = [model.F_LABORATORY componentsSeparatedByString:@","];
        self.shiyanshiV.defaultChooses = array;
    } else {
        self.shiyanshiV.defaultChooses = @[];
    }
    
    if ([Utility isString:model.F_REAL]) {
        NSArray *array = [model.F_REAL componentsSeparatedByString:@","];
        self.yingguangV.defaultChooses = array;
    } else {
        self.yingguangV.defaultChooses = @[];
    }
    
    if ([Utility isString:model.F_FIELD]) {
        NSArray *array = [model.F_FIELD componentsSeparatedByString:@","];
        self.postionStatusLB.hidden = !array.count;
        self.postionStatusLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)array.count];
    } else {
        self.postionStatusLB.hidden = YES;
        self.postionStatusLB.text = @"";
    }
    
    if ([Utility isString:model.F_DUI]) {
        [self.matchBtn setSelected:([[NSString stringWithFormat:@"%@", model.F_DUI] isEqualToString:@"true"] || [[NSString stringWithFormat:@"%@", model.F_DUI] isEqualToString:@"1"])?YES:NO];
    } else {
        [self.matchBtn setSelected:NO];
    }
    
    if ([Utility isString:model.F_EXPIRE]) {
        [self.dateBtn setTitle:model.F_EXPIRE forState:UIControlStateNormal];
    } else {
        [self.dateBtn setTitle:@"" forState:UIControlStateNormal];
    }
    
    if ([Utility isString:model.F_PLNGLUAN]) {
        [self.remarkTF setText:model.F_PLNGLUAN];
    } else {
       [self.remarkTF setText:@""];
    }
    
    [self.btn5 setSelected:model.F_ISZS];
}
   

- (IBAction)positionClick:(UIButton *)sender {
     __weak typeof(self)weakself = self;
    
    [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/AppSearch?method=onload") parameters:@{@"lang" : [NSString stringWithFormat:@"%d", [RNLanguageManager shareManager].languageType]} success:^(id responseObject, ResponseState state) {
        NSLog(@"%@", responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSMutableArray *allCountry = [NSMutableArray array];
//            if (responseObject[@"allCity"]) {
//                allCity addObjectsFromArray:responseObject[@"allCity"]];
//            }
            
            if (responseObject[@"allCountry"]) {
                [allCountry addObjectsFromArray:responseObject[@"allCountry"]];
            }
//
//            if (responseObject[@"allState"]) {
//                [weakself.allState addObjectsFromArray:responseObject[@"allState"]];
//            }
            
            if (allCountry.count) {
                NSMutableArray *list = [NSMutableArray array];
                for (NSDictionary *dict in allCountry) {
                    [list addObject:dict[@"name"]];
                }
                
                RNOptionChooseView *chooseView = [[RNOptionChooseView alloc] initWithTopSpace:120 searchAvaliable:YES];
                [chooseView showWithDataSource:list chooseBlock:^(NSArray * _Nonnull array) {
                    NSMutableArray *loctions = [NSMutableArray array];
                    for (NSNumber *number in array) {
                        [loctions addObject:list[[number integerValue]]];
                    }
                    weakself.model.F_FIELD = [loctions componentsJoinedByString:@","];
                    weakself.postionStatusLB.hidden = !loctions.count;
                    weakself.postionStatusLB.text = [NSString stringWithFormat:@"%lu", (unsigned long)loctions.count];
                    if (weakself.callBack) {
                        weakself.callBack(weakself.model);
                    }
                   
                } defaultArray:@[]];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)minTaimianChanged:(ZTTextField *)sender {
    self.model.F_BOTTOMMIN = sender.text;
    if (self.callBack) {
        self.callBack(self.model);
    }
}
- (IBAction)maxTaimianChanged:(ZTTextField *)sender {
    self.model.F_BOTTOM = sender.text;
    if (self.callBack) {
        self.callBack(self.model);
    }
}


- (IBAction)minShenduChanged:(ZTTextField *)sender {
    self.model.F_DEPTHPERCENTAGEMIN = sender.text;
    if (self.callBack) {
        self.callBack(self.model);
    }
}

- (IBAction)maxShenduChanged:(ZTTextField *)sender {
    self.model.F_DEPTHPERCENTAGE = sender.text;
    if (self.callBack) {
        self.callBack(self.model);
    }
}

- (IBAction)minChangedChanged:(ZTTextField *)sender {
    self.model.F_CHANGMIN = sender.text;
    if (self.callBack) {
        self.callBack(self.model);
    }
}

- (IBAction)maxChangChanged:(ZTTextField *)sender {
    self.model.F_CHANG = sender.text;
    if (self.callBack) {
        self.callBack(self.model);
    }
}

- (IBAction)minkuanChanged:(ZTTextField *)sender {
    self.model.F_KUANMIN = sender.text;
    if (self.callBack) {
        self.callBack(self.model);
    }
}

- (IBAction)maxkuanChanged:(ZTTextField *)sender {
    self.model.F_KUAN = sender.text;
    if (self.callBack) {
        self.callBack(self.model);
    }
}



- (IBAction)minsduChanged:(ZTTextField *)sender {
    self.model.F_GAOMIN = sender.text;
    if (self.callBack) {
        self.callBack(self.model);
    }
}

- (IBAction)maxsduChanged:(ZTTextField *)sender {
     self.model.F_GAO = sender.text;
    if (self.callBack) {
        self.callBack(self.model);
    }
}

- (IBAction)dailyEmailClick:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    if (self.callBack) {
        self.callBack(self.model);
    }
}
- (IBAction)justEmailClick:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    if (self.callBack) {
        self.callBack(self.model);
    }
}
- (IBAction)matchClick:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    self.model.F_DUI = [NSString stringWithFormat:@"%d", sender.selected?1:0];
    if (self.callBack) {
        self.callBack(self.model);
    }
}

- (IBAction)signClick:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    self.model.F_ISZS = sender.selected?1:0;
    if (self.callBack) {
        self.callBack(self.model);
    }
}

- (IBAction)dateClick:(UIButton *)sender {
    
}
- (IBAction)jinxianshiClick:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    self.model.F_DUI = [NSString stringWithFormat:@"%d", sender.selected?1:0];
    if (self.callBack) {
        self.callBack(self.model);
    }
}
- (IBAction)remarkChanged:(UITextField *)sender {
    self.model.F_PLNGLUAN = sender.text;
    if (self.callBack) {
        self.callBack(self.model);
    }
}
- (IBAction)daoqiClick:(UIButton *)sender {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
   
//    [self.dateBtn setTitle:strDate forState:UIControlStateNormal];
//    if (self.callBack) {
//        self.callBack(self.model);
//    }
    //指定日期2011-11-11 11:11
    NSDateFormatter *minDateFormater = [[NSDateFormatter alloc] init];
    [minDateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *scrollToDate = [minDateFormater dateFromString:@"2011-11-11 11:11"];
    __weak typeof(self)weakself = self;
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:scrollToDate CompleteBlock:^(NSDate *selectDate) {
        
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        NSLog(@"选择的日期：%@",date);
        [weakself.dateBtn setTitle:strDate forState:UIControlStateNormal];
        weakself.model.F_EXPIRE = strDate;
        if (weakself.callBack) {
            weakself.callBack(weakself.model);
        }
    }];
    datepicker.dateLabelColor = RGB(65, 188, 241);//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = RGB(65, 188, 241);//确定按钮的颜色
    datepicker.hideBackgroundYearLabel = YES;//隐藏背景年份文字
    [datepicker show];
}


- (void)onChooseViewDidSeletedOptions:(NSArray *)options chooseView:(nonnull RNChooseView *)chooseView {
    if ([chooseView isEqual:self.yingguangV]) {
        self.model.F_REAL = [options componentsJoinedByString:@","];
    } else {
        self.model.F_LABORATORY = [options componentsJoinedByString:@","];
    }
    if (self.callBack) {
        self.callBack(self.model);
    }
}

@end
