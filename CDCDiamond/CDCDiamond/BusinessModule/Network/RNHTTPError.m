//
//  RNHTTPError.m
//  RapNet
//
//  Created by liufulin on 2019/7/19.
//  Copyright © 2019 lptechnology. All rights reserved.
//
NSString* const RN_ERROR_DOMAIN = @"com.bindo.httpError";

NSString* const RN_ERROR_EXCEPTION_DOMAIN = @"com.bindo.exception";

NSInteger const ERROR_CODE_UNKNOWN_EXCEPTION = 10000;
NSString* const ERROR_CODE_DUPLICATED_ORDER = @"101";
NSInteger const ERROR_CODE_DUPLICATED_PAYMENT = 102;
NSInteger const ERROR_CODE_NEED_LOGIN = 401;
NSInteger const ERROR_CODE_LOGIN_FAIL = 400;
NSInteger const ERROR_CODE_INACTIVE = 403;
NSInteger const ERROR_CODE_NOT_FOUND = 404;
NSInteger const ERROR_CODE_HTTP_ERROR = 500;
NSInteger const ERROR_CODE_TIMEOUT = 1001;
NSInteger const ERROR_CODE_UNKNOWN = 2001;
NSInteger const ERROR_CODE_NSURL_ERROR = 3001;

#import "RNHTTPError.h"
#import "AFNetworking.h"
#import "RNJSONResponseSerializer.h"
#import "JSONKit.h"

@implementation RNHTTPError

+ (RNHTTPError *)errorFromURLSessionTask:(NSURLSessionTask *)task {
    return [self errorFromURLSessionTask:task originalError:nil];
}

+ (RNHTTPError *)errorFromURLSessionTask:(NSURLSessionTask *)task originalError:(NSError *)originalError {
    if (task.state == NSURLSessionTaskStateCanceling) {
        return nil;
    }
    
    if (originalError.code == NSURLErrorCancelled) {
        return nil;
    }
    
    if (originalError.code == NSURLErrorCannotFindHost ||
        originalError.code == NSURLErrorCannotConnectToHost ||
        originalError.code == NSURLErrorNetworkConnectionLost ||
        originalError.code == NSURLErrorDNSLookupFailed ||
        originalError.code == NSURLErrorNotConnectedToInternet) {
        return [self errorWithDomain:originalError.domain
                                code:originalError.code
                            userInfo:@{NSLocalizedDescriptionKey: RNLocalized(@"Bindo POS is unable to connect to server. Please check your internet connection.")}];
    }
    
    if (originalError.code == NSURLErrorUnsupportedURL
        ) {
        return [self errorWithDomain:originalError.domain
                                code:originalError.code
                            userInfo:@{NSLocalizedDescriptionKey: RNLocalized(@"Please check your connection to server.")}];
    }
    
    // AFNetworking
    RNHTTPError *error = nil;
    NSData *resopnseData = originalError.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    NSString *responeString = [[NSString alloc] initWithData:resopnseData encoding:NSUTF8StringEncoding];
    error = [self specificHttpErrorFromResponse:(NSHTTPURLResponse *)task.response responseString:responeString];
    if (error) {
        return error;
    }
    
    if (task.error) {
        return [self errorWithURL:task.currentRequest.URL description:task.error.localizedDescription];
    }
    return [self errorWithURL:task.currentRequest.URL description:RNLocalized(@"Unknown")];
}

+ (RNHTTPError *)errorWithURL:(NSURL *)url description:(NSString *)desc {
    
    NSString *logMsg = [NSString stringWithFormat:@"request to %@ got error %@", url, desc];
    BPRemoteLogError(@"client.http.error", logMsg, nil);
    
    NSString *errorMessage = [NSString stringWithFormat:RNLocalized(@"Error: %@\n                                                                                   Request URL: %@\nRequest time out occurs when the requested action could not be completed in a given amount of time. This could have occurred due to a slow or faulty internet connection.\nIf you continue to see this message please check your internet connection. If your internet is working properly please reach out to Bindo support to report the issue."),desc, url.absoluteString];
    
    RNHTTPError *error = [self errorWithDomain:RN_ERROR_DOMAIN
                                          code:ERROR_CODE_TIMEOUT
                                      userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey]];
    return error;
}

#pragma mark - Error from specific HTTP status codes

+ (RNHTTPError *)specificHttpErrorFromResponse:(NSHTTPURLResponse *)response responseString:(NSString *)responseString {
    if (response.statusCode < 400 && response.statusCode >= 200) {
        return nil;
    }
    
    NSDictionary *errorInfo = [responseString objectFromJSONString];
    id errorCodeString = errorInfo[@"code"];
    NSInteger errorCode = 0;
    if (nil != errorCodeString && ![errorCodeString isEqual:[NSNull null]]) {
        errorCode = [errorCodeString integerValue];
    }
    NSString *errorMessage = errorInfo[@"message"];
    
    if (nil == errorMessage || [errorMessage isEqual:[NSNull null]]) {
        return nil;
    }
    
    RNHTTPError *error = nil;
    
    if (response.statusCode == 400) {
        error = [self errorWithDomain:RN_ERROR_DOMAIN
                                 code:ERROR_CODE_LOGIN_FAIL
                             userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey]];
    } else if (response.statusCode == 401) {
        /*
         * When User logout, then if sign up, the new user (currentUser) is not consistent with
         * currentStore, so server will send this error message.
         * Should be prevented by server, temporarily solved by [BPUserDefaults shouldReceiveDeactiveMessage].
         */
        rn_dispatch_main_async(^{
            //[[NSNotificationCenter defaultCenter] postNotificationName:notificationKeyUserNeedLogin object:[FCUser currentUser].login];
        });
        error = [self errorWithDomain:RN_ERROR_DOMAIN
                                 code:ERROR_CODE_NEED_LOGIN
                             userInfo:[NSDictionary dictionaryWithObject:RNLocalized(@"You are logged out because you have logged in with another device. Please sign in again.") forKey:NSLocalizedDescriptionKey]];
    } else if (response.statusCode == 403) {
        NSDictionary *respDic = [responseString objectFromJSONString];
        NSNumber *storeID = [respDic objectForKey:@"store_id"];
        rn_dispatch_main_async(^{
            //[[NSNotificationCenter defaultCenter] postNotificationName:notificationKeyStoreNotActivated object:storeID];
        });
        error = [self errorWithDomain:RN_ERROR_DOMAIN
                                 code:ERROR_CODE_INACTIVE
                             userInfo:[NSDictionary dictionaryWithObject:RNLocalized(@"Your store is being activated. Please contact 1-800-MY-BINDO for assistance.") forKey:NSLocalizedDescriptionKey]];
    } else if (response.statusCode == 404) {
        error = [self errorWithDomain:RN_ERROR_DOMAIN
                                 code:ERROR_CODE_NOT_FOUND
                             userInfo:[NSDictionary dictionaryWithObject:RNLocalized(@"The resource not found.") forKey:NSLocalizedDescriptionKey]];
    } else if (response.statusCode == 500 || [errorMessage length] > 0) {
        error = [self errorWithDomain:RN_ERROR_DOMAIN
                                 code:errorCode
                             userInfo:[NSDictionary dictionaryWithObject:errorMessage forKey:NSLocalizedDescriptionKey]];
    }
    
    NSString *logMsg = [NSString stringWithFormat:@"request to %@ got error %@", response.URL, error];
    BPRemoteLogError(@"client.http.error", logMsg, nil);
    
    return error;
}

#pragma mark - Eror from multiple errors

+ (RNHTTPError *)errorFromErrors: (NSArray *)errors {
    NSMutableString *messages = [NSMutableString string];
    for (NSError *error in errors) {
        if (messages.length == 0) {
            [messages appendString:[error localizedDescription]];
        } else {
            [messages appendString:[NSString stringWithFormat:@"\n%@", [error localizedDescription]]];
        }
    }
    if (errors.count > 0) {
        return [RNHTTPError errorWithDomain:RN_ERROR_DOMAIN code:ERROR_CODE_HTTP_ERROR userInfo:[NSDictionary dictionaryWithObject:messages forKey:NSLocalizedDescriptionKey]];
    } else {
        return nil;
    }
}

+ (RNHTTPError *)alertError:(NSError *)error fromTask:(NSURLSessionTask *)task
{
    RNHTTPError *processedError = [RNHTTPError errorFromURLSessionTask:task originalError:error];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:RNLocalized(@"Alert")
                                                 message:[processedError localizedDescription]
                                                delegate:nil
                                       cancelButtonTitle:RNLocalized(@"OK")
                                       otherButtonTitles:nil];
    [av show];
    
    return processedError;
}


@end
