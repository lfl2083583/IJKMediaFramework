//
//  RNUserInfo.m
//  RapNet
//
//  Created by liufulin on 2019/10/13.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNUserInfo.h"
#import "RNUserModel.h"
#import "objc/runtime.h"

@implementation RNUserInfo

static RNUserInfo *_userinfo = nil;
static inline NSString * RNDocumentsFilePath(NSString *fileName)
{
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [directories[0] stringByAppendingPathComponent:fileName];
}
static NSString *kRNUserInfoPersistentPath = @"RNUserInfo";

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userinfo = [super allocWithZone:zone];
    });
    return _userinfo;
}

+ (instancetype)shareUserInfo
{
    @synchronized(self)
    {
        if (_userinfo == nil)
        {
            if ([NSKeyedUnarchiver unarchiveObjectWithFile:RNDocumentsFilePath(kRNUserInfoPersistentPath)]) {
                return [NSKeyedUnarchiver unarchiveObjectWithFile:RNDocumentsFilePath(kRNUserInfoPersistentPath)];
            }
            else
            {
                return [[self alloc] init];
            }
        }
        return _userinfo;
    }
}

/**
 *  归档
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *ivarName = ivar_getName(ivars[i]);
        NSString *name = [NSString stringWithUTF8String:ivarName];
        id value = [self valueForKey:name];
        [aCoder encodeObject:value forKey:name];
    }
    free(ivars);
}

/**
*  解档
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (unsigned int i = 0; i < count; i++) {
            const char *ivarName = ivar_getName(ivars[i]);
            NSString *name = [NSString stringWithUTF8String:ivarName];
            id value = [aDecoder decodeObjectForKey:name];
            [self setValue:value forKey:name];
        }
        free(ivars);
    }
    return self;
}

- (void)save
{
    NSString *path = RNDocumentsFilePath(kRNUserInfoPersistentPath);
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}

- (void)clear
{
    //[self save];
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"CREATEGUID"      : @"basedata.CREATEGUID",
             @"CREATETIME"      : @"basedata.CREATETIME",
             @"F_ADDRESS"       : @"basedata.F_ADDRESS",
             @"F_ADDRESS2"      : @"basedata.F_ADDRESS2",
             @"F_CITY"          : @"basedata.F_CITY",
             @"F_CITYNAME"      : @"basedata.F_CITYNAME",
             @"F_COMCODE"       : @"basedata.F_COMCODE",
             @"F_COMNAME"       : @"basedata.F_COMNAME",
             @"F_COMPANYTYPE"   : @"basedata.F_COMPANYTYPE",
             @"F_COMPANYTYPE2"  : @"basedata.F_COMPANYTYPE2",
             @"F_COMPANYTYPE3"  : @"basedata.F_COMPANYTYPE3",
             @"F_COUNTRY"       : @"basedata.F_COUNTRY",
             @"F_COUNTRYNAME"   : @"basedata.F_COUNTRYNAME",
             @"F_EMAIL"         : @"basedata.F_EMAIL",
             @"F_ENDTIME"       : @"basedata.F_ENDTIME",
             @"F_FACEBOOK"      : @"basedata.F_FACEBOOK",
             @"F_FAMPHONE"      : @"basedata.F_FAMPHONE",
             @"F_FAX"           : @"basedata.F_FAX",
             @"F_HEADIMG"       : @"basedata.F_HEADIMG",
             @"F_INDENT"        : @"basedata.F_INDENT",
             @"F_INDENT2"       : @"basedata.F_INDENT2",
             @"F_INTRO"         : @"basedata.F_INTRO",
             @"F_LICENSE"       : @"basedata.F_LICENSE",
             @"F_LINKEDIN"      : @"basedata.F_LINKEDIN",
             @"F_MAINPHONE"     : @"basedata.F_MAINPHONE",
             @"ile"             : @"basedata.ile",
             @"F_MOBILE"        : @"basedata.F_MOBILE",
             @"F_PHONE"         : @"basedata.F_PHONE",
             @"F_RECOMMEND"     : @"basedata.F_RECOMMEND",
             @"F_SCALE"         : @"basedata.F_SCALE",
             @"F_SCORE"         : @"basedata.F_SCORE",
             @"F_SETUPTIME"     : @"basedata.F_SETUPTIME",
             @"F_SHENG"         : @"basedata.F_SHENG",
             @"F_SHENGNAME"     : @"basedata.F_SHENGNAME",
             @"F_SKYPE"         : @"basedata.F_SKYPE",
             @"F_STATE"         : @"basedata.F_STATE",
             @"F_WEBSITE"       : @"basedata.F_WEBSITE",
             @"F_ZIP"           : @"basedata.F_ZIP",
             @"GUID"            : @"basedata.GUID",
             @"LT_FLOWS"        : @"basedata.LT_FLOWS",
             @"PROTECTED"       : @"basedata.PROTECTED",
             @"STATE"           : @"basedata.STATE",
             @"UF_BLACKID"      : @"basedata.UF_BLACKID",
             @"UF_COMID"        : @"basedata.UF_COMID",
             @"UF_COMPANYCARD"  : @"basedata.UF_COMPANYCARD",
             @"UF_EMAIL"        : @"basedata.UF_EMAIL",
             @"UF_HEADIMG"      : @"basedata.UF_HEADIMG",
             @"UF_HYGRADE"      : @"basedata.UF_HYGRADE",
             @"UF_ISSHOW"       : @"basedata.UF_ISSHOW",
             @"UF_ISZHU"        : @"basedata.UF_ISZHU",
             @"UF_NAME"         : @"basedata.UF_NAME",
             @"UF_PASSWORD"     : @"basedata.UF_PASSWORD",
             @"UF_PHONE"        : @"basedata.UF_PHONE",
             @"UF_POSITION"     : @"basedata.UF_POSITION",
             @"UF_SCORE"        : @"basedata.UF_SCORE",
             @"UF_SHENCATD"     : @"basedata.UF_SHENCATD",
             @"UF_USERNAME"     : @"basedata.UF_USERNAME",
             @"UF_ZIP"          : @"basedata.UF_ZIP",
             @"UF_ZPHONE"       : @"basedata.UF_ZPHONE",
             @"UGUID"           : @"basedata.UGUID",
             @"UPDATEGUID"      : @"basedata.UPDATEGUID",
             @"UPDATETIME"      : @"basedata.UPDATETIME",
             @"F_COMPANYTYPENAME":@"basedata.F_COMPANYTYPENAME",
             @"comtype"         : @"basedata.comtype",
             @"ptbNum"          : @"diamondnum.ptbNum",
             @"ptcNum"          : @"diamondnum.ptcNum",
             @"cbbNum"          : @"diamondnum.cbbNum",
             @"cbcNum"          : @"diamondnum.cbcNum",
             @"ppbNum"          : @"diamondnum.ppbNum",
             @"ppcNum"          : @"diamondnum.ppcNum",
             @"AllNum"          : @"diamondnum.AllNum",
             @"months"          : @"diamondnum.months",
             @"isBlack"         : @"diamondnum.isBlack",
             @"isQing"          : @"diamondnum.isQing",

             @"list"            : @"lists",
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : [RNUserModel class]};
}

@end
