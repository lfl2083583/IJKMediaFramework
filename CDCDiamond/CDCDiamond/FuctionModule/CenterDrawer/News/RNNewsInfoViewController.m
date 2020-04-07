//
//  RNNewsInfoViewController.m
//  RapNet
//
//  Created by jt on 2019/11/24.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNNewsInfoViewController.h"
#import "RNNewsModel.h"
#import "BAKit_WebView.h"
//#import "JPVideoPlayerKit.h"

static NSString *const newsInfoIdentifier = @"RNNewsInfoViewCell";

@interface RNNewsInfoViewController ()<WKNavigationDelegate>


@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) RNNewsModel *model;
@property (nonatomic, assign) BOOL isSaved;

@property (strong, nonatomic)  UIScrollView *scrollerView;
@property (strong, nonatomic)  UILabel *titleLB;
@property (strong, nonatomic)  UILabel *anchorLB;
@property (strong, nonatomic)  UILabel *timeLB;
@property (strong, nonatomic)  UIImageView *coverView;
@property (strong, nonatomic)  UIButton *playBtn;

@property (nonatomic, strong)  WKWebView *attributedLabel;
@property (nonatomic, assign) CGRect viewMaxRect;


 
@end

@implementation RNNewsInfoViewController

- (void)dealloc {
//    [self.coverView jp_stopPlay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = RNLocalized(@"Details");
    [self setupUI];
   
    [self requestNewsDetail];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
   UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
   [self.view addSubview:scrollerView];
   self.scrollerView = scrollerView;
   
   
   _titleLB = [UILabel yz_labelWithText:@"" textColor:RGBOF(0x333333) textFont:[UIFont boldSystemFontOfSize:18.f] numberOfLines:0];
   _titleLB.frame = CGRectMake(15, 15, App_Frame_Width - 30, 24);
   [self.scrollerView addSubview:_titleLB];
   
   _anchorLB = [UILabel yz_labelWithText:@"" textColor:RGBOF(0x999999) textFont:[UIFont systemFontOfSize:14.f]];
   _anchorLB.frame = CGRectMake(15, CGRectGetMaxY(_titleLB.frame)+5, 100, 18);
   [self.scrollerView addSubview:_anchorLB];
   
   _timeLB = [UILabel yz_labelWithText:@"" textColor:RGBOF(0x999999) textFont:[UIFont systemFontOfSize:14.f]];
   _timeLB.frame = CGRectMake(CGRectGetMaxX(_anchorLB.frame), CGRectGetMaxY(_titleLB.frame)+5, 200, 18);
   [self.scrollerView addSubview:_timeLB];
   
   self.coverView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_anchorLB.frame)+15, App_Frame_Width - 30, (App_Frame_Width - 30) * 9 / 16.f)];
   self.coverView.contentMode = UIViewContentModeScaleAspectFill;
   self.coverView.layer.borderWidth = 0.5;
   self.coverView.layer.borderColor = RGBOF(0xe6e6e6).CGColor;
   self.coverView.layer.cornerRadius = 5.f;
   self.coverView.layer.masksToBounds = YES;
   self.coverView.clipsToBounds = YES;
   [self.scrollerView addSubview:self.coverView];
   
   self.playBtn = [[UIButton alloc] init];
   [self.playBtn setHidden:YES];
   [self.playBtn setBackgroundImage:ImageName(@"btn_play") forState:UIControlStateNormal];
   [self.playBtn setFrame:CGRectMake(0, 0, 60, 60)];
   self.playBtn.center = self.coverView.center;
   [self.scrollerView addSubview:self.playBtn];
   [self.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
   
   _viewMaxRect =  CGRectMake(15, 15, App_Frame_Width - 15*2, MAXFLOAT);
      //创建控件，显示富文本
   [scrollerView addSubview:self.attributedLabel];
}

- (void)playBtnClick:(UIButton *)sender {
//    [self.playBtn setHidden:YES];
//    [self.coverView jp_resumePlayWithURL:[NSURL URLWithString:self.model.F_NEWSAPP]
//                      bufferingIndicator:nil
//                             controlView:nil
//                            progressView:nil
//                           configuration:^(UIView *view, JPVideoPlayerModel *playerModel) {
//                         }];
}

// 删除、添加收藏
- (void)likeClick:(UIButton *)sender {
    __weak typeof(self)weakself = self;
    if (self.likeBtn.isSelected == NO) {
        
        [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/NewsCollectionServlet?method=newsadd") parameters:@{@"guid" : self.model.GUID} success:^(id responseObject, ResponseState state) {
            NSLog(@"%@", responseObject);
            weakself.model.cguid = [NSString stringWithFormat:@"%@", responseObject[@"cguid"]];
            [weakself.likeBtn setSelected:!weakself.likeBtn.selected];
            [YZHubTool showSuccessText:RNLocalized(@"Collection success")];
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    } else {
        [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/NewsCollectionServlet?method=newsdele") parameters:@{@"cguid" : self.model.cguid} success:^(id responseObject, ResponseState state) {
            NSLog(@"%@", responseObject);
            [YZHubTool showSuccessText:RNLocalized(@"Cancelled collection")];
            [weakself.likeBtn setSelected:!weakself.likeBtn.selected];
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    
}


- (void)requestNewsDetail {
    __weak typeof(self)weakself = self;
    [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/NewsCollectionServlet?method=getOne") parameters:@{@"newsid" : self.newsID, @"WORDS" : @([RNLanguageManager shareManager].languageType)} success:^(id responseObject, ResponseState state) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]] && [responseObject count]) {
            id source = [responseObject firstObject];
    
            weakself.model = [RNNewsModel mj_objectWithKeyValues:source];
            weakself.isSaved = weakself.model.cguid?YES:NO;
            //[weakself.tableView reloadData];
            [weakself refreshUI:weakself.model];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}


- (void)refreshUI:(RNNewsModel *)model {
    [self.titleLB setText:model.F_BIGTITLE];
    CGSize titleSize = [Utility getTextString:model.F_BIGTITLE textFont:[UIFont boldSystemFontOfSize:18.f] frameWidth:App_Frame_Width-30 attributedString:nil];
    [self.titleLB setHeight:titleSize.height];
    
    [self.anchorLB setText:model.F_AUTHOR];
    [self.anchorLB setY:CGRectGetMaxY(self.titleLB.frame)+15];
    
    CGSize size = [Utility getTextString:model.F_AUTHOR textFont:[UIFont systemFontOfSize:14] frameWidth:App_Frame_Width attributedString:nil];
    
    [self.timeLB setText:model.CREATETIME];
    [self.timeLB setX:CGRectGetMinX(self.anchorLB.frame)+size.width+20];
    [self.timeLB setY:CGRectGetMaxY(self.titleLB.frame)+15];
    
    if (self.model.F_NEWSIMG && [self.model.F_NEWSIMG isKindOfClass:[NSString class]] && self.model.F_NEWSIMG.length) {
        [self.coverView setHidden:NO];
        [self.coverView sd_setImageWithURL:[NSURL URLWithString:self.model.F_NEWSIMG]];
        [self.coverView setHeight:(App_Frame_Width-32)*9/16.f];
        
    } else {
        [self.coverView setHidden:YES];
        [self.coverView setHeight:0.f];
    }
    [self.coverView setY:CGRectGetMaxY(self.anchorLB.frame)+15];
    if (self.model.F_NEWSAPP && [self.model.F_NEWSAPP isKindOfClass:[NSString class]] && self.model.F_NEWSAPP.length && [self.model.F_NEWSAPP containsString:@".mp4"]) {
        [self.playBtn setHidden:NO];
        [self.playBtn setCenter:self.coverView.center];
    } else {
        [self.playBtn setHidden:YES];
    }
    
    [self.attributedLabel ba_web_loadHTMLString:self.model.F_CONTENT];
    __weak typeof(self)weakself = self;
    self.attributedLabel.ba_web_getCurrentHeightBlock = ^(CGFloat currentHeight) {

        weakself.attributedLabel.frame = CGRectMake(15, CGRectGetMaxY(self.coverView.frame) + 15, App_Frame_Width - 30, currentHeight);
        [weakself.scrollerView setContentSize:CGSizeMake(App_Frame_Width, CGRectGetMaxY(weakself.attributedLabel.frame))];
    };
    
}

- (void)setIsSaved:(BOOL)isSaved {
    _isSaved = isSaved;
    [self.likeBtn setSelected:isSaved];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.likeBtn];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    //修改字体大小（方法一）
    NSString *fontSize = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'",250];
    [ webView evaluateJavaScript:fontSize completionHandler:nil];

    
//    //修改字体颜色
//    NSString *colorString = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#364857'"];
//    [webView evaluateJavaScript:colorString completionHandler:nil];
    
     // 不执行前段界面弹出列表的JS代码，关闭系统的长按保存图片
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    
    
      
       //    document.body.scrollHeight（不准）   document.body.offsetHeight;(好)
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id Result, NSError * error) {
         NSString *heightStr = [NSString stringWithFormat:@"%@",Result];
               
    }];
     
}


#pragma mark - Getter && Setter
//懒加载创建
- (WKWebView *)attributedLabel{
    if (_attributedLabel == nil) {
        _attributedLabel = [[WKWebView alloc] initWithFrame:CGRectZero];
        _attributedLabel.ba_web_isAutoHeight = YES;
        _attributedLabel.userInteractionEnabled = false;
        _attributedLabel.navigationDelegate = self;
    }
    return _attributedLabel;
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
