//
//  RNBuyRequestAddModel.h
//  RapNet
//
//  Created by jt on 2019/11/10.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNBuyRequestAddModel : NSObject

@property (nonatomic, copy) NSString *GUID;
@property (nonatomic, copy) NSString *F_CHANG;
//长度
@property (nonatomic, copy) NSString *F_SIZEMIN;
//最小尺寸
@property (nonatomic, copy) NSString *F_GAOMIN;
//最小高度
@property (nonatomic, copy) NSString *F_KUAN;
//宽度
@property (nonatomic, copy) NSString *F_COLOR;
//普通颜色
@property (nonatomic, copy) NSString *F_PLNGLUAN;
//用户评论
@property (nonatomic, copy) NSString *F_PRICETOTAL;
//价格
@property (nonatomic, copy) NSString *F_DEPTHMIN;
//最小深度
@property (nonatomic, copy) NSString *F_FANCYCCOLOROVERTONE;
//光彩
@property (nonatomic, copy) NSString *F_POLISHED;
//抛光
@property (nonatomic, copy) NSString *F_LOWTIPTJ;
//底尖条件
@property (nonatomic, copy) NSString *F_FIELD;
//卖家地点
@property (nonatomic, copy) NSString *F_CLARITY;
//净度
@property (nonatomic, copy) NSString *F_REAL;
//荧光
@property (nonatomic, copy) NSString *F_WAISTTJ;
//腰围条件
@property (nonatomic, copy) NSString *F_KUANMIN;
//最小宽度
@property (nonatomic, copy) NSString *F_ACTUAL;
//通知
@property (nonatomic, copy) NSString *F_BOTTOMMIN;
//最小台面百分比
@property (nonatomic, copy) NSString *F_DUI;
//对（是否匹配成对的钻石）
@property (nonatomic, copy) NSString *F_PRICE;
//价格类型
@property (nonatomic, copy) NSString *F_SYMMETRICAL;
//对称性
@property (nonatomic, copy) NSString *F_PRICETOTALMIN;//
//对称性
@property (nonatomic, copy) NSString *F_PRICETOTALMAX;
//最小价格
@property (nonatomic, copy) NSString *F_FANCYCCOLORIMENSTFY;
//强度
@property (nonatomic, copy) NSString *F_FANCYCCOLOR1;
//彩钻颜色
@property (nonatomic, copy) NSString *F_CUT;
//切工
@property (nonatomic, copy) NSString *F_EXPIRE;
//到期日期
@property (nonatomic, copy) NSString *F_SHAPE;
//形状
@property (nonatomic, copy) NSString *F_LABORATORY;
//实验室
@property (nonatomic, copy) NSString *F_BOTTOM;
//台面百分比
@property (nonatomic, copy) NSString *F_GAO;
//高度
@property (nonatomic, copy) NSString *F_ISCZ;
//颜色类型（是否彩钻）
@property (nonatomic, copy) NSString *F_DEPTH;
//深度
@property (nonatomic, copy) NSString *F_SIZE;
//尺寸
@property (nonatomic, copy) NSString *F_CHANGMIN;
//最小长度
@property (nonatomic, copy) NSString *F_HANDLE;
//处理
@property (nonatomic, copy) NSString *F_DEPTHPERCENTAGE;
//深度百分比
@property (nonatomic, copy) NSString *F_DEPTHPERCENTAGEMIN;
//最小深度百分比
@property (nonatomic, copy) NSString *F_PURCHASENO;

@property (nonatomic, copy) NSString *F_TIME;
//用户ID
@property (nonatomic, copy) NSString *F_YHID;

@property (nonatomic, copy) NSString *F_CLARITY1;
@property (nonatomic, copy) NSString *F_COLOR1;
@property (nonatomic, copy) NSString *F_FIELD1;
@property (nonatomic, assign) BOOL F_ISZS;

- (NSMutableDictionary *)getParameters;
@end

NS_ASSUME_NONNULL_END
