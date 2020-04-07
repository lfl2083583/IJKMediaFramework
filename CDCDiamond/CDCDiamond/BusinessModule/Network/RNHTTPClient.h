//
//  RNHTTPClient.h
//  RapNet
//
//  Created by liufulin on 2019/7/22.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>

#import "RNHTTPError.h"

typedef void (^RNHTTPClientSuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^RNHTTPClientFailureBlock)(NSURLSessionDataTask *task, NSError *error);
typedef void (^RNHTTPClientFailureBlockWithBPHTTPError)(NSURLSessionDataTask *task, NSError *error);
typedef void (^RNHTTPClientMultipartFormDataBlock)(id <AFMultipartFormData> formData);

NS_ASSUME_NONNULL_BEGIN

@interface RNHTTPClient : AFHTTPSessionManager

+ (RNHTTPClient *)sharedClient;

+ (void)resetClients;

/**
 *  Concat base url to path
 *
 *  @param path relative path, ensure NOT include base url
 *
 *  @return full url
 */
- (NSString *)fullURLStringWithPath:(NSString *)path;

/**
 *  Generate custom request with HTTP method and relative path
 *
 *  @param method     HTTP method
 *  @param path       relative path, ensure NOT include base url
 *  @param parameters custom parameters
 *
 *  @return custom request
 */
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(id)parameters;

/**
 *  Generate custom multipart form request with HTTP method, relative path, parameters and block of constructing body
 *
 *  @param method                HTTP method
 *  @param path                  relative path, ensure NOT include base url
 *  @param parameters            custom parameters
 *  @param constructingBodyBlock block of constructing body
 *
 *  @return custom request
 */
- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                                   path:(NSString *)path
                                             parameters:(id)parameters
                                  constructingBodyBlock:(RNHTTPClientMultipartFormDataBlock)constructingBodyBlock;

/**
 *  Send request with custom request and return the task object for future use
 *
 *  @param request custom url request
 *  @param success success callback
 *  @param failure failure callback
 *
 *  @return the task object
 */
- (NSURLSessionDataTask *)sendRequest:(NSURLRequest *)request
                              success:(RNHTTPClientSuccessBlock)success
                              failure:(RNHTTPClientFailureBlock)failure;

/**
 *  Send request with HTTP method, relative path and custom parameters, return the task object for future use.
 *  This method will call sendRequest:success:failure: internally.
 *
 *  @param method     HTTP method
 *  @param path       relative path, ensure NOT include base url
 *  @param parameters custom parameters
 *  @param success    success callback
 *  @param failure    failure callback
 *
 *  @return the task object
 */
- (NSURLSessionDataTask *)sendRequestWithMethod:(NSString *)method
                                           path:(NSString *)path
                                     parameters:(id)parameters
                                        success:(RNHTTPClientSuccessBlock)success
                                        failure:(RNHTTPClientFailureBlock)failure;

/**
 *  Send request with HTTP method, relative path and custom parameters, return the task object for future use.
 *  This method will call sendRequest:success:failure: internally.
 *
 *  @param method                HTTP method
 *  @param path                  relative path, ensure NOT include base url
 *  @param parameters            custom parameters
 *  @param constructingBodyBlock block to construct custom HTTP body
 *  @param success               success callback
 *  @param failure               failure callback
 *
 *  @return the task object
 */
- (NSURLSessionDataTask *)sendMultiFormDataRequestWithMethod:(NSString *)method
                                                        path:(NSString *)path
                                                  parameters:(id)parameters
                                   constructingBodyWithBlock:(RNHTTPClientMultipartFormDataBlock)constructingBodyBlock
                                                     success:(RNHTTPClientSuccessBlock)success
                                                     failure:(RNHTTPClientFailureBlock)failure;


/**
 *  AFNetworking don't have PUT with constructingBodyBlock
 *
 *  @param URLString             relative path, ensure NOT include base url
 *  @param parameters            custom parameters
 *  @param constructingBodyBlock block to construct custom HTTP body
 *  @param success               success callback
 *  @param failure               failure callback
 *
 *  @return the task object
 */
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
    constructingBodyWithBlock:(RNHTTPClientMultipartFormDataBlock)constructingBodyBlock
                      success:(RNHTTPClientSuccessBlock)success
                      failure:(RNHTTPClientFailureBlock)failure;


/**
 *  Upload a file at url.
 *
 *  @param fileUrl    url of the original file
 *  @param name       parameter name
 *  @param fileName   file name
 *  @param mimeType   mime type
 *  @param method     HTT
 *  @param path       relative path, ensure NOT include base url
 *  @param parameters custom parameters
 *  @param success    success callback
 *  @param failure    failure callback
 */
- (void)uploadFileWithURL:(NSURL *)fileUrl
                     name:(NSString *)name
                 fileName:(NSString *)fileName
                 mimeType:(NSString *)mimeType
                   method:(NSString *)method
                     path:(NSString *)path
               parameters:(NSDictionary *)parameters
                  success:(RNHTTPClientSuccessBlock)success
                  failure:(RNHTTPClientFailureBlock)failure;
/**
 *  Upload data.
 *
 *  @param data       data to be uploaded
 *  @param name       parameter name
 *  @param fileName   file name
 *  @param mimeType   mime type
 *  @param method     HTT
 *  @param path       relative path, ensure NOT include base url
 *  @param parameters custom parameters
 *  @param success    success callback
 *  @param failure    failure callback
 */
- (void)uploadData:(NSData *)data
              name:(NSString *)name
          fileName:(NSString *)fileName
          mimeType:(NSString *)mimeType
            method:(NSString *)method
              path:(NSString *)path
        parameters:(NSDictionary *)parameters
           success:(RNHTTPClientSuccessBlock)success
           failure:(RNHTTPClientFailureBlock)failure;

/**
 *  Cancel all related tasks to path
 *
 *  @param path the path of the tasks
 */
- (void)cancelAllTasksToPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
