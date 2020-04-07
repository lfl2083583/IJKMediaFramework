//
//  RNAuthClient.h
//  RapNet
//
//  Created by liufulin on 2019/9/19.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNHTTPClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNAuthClient : RNHTTPClient

+ (RNAuthClient *)sharedAuthClient;


@end

NS_ASSUME_NONNULL_END
