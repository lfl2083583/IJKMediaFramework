//
//  RNHomeModel.m
//  RapNet
//
//  Created by liufulin on 2019/9/22.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNHomeModel.h"
#import "RNNewsModel.h"

@implementation RNBannerModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"imageUrl"                 : @"F_IMGADDRESS",
             @"linkUrl"                  : @"F_IMGWEDSITE",
             };
}


@end

//@implementation RNHomeNewsModel
//
//+ (NSDictionary *)mj_replacedKeyFromPropertyName
//{
//    return @{
//             @"author"                 : @"F_AUTHOR",
//             @"title"                  : @"F_BIGTITLE",
//             @"createTime"             : @"F_DATE",
//             @"newsID"                 : @"GUID",
//             };
//}
//
//
//@end


@implementation RNMenuModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"code"                 : @"F_CODE",
             @"imageUrl"             : @"F_IMG",
             @"englishText"          : @"F_ENGLISH",
             @"simplifyText"         : @"F_TEXT",
             @"trditionalText"       : @"F_TRADITIONAL",
             };
}

@end



@implementation RNHomeModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"bannners"            : @"imgData",
             @"centerMunus"         : @"indexMenuData",
             @"leftMenus"           : @"leftMenuData",
             @"news"                : @"newsData",
             @"caveatContent"       : @"caveatData.F_CONTENT",
             @"caveatTime"          : @"caveatData.F_DATE",
             };
}

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"bannners"     : [RNBannerModel class],
             @"centerMunus"  : [RNMenuModel class],
             @"leftMenus"    : [RNMenuModel class],
             @"news"         : [RNNewsModel class]
             };
}
@end
