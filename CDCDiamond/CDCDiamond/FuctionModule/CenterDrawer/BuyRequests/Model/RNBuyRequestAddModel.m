//
//  RNBuyRequestAddModel.m
//  RapNet
//
//  Created by jt on 2019/11/10.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNBuyRequestAddModel.h"

@implementation RNBuyRequestAddModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _F_PRICE = @"%/Ct";
        _F_ISCZ = @"false";
    }
    return self;
}

- (NSMutableDictionary *)getParameters {
    NSDictionary *dict = [self mj_keyValues];
    NSMutableDictionary *parameters = [dict mutableCopy];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id value = dict[key];
        if (value && [value isKindOfClass:[NSString class]] && [value isEqualToString:@""]) {
            [parameters removeObjectForKey:key];
        }
    }];
    
//    NSString *color = [dict objectForKey:@"F_COLOR"];
//    if (color && KFormat(color).length) {
//        NSArray *array = @[@"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
//        NSArray *list = [color componentsSeparatedByString:@","];
//        NSMutableArray *muArr = [NSMutableArray array];
//        for (id value in list) {
//            [muArr addObject:@([array indexOfObject:KFormat(value)]+1)];
//        }
//        if (muArr.count) {
//            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"F_COLOR"];
//        }
//    }
//
    NSString *waisttj = [dict objectForKey:@"F_WAISTTJ"];
    if (waisttj && KFormat(waisttj).length) {
        NSArray *array = @[@"Polished", @"Faceted", @"Bruted"];
        NSArray *list = [waisttj componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            [muArr addObject:@([array indexOfObject:KFormat(value)])];
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"F_WAISTTJ"];
        }
    }
    
    return parameters;
}


@end
