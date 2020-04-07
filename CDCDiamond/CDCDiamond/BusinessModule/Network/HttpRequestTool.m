//
//  AppDelegate.m
//  ZTIceHockey
//
//  Created by 观潮汇 on 6/7/22.
//  Copyright © 2016年 观潮汇. All rights reserved.
//

#import "HttpRequestTool.h"
#import "Utility.h"
#import "AppDelegate.h"
#import "RNLoginViewController.h"
#import "BANetManager.h"

#define CustomErrorDomain @"com.CDC.application"

@implementation HttpRequestTool



#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject, ResponseState state))success
                 failure:(void (^)(NSError *error))failure
{
    __weak typeof(self)weakself = self;
    [BANetManager ba_request_GETWithUrlString:URLString isNeedCache:NO parameters:parameters successBlock:^(id  _Nullable response) {
        [weakself handleNetworkResponseObject:response URLString:URLString parameters:parameters configParam:nil success:success failure:failure];

    } failureBlock:^(NSError * _Nullable error) {
        NSString *errorString = [NSString stringWithFormat:@"%@", error];
        if ([errorString containsString:@"unauthorized"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:RNLocalized(@"Safety Warning") message:RNLocalized(@"The client is not authorized to log in, please log in again") delegate:nil cancelButtonTitle:RNLocalized(@"Comfirm") otherButtonTitles:nil];
            [alertView show];
            [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:isLogin];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:userToken];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [AppDelegate sharedAppDelegate].window.rootViewController = [[RNNavigationController alloc] initWithRootViewController:[[RNLoginViewController alloc] init]];
        } else {
            [YZHubTool showFailureText:RNLocalized(@"Network exception, please try again")];
        }
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}


#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject, ResponseState state))success
                  failure:(void (^)(NSError *))failure
{
    __weak typeof(self)weakself = self;
    [BANetManager ba_request_POSTWithUrlString:URLString isNeedCache:NO parameters:parameters successBlock:^(id  _Nullable response) {
        [weakself handleNetworkResponseObject:response URLString:URLString parameters:parameters configParam:nil success:success failure:failure];
    } failureBlock:^(NSError * _Nullable error) {
        NSString *errorString = [NSString stringWithFormat:@"%@", error];
        if ([errorString containsString:@"unauthorized"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:RNLocalized(@"Safety Warning") message:RNLocalized(@"The client is not authorized to log in, please log in again") delegate:nil cancelButtonTitle:RNLocalized(@"Comfirm") otherButtonTitles:nil];
            [alertView show];
            [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:isLogin];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:userToken];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [AppDelegate sharedAppDelegate].window.rootViewController = [[RNNavigationController alloc] initWithRootViewController:[[RNLoginViewController alloc] init]];
        } else {
            [YZHubTool showFailureText:RNLocalized(@"Network exception, please try again")];
        }
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}


#pragma mark - 处理接口返回数据
+ (void)handleNetworkResponseObject:(id)responseObject
                          URLString:(NSString *)URLString
                         parameters:(id)parameters
                        configParam:(id)configParam
                            success:(void (^)(id responseObject, ResponseState state))success
                            failure:(void (^)(NSError *))failure
{
    id source = responseObject;
    
    if (URLString && [URLString isKindOfClass:[NSString class]] && [URLString containsString:@"auth/oauth/token"] && responseObject && [responseObject isKindOfClass:[NSDictionary class]] && ![source objectForKey:@"code"]) {
        if (success) {
            success(source, ResponseStateNormal);
        }
        return;
    }
    NSInteger status = [source objectForKey:@"code"] ? [[source objectForKey:@"code"] integerValue] : -9527;
    if (status == 200) {
        
        NSLog(@"%@", source);
        if (source && [source objectForKey:@"data"]) {
            if (success) {
                success(source[@"data"], ResponseStateNormal);
            }
            if ([source[@"data"] isKindOfClass:[NSArray class]] && ![source[@"data"] count]) {
                 //[YZHubTool showText:[source objectForKey:@"msg"]];
            }
            
            if ([source[@"data"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = source[@"data"];
                if (!dict.allKeys) {
                    //[YZHubTool showText:[source objectForKey:@"msg"]];
                }
            }
            if ([source[@"data"] isKindOfClass:[NSNull class]]) {
                //[YZHubTool showText:[source objectForKey:@"msg"]];
            }
        }
        else
        {
            //[YZHubTool showText:[source objectForKey:@"msg"]];
            if (success) {
                success(@{}, ResponseStateNormal);
            }
        }
    } else if (status == 403) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:RNLocalized(@"Safety Warning") message:RNLocalized(@"The client is not authorized to log in, please log in again") delegate:nil cancelButtonTitle:RNLocalized(@"Comfirm") otherButtonTitles:nil];
        [alertView show];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:isLogin];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:userToken];
        [AppDelegate sharedAppDelegate].window.rootViewController = [[RNNavigationController alloc] initWithRootViewController:[[RNLoginViewController alloc] init]];
    } else
    {
        NSError *error = [[NSError alloc] initWithDomain:CustomErrorDomain code:status userInfo:@{@"msg": source?KFormat(source[@"error"]):RNLocalized(@"Network exception, please try again")}];
        if (failure) {
            failure(error);
        }
    }
}

@end
