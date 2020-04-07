//
//  RNNewsModel.h
//  RapNet
//
//  Created by liufulin on 2019/10/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNNewsModel : NSObject

@property (nonatomic, copy) NSString *STATE;
@property (nonatomic, copy) NSString *PROTECTED;
@property (nonatomic, copy) NSString *GUID;
@property (nonatomic, copy) NSString *F_BIGTITLE;
@property (nonatomic, copy) NSString *UPDATEGUID;
@property (nonatomic, copy) NSString *F_DATE;
@property (nonatomic, copy) NSString *CREATETIME;
@property (nonatomic, copy) NSString *F_CONTENT;
@property (nonatomic, copy) NSString *F_AUTHOR;
@property (nonatomic, copy) NSString *F_TITLE;
@property (nonatomic, copy) NSString *CREATEGUID;
@property (nonatomic, copy) NSString *F_TYPEID;
@property (nonatomic, copy) NSString *F_TYPE;
@property (nonatomic, copy) NSString *UPDATETIME;
@property (nonatomic, copy) NSString *LT_FLOWS;
@property (nonatomic, copy) NSString *cguid;
@property (nonatomic, copy) NSString *F_NEWSIMG;
@property (nonatomic, copy) NSString *F_NEWSAPP;


@property (nonatomic, assign) CGFloat rowHight;

@end

NS_ASSUME_NONNULL_END
