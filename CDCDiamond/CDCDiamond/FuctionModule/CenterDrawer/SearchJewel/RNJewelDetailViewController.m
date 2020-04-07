//
//  RNJewelDetailViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/31.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNJewelDetailViewController.h"
#import "RNCaculatorViewController.h"
#import "RNJewelDetailModel.h"
#import <AVKit/AVKit.h>
#import "RNLanguageManager.h"
#import "RootWebViewController.h"

@interface RNJewelDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *containerView2;
@property (weak, nonatomic) IBOutlet UIView *containerView3;
@property (weak, nonatomic) IBOutlet UIView *containerView4;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *xinzhuangLB;
@property (weak, nonatomic) IBOutlet UILabel *moguangLB;
@property (weak, nonatomic) IBOutlet UILabel *daxiaoLB;
@property (weak, nonatomic) IBOutlet UILabel *duichengLB;
@property (weak, nonatomic) IBOutlet UILabel *yanseLB;
@property (weak, nonatomic) IBOutlet UILabel *yinguangLB;
@property (weak, nonatomic) IBOutlet UILabel *jinduLB;
@property (weak, nonatomic) IBOutlet UILabel *shiyanshiLB;
@property (weak, nonatomic) IBOutlet UILabel *qiegeLB;
@property (weak, nonatomic) IBOutlet UILabel *jiagectLB;
@property (weak, nonatomic) IBOutlet UILabel *jiageperLB;
@property (weak, nonatomic) IBOutlet UILabel *jiagetoLB;
@property (weak, nonatomic) IBOutlet UIButton *emailBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIButton *reportBtn;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (weak, nonatomic) IBOutlet UIButton *sellerBtn;
@property (weak, nonatomic) IBOutlet UIButton *jewelBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;
@property (weak, nonatomic) IBOutlet UILabel *jewelTitleLB;

@property (weak, nonatomic) IBOutlet UILabel *IDLB;
@property (weak, nonatomic) IBOutlet UILabel *compayLB;
@property (weak, nonatomic) IBOutlet UILabel *userNameLB;
@property (weak, nonatomic) IBOutlet UILabel *phoneLB;
@property (weak, nonatomic) IBOutlet UILabel *postionLB;
@property (weak, nonatomic) IBOutlet UILabel *scoreLB;

@property (weak, nonatomic) IBOutlet UILabel *stockLB;
@property (weak, nonatomic) IBOutlet UILabel *updateLB;
@property (weak, nonatomic) IBOutlet UILabel *useLB;
@property (weak, nonatomic) IBOutlet UILabel *locationLB;

@property (weak, nonatomic) IBOutlet UILabel *deepLB;
@property (weak, nonatomic) IBOutlet UILabel *deskLB;
@property (weak, nonatomic) IBOutlet UILabel *sizeLB;

@property (weak, nonatomic) IBOutlet UILabel *jianLB;


@property (weak, nonatomic) IBOutlet UILabel *certificateLB;
@property (weak, nonatomic) IBOutlet UILabel *certificateContentLB;
@property (weak, nonatomic) IBOutlet UILabel *shadeContentLB;


@property (weak, nonatomic) IBOutlet UILabel *bottomLB;
@property (weak, nonatomic) IBOutlet UILabel *yaoLB;
@property (weak, nonatomic) IBOutlet UILabel *topLB;
@property (weak, nonatomic) IBOutlet UILabel *controlLB;
@property (weak, nonatomic) IBOutlet UILabel *aboutLB;
@property (weak, nonatomic) IBOutlet UILabel *xingmianLB;
@property (weak, nonatomic) IBOutlet UILabel *biliLB;
@property (weak, nonatomic) IBOutlet UILabel *inclutionLB;
@property (weak, nonatomic) IBOutlet UILabel *shadeLB;
@property (weak, nonatomic) IBOutlet UILabel *BrandLB;
@property (weak, nonatomic) IBOutlet UILabel *symbolsLB;
@property (weak, nonatomic) IBOutlet UILabel *gongyiLB;
@property (weak, nonatomic) IBOutlet UILabel *baogaoLB;

@property (weak, nonatomic) IBOutlet UIView *drawView1;
@property (weak, nonatomic) IBOutlet UIView *childview1;
@property (weak, nonatomic) IBOutlet UIView *childview2;
@property (weak, nonatomic) IBOutlet UIView *childview3;
@property (weak, nonatomic) IBOutlet UIView *childview4;
@property (weak, nonatomic) IBOutlet UIView *childview5;
@property (weak, nonatomic) IBOutlet UIView *childview6;
@property (weak, nonatomic) IBOutlet UIView *childview7;

@property (weak, nonatomic) IBOutlet UIView *drawView2;
@property (weak, nonatomic) IBOutlet UIView *childview2_1;
@property (weak, nonatomic) IBOutlet UIView *childview2_2;
@property (weak, nonatomic) IBOutlet UIView *childview2_3;
@property (weak, nonatomic) IBOutlet UIView *childview2_4;
@property (weak, nonatomic) IBOutlet UIView *childview2_5;


@property (weak, nonatomic) IBOutlet UIView *drawView3;
@property (weak, nonatomic) IBOutlet UIView *childview3_1;
@property (weak, nonatomic) IBOutlet UIView *childview3_2;
@property (weak, nonatomic) IBOutlet UIView *childview3_3;
@property (weak, nonatomic) IBOutlet UIView *childview3_4;
@property (weak, nonatomic) IBOutlet UIView *childview3_5;
@property (weak, nonatomic) IBOutlet UIView *childview3_6;
@property (weak, nonatomic) IBOutlet UIView *childview3_7;
@property (weak, nonatomic) IBOutlet UIView *childview3_8;
@property (weak, nonatomic) IBOutlet UIView *childview3_9;
@property (weak, nonatomic) IBOutlet UIView *childview3_10;
@property (weak, nonatomic) IBOutlet UIView *childview3_11;
@property (weak, nonatomic) IBOutlet UIView *childview3_12;
@property (weak, nonatomic) IBOutlet UIView *childview3_13;
@property (weak, nonatomic) IBOutlet UIView *childview3_14;
@property (weak, nonatomic) IBOutlet UIView *childview3_15;
@property (weak, nonatomic) IBOutlet UIView *childview3_16;
@property (weak, nonatomic) IBOutlet UIView *childview3_17;
@property (weak, nonatomic) IBOutlet UIView *childview3_18;

@property (weak, nonatomic) IBOutlet UIView *drawView4;
@property (weak, nonatomic) IBOutlet UIView *childview4_2;
@property (weak, nonatomic) IBOutlet UITextView *childview4_1;
@property (weak, nonatomic) IBOutlet UILabel *cashLB1;
@property (weak, nonatomic) IBOutlet UILabel *cashLB2;
@property (weak, nonatomic) IBOutlet UILabel *cashLB3;
@property (weak, nonatomic) IBOutlet UILabel *handleLB;

@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) RNJewelDetailModel *model;
@property (nonatomic, assign) BOOL isSaved;

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


@property (weak, nonatomic) IBOutlet UILabel *LB16;
@property (weak, nonatomic) IBOutlet UILabel *LB17;
@property (weak, nonatomic) IBOutlet UILabel *LB18;
@property (weak, nonatomic) IBOutlet UILabel *videoLB;

@property (weak, nonatomic) IBOutlet UILabel *LB19;
@property (weak, nonatomic) IBOutlet UILabel *LB20;
@property (weak, nonatomic) IBOutlet UILabel *LB21;
@property (weak, nonatomic) IBOutlet UILabel *LB22;
@property (weak, nonatomic) IBOutlet UILabel *LB23;
@property (weak, nonatomic) IBOutlet UILabel *LB24;
@property (weak, nonatomic) IBOutlet UILabel *LB25;

@property (weak, nonatomic) IBOutlet UILabel *LB26;


@property (weak, nonatomic) IBOutlet UILabel *LB27;
@property (weak, nonatomic) IBOutlet UILabel *LB28;
@property (weak, nonatomic) IBOutlet UILabel *LB29;
@property (weak, nonatomic) IBOutlet UILabel *LB30;

@property (weak, nonatomic) IBOutlet UILabel *LB31;
@property (weak, nonatomic) IBOutlet UILabel *LB32;
@property (weak, nonatomic) IBOutlet UILabel *LB33;
@property (weak, nonatomic) IBOutlet UILabel *LB34;
@property (weak, nonatomic) IBOutlet UILabel *LB35;
@property (weak, nonatomic) IBOutlet UILabel *LB36;
@property (weak, nonatomic) IBOutlet UILabel *LB37;
@property (weak, nonatomic) IBOutlet UILabel *LB38;
@property (weak, nonatomic) IBOutlet UILabel *LB39;
@property (weak, nonatomic) IBOutlet UILabel *LB40;
@property (weak, nonatomic) IBOutlet UILabel *LB41;
@property (weak, nonatomic) IBOutlet UILabel *LB42;
@property (weak, nonatomic) IBOutlet UILabel *LB43;
@property (weak, nonatomic) IBOutlet UILabel *LB44;
@property (weak, nonatomic) IBOutlet UILabel *LB45;

@property (weak, nonatomic) IBOutlet UIImageView *icon_email;
@property (weak, nonatomic) IBOutlet UIImageView *icon_check;
@property (weak, nonatomic) IBOutlet UIImageView *icon_report;
@property (weak, nonatomic) IBOutlet UIImageView *icon_video;
@property (weak, nonatomic) IBOutlet UILabel *incluLB;
@property (weak, nonatomic) IBOutlet UILabel *shadLB;
@property (weak, nonatomic) IBOutlet UILabel *keytoLB;



@property (nonatomic, assign) CGFloat draw3Height;
@end

@implementation RNJewelDetailViewController

- (void)setupBaseUI {
    self.LB1.text = RNLocalized(@"Contact The Seller");
    self.LB2.text = RNLocalized(@"Caculator");
    self.LB3.text = RNLocalized(@"Share");
    self.LB4.text = RNLocalized(@"Shape");
    self.LB5.text = RNLocalized(@"daxiao");
    self.LB6.text = RNLocalized(@"Color");
    self.LB7.text = RNLocalized(@"Clarity");
    self.LB8.text = RNLocalized(@"Cut");
    self.LB9.text = RNLocalized(@"Polishing");
    self.LB10.text = RNLocalized(@"Symmetry");
    self.LB11.text = RNLocalized(@"Fluorescence");
    self.LB12.text = RNLocalized(@"Laboratory");
    self.LB13.text = RNLocalized(@"Dispose");
    self.LB14.text = RNLocalized(@"Prices");
    self.LB26.text = RNLocalized(@"Prices");
    self.LB15.text = RNLocalized(@"$Total");
   
    self.LB19.text = RNLocalized(@"Other information");
    self.LB20.text = RNLocalized(@"RapID/Code");
    self.LB21.text = RNLocalized(@"Company Name");
    self.LB22.text = RNLocalized(@"User Name");
    self.LB23.text = RNLocalized(@"Phone");
    self.LB24.text = RNLocalized(@"Seller Location");
    self.LB25.text = RNLocalized(@"Total Score");
 
    self.LB27.text = RNLocalized(@"Stock");
    self.LB28.text = RNLocalized(@"Updated");
    self.LB29.text = RNLocalized(@"Availability");
    self.LB30.text = RNLocalized(@"Loction");
    self.LB31.text = RNLocalized(@"Seller Details");
    self.LB32.text = RNLocalized(@"Depth");
    self.LB33.text = RNLocalized(@"Table");
    self.LB34.text = RNLocalized(@"Measure");
    self.LB35.text = RNLocalized(@"Sharp Bottom");
    self.LB36.text = RNLocalized(@"Waistline");
    self.LB37.text = RNLocalized(@"Crown");
    self.LB38.text = RNLocalized(@"Pavilion");
    self.LB39.text = RNLocalized(@"After Processing");
    self.LB40.text = RNLocalized(@"Inclusions");
    //self.LB41.font = ([RNLanguageManager shareManager].languageType == 2)?[UIFont boldSystemFontOfSize:10.f]:[UIFont boldSystemFontOfSize:14.f];
    self.LB41.text = RNLocalized(@"Star Surface Process");
    self.LB42.text = RNLocalized(@"Proportion");
    self.LB43.text = RNLocalized(@"Supplier Notes");
    self.LB44.text = RNLocalized(@"Report Notes");
    self.LB45.text = RNLocalized(@"Per Price");
    
    
    self.icon_check.image = ImageName(@"icon_report_check_n");
    self.icon_report.image = ImageName(@"icon_report_look_n");
    self.icon_video.image = ImageName(@"icon_video_n");
    self.LB17.textColor = RGBOF(0x999999);
    self.LB18.textColor = RGBOF(0x999999);
    self.videoLB.textColor = RGBOF(0x999999);
    
    self.certificateLB.text = RNLocalized(@"Report No.");
    self.shadLB.text = RNLocalized(@"Shade");
    self.incluLB.text = RNLocalized(@"Center Inclusion");
    self.keytoLB.text = RNLocalized(@"Key to symbols");
    [self layoutViews:NO];
}

- (instancetype)initWithGUID:(NSString *)GUID {
    self = [super init];
    if (self) {
        _GUID = GUID;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Diamond details");
    self.scrollerView.contentSize = CGSizeMake(App_Frame_Width, 1464);
    [self setupBaseUI];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}


- (void)setIsSaved:(BOOL)isSaved {
    _isSaved = isSaved;
    [self.likeBtn setSelected:isSaved];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.likeBtn];
}

- (void)likeClick:(UIButton *)sender {
    __weak typeof(self)weakself = self;
   if (self.likeBtn.isSelected == YES) {
       [HttpRequestTool getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/DiamondLikeServlet?method=cancle") parameters:@{@"likeGuid" : [NSString stringWithFormat:@"%@",self.model.likeid]} success:^(id responseObject, ResponseState state) {
           [YZHubTool showSuccessText:RNLocalized(@"Cancelled collection")];
           [weakself.likeBtn setSelected:!weakself.likeBtn.selected];
       } failure:^(NSError *error) {
           NSLog(@"%@", error);
       }];
   } else {
       [HttpRequestTool getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/DiamondLikeServlet?method=add") parameters:@{@"guid" : [NSString stringWithFormat:@"%@",self.model.GUID]} success:^(id responseObject, ResponseState state) {
           [weakself.likeBtn setSelected:!weakself.likeBtn.selected];
           [YZHubTool showSuccessText:RNLocalized(@"Collection success")];
       } failure:^(NSError *error) {
           NSLog(@"%@", error);
       }];
   }
    
}


- (void)loadData {
    __weak typeof(self)weakself = self;
    
    [HttpRequestTool getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/DiamondDetailServlet?method=getDetail") parameters:@{@"GUID" : self.GUID} success:^(id responseObject, ResponseState state) {
        NSLog(@"%@", responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            weakself.model = [RNJewelDetailModel mj_objectWithKeyValues:responseObject];
        }
        [weakself updateUI];
        NSLog(@"%@", responseObject);
    } failure:^(NSError *error) {
        
    }];
}


- (void)updateUI {
    self.isSaved = self.model.likeid?YES:NO;
    
    if (self.model.F_HEADIMG && [self.model.F_HEADIMG isKindOfClass:[NSString class]] && [self.model.F_HEADIMG containsString:@"http"]) {
        [self.bannerView sd_setImageWithURL:[NSURL URLWithString:self.model.F_HEADIMG]];
    } else {
        self.bannerView.height = 0;
    }
    self.titleLB.text = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",self.model.F_SHAPE,self.model.F_SIZE, self.model.F_COLOR, self.model.F_CLARITY, self.model.F_JIANDINGSUO];
    self.xinzhuangLB.text = [Utility fomateString:self.model.F_SHAPE];
    self.moguangLB.text = [Utility fomateString:self.model.F_POLISHED];
    self.daxiaoLB.text = [Utility fomateString:self.model.F_SIZE];
    self.duichengLB.text = [Utility fomateString: self.model.F_SYMMETRICAL];
    self.yanseLB.text = [Utility fomateString:self.model.F_COLOR];
    self.yinguangLB.text = [Utility fomateString:self.model.F_FLUORESCENT];
    self.jinduLB.text = [Utility fomateString:self.model.F_CLARITY];
    self.shiyanshiLB.text = [Utility fomateString:self.model.F_JIANDINGSUO];
    self.qiegeLB.text = [Utility fomateString:self.model.F_CUT];
    self.handleLB.text = [Utility fomateString:self.model.F_HANDLE];
   
    if (self.model.F_PRICE && [self.model.F_PRICE isKindOfClass:[NSString class]] && self.model.F_PRICE.length) {
        self.jiagectLB.text = [NSString stringWithFormat:@"$%d", [self.model.F_PRICE intValue]];
    } else {
        self.jiagectLB.text = @"-";
    }
    
    if (self.model.F_PRICETOTAL && [self.model.F_PRICETOTAL isKindOfClass:[NSString class]] && self.model.F_PRICETOTAL.length) {
        self.jiagetoLB.text = [NSString stringWithFormat:@"$%d", [self.model.F_PRICETOTAL intValue]];
    } else {
        self.jiagetoLB.text = @"-";
    }
    
    if (self.model.F_CASHPRICE && [self.model.F_CASHPRICE isKindOfClass:[NSString class]] && self.model.F_CASHPRICE.length) {
        self.cashLB1.text = [NSString stringWithFormat:@"%d", [self.model.F_CASHPRICE intValue]];
    } else {
        self.cashLB1.text = @"-";
    }
    
    if (self.model.F_CASHPRICETOTAL && [self.model.F_CASHPRICETOTAL isKindOfClass:[NSString class]] && self.model.F_CASHPRICETOTAL.length) {
        self.cashLB3.text = [NSString stringWithFormat:@"%.2f", [self.model.F_CASHPRICETOTAL floatValue]];
    } else {
        self.cashLB3.text = @"-";
    }
    
    self.IDLB.text = [Utility fomateString:self.model.F_COMCODE];
    self.compayLB.text = [Utility fomateString:self.model.F_COMNAME];
    self.userNameLB.text = [Utility fomateString:self.model.F_NAME];
    
    NSString *phoneString = [Utility fomateString:self.model.F_PHONE];
    if (![phoneString isEqualToString:@"-"]) {
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", phoneString] attributes:attribtDic];
        self.phoneLB.attributedText = attribtStr;
        
        UITapGestureRecognizer *tapGuester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCallPhone)];
        self.phoneLB.userInteractionEnabled = YES;
        [self.phoneLB addGestureRecognizer:tapGuester];
    } else {
       self.phoneLB.text = phoneString;
    }
    
    
    self.scoreLB.text = (self.model.F_SCORE && [self.model.F_SCORE isKindOfClass:[NSString class]] && self.model.F_SCORE.length)?[NSString stringWithFormat:@"%@%%",self.model.F_SCORE]:@"-";
    
    self.jewelTitleLB.text = [NSString stringWithFormat:@"%@ %@", RNLocalized(@"Diamond"),self.model.F_PINO];
    self.stockLB.text = [Utility fomateString:self.model.F_KUCUNNUM];
    self.updateLB.text = [Utility fomateString:self.model.F_UPTIME];
    self.certificateContentLB.text = [Utility fomateString:self.model.F_IGINUM];
    
    if (self.model.CF_COUNTRYNAME) {
        NSArray *list = [self.model.CF_COUNTRYNAME componentsSeparatedByString:@","];
        if (list && [list isKindOfClass:[NSArray class]] && list.count == 3) {
            self.postionLB.text = [Utility fomateString:[list objectAtIndex:[RNLanguageManager shareManager].languageType]];
        }
    }
    
    if (self.model.F_JKSHZK) {
        if ([self.model.F_JKSHZK intValue] == 1) {
            self.useLB.text = RNLocalized(@"Available");
        } else if ([self.model.F_JKSHZK intValue] == 2) {
            self.useLB.text = RNLocalized(@"Unavailable");
        } else {
            self.useLB.text = RNLocalized(@"Retain");
        }
    } else {
        self.useLB.text = [Utility fomateString:self.model.F_JKSHZK];
    }

    self.locationLB.text = [Utility fomateString:self.model.F_COUNTRY];
    self.deepLB.text = ([[Utility fomateString:self.model.F_DEPTH] isEqualToString:@"-"])?[Utility fomateString:self.model.F_DEPTH]:[NSString stringWithFormat:@"%@%%",self.model.F_DEPTH];
    self.deskLB.text = ([[Utility fomateString:self.model.F_BOTTOM] isEqualToString:@"-"])?[Utility fomateString:self.model.F_BOTTOM]:[NSString stringWithFormat:@"%@%%",self.model.F_BOTTOM];
    self.sizeLB.text = [NSString stringWithFormat:@"%@-%@x%@", self.model.F_CHANG, self.model.F_KUAN, self.model.F_GAO];
    self.jianLB.text = [Utility fomateString:self.model.F_LOWTIP];
    self.yaoLB.text = [Utility fomateString:self.model.F_WAIST];
    self.topLB.text = [Utility fomateString:self.model.F_GUANGAO];
    self.bottomLB.text = [Utility fomateString:self.model.F_TINGSHENG];
    self.controlLB.text = [Utility fomateString:self.model.F_HANDLE];
    self.aboutLB.text = [Utility fomateString:self.model.F_CENTERINCLUSION];
    self.xingmianLB.text = [Utility fomateString:self.model.F_STARFACETLENGTH];
    self.biliLB.text = (self.model.F_RATIO && [self.model.F_RATIO isKindOfClass:[NSString class]] && self.model.F_RATIO.length)?[NSString stringWithFormat:@"%.2f%%",[self.model.F_RATIO floatValue]]:@"-";
    self.inclutionLB.text = [Utility fomateString:self.model.F_OPENINCLUSIONS];
    self.shadeLB.text = [Utility fomateString:self.model.F_SHADECO];
    self.symbolsLB.text = [Utility fomateString:self.model.F_KEYTOSY];
    self.gongyiLB.text = [Utility fomateString:self.model.F_MEMCOMMENT];
    self.shadeContentLB.text = [Utility fomateString:self.model.F_SHADECO];
    
    [self setupBannerView];
    self.sellerBtn.selected = YES;
    self.jewelBtn.selected = YES;
    self.otherBtn.selected = YES;
    self.markBtn.selected = YES;
    [self sellerClick:self.sellerBtn];
    [self jewelClick:self.jewelBtn];
    [self otherClick:self.otherBtn];
    [self markClick:self.markBtn];

    self.baogaoLB.text = [Utility fomateString:self.model.F_CERCOMMENT];
    CGSize size = [Utility getTextString:[Utility fomateString:self.model.F_CERCOMMENT] textFont:[UIFont systemFontOfSize:12] frameWidth:App_Frame_Width-168 attributedString:nil];
    [self.baogaoLB setHeight:size.height];
    [self.baogaoLB setX:CGRectGetMinX(self.symbolsLB.frame)+12];
    if (size.height>20) {
        self.draw3Height = CGRectGetMaxY(self.baogaoLB.frame)+10;
    } else {
        self.draw3Height = 455;
    }
   
    self.postionLB.text = [Utility fomateString:self.model.CF_COUNTRY];
    self.childview3_18.y = self.draw3Height-1;
    self.LB16.text = RNLocalized(@"Check Report");
    self.LB17.text = RNLocalized(@"Look Report");
    self.LB18.text = RNLocalized(@"Look Imge");
    self.videoLB.text = RNLocalized(@"Video");
    
    if (KFormat(self.model.F_REPORTOUTURL).length && [KFormat(self.model.F_REPORTOUTURL) containsString:@"http"]) {
        self.icon_email.image = ImageName(@"icon_report_check_h");
        self.LB16.textColor = RGBOF(0x222222);
    } else {
        self.icon_email.image = ImageName(@"icon_report_check_n");
        self.LB16.textColor = RGBOF(0x999999);
    }
    
    if ((KFormat(self.model.REPORTADDR).length && [KFormat(self.model.REPORTADDR) containsString:@"http"])|| (KFormat(self.model.F_CERTIRL).length && [KFormat(self.model.F_CERTIRL) containsString:@"http"])) {
        self.icon_check.image = ImageName(@"icon_report_look_h");
        self.LB17.textColor = RGBOF(0x222222);
    } else {
        self.icon_check.image = ImageName(@"icon_report_look_n");
        self.LB17.textColor = RGBOF(0x999999);
    }
    
    
    if (KFormat(self.model.F_IMAVIDURL).length && [KFormat(self.model.F_IMAVIDURL) containsString:@"http"]) {
        self.icon_video.image = ImageName(@"icon_video_h");
        self.videoLB.textColor = RGBOF(0x222222);
    } else {
        self.icon_video.image = ImageName(@"icon_video_n");
        self.videoLB.textColor = RGBOF(0x999999);
    }
    
    if (KFormat(self.model.F_ADDRESS).length && [KFormat(self.model.F_ADDRESS) containsString:@"http"]) {
        self.icon_report.image = ImageName(@"icon_img_look_h");
        self.LB18.textColor = RGBOF(0x222222);
    } else {
        self.icon_report.image = ImageName(@"icon_img_look_n");
        self.LB18.textColor = RGBOF(0x999999);
    }
    
    
}

- (void)onCallPhone {
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", KFormat(self.model.F_PHONE)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",callPhone]]];
}

- (void)setupBannerView {
    BOOL hasBanner = (self.model.F_HEADIMG && [self.model.F_HEADIMG isKindOfClass:[NSString class]] && [self.model.F_HEADIMG containsString:@"http"])?YES:NO;
    [self layoutViews:hasBanner];
}

- (void)layoutViews:(BOOL)hasBanner {
    [self.topView setHeight:hasBanner?125:0];
    [self.bannerView setHidden:!hasBanner];
    
    [self.containerView2 setY:CGRectGetMaxY(self.topView.frame)+8];
    [self.containerView3 setY:CGRectGetMaxY(self.containerView2.frame)];
    [self.containerView4 setY:CGRectGetMaxY(self.containerView3.frame)+8];
    
    [self.drawView3 setY:CGRectGetMaxY(self.containerView4.frame)+8];
    [self.drawView2 setY:CGRectGetMaxY(self.drawView3.frame)];
    [self.drawView1 setY:CGRectGetMaxY(self.drawView2.frame)];

    [self.scrollerView setContentSize:CGSizeMake(0 , CGRectGetMaxY(self.drawView1.frame))];
    [self.view layoutIfNeeded];
}


- (IBAction)contractSeller:(UIButton *)sender {
    if (KFormat(self.model.F_REPORTOUTURL).length && [KFormat(self.model.F_REPORTOUTURL) containsString:@"http"]) {
        RootWebViewController *webView = [[RootWebViewController alloc] initWithUrl:KFormat(self.model.F_REPORTOUTURL)];
        [self.navigationController pushViewController:webView animated:YES];
    }
}



- (IBAction)caculator:(id)sender {
    //[self.navigationController pushViewController:[[RNCaculatorViewController alloc] init] animated:YES];
}


- (IBAction)checkClick:(id)sender {
    if (KFormat(self.model.REPORTADDR).length && [KFormat(self.model.REPORTADDR) containsString:@"http"]) {
        RootWebViewController *webView = [[RootWebViewController alloc] initWithUrl:KFormat(self.model.REPORTADDR)];
        [self.navigationController pushViewController:webView animated:YES];
    } else if (KFormat(self.model.F_CERTIRL).length && [KFormat(self.model.F_CERTIRL) containsString:@"http"]) {
        RootWebViewController *webView = [[RootWebViewController alloc] initWithUrl:KFormat(self.model.F_CERTIRL)];
        [self.navigationController pushViewController:webView animated:YES];
    }
}
- (IBAction)reportClick:(id)sender {
   if (KFormat(self.model.F_ADDRESS).length && [KFormat(self.model.F_ADDRESS) containsString:@"http"]) {
       RootWebViewController *webView = [[RootWebViewController alloc] initWithUrl:KFormat(self.model.F_ADDRESS)];
       [self.navigationController pushViewController:webView animated:YES];
   }
}
- (IBAction)videoClick:(id)sender {
    if (KFormat(self.model.F_IMAVIDURL).length && [KFormat(self.model.F_IMAVIDURL) containsString:@"http"]) {
        RootWebViewController *webView = [[RootWebViewController alloc] initWithUrl:KFormat(self.model.F_IMAVIDURL)];
        [self.navigationController pushViewController:webView animated:YES];
    }
}

- (IBAction)sellerClick:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    [self.drawView1 setHeight:(!sender.isSelected)?48:216];
    self.childview1.hidden= (!sender.isSelected)?YES:NO;
    self.childview2.hidden= (!sender.isSelected)?YES:NO;
    self.childview3.hidden= (!sender.isSelected)?YES:NO;
    self.childview4.hidden= (!sender.isSelected)?YES:NO;
    self.childview5.hidden= (!sender.isSelected)?YES:NO;
    self.childview6.hidden= (!sender.isSelected)?YES:NO;
    self.childview7.hidden= (!sender.isSelected)?YES:NO;
    
    [self.drawView3 setY:CGRectGetMaxY(self.containerView4.frame)+8];
    [self.drawView2 setY:CGRectGetMaxY(self.drawView3.frame)];
    [self.drawView1 setY:CGRectGetMaxY(self.drawView2.frame)];
    [self.scrollerView setContentSize:CGSizeMake(0 , CGRectGetMaxY(self.drawView1.frame))];
    [self.view layoutIfNeeded];
}

- (IBAction)jewelClick:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    [self.drawView2 setHeight:(!sender.isSelected)?48:167];
    self.childview2_1.hidden= (!sender.isSelected)?YES:NO;
    self.childview2_2.hidden= (!sender.isSelected)?YES:NO;
    self.childview2_3.hidden= (!sender.isSelected)?YES:NO;
    self.childview2_4.hidden= (!sender.isSelected)?YES:NO;
    self.childview2_5.hidden= (!sender.isSelected)?YES:NO;
    [self.drawView3 setY:CGRectGetMaxY(self.containerView4.frame)+8];
    [self.drawView2 setY:CGRectGetMaxY(self.drawView3.frame)];
    [self.drawView1 setY:CGRectGetMaxY(self.drawView2.frame)];
    [self.scrollerView setContentSize:CGSizeMake(0 , CGRectGetMaxY(self.drawView1.frame))];
    [self.view layoutIfNeeded];
}

- (IBAction)otherClick:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    [self.drawView3 setHeight:(!sender.isSelected)?48:self.draw3Height];
    self.childview3_1.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_2.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_3.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_4.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_5.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_6.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_7.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_8.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_9.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_10.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_11.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_12.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_13.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_14.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_15.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_16.hidden= (!sender.isSelected)?YES:NO;
    self.childview3_17.hidden= (!sender.isSelected)?YES:NO;
    [self.drawView3 setY:CGRectGetMaxY(self.containerView4.frame)+8];
    [self.drawView2 setY:CGRectGetMaxY(self.drawView3.frame)];
    [self.drawView1 setY:CGRectGetMaxY(self.drawView2.frame)];
    [self.scrollerView setContentSize:CGSizeMake(0 , CGRectGetMaxY(self.drawView1.frame))];
    [self.view layoutIfNeeded];
}

- (IBAction)markClick:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    [self.drawView4 setHeight:(!sender.isSelected)?48:216];
    [self.scrollerView setContentSize:CGSizeMake(0 , CGRectGetMaxY(self.drawView1.frame))];
    [self.view layoutIfNeeded];
}


- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [UIButton yz_buttonWithImageStr:@"icon_star_normal"];
        [_likeBtn setImage:[UIImage imageNamed:@"icon_star"] forState:UIControlStateSelected];
        _likeBtn.frame = CGRectMake(0, 0, 44, 44);
        [_likeBtn addTarget:self action:@selector(likeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

@end
