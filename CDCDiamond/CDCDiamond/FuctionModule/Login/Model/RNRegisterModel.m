//
//  RNRegisterModel.m
//  CDCDiamond
//
//  Created by Frank on 2020/3/28.
//  Copyright © 2020 Frank. All rights reserved.
//

#import "RNRegisterModel.h"

@implementation RNRegisterModel

- (instancetype)init {
    self = [super init];
    if (self) {
        //英文名第一个输入框
        _usernameFirst = @"";
        //英文名第二个输入框
        _usernameLast = @"";
        //中文名
        _ChinseName = @"";
        //区号（个人信息）
        _address3 = @"";
        //手机号（个人信息）
        _phone = @"";
        //电子邮箱
        _email = @"";
        //性别
        _Gender = @"";
        //公司名称
        _comname = @"";
        //公司代码
        _comcode = @"";
        //国家
        _country = @"";
        //职位
        _position = @"";
        //公司手机号区号
        _countries = @"";
        //公司手机号
        _mobile = @"";
        //传真
        _fax = @"";
        //城市
        _city = @"";
        //部门
        _department = @"";
        //地址
        _address = @"";
        //网站
        _website = @"";
        //地址2
        _address2 = @"";

    }
    return self;
}

@end
