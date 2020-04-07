//
//  AppDelegate.m
//  ZTIceHockey
//
//  Created by 观潮汇 on 6/7/22.
//  Copyright © 2016年 观潮汇. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger, HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};

/**
 *  响应状态
 */
typedef NS_ENUM(NSUInteger, ResponseState) {
    /**
     *  网络响应
     */
    ResponseStateNormal = 0,
    /**
     *  缓存响应
     */
    ResponseStateCache,
    /**
     *  无响应
     */
    ResponseStateNone
};

@interface HttpRequestTool : NSObject



+ (instancetype)sharedInstance;



/**
 *  发送get请求
 *
 *  @param URLString    请求的网址字符串
 *  @param parameters   请求的参数
 *  @param success      请求成功的回调
 *  @param failure      请求失败的回调
 */
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject, ResponseState state))success
                 failure:(void (^)(NSError *error))failure;




/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject, ResponseState state))success
                  failure:(void (^)(NSError *error))failure;



@end

