//
//  RNJSONResponseSerializer.m
//  RapNet
//
//  Created by liufulin on 2019/7/22.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNJSONResponseSerializer.h"
#import "RNHTTPError.h"

@implementation RNJSONResponseSerializer

- (BOOL)validateResponse:(NSHTTPURLResponse *)response
                    data:(NSData *)data
                   error:(NSError * __autoreleasing *)error
{
    BOOL isValid = [super validateResponse:response data:data error:error];
    if (*error != nil) {
        NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
        NSData *errorData = userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (errorData) {
            NSString *responeString = [[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding];
            NSError *newError = [RNHTTPError specificHttpErrorFromResponse:userInfo[AFNetworkingOperationFailingURLResponseErrorKey] responseString:responeString];
            if (newError) {
                (*error) = newError;
            }
        }
    }
    return isValid;
}

@end
