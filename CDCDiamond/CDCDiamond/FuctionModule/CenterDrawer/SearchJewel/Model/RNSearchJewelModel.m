//
//  RNSearchJewelModel.m
//  RapNet
//
//  Created by jt on 2019/11/3.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNSearchJewelModel.h"

@implementation RNSearchJewelModel

- (instancetype)init {
    self = [super init];
    if (self) {
        //形状
        _shape = @"";
        //尺寸最小值
        _size = @"";
        //尺寸最大值
        _maxsize = @"";
        //颜色
        _color = @"";
        //净度
        _clarity = @"";
        //切口
        _cut = @"";
        //抛光
        _polished = @"";
        //对称性
        _symmetrical = @"";
        //地址选择类型
        _loctiontype = @"1";

        _drpState = @"";
        //城市
        _city = @"";
        //鉴定所
        _jiandingsuo = @"";
        //价格最小值
        _pricemin = @"";
        //价格最大值
        _pricemax = @"";
        //价格类型1，2,3）
        _pricetype = @"1";
        //荧光强度
        _fluorescent = @"";
        //萤光颜色
        _fluorescentcorol = @"";
        //是否高级会员
        _ishighmember = false;
        //是否彩钻（0：普通颜色，1：彩钻）
        _iscz = false;
        //可售状态
        _isavalible = false;
        //是否匹配对
        _isppd = false;
        //证书编号
        _reportId = @"";
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
    
    NSString *color = [dict objectForKey:@"color"];
    if (color && KFormat(color).length) {
        NSArray *array = @[@"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
        NSArray *list = [color componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            [muArr addObject:@([array indexOfObject:KFormat(value)]+1)];
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"color"];
        }
    }
    
    NSString *clarity = [dict objectForKey:@"clarity"];
    if (clarity && KFormat(clarity).length) {
        NSArray *array = @[@"FL", @"IF", @"VVS1", @"VVS2", @"VS1", @"VS2", @"SI1", @"SI2", @"SI3", @"I1", @"I2", @"I3"];
        NSArray *list = [clarity componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            [muArr addObject:@([array indexOfObject:KFormat(value)]+1)];
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"clarity"];
        }
    }
    
    NSString *cut = [dict objectForKey:@"cut"];
    if (cut && KFormat(cut).length) {
        NSArray *array =  @[@"Ideal", @"Excellent", @"Very Good", @"Good", @"Fail", @"Poor"];
        NSArray *list = [cut componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            [muArr addObject:@([array indexOfObject:KFormat(value)]+1)];
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"cut"];
        }
    }
    
    NSString *polished = [dict objectForKey:@"polished"];
    if (polished && KFormat(polished).length) {
        NSArray *array =  @[@"Ideal", @"Excellent", @"Very Good", @"Good", @"Fail", @"Poor"];
        NSArray *list = [polished componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            [muArr addObject:@([array indexOfObject:KFormat(value)]+1)];
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"polished"];
        }
    }
    
    NSString *symmetrical = [dict objectForKey:@"symmetrical"];
    if (symmetrical && KFormat(symmetrical).length) {
        NSArray *array =  @[@"Ideal", @"Excellent", @"Very Good", @"Good", @"Fail", @"Poor"];
        NSArray *list = [symmetrical componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            [muArr addObject:@([array indexOfObject:KFormat(value)]+1)];
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"symmetrical"];
        }
    }
    
    NSString *jiandingsuo = [dict objectForKey:@"jiandingsuo"];
    if (jiandingsuo && KFormat(jiandingsuo).length) {
        NSArray *array = @[@"GIA",@"RAP",@"AGS",@"HRD",@"IGI",@"RDC",@"CGL",@"DCLA",@"GCAL",@"GHI",@"IIDGR",@"GSI",@"NGTC",@"PGS",@"NONE",@"IGI-USA"];
        NSArray *list = [jiandingsuo componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            [muArr addObject:@([array indexOfObject:KFormat(value)]+1)];
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"jiandingsuo"];
        }
    }
    
    NSString *shadecos = [dict objectForKey:@"shadecos"];
    if (shadecos && KFormat(shadecos).length) {
        NSArray *shade = @[@"Any" ,@"None",@"No Brown",@"No Yellow",@"No Green",@"No Grey",@"No Black", @"No Pink", @"No Blue"];
        NSArray *array = @[@"" ,@"None",@"Brown",@"Yellow",@"Green",@"Grey",@"Black", @"Pink", @"Blue"];
        NSArray *list = [shadecos componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            NSInteger i = [shade indexOfObject:KFormat(value)];
            [muArr addObject:[array objectAtIndex:i]];
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"shadecos"];
        }
    }
    
    NSString *fluorescent = [dict objectForKey:@"fluorescent"];
    if (fluorescent && KFormat(fluorescent).length) {
        NSArray *array = @[@"None", @"Very Slight", @"Faint", @"Medium", @"Strong", @"Very Strong"];
        NSArray *list = [fluorescent componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            [muArr addObject:@([array indexOfObject:KFormat(value)]+1)];
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"fluorescent"];
        }
    }
    
    NSString *fluorescentcorol = [dict objectForKey:@"fluorescentcorol"];
    if (fluorescentcorol && KFormat(fluorescentcorol).length) {
        NSArray *array = @[@"Blue", @"Yellow", @"Green", @"Red", @"Orange", @"White"];
        NSArray *list = [fluorescentcorol componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            [muArr addObject:@([array indexOfObject:KFormat(value)]+1)];
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"fluorescentcorol"];
        }
    }
    
    if ([[dict objectForKey:@"isppd"] boolValue] == 1) {
        [parameters setValue:@"true" forKey:@"isppd"];
    } else {
        [parameters setValue:@"false" forKey:@"isppd"];
    }
    
    if ([[dict objectForKey:@"ishighmember"] boolValue] == 1) {
        [parameters setValue:@"true" forKey:@"ishighmember"];
    } else {
        [parameters setValue:@"false" forKey:@"ishighmember"];
    }
    
    NSString *locationStr = [dict objectForKey:@"loction"];
    if (locationStr && KFormat(locationStr).length) {
        NSArray *array = [KFormat(locationStr) componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        if ([RNUserInfo shareUserInfo].countryMap && [RNUserInfo shareUserInfo].countryMap.count) {
            for (NSString *key in array) {
                [muArr addObject:[[RNUserInfo shareUserInfo].countryMap objectForKey:KFormat(key)]];
            }
        }
        
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"loction"];
        }
    }
    
    NSString *whiteinclusions = [dict objectForKey:@"whiteinclusions"];
    if (whiteinclusions && KFormat(whiteinclusions).length) {
        NSArray *array = @[@"Any", @"White Inclusions None", @"White Table Meaningles", @"White Table Small", @"White Table Medium", @"White Table Large", @"White Crown Meaningless", @"White Crown Small", @"White Crown Medium", @"White Crown Large"];
        NSArray *list = [whiteinclusions componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            [muArr addObject:@([array indexOfObject:KFormat(value)])];
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"whiteinclusions"];
        }
    }
    
    NSString *blackinclusions = [dict objectForKey:@"blackinclusions"];
    if (blackinclusions && KFormat(blackinclusions).length) {
        NSArray *array = @[@"Any", @"None", @"Light", @"Medium", @"Heavy",@"Black Table Meaningless", @"Black Table Small", @"Black Table Medium", @"Black Table Large", @"Black Crown Meaningless", @"Black Crown Small", @"Black Crown Medium",@"Black Crown Large"];
        NSArray *list = [blackinclusions componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            NSInteger j = [array indexOfObject:KFormat(value)];
            if (j > 0) {
               [muArr addObject:@(j)];
            }
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"blackinclusions"];
        }
    }
    
    NSString *eyeclean = [dict objectForKey:@"eyeclean"];
    if (eyeclean && KFormat(eyeclean).length) {
        NSArray *array = @[@"Yes", @"Borderline", @"No"];
        NSArray *list = [eyeclean componentsSeparatedByString:@","];
        NSMutableArray *muArr = [NSMutableArray array];
        for (id value in list) {
            [muArr addObject:[array objectAtIndex:[KFormat(value) intValue]]];
        }
        if (muArr.count) {
            [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"eyeclean"];
        }
    }
    
    
    if ([RNUserInfo shareUserInfo].laboratoryArray && [RNUserInfo shareUserInfo].laboratoryArray.count) {
        NSString *jiandingsuo = [dict objectForKey:@"jiandingsuo"];
        if (jiandingsuo && KFormat(jiandingsuo).length) {
            NSArray *array = [RNUserInfo shareUserInfo].laboratoryArray;
            NSArray *list = [jiandingsuo componentsSeparatedByString:@","];
            NSMutableArray *muArr = [NSMutableArray array];
            for (id value in list) {
                [muArr addObject:[array objectAtIndex:[KFormat(value) intValue]]];
            }
            if (muArr.count) {
                [parameters setValue:[muArr componentsJoinedByString:@","] forKey:@"jiandingsuo"];
            }
        }
    }

    return parameters;
}

@end
 
