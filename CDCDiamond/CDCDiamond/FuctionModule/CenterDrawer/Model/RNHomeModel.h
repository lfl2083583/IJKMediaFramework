//
//  RNHomeModel.h
//  RapNet
//
//  Created by liufulin on 2019/9/22.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RNNewsModel;

NS_ASSUME_NONNULL_BEGIN

@interface RNBannerModel : NSObject

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *linkUrl;

@end

//@interface RNHomeNewsModel : NSObject
//
//@property (nonatomic, copy) NSString *author;
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *createTime;
//@property (nonatomic, copy) NSString *newsID;
//
//
//@end

@interface RNMenuModel : NSObject

@property (nonatomic, assign) int code;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *englishText;
@property (nonatomic, copy) NSString *simplifyText;
@property (nonatomic, copy) NSString *trditionalText;

@end

@interface RNHomeModel : NSObject

@property (nonatomic, strong) NSArray <RNBannerModel *>*bannners;
@property (nonatomic, strong) NSArray <RNMenuModel *>*centerMunus;
@property (nonatomic, strong) NSArray <RNMenuModel *>*leftMenus;
@property (nonatomic, strong) NSArray <RNNewsModel *>*news;
@property (nonatomic, copy)   NSString *caveatContent;
@property (nonatomic, copy)   NSString *caveatTime;
@property (nonatomic, assign) int xzsize;

@end

NS_ASSUME_NONNULL_END
