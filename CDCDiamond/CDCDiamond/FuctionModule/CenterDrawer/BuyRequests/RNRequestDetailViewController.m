//
//  RNRequestDetailViewController.m
//  RapNet
//
//  Created by Frank on 2020/3/16.
//  Copyright © 2020 lptechnology. All rights reserved.
//

#import "RNRequestDetailViewController.h"
#import "RNBuyRequestAddViewController.h"
#import "RNAddRequestStackView.h"

@interface RNRequestDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, copy) NSString *GUID;
@property (nonatomic, strong) RNBuyRequestAddModel *model;

@end

@implementation RNRequestDetailViewController

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
    [self reloadData];
    // Do any additional setup after loading the view.
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
    
    NSMutableArray *muarr = [NSMutableArray array];
    [muarr addObject:@{@"title" : RNLocalized(@"Shopping coding"), @"subtitle" : KFormat([Utility fomateString:self.model.F_PURCHASENO])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Shape"), @"subtitle" : KFormat([Utility fomateString:self.model.F_SHAPE])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Size"), @"subtitle" : [NSString  stringWithFormat:@"%@-%@", KFormat(self.model.F_SIZEMIN), KFormat(self.model.F_SIZE)]}];
    [muarr addObject:@{@"title" : RNLocalized(@"Color"), @"subtitle" : KFormat([Utility fomateString:self.model.F_COLOR1])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Clarity"), @"subtitle" : KFormat([Utility fomateString:self.model.F_CLARITY1])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Colorful Diamond"), @"subtitle" : ([KFormat(self.model.F_ISCZ) isEqualToString:@"1"])?@"YES":@"NO"}];
    [muarr addObject:@{@"title" : RNLocalized(@"Strength"), @"subtitle" : KFormat([Utility fomateString:self.model.F_FANCYCCOLORIMENSTFY])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Glorious"), @"subtitle" : KFormat([Utility fomateString:self.model.F_FANCYCCOLOROVERTONE])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Colorful Diamond color"), @"subtitle" : KFormat([Utility fomateString:self.model.F_FANCYCCOLOR1])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Cut"), @"subtitle" : KFormat([Utility fomateString:self.model.F_CUT])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Polishing"), @"subtitle" : KFormat([Utility fomateString:self.model.F_POLISHED])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Symmetry"), @"subtitle" : KFormat([Utility fomateString:self.model.F_SYMMETRICAL])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Price Type"), @"subtitle" : KFormat([Utility fomateString:self.model.F_PRICE])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Prices"), @"subtitle" : [NSString  stringWithFormat:@"%@-%@", KFormat(self.model.F_PRICETOTALMIN), KFormat(self.model.F_PRICETOTAL)]}];
    NSString *waisttj = @"-";
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
            waisttj = [muarr componentsJoinedByString:@","];
        }
    }
    
    [muarr addObject:@{@"title" : RNLocalized(@"Waistline"), @"subtitle" : KFormat(waisttj)}];
    [muarr addObject:@{@"title" : RNLocalized(@"Culet"), @"subtitle" : KFormat([Utility fomateString:self.model.F_LOWTIPTJ])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Dispose"), @"subtitle" : KFormat([Utility fomateString:self.model.F_HANDLE])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Table Percentage"), @"subtitle" : [NSString  stringWithFormat:@"%@-%@", KFormat(self.model.F_BOTTOMMIN), KFormat(self.model.F_BOTTOM)]}];
    [muarr addObject:@{@"title" : RNLocalized(@"Depth Percentage"), @"subtitle" : [NSString  stringWithFormat:@"%@-%@", KFormat(self.model.F_DEPTHPERCENTAGEMIN), KFormat(self.model.F_DEPTHPERCENTAGE)]}];
    [muarr addObject:@{@"title" : RNLocalized(@"Measure"), @"subtitle" : [NSString stringWithFormat:@"%d-%d*%d-%d*%d-%d",[self.model.F_CHANGMIN intValue], [self.model.F_CHANG intValue], [self.model.F_KUANMIN intValue], [self.model.F_KUAN intValue], [self.model.F_GAOMIN intValue], [self.model.F_GAO intValue]]}];
    [muarr addObject:@{@"title" : RNLocalized(@"Laboratory"), @"subtitle" : KFormat([Utility fomateString:self.model.F_LABORATORY])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Fluorescence reaction"), @"subtitle" : KFormat([Utility fomateString:self.model.F_REAL])}];
    [muarr addObject:@{@"title" : RNLocalized(@"Matches Only"), @"subtitle" : ([KFormat(self.model.F_DUI) isEqualToString:@"1"])?@"YES":@"NO"}];
    [muarr addObject:@{@"title" : RNLocalized(@"Annotation"),  @"subtitle" : KFormat([Utility fomateString:self.model.F_PLNGLUAN])}];
    NSString *startTime = [Utility fomateString:self.model.F_TIME];
    NSString *endTime = [Utility fomateString:self.model.F_EXPIRE];
    [muarr addObject:@{@"title" : RNLocalized(@"Date"), @"subtitle" : [NSString  stringWithFormat:@"%@", startTime.length>10?[startTime substringToIndex:10]:startTime]}];
    [muarr addObject:@{@"title" : RNLocalized(@"Due Date"), @"subtitle" : [NSString  stringWithFormat:@"%@", endTime.length>10?[endTime substringToIndex:10]:endTime]}];
    [muarr addObject:@{@"title" : RNLocalized(@"Seller Location"), @"subtitle" : KFormat([Utility fomateString:self.model.F_REAL])}];
    
    CGSize size1 = [Utility getTextString:[NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_CUT]] textFont:[UIFont systemFontOfSize:14.f] frameWidth:App_Frame_Width attributedString:nil];
    
    CGSize size2 = [Utility getTextString:[NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_POLISHED]] textFont:[UIFont systemFontOfSize:14.f] frameWidth:App_Frame_Width attributedString:nil];
    
    CGSize size3 = [Utility getTextString:[NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_SYMMETRICAL]] textFont:[UIFont systemFontOfSize:14.f] frameWidth:App_Frame_Width attributedString:nil];
    
    CGSize size4 = [Utility getTextString:[NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_WAISTTJ]] textFont:[UIFont systemFontOfSize:14.f] frameWidth:App_Frame_Width attributedString:nil];
    
    CGSize size5 = [Utility getTextString:[NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_LOWTIPTJ]] textFont:[UIFont systemFontOfSize:14.f] frameWidth:App_Frame_Width attributedString:nil];
    
    CGSize size6 = [Utility getTextString:[NSString  stringWithFormat:@"%@", [Utility fomateString:self.model.F_HANDLE]] textFont:[UIFont systemFontOfSize:14.f] frameWidth:App_Frame_Width attributedString:nil];
    
    NSArray *array = @[@(size1.width), @(size2.width), @(size3.width), @(size4.width), @(size5.width), @(size6.width)];
    
    CGFloat max = [[array valueForKeyPath:@"@max.floatValue"] floatValue];
    NSLog(@"%f", max);
    CGFloat newWidth = App_Frame_Width-24;
    if (max > App_Frame_Width/2.0-24) {
        newWidth = 24+App_Frame_Width/2.0+max+20;
    }
    
    self.scrollerView = [[UIScrollView alloc] init];
    self.scrollerView.backgroundColor = RGBOF(0xf5f5f5);
    [self.view addSubview:self.scrollerView];
    
    [self.scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
    
    for (int i = 0; i < muarr.count; i++) {
        NSDictionary *source = [muarr objectAtIndex:i];
        RNAddRequestStackView *stackView = [[RNAddRequestStackView alloc] initWithFrame:CGRectMake(12, 40*i, newWidth, 40) title:source[@"title"] subTitle:source[@"subtitle"]];
        [self.scrollerView addSubview:stackView];
    }
    [self.scrollerView setContentSize:CGSizeMake(newWidth, 40*muarr.count)];
    
    if (self.eidteEnable) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RNLocalized(@"Edit") style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick)];
    }
}


- (void)rightBarButtonItemClick {
    NSString *waisttj = @"";
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
            waisttj = [muarr componentsJoinedByString:@","];
        }
    }
    RNBuyRequestAddModel *model = self.model;
    model.F_WAISTTJ = waisttj;
    RNBuyRequestAddViewController *vc = [[RNBuyRequestAddViewController alloc] init];
    vc.isEdite = YES;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
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
