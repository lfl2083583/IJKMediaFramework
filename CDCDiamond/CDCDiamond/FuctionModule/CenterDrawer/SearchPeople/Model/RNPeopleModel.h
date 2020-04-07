//
//  RNPeopleModel.h
//  RapNet
//
//  Created by liufulin on 2019/10/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNPeopleModel : NSObject

@property (nonatomic, copy) NSString *UGUID;
@property (nonatomic, copy) NSString *F_COMNAME;
@property (nonatomic, copy) NSString *F_COUNTRYNAME;//国家
@property (nonatomic, copy) NSString *F_NAME;
@property (nonatomic, copy) NSString *F_USERNAME;
@property (nonatomic, copy) NSString *F_SHENGNAME;//省份
@property (nonatomic, copy) NSString *F_SCORE;
@property (nonatomic, copy) NSString *F_COMPANYTYPE;
@property (nonatomic, copy) NSString *CGUID;
@property (nonatomic, copy) NSString *F_CITYNAME;//城市

@end

NS_ASSUME_NONNULL_END
