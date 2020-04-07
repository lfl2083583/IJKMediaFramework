//
//  RNBuyRequestDetalViewController.m
//  RapNet
//
//  Created by jt on 2019/11/6.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNBuyRequestDetalViewController.h"
#import "RNBuyRequestModel.h"
#import "RNBuyRequestAddViewController.h"

@interface RNBuyRequestDetalViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;


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
@property (weak, nonatomic) IBOutlet UILabel *LB15;
@property (weak, nonatomic) IBOutlet UILabel *LB116;
@property (weak, nonatomic) IBOutlet UILabel *LB17;
@property (weak, nonatomic) IBOutlet UILabel *LB18;
@property (weak, nonatomic) IBOutlet UILabel *LB19;
@property (weak, nonatomic) IBOutlet UILabel *LB20;
@property (weak, nonatomic) IBOutlet UILabel *LB21;
@property (weak, nonatomic) IBOutlet UILabel *LB22;
@property (weak, nonatomic) IBOutlet UILabel *LB23;
@property (weak, nonatomic) IBOutlet UILabel *LB24;
@property (weak, nonatomic) IBOutlet UILabel *LB25;
@property (weak, nonatomic) IBOutlet UILabel *LB26;
@property (weak, nonatomic) IBOutlet UILabel *LB27;


@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UILabel *lb5;
@property (weak, nonatomic) IBOutlet UILabel *lb6;
@property (weak, nonatomic) IBOutlet UILabel *lb7;
@property (weak, nonatomic) IBOutlet UILabel *lb8;
@property (weak, nonatomic) IBOutlet UILabel *lb9;
@property (weak, nonatomic) IBOutlet UILabel *lb10;
@property (weak, nonatomic) IBOutlet UILabel *lb11;
@property (weak, nonatomic) IBOutlet UILabel *lb12;
@property (weak, nonatomic) IBOutlet UILabel *lb13;
@property (weak, nonatomic) IBOutlet UILabel *lb14;
@property (weak, nonatomic) IBOutlet UILabel *lb15;
@property (weak, nonatomic) IBOutlet UILabel *lb16;
@property (weak, nonatomic) IBOutlet UILabel *lb17;
@property (weak, nonatomic) IBOutlet UILabel *lb18;
@property (weak, nonatomic) IBOutlet UILabel *lb19;
@property (weak, nonatomic) IBOutlet UILabel *lb20;
@property (weak, nonatomic) IBOutlet UILabel *lb21;
@property (weak, nonatomic) IBOutlet UILabel *lb22;
@property (weak, nonatomic) IBOutlet UILabel *lb23;
@property (weak, nonatomic) IBOutlet UILabel *lb24;
@property (weak, nonatomic) IBOutlet UILabel *lb25;
@property (weak, nonatomic) IBOutlet UILabel *lb26;
@property (weak, nonatomic) IBOutlet UILabel *lb27;
@property (weak, nonatomic) IBOutlet UIView *contentView;




@property (nonatomic, copy) NSString *GUID;
@property (nonatomic, strong) RNBuyRequestAddModel *model;

@end

@implementation RNBuyRequestDetalViewController


- (instancetype)initWithGUID:(NSString *)GUID  eidteEnable:(BOOL)eidteEnable {
    self = [super init];
    if (self) {
        _GUID  = GUID;
        _eidteEnable = eidteEnable;
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Request Detail");
    [self setupBaseUI];
    self.scrollerView.contentSize = CGSizeMake(App_Frame_Width, 1213);
    self.view.backgroundColor = UIColorFromRGB(0xf8f8f8);
    [self reloadData];
//    if (self.eidteEnable == YES) {
//        
//    }
}

- (void)setupBaseUI {
    self.lb1.text = RNLocalized(@"Shopping coding");
    self.lb2.text = RNLocalized(@"Shape");
    self.lb3.text = RNLocalized(@"Size");
    self.lb4.text = RNLocalized(@"Color");
    self.lb5.text = RNLocalized(@"Clarity");
    self.lb6.text = RNLocalized(@"Colorful Diamond");
    self.lb7.text = RNLocalized(@"Request_Strength");
    self.lb8.text = RNLocalized(@"Request_Overtone");
    self.lb9.text = RNLocalized(@"Colorful Diamond color");
    self.lb10.text = RNLocalized(@"Cut");
    self.lb11.text = RNLocalized(@"Polishing");
    self.lb12.text = RNLocalized(@"Symmetry");
    self.lb13.text = RNLocalized(@"Price Type");
    self.lb14.text = RNLocalized(@"Prices");
    self.lb15.text = RNLocalized(@"Waistline");
    self.lb16.text = RNLocalized(@"Culet");
    self.lb17.text = RNLocalized(@"Dispose");
    self.lb18.text = RNLocalized(@"Table Percentage");
    self.lb19.text = RNLocalized(@"Depth Percentage");
    self.lb20.text = RNLocalized(@"Measure");
    self.lb21.text = RNLocalized(@"Laboratory");
    self.lb22.text = RNLocalized(@"Fluorescence reaction");
    self.lb23.text = RNLocalized(@"Matches Only");
    self.lb24.text = RNLocalized(@"Annotation");
    self.lb25.text = RNLocalized(@"Date");
    self.lb26.text = RNLocalized(@"Due Date");
    self.lb27.text = RNLocalized(@"Seller Location");
}


- (void)rightBarButtonItemClick {
    //RNBuyRequestAddModel *model = [RNBuyRequestAddModel mj_objectWithKeyValues:[self.model mj_keyValues]];
    RNBuyRequestAddViewController *vc = [[RNBuyRequestAddViewController alloc] init];
    vc.isEdite = YES;
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)reloadData {
    __weak typeof(self)weakself = self;
    [self.dataArray removeAllObjects];
    [HttpRequestTool  postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/PurchaseServlet?method=allList") parameters:@{@"guid" : self.GUID} success:^(id responseObject, ResponseState state) {
        NSLog(@"%@", responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSArray class]] && [responseObject count]) {
            weakself.model = [RNBuyRequestAddModel mj_objectWithKeyValues:[responseObject firstObject]];
        }
        [weakself refreshUI];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:userToken]);
    }];
}


- (void)refreshUI {
    if (self.model.F_WAISTTJ && KFormat(self.model.F_WAISTTJ).length) {
        NSMutableArray *muarr = [NSMutableArray array];
        NSArray *array = [self.model.F_WAISTTJ componentsSeparatedByString:@","];
        NSArray *list = @[@"Polished", @"Faceted", @"Bruted"];
        for (id obj in array) {
            if ([KFormat(obj) intValue] < list.count) {
                [muarr addObject:[list objectAtIndex:[KFormat(obj) intValue]]];
            }
        }
        if (muarr.count) {
            NSString *waisttj = [muarr componentsJoinedByString:@","];
            self.model.F_WAISTTJ = waisttj;
        }
    }
    
    self.LB1.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_PURCHASENO]];//编号
    self.LB2.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_SHAPE]];//形状
    self.LB3.text = [NSString  stringWithFormat:@"%@-%@", KFormat(self.model.F_SIZEMIN), KFormat(self.model.F_SIZE)];//大小
    self.LB4.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_COLOR1]];//颜色
    self.LB5.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_CLARITY1]];//净度
    self.LB6.text = ([KFormat(self.model.F_ISCZ) isEqualToString:@"1"])?@"YES":@"NO";//彩钻
    self.LB7.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_FANCYCCOLORIMENSTFY]];//强度
    self.LB8.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_FANCYCCOLOROVERTONE]];//光彩
    self.LB9.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_FANCYCCOLOR1]];//彩钻颜色
    self.LB10.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_CUT]];//切割
    self.LB11.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_POLISHED]];//抛光
    self.LB12.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_SYMMETRICAL]];//对称
    self.LB13.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_PRICE]];//价格类型
    self.LB14.text = [NSString  stringWithFormat:@"%@-%@", KFormat(self.model.F_PRICETOTALMIN), KFormat(self.model.F_PRICETOTAL)];//价格
    self.LB15.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_WAISTTJ]];//腰围
    self.LB116.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_LOWTIPTJ]];//尖底
    self.LB17.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_HANDLE]];//处理
    self.LB18.text = [NSString  stringWithFormat:@"%@-%@", KFormat(self.model.F_BOTTOMMIN), KFormat(self.model.F_BOTTOM)];//台面百分比
    self.LB19.text = [NSString  stringWithFormat:@"%@-%@", KFormat(self.model.F_DEPTHPERCENTAGEMIN), KFormat(self.model.F_DEPTHPERCENTAGE)];//深度百分比
    self.LB20.text = [NSString stringWithFormat:@"%d-%d*%d-%d*%d-%d",[self.model.F_CHANGMIN intValue], [self.model.F_CHANG intValue], [self.model.F_KUANMIN intValue], [self.model.F_KUAN intValue], [self.model.F_GAOMIN intValue], [self.model.F_GAO intValue]];
    
    self.LB21.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_LABORATORY]];//实验室
    self.LB22.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_REAL]];//荧光反映/
    self.LB23.text = ([KFormat(self.model.F_DUI) isEqualToString:@"1"])?@"YES":@"NO";//仅限对
    self.LB24.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_PLNGLUAN]];//注释
    NSString *startTime = [Utility fomateString:self.model.F_TIME];
    NSString *endTime = [Utility fomateString:self.model.F_EXPIRE];
    self.LB25.text = [NSString  stringWithFormat:@"%@", startTime.length>10?[startTime substringToIndex:10]:startTime];//日期
    self.LB26.text = [NSString  stringWithFormat:@"%@", endTime.length>10?[endTime substringToIndex:10]:endTime];//到期
    self.LB27.text = [NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_REAL]];//卖家位置
    
    if (self.eidteEnable) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RNLocalized(@"Edit") style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick)];
    }
//    CGFloat orginalWidth = self.LB9.width;
//    CGFloat maxWidth = 0;
//
//    CGSize size1 = [Utility getTextString:self.LB10.text textFont:[UIFont systemFontOfSize:14.f] frameWidth:App_Frame_Width attributedString:nil];
//    [self.LB10 setWidth:size1.width+20];
//    [self.LB10 setX:self.LB7.x];
//    maxWidth = MAX(orginalWidth, size1.width);
//
//    CGSize size2 = [Utility getTextString:self.LB11.text textFont:[UIFont systemFontOfSize:14.f] frameWidth:App_Frame_Width attributedString:nil];
//    [self.LB11 setWidth:size2.width+20];
//    [self.LB11 setX:self.LB9.x];
//    maxWidth = MAX(maxWidth, size2.width);
//
//    CGSize size3 = [Utility getTextString:self.LB12.text textFont:[UIFont systemFontOfSize:14.f] frameWidth:App_Frame_Width attributedString:nil];
//    [self.LB12 setWidth:size3.width+20];
//    [self.LB12 setX:self.LB9.x];
//    maxWidth = MAX(maxWidth, size3.width);
//
//    CGSize size4 = [Utility getTextString:self.LB15.text textFont:[UIFont systemFontOfSize:14.f] frameWidth:App_Frame_Width attributedString:nil];
//    [self.LB15 setWidth:size4.width+20];
//    [self.LB15 setX:self.LB9.x];
//    maxWidth = MAX(maxWidth, size4.width);
//
//    CGSize size5 = [Utility getTextString:self.LB116.text textFont:[UIFont systemFontOfSize:14.f] frameWidth:App_Frame_Width attributedString:nil];
//    [self.LB116 setWidth:size5.width+20];
//    [self.LB116 setX:self.LB9.x];
//    maxWidth = MAX(maxWidth, size5.width);
    
//    CGSize size6 = [Utility getTextString:self.LB17.text textFont:[UIFont systemFontOfSize:14.f] frameWidth:App_Frame_Width attributedString:nil];
//    [self.LB17 setWidth:size6.width+20];
//    [self.LB17 setX:self.LB9.x];
//    maxWidth = MAX(maxWidth, size6.width);
//    
//    if (maxWidth > orginalWidth) {
//        CGFloat contentWidth = App_Frame_Width+maxWidth-orginalWidth+60;
//        [self.scrollerView setContentSize:CGSizeMake(contentWidth, 1213)];
//        [self.contentView setWidth:contentWidth-24];
//    }
}

- (BOOL)isString:(NSString *)astring {
    if (astring && [astring isKindOfClass:[NSString class]] && astring.length) {
        return YES;
    } else {
        return NO;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
