//
//  RNRegisterModel.h
//  CDCDiamond
//
//  Created by Frank on 2020/3/28.
//  Copyright © 2020 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>
///bpdm/sys/appRegister
//fileb
//string
//true
//个人名片（文件）
//filea
//string
//true
//个人身份证（文件）
//filec
//string
//true
//公司证书（文件）

NS_ASSUME_NONNULL_BEGIN

@interface RNRegisterModel : NSObject
//英文名第一个输入框
@property (nonatomic, copy) NSString *usernameFirst;
//英文名第二个输入框
@property (nonatomic, copy) NSString *usernameLast;
//中文名
@property (nonatomic, copy) NSString *ChinseName;
//区号（个人信息）
@property (nonatomic, copy) NSString *address3;
//手机号（个人信息）
@property (nonatomic, copy) NSString *phone;
//电子邮箱
@property (nonatomic, copy) NSString *email;
//性别
@property (nonatomic, copy) NSString *Gender;
//公司名称
@property (nonatomic, copy) NSString *comname;
//公司代码
@property (nonatomic, copy) NSString *comcode;
//国家
@property (nonatomic, copy) NSString *country;
//职位
@property (nonatomic, copy) NSString *position;
//公司手机号区号
@property (nonatomic, copy) NSString *countries;
//公司手机号
@property (nonatomic, copy) NSString *mobile;
//传真
@property (nonatomic, copy) NSString *fax;
//城市
@property (nonatomic, copy) NSString *city;
//部门
@property (nonatomic, copy) NSString *department;
//地址
@property (nonatomic, copy) NSString *address;
//网站
@property (nonatomic, copy) NSString *website;
//地址2
@property (nonatomic, copy) NSString *address2;

@end

NS_ASSUME_NONNULL_END
