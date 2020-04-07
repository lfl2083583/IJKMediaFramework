//
//  RNLoginViewController.m
//  RapNet
//
//  Created by liufulin on 2019/9/19.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNLoginViewController.h"
#import "RNCenterViewController.h"
#import "RNNavigationController.h"
#import "RNAuthClient.h"
#import "HttpRequestTool.h"
#import "AppDelegate.h"
#import "RNRegisterViewController.h"

@interface RNLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *loginAccount;
@property (weak, nonatomic) IBOutlet UITextField *loginPsw;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation RNLoginViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.blackColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    // 键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
    //self.topConstraint.constant = AUTO_WIDTH(302);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.loginAccount.placeholder = RNLocalized(@"Please enter account");
    self.loginPsw.placeholder = RNLocalized(@"Please enter your password");
    [self.loginBtn setTitle:RNLocalized(@"Login") forState:UIControlStateNormal];
    [self.registerBtn setTitle:RNLocalized(@"Register") forState:UIControlStateNormal];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)login:(UIButton *)sender {
    if (!self.loginAccount.text.length) {
        [YZHubTool showText:RNLocalized(@"Please enter account")];
        return;
    }
    if (!self.loginPsw.text.length) {
        [YZHubTool showText:RNLocalized(@"Please enter your password")];
        return;
    }
    [YZHubTool showLoadingStatus:RNLocalized(@"Login...")];
    
    __weak typeof(self)weakself = self;
    //[self checkUserExist:^{
        //[HttpRequestTool.manager.requestSerializer setValue:@"Basic YXBwbGljYXRpb24lM0FhcHBsaWNhdGlvbg==" forHTTPHeaderField:@"Authorization"];
        [HttpRequestTool postWithURLString:KStringFormat(BaseServer, @"auth/oauth/token")  parameters:@{@"username" : weakself.loginAccount.text, @"password" : weakself.loginPsw.text, @"grant_type" : @"password"} success:^(id responseObject, ResponseState state) {
            if (responseObject && [responseObject objectForKey:@"access_token"]) {
                [YZHubTool showSuccessText:RNLocalized(@"Login Success")];
                // 保存用户已登录状态 及 token
                [[NSUserDefaults standardUserDefaults] setValue:[responseObject objectForKey:@"access_token"] forKey:userToken];
                [[NSUserDefaults standardUserDefaults] setValue:weakself.loginAccount.text forKey:loginName];
                [[NSUserDefaults standardUserDefaults] setValue:@(1) forKey:isLogin];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [AppDelegate sharedAppDelegate].window.rootViewController = [[RNNavigationController alloc] initWithRootViewController:[[RNCenterViewController alloc] init]];
            } else {
                [YZHubTool showText:responseObject[@"msg"]];
            }
        } failure:^(NSError *error) {
            id userInfo = error.userInfo;
            [YZHubTool showFailureText:userInfo[@"msg"]];
        }];
    //}];
    return;
    
}

- (void)checkUserExist:(void (^)(void))exist {
    [HttpRequestTool postWithURLString:KStringFormat(BaseServer, @"bpdm/sys/getLoginSource")  parameters:@{@"username" : self.loginAccount.text, @"type" : @(1)} success:^(id responseObject, ResponseState state) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (exist) {
                exist();
            }
        } else {
            [YZHubTool showText:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        id userInfo = error.userInfo;
        [YZHubTool showFailureText:userInfo[@"msg"]];
    }];
}

- (IBAction)onRegisterAccount:(UIButton *)sender {
    [self.navigationController pushViewController:[[RNRegisterViewController alloc] init] animated:YES];
}

#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
//    // 获取键盘的高度
//    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
}

- (void)keyboardWillBeHiden:(NSNotification *)notification
{
//    [self.view setY:0];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.loginPsw) {
        [self login:nil];
        return NO;
    } else {
        [self.loginPsw becomeFirstResponder];
    }
    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
