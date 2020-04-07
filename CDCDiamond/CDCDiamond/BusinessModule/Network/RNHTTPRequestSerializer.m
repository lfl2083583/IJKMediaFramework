//
//  RNHTTPRequestSerializer.m
//  RapNet
//
//  Created by liufulin on 2019/7/22.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNHTTPRequestSerializer.h"

@implementation RNHTTPRequestSerializer


+ (instancetype)defaultSerializer
{
    RNHTTPRequestSerializer *requestSerializer = [super serializer];
    requestSerializer.timeoutInterval = 180.0;
    requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [requestSerializer setValue:@"X-WWW-FORM-URLENCODED" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    return requestSerializer;
}

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError * __autoreleasing *)error {
    
//    if ([FCUser currentUser].userID) {
//        NSString *accessToken = [FCUser currentUser].singleAccessToken;
//        if (!accessToken || [accessToken isEmpty]) {
//            BPLogError(@"user is signed in but access token can't be found. user id: %@, store id: %@", [FCUser currentUser].userID, [FCStore currentStore].storeID);
//        } else {
//            [self setValue:accessToken forHTTPHeaderField:kDBAccessTokenHTTPHeaderField];
//            // For new server
//            [self setValue:[NSString stringWithFormat:@"%@%@", kBPRequestHeaderFieldAccessTokenAuthorizationValuePrefix, accessToken] forHTTPHeaderField:kBPRequestHeaderFieldAccessTokenAuthorization];
//        }
//    }
//    [self setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:kClientReuqestIdHeaderField];
    
    return [super requestBySerializingRequest:request withParameters:parameters error:error];
}

@end
