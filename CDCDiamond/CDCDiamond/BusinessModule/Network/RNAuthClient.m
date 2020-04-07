//
//  RNAuthClient.m
//  RapNet
//
//  Created by liufulin on 2019/9/19.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNAuthClient.h"

static RNAuthClient * sharedAuthClient = nil;
static dispatch_once_t onceToken = 0;

@implementation RNAuthClient

+ (RNAuthClient *)sharedAuthClient {
    dispatch_once(&onceToken, ^{
        sharedAuthClient = [[RNAuthClient alloc] initWithAPI];
    });
    return sharedAuthClient;
}

- (instancetype)initWithAPI {
    self = [super initWithBaseURL:[NSURL URLWithString:BaseServer]];
    return self;
}

@end
