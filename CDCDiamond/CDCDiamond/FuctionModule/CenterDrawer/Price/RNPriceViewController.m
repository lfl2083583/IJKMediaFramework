//
//  RNPriceViewController.m
//  RapNet
//
//  Created by tjl on 2019/10/10.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNPriceViewController.h"
#import "ZTFormListView.h"
#import "RNPriceListModel.h"
#import "RNExchangeScreenModel.h"
#import "RNCaculatorViewController.h"
#import "RNSearchJewelViewController.h"
#import "FKGPopOption.h"
#import "PopoverView.h"

@interface RNPriceViewController ()<ZTFormListViewDelegate>

@property (nonatomic, strong) ZTFormListView *formView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, assign) int priceType;

@property (nonatomic, assign) int shape;
@property (nonatomic, assign) int type;
@property (nonatomic, assign) int sizeIndex;
@property (nonatomic, copy) NSString *shapeString;

@end

@implementation RNPriceViewController

- (instancetype)initIsFromSideMenue:(BOOL)isFromSideMenue priceType:(int)priceType {
    
    self = [super initIsFromSideMenue:isFromSideMenue];
    if (self) {
        _priceType = priceType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"价格列表";
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    UIButton *leftBtn = [UIButton yz_buttonWithTitle:@"" titleColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_MediumFontOfSize:14]];
    leftBtn.frame = CGRectMake(0, 0, 120, 40);
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [UIButton yz_buttonWithTitle:@"" titleColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_MediumFontOfSize:14]];
    rightBtn.frame = CGRectMake(120, 0, 120, 40);
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:leftBtn];
    [titleView addSubview:rightBtn];
    self.leftBtn = leftBtn;
    self.rightBtn = rightBtn;
    
    self.navigationItem.titleView = titleView;
    [self.view addSubview:self.formView];//
    
    
    if (_priceType == 0) {
        self.type = 12;
        self.shape = 1;
        [self setleftBtnTitle:@"圆形"];
        [self setrightBtnTitle:@"1.00 - 1.49CT"];
        [self.formView setTopMenus:@[@"",@"IF",@"VVS1",@"VVS2",@"VS1",@"VS2",@"SI1",@"SI2",@"SI3",@"I1",@"I2",@"I3"] sideMenus:@[@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M"]];
        [self requestPrice];
    } else {
        self.type = 11;
        self.shapeString = @"Round";
        self.sizeIndex = -1;
        [self setleftBtnTitle:@"Round"];
        [self setrightBtnTitle:@"1.00 - 1.49CT"];
        [self.formView setTopMenus:@[@"",@"IF",@"VVS1",@"VVS2",@"VS1",@"VS2",@"SI1",@"SI2",@"I1",@"I2"] sideMenus:@[@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M"]];
        [self requestExchangeScreen];
    }
    
    
    if (@available(iOS 11.0, *)) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.right.mas_equalTo(0);
            }];
        });
    }
}

- (void)setleftBtnTitle:(NSString *)title {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.bounds = CGRectMake(0, -2, 12, 12);
    attach.image = [UIImage imageNamed:@"nav_icon_arrowdown"];
    NSAttributedString *strAtt = [NSAttributedString attributedStringWithAttachment:attach];
    [attributedString appendAttributedString:strAtt];
    [self.leftBtn setAttributedTitle:attributedString forState:UIControlStateNormal];
}

- (void)setrightBtnTitle:(NSString *)title {
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedString2 appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    NSTextAttachment *attach2 = [[NSTextAttachment alloc] init];
    attach2.bounds = CGRectMake(0, -2, 12, 12);
    attach2.image = [UIImage imageNamed:@"nav_icon_arrowdown"];
    NSAttributedString *strAtt2 = [NSAttributedString attributedStringWithAttachment:attach2];
    [attributedString2 appendAttributedString:strAtt2];
    [self.rightBtn setAttributedTitle:attributedString2 forState:UIControlStateNormal];
}

- (void)leftBtnClick:(UIButton *)sender {
    __weak typeof(self)weakself = self;
    NSArray *titles = nil;
    if (_priceType == 0) {
        titles = @[@"圆形", @"异形"];
    } else {
        titles = @[@"Round", @"Princess", @"Radiant", @"Emerald", @"Sq. Emerald", @"Pear", @"Cushion (all)", @"Cushion Brilliant",
        @"Cushion Modified", @"Asscher", @"Assche Sq. Emer", @"Baguette", @"Briolette", @"Bullets", @"European Cut", @"Flanders", @"Half Moon", @"Heart", @"Hexagonal", @"Kite", @"Lozenge",
        @"Marquise", @"Octagonal", @"Old Mine", @"Other", @"Oval", @"Pentagonal", @"Rose", @"Round", @"Shield", @"Square", @"Star", @"Tapered Baguette", @"Trapezoid", @"Triangular", @"Trilliant"];
    }
    PopoverView *popveView = [PopoverView popoverView];
    popveView.showShade = YES;
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in titles) {
        PopoverAction *action  = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action) {
            [weakself setleftBtnTitle:action.title];
            weakself.shapeString = action.title;
            weakself.shape = (int)[titles indexOfObject:action.title]+1;
            if (weakself.priceType == 0) {
                [weakself requestPrice];
            } else {
                [weakself requestExchangeScreen];
            }
        }];
        [array addObject:action];
    }
    [popveView showToView:sender withActions:array];
}

- (void)rightBtnClick:(UIButton *)sender {
    __weak typeof(self)weakself = self;
    NSArray *titles = @[@".01 - .03CT", @".04 - .07CT",
           @".08 - .14CT", @".15 - .17CT", @".18 - .22CT", @".23-.29CT",@".30 - .39CT",
           @".40 - .49CT", @".50 - .69CT", @".70 - .89CT", @".90 - .99CT",
    @"1.50 - 1.99CT", @"2.00 - 2.99CT", @"3.00 - 3.99CT", @"4.00 - 4.99CT",
           @"5.00 - 5.99CT", @"10.00 - 10.99CT"];
    PopoverView *popveView = [PopoverView popoverView];
    popveView.showShade = YES;
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in titles) {
        PopoverAction *action  = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action) {
            [weakself setrightBtnTitle:action.title];
            weakself.type = (int)[titles indexOfObject:action.title]+1;
            if (weakself.priceType == 0) {
                [weakself requestPrice];
            } else {
                [weakself requestExchangeScreen];
            }
        }];
        [array addObject:action];
    }
    [popveView showToView:sender withActions:array];
}


// 价格列表
- (void)requestPrice {
    __weak typeof(self)weakself = self;
    [HttpRequestTool postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/TradingScreenServlet?method=getPricetable")
                                            
                            parameters:@{@"papaport" : @(self.type), @"shape" : @(self.shape)} success:^(id responseObject, ResponseState state) {
        NSArray *array = responseObject;
        [weakself.dataArray removeAllObjects];
        for (NSDictionary *dict in array) {
            RNPriceListModel *model = [RNPriceListModel mj_objectWithKeyValues:dict];
            [weakself.dataArray addObject:model];
        }
        [weakself sortPrice];
        
    }
                                              
                               failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

// 交易屏幕
- (void)requestExchangeScreen {
    __weak typeof(self)weakself = self;
    [YZHubTool showLoadingStatus:RNLocalized(@"Loading")];
    [self.dataArray removeAllObjects];
    [self initExchangeScreenForm];
    [HttpRequestTool postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/TradingScreenServlet?method=onloadAppTradingScreen")
                                            
                            parameters:@{@"type" : @(self.type), @"shape" : self.shapeString}
                                           
                               success:^(id responseObject, ResponseState state) {
        [YZHubTool hide];
        NSArray *array = responseObject[@"data"];
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            [weakself.dataArray removeAllObjects];
            for (NSDictionary *dict in array) {
                NSArray *array = [dict objectForKey:@"hang"];
                NSArray *list = [RNExchangeScreenModel mj_objectArrayWithKeyValuesArray:array];
                [weakself.dataArray addObject:list];
            }
            [weakself handleExchangeScreenData];
            [weakself sortExchangeScreenPrice];
        } else {
            [YZHubTool showText:RNLocalized(@"No data temporarily, unable to view")];
        }
    }
                                               
                               failure:^(NSError *error) {
        [YZHubTool hide];
        NSLog(@"%@", error);
    }];
}

- (void)handleExchangeScreenData {
    if (self.dataArray.count < 9) {
        NSInteger count = 9-self.dataArray.count;
        for (int i = 0; i < count; i++) {
            NSMutableArray *array = [NSMutableArray array];
            for (int j = 0; j < 11; j++) {
                RNExchangeScreenModel *model = [[RNExchangeScreenModel alloc] init];
                model.F_PRICE = @"0.00";
                [array addObject:model];
            }
            [self.dataArray addObject:array];
        }
    }
}

- (void)initExchangeScreenForm {
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        NSMutableArray *array = [NSMutableArray array];
        for (int j = 0; j < 11; j++) {
            [array addObject:@""];
        }
        [datas addObject:array];
    }
    
    [self.formView setDataSource:datas];
}

- (void)sortPrice {
    NSMutableArray *dataSource = [NSMutableArray array];
    for (RNPriceListModel *model in self.dataArray) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:model.F_IF];
        [array addObject:model.F_VVS1];
        [array addObject:model.F_VVS2];
        [array addObject:model.F_VS1];
        [array addObject:model.F_VS2];
        [array addObject:model.F_SI1];
        [array addObject:model.F_SI2];
        [array addObject:model.F_SI3];
        [array addObject:model.F_I1];
        [array addObject:model.F_I2];
        [array addObject:model.F_I3];
        [dataSource addObject:array];
    }
    
    [self.formView setDataSource:dataSource];
}

- (void)sortExchangeScreenPrice {
    [self.formView setDataSource:self.dataArray];
}

#pragma mark - ZTFormListViewDelegate

- (void)onDidSeletedFormListCell:(NSIndexPath *)indexPath {
    NSArray *array = self.dataArray[indexPath.section];
    if (array && [array isKindOfClass:[NSArray class]] && array.count) {
        RNExchangeScreenModel *model = [array objectAtIndex:indexPath.row];
        if (model && [model isKindOfClass:[RNExchangeScreenModel class]] && model.F_PRICE && [model.F_PRICE integerValue] > 0) {
            RNSearchJewelModel *jewelModel = [[RNSearchJewelModel alloc] init];
            /**净度*/
            NSArray *list = @[@"IF",@"VVS1",@"VVS2",@"VS1",@"VS2",@"SI1",@"SI2",@"SI3",@"I1",@"I2",@"I3"];
            jewelModel.clarity = list[indexPath.row];
            
            /**颜色*/
            NSArray *colorList = @[@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M"];
            jewelModel.color = colorList[indexPath.section];
            
//            /**对称*/
//            if (model.F_JIANDINGSUO) {
//               jewelModel.symmetrical = KFormat(model.F_JIANDINGSUO);
//            }
            
            
            /**形状*/
            if (model.F_SHAPE) {
                jewelModel.shape = self.shapeString;
            }
            
            /**尺寸*/
            NSArray *array = @[@"0.01-0.03", @"0.04-0.07",@"0.08-0.14", @"0.15-0.17", @"0.18-0.22", @"0.23-0.29",@"0.30-0.39",@"0.40-0.49", @"0.50-0.69", @"0.70-0.89", @"0.90-0.99",@"1.50-1.99", @"2.00-2.99", @"3.00-3.99", @"4.00-4.99",@"5.00-5.99", @"10.00-10.99"];
            if (self.sizeIndex < 0) {
                jewelModel.maxsize = @"1.49";
                jewelModel.size = @"1.00";
            } else {
                NSString *sizeString = array[self.sizeIndex];
                NSArray *sizeArray = [sizeString componentsSeparatedByString:@"-"];
                jewelModel.maxsize = sizeArray[1];
                jewelModel.size = sizeArray[0];
            }
        
            __weak typeof(self)weakself = self;
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:RNLocalized(@"Open the...") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *searchAction = [UIAlertAction actionWithTitle:RNLocalized(@"Looking for diamonds") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                RNSearchJewelViewController *searchJewelVC = [[RNSearchJewelViewController alloc] init];
                searchJewelVC.title = RNLocalized(@"Looking for diamonds");
                searchJewelVC.jewelModel = jewelModel;
                [weakself.navigationController pushViewController:searchJewelVC animated:YES];
            }];
            [alertVc addAction:searchAction];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:RNLocalized(@"Cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertVc addAction:cancelAction];
            [self presentViewController:alertVc animated:YES completion:nil];
            alertVc.view.tintColor =  [UIColor greenColor];
        }
        
    }
}


- (ZTFormListView *)formView
{
    if (!_formView) {
        _formView = [[ZTFormListView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height)];
        _formView.delegate = self;
    }
    return _formView;
}

@end
