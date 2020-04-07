//
//  RNUserModel.h
//  RapNet
//
//  Created by liufulin on 2019/10/13.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNUserModel : MTLModel

@property (nonatomic, copy) NSString *CREATEGUID;
@property (nonatomic, copy) NSString *CREATETIME;
@property (nonatomic, copy) NSString *F_BLACKID;
@property (nonatomic, copy) NSString *F_COMID;
@property (nonatomic, copy) NSString *F_COMPANYCARD;
@property (nonatomic, copy) NSString *F_EMAIL;
@property (nonatomic, copy) NSString *F_ENDTIME;
@property (nonatomic, copy) NSString *F_HEADIMG;
@property (nonatomic, copy) NSString *F_HYGRADE;
@property (nonatomic, copy) NSString *F_ISSHOW;
@property (nonatomic, copy) NSString *F_ISZHU;
@property (nonatomic, copy) NSString *F_NAME;
@property (nonatomic, copy) NSString *F_PASSWORD;
@property (nonatomic, copy) NSString *F_PHONE;
@property (nonatomic, copy) NSString *F_POSITION;
@property (nonatomic, copy) NSString *F_QDID;
@property (nonatomic, copy) NSString *F_SCORE;
@property (nonatomic, copy) NSString *F_SHENCATD;
@property (nonatomic, copy) NSString *F_UPDATE;
@property (nonatomic, copy) NSString *F_USERNAME;
@property (nonatomic, copy) NSString *F_ZIP;
@property (nonatomic, copy) NSString *F_ZPHONE;
@property (nonatomic, copy) NSString *GUID;
@property (nonatomic, copy) NSString *LT_FLOWS;
@property (nonatomic, copy) NSString *PROTECTED;
@property (nonatomic, copy) NSString *STATE;
@property (nonatomic, copy) NSString *UPDATEGUID;
@property (nonatomic, copy) NSString *UPDATETIME;
@property (nonatomic, copy) NSString *UF_PHONE;

@end

NS_ASSUME_NONNULL_END
