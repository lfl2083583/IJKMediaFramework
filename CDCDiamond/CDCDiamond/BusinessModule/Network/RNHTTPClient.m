//
//  RNHTTPClient.m
//  RapNet
//
//  Created by liufulin on 2019/7/22.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNHTTPClient.h"
#import "RNHTTPError.h"
#import "RNHTTPRequestSerializer.h"
#import "RNJSONResponseSerializer.h"

@implementation RNHTTPClient

+ (RNHTTPClient *)sharedClient
{
    // design to be overwrited by subclasses
    return nil;
}

+ (void)resetClients {}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    return [self initWithBaseURL:url sessionConfiguration:nil];
}

- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    if (self = [super initWithBaseURL:url sessionConfiguration:configuration]) {
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        self.requestSerializer = requestSerializer;
        self.responseSerializer = responseSerializer;
        [self.operationQueue setMaxConcurrentOperationCount:4];
        
    }
    return self;
}


#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if ([super respondsToSelector:@selector(URLSession:task:didCompleteWithError:)]) {
        if (error) {
            [super URLSession:session task:task didCompleteWithError:[RNHTTPError errorFromURLSessionTask:task originalError:error]];
        } else {
            [super URLSession:session task:task didCompleteWithError:error];
        }
    }
}


#pragma mark - Private methods

/**
 *  Extract http body from a multipart form request to a temp file, then generate a NSURLSessionUploadTask task with the file.
 *  Don't use NSURLSessionDataTask because the Content-Length of url request will be striped when use NSURLSessionDataTask.
 *
 *  @param request original multipart form request
 *  @param success success callback
 *  @param failure failure callback
 *
 *  @return the upload task intance
 */
- (void)uploadWithMultipartFormRequest:(NSMutableURLRequest *)request
                               success:(RNHTTPClientSuccessBlock)success
                               failure:(RNHTTPClientFailureBlock)failure
{
    NSString *tmpFileName = [[NSUUID UUID] UUIDString];
    NSURL *tmpFileUrl = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:tmpFileName]];
    __block NSURLSessionUploadTask *uploadTask = nil;
    
    [self.requestSerializer requestWithMultipartFormRequest:request writingStreamContentsToFile:tmpFileUrl completionHandler:^(NSError *error) {
        uploadTask = [self uploadTaskWithRequest:request
                                        fromFile:tmpFileUrl
                                        progress:nil
                               completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                   if (error) {
                                       if (failure) {
                                           failure(uploadTask, error);
                                       }
                                   } else {
                                       if (success) {
                                           success(uploadTask, responseObject);
                                       }
                                   }
                                   [[NSFileManager defaultManager] removeItemAtURL:tmpFileUrl error:nil];
                               }];
        [uploadTask resume];
    }];
}

#pragma mark - Instance methods

- (NSString *)fullURLStringWithPath:(NSString *)path
{
    NSString *urlString = [[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString];
    return urlString;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(id)parameters
{
    return [self.requestSerializer requestWithMethod:method
                                           URLString:[self fullURLStringWithPath:path]
                                          parameters:parameters
                                               error:nil];
}

- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                                   path:(NSString *)path
                                             parameters:(id)parameters
                                  constructingBodyBlock:(RNHTTPClientMultipartFormDataBlock)constructingBodyBlock {
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:method
                                                                                URLString:[self fullURLStringWithPath:path]
                                                                               parameters:parameters
                                                                constructingBodyWithBlock:constructingBodyBlock
                                                                                    error:nil];
    return request;
}

- (NSURLSessionDataTask *)sendRequest:(NSURLRequest *)request
                              success:(RNHTTPClientSuccessBlock)success
                              failure:(RNHTTPClientFailureBlock)failure
{
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) failure(task, error);
        } else {
            id source = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if (success) success(task, source);
        }
    }];
    [task resume];
    return task;
}

- (NSURLSessionDataTask *)sendRequestWithMethod:(NSString *)method
                                           path:(NSString *)path
                                     parameters:(id)parameters
                                        success:(RNHTTPClientSuccessBlock)success
                                        failure:(RNHTTPClientFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestWithMethod:method path:path parameters:parameters];
    return [self sendRequest:request success:success failure:failure];
}


- (NSURLSessionDataTask *)sendMultiFormDataRequestWithMethod:(NSString *)method
                                                        path:(NSString *)path
                                                  parameters:(id)parameters
                                   constructingBodyWithBlock:(RNHTTPClientMultipartFormDataBlock)constructingBodyBlock
                                                     success:(RNHTTPClientSuccessBlock)success
                                                     failure:(RNHTTPClientFailureBlock)failure
{
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:method
                                                                                URLString:[self fullURLStringWithPath:path]
                                                                               parameters:parameters
                                                                constructingBodyWithBlock:constructingBodyBlock
                                                                                    error:nil];
    return [self sendRequest:request success:success failure:failure];
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
    constructingBodyWithBlock:(RNHTTPClientMultipartFormDataBlock)constructingBodyBlock
                      success:(RNHTTPClientSuccessBlock)success
                      failure:(RNHTTPClientFailureBlock)failure
{
    if (constructingBodyBlock != NULL) {
        return [self sendMultiFormDataRequestWithMethod:@"PUT"
                                                   path:URLString
                                             parameters:parameters
                              constructingBodyWithBlock:constructingBodyBlock
                                                success:success
                                                failure:failure];
    }
    return [super PUT:URLString parameters:parameters success:success failure:failure];
}

- (void)uploadFileWithURL:(NSURL *)fileUrl
                     name:(NSString *)name
                 fileName:(NSString *)fileName
                 mimeType:(NSString *)mimeType
                   method:(NSString *)method
                     path:(NSString *)path
               parameters:(NSDictionary *)parameters
                  success:(RNHTTPClientSuccessBlock)success
                  failure:(RNHTTPClientFailureBlock)failure
{
    NSMutableURLRequest *request = [self multipartFormRequestWithMethod:method path:path parameters:parameters constructingBodyBlock:^(id <AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:fileUrl name:name fileName:fileName mimeType:mimeType error:nil];
    }];
    
    [self uploadWithMultipartFormRequest:request success:success failure:failure];
}

- (void)uploadData:(NSData *)data
              name:(NSString *)name
          fileName:(NSString *)fileName
          mimeType:(NSString *)mimeType
            method:(NSString *)method
              path:(NSString *)path
        parameters:(NSDictionary *)parameters
           success:(RNHTTPClientSuccessBlock)success
           failure:(RNHTTPClientFailureBlock)failure
{
    
    NSMutableURLRequest *request = [self multipartFormRequestWithMethod:method path:path parameters:parameters constructingBodyBlock:^(id <AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data
                                    name:name
                                fileName:fileName
                                mimeType:mimeType];
    }];
    
    [self uploadWithMultipartFormRequest:request success:success failure:failure];
}

- (void)cancelAllTasksToPath:(NSString *)path
{
    for (NSURLSessionTask *task in self.tasks) {
        NSString *taskURLString = [[[[task.currentRequest URL] absoluteString] componentsSeparatedByString:@"?"] objectAtIndex:0];
        if ([taskURLString isEqualToString:[self fullURLStringWithPath:path]]) {
            [task cancel];
        }
    }
}

@end
