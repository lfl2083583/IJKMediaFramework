//
//  RNUserInfo.h
//  RapNet
//
//  Created by liufulin on 2019/10/13.
//  Copyright © 2019 lptechnology. All rights reserved.
//
#import <Mantle/Mantle.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNUserInfo : NSObject<NSCoding>

@property (nonatomic, copy) NSString *CREATEGUID;
@property (nonatomic, copy) NSString *CREATETIME;
@property (nonatomic, copy) NSString *F_ADDRESS;
@property (nonatomic, copy) NSString *F_ADDRESS2;
@property (nonatomic, copy) NSString *F_CITY;
@property (nonatomic, copy) NSString *F_CITYNAME;
@property (nonatomic, copy) NSString *F_COMCODE;
@property (nonatomic, copy) NSString *F_COMNAME;
@property (nonatomic, copy) NSString *F_COMPANYTYPE;
@property (nonatomic, copy) NSString *F_COMPANYTYPE2;
@property (nonatomic, copy) NSString *F_COMPANYTYPE3;
@property (nonatomic, copy) NSString *F_COUNTRY;
@property (nonatomic, copy) NSString *F_COUNTRYNAME;
@property (nonatomic, copy) NSString *F_EMAIL;
@property (nonatomic, copy) NSString *F_ENDTIME;
@property (nonatomic, copy) NSString *F_FACEBOOK;
@property (nonatomic, copy) NSString *F_FAMPHONE;
@property (nonatomic, copy) NSString *F_FAX;
@property (nonatomic, copy) NSString *F_HEADIMG;
@property (nonatomic, copy) NSString *F_INDENT;
@property (nonatomic, copy) NSString *F_INDENT2;
@property (nonatomic, copy) NSString *F_INTRO;
@property (nonatomic, copy) NSString *F_LICENSE;
@property (nonatomic, copy) NSString *F_LINKEDIN;
@property (nonatomic, copy) NSString *F_MAINPHONE;
@property (nonatomic, copy) NSString *ile;
@property (nonatomic, copy) NSString *F_MOBILE;
@property (nonatomic, copy) NSString *F_PHONE;
@property (nonatomic, copy) NSString *F_RECOMMEND;
@property (nonatomic, copy) NSString *F_SCALE;
@property (nonatomic, copy) NSString *F_SCORE;
@property (nonatomic, copy) NSString *F_SETUPTIME;
@property (nonatomic, copy) NSString *F_SHENG;
@property (nonatomic, copy) NSString *F_SHENGNAME;
@property (nonatomic, copy) NSString *F_SKYPE;
@property (nonatomic, copy) NSString *F_STATE;
@property (nonatomic, copy) NSString *F_WEBSITE;
@property (nonatomic, copy) NSString *F_ZIP;
@property (nonatomic, copy) NSString *GUID;
@property (nonatomic, copy) NSString *LT_FLOWS;
@property (nonatomic, copy) NSString *PROTECTED;
@property (nonatomic, copy) NSString *STATE;
@property (nonatomic, copy) NSString *UF_BLACKID;
@property (nonatomic, copy) NSString *UF_COMID;
@property (nonatomic, copy) NSString *UF_COMPANYCARD;
@property (nonatomic, copy) NSString *UF_EMAIL;
@property (nonatomic, copy) NSString *UF_HEADIMG;
@property (nonatomic, copy) NSString *UF_HYGRADE;
@property (nonatomic, copy) NSString *UF_ISSHOW;
@property (nonatomic, copy) NSString *UF_ISZHU;
@property (nonatomic, copy) NSString *UF_NAME;
@property (nonatomic, copy) NSString *UF_PASSWORD;
@property (nonatomic, copy) NSString *UF_PHONE;
@property (nonatomic, copy) NSString *UF_POSITION;
@property (nonatomic, copy) NSString *UF_SCORE;
@property (nonatomic, copy) NSString *UF_SHENCATD;
@property (nonatomic, copy) NSString *UF_USERNAME;
@property (nonatomic, copy) NSString *UF_ZIP;
@property (nonatomic, copy) NSString *UF_ZPHONE;
@property (nonatomic, copy) NSString *UGUID;
@property (nonatomic, copy) NSString *UPDATEGUID;
@property (nonatomic, copy) NSString *UPDATETIME;
@property (nonatomic, copy) NSString *comtype;
@property (nonatomic, copy) NSString *F_COMPANYTYPENAME;

@property (nonatomic, copy) NSString *ptbNum;
@property (nonatomic, copy) NSString *ptcNum;
@property (nonatomic, copy) NSString *cbbNum;
@property (nonatomic, copy) NSString *cbcNum;
@property (nonatomic, copy) NSString *ppbNum;
@property (nonatomic, copy) NSString *ppcNum;
@property (nonatomic, copy) NSString *AllNum;
@property (nonatomic, copy) NSString *months;
@property (nonatomic, copy) NSString *isBlack;
@property (nonatomic, copy) NSString *isQing;


@property (nonatomic, strong) NSArray *list;

@property (nonatomic, copy) NSString *hedImg;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *loginname;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *TImeAll;
@property (nonatomic, copy) NSString *TIme12;

@property (nonatomic, strong) NSMutableDictionary *countryMap;
@property (nonatomic, strong) NSMutableArray *laboratoryArray;

+ (instancetype)shareUserInfo;

/**
 保存数据
 */
- (void)save;

/**
 clear数据
 */
- (void)clear;

@end

NS_ASSUME_NONNULL_END
