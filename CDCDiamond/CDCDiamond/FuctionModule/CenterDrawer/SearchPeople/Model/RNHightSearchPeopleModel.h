//
//  RNHightSearchPeopleModel.h
//  RapNet
//
//  Created by jt on 2019/11/12.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNHightSearchPeopleModel : NSObject

@property (nonatomic, copy) NSString *comname;
//true string
//用户id|用户名称|公司名称（支持模糊查询）
@property (nonatomic, copy) NSString *city;
//true string
//城市代码
@property (nonatomic, copy) NSString *ratings;
//true string
//评分等级
@property (nonatomic, copy) NSString *mname;
//true string
//用户名
@property (nonatomic, copy) NSString *country;
//true string
//国家
@property (nonatomic, copy) NSString *dialist;
//true string
//钻石上市
@property (nonatomic, copy) NSString *comcode;
//true string
//公司代码
@property (nonatomic, copy) NSString *sheng;
//true string
//省
@property (nonatomic, copy) NSString *website;
//true string
//网站
@property (nonatomic, copy) NSString *comtype;
//true string
//公司类型
@property (nonatomic, copy) NSString *phone;
//true string
//手机号
@property (nonatomic, copy) NSString *rapID;
//true string
//登录账号*/

@end

NS_ASSUME_NONNULL_END
