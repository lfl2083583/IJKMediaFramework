//
//  RNPrivateViewController.m
//  RapNet
//
//  Created by tjl on 2020/1/20.
//  Copyright © 2020 lptechnology. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "RNPrivateViewController.h"

@interface RNPrivateViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation RNPrivateViewController

- (instancetype)initWithType:(int)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(15, 0, App_Frame_Width-30, APP_Frame_Height-kStatusBarHeight-kTopBarHeight) configuration:config];
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    [self loadData];
}

- (void)loadData {
    __weak typeof(self)weakself = self;
    [YZHubTool showLoadingStatus:@"loading..."];
    [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/LookServlet?method=clauseAll") parameters:@{@"TYPE" : @(self.type)} success:^(id responseObject, ResponseState state) {
        [YZHubTool hide];
        NSArray *array = responseObject;
        if (array && [array isKindOfClass:[NSArray class]] && array.count ) {
            id source = [array firstObject];
            NSString *text = [source objectForKey:@"F_CONTENT"];
            [weakself.webView loadHTMLString:text baseURL:nil];
            weakself.title = [source objectForKey:@"F_TITLE"];
        }
    } failure:^(NSError *error) {
        [YZHubTool hide];
        NSLog(@"%@", error);
    }];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    //修改字体大小（方法一）
    NSString *fontSize = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%d%%'",300];
    [ webView evaluateJavaScript:fontSize completionHandler:nil];

    
    //修改字体颜色
    NSString *colorString = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#364857'"];
    [webView evaluateJavaScript:colorString completionHandler:nil];
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
