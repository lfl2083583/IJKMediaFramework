//
//  RNHTTPJSONRequestSerializer.h
//  RapNet
//
//  Created by liufulin on 2019/7/19.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "AFURLRequestSerialization.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNHTTPJSONRequestSerializer : AFJSONRequestSerializer

+ (instancetype)defaultSerializer;

@end

NS_ASSUME_NONNULL_END
