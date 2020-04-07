//
//  RNRegisterProtocolViewController.m
//  CDCDiamond
//
//  Created by Frank on 2020/4/6.
//  Copyright © 2020 Frank. All rights reserved.
//

#import "RNRegisterProtocolViewController.h"
#import "BAKit_WebView.h"

@interface RNRegisterProtocolViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) UIButton *boxBtn;
@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation RNRegisterProtocolViewController

- (instancetype)initWithProgram:(NSDictionary *)program {
    self = [super init];
    if (self) {
        _program = program;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Registration Terms");
    [self getProtocol];
    // Do any additional setup after loading the view.
}

- (void)getProtocol {
    __weak typeof(self)weakself = self;
    [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/sys/getclause") parameters:@{@"WORDS" : @([RNLanguageManager shareManager].languageType)} success:^(id responseObject, ResponseState state) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]] && [responseObject count]) {
            NSDictionary *dict = [responseObject firstObject];
            [weakself setupUIWithString:dict[@"F_TEXT"]];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)setupUIWithString:(NSString *)string {
    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    WKWebView *attributedLabel = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:webConfiguration];
    attributedLabel.navigationDelegate = self;
    [self.view addSubview:attributedLabel];
    [attributedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.top.equalTo(self.view.mas_top).offset(15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
    }];
    
    [attributedLabel ba_web_loadHTMLString:string];
    
    _boxBtn = [[UIButton alloc] init];
    [_boxBtn setImage:ImageName(@"icon_box_normal") forState:UIControlStateNormal];
    [_boxBtn setImage:ImageName(@"icon_box_seleted") forState:UIControlStateSelected];
    [_boxBtn addTarget:self action:@selector(obBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_boxBtn];
    [_boxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(attributedLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *tipLab = [UILabel yz_labelWithText:RNLocalized(@"I agree with the above agreement") textColor:RGBOF(0x222222) sizeFont:14];
    [self.view addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_boxBtn.mas_right).offset(5);
        make.centerY.equalTo(self->_boxBtn.mas_centerY);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(24);
    }];
    
    _submitBtn = [UIButton yz_buttonWithTitle:RNLocalized(@"Submit") titleColor:UIColor.whiteColor textFont:[UIFont yz_PingFangSC_RegularFontOfSize:16]];
    _submitBtn.layer.cornerRadius = 3.f;
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.backgroundColor = [RNGlobalUIStandard defaultMainColor];
    [_submitBtn addTarget:self action:@selector(onSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(App_Frame_Width/2.0, 40));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self->_boxBtn.mas_bottom).offset(10);
    }];

}

- (void)obBoxClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)onSubmitBtnClick:(UIButton *)sender {
    if (self.boxBtn.selected == NO) {
        [YZHubTool showText:RNLocalized(@"Please agree to the content of the agreement before registering!")];
    } else {
        __weak typeof(self)weakself = self;
        [HttpRequestTool postWithURLString:KStringFormat(BaseServer, @"bpdm/sys/appRegister")  parameters:self.program success:^(id responseObject, ResponseState state) {
            [YZHubTool showSuccessText:RNLocalized(@"You have registered successfully,the administrator is reviewing.")];
            [weakself.navigationController popToRootViewControllerAnimated:YES];

        } failure:^(NSError *error) {
            id erroInfo = error.userInfo;
            [YZHubTool showFailureText:erroInfo[@"msg"]];
        }];
    }

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
     
}


@end
