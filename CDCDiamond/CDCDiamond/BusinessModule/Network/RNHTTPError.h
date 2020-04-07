//
//  RNHTTPError.h
//  RapNet
//
//  Created by liufulin on 2019/7/19.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNHTTPError : NSError

+ (RNHTTPError *)errorFromURLSessionTask:(NSURLSessionTask *)task;
+ (RNHTTPError *)errorFromURLSessionTask:(NSURLSessionTask *)task originalError:(NSError *)originalError;
+ (RNHTTPError *)specificHttpErrorFromResponse:(NSHTTPURLResponse *)response responseString:(NSString *)responseString;
+ (RNHTTPError *)timeoutError;
+ (RNHTTPError *)unknownErrorWithURL:(NSURL *)url statusCode:(NSInteger)statusCode responseString:(NSString *)responseString;
+ (RNHTTPError *)errorFromErrors: (NSArray *)errors;

+ (RNHTTPError *)alertError:(NSError *)error fromTask:(NSURLSessionTask *)task;

@end

NS_ASSUME_NONNULL_END
