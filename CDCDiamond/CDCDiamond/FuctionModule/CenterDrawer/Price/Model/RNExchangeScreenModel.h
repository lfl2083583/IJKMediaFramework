//
//  RNExchangeScreenModel.h
//  RapNet
//
//  Created by liufulin on 2019/10/27.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNExchangeScreenModel : NSObject

@property (nonatomic, copy) NSString *F_CLARITY;
@property (nonatomic, copy) NSString *F_COLOR;
@property (nonatomic, copy) NSString *F_JIANDINGSUO;
@property (nonatomic, copy) NSString *F_PRICE;
@property (nonatomic, copy) NSString *F_SHAPE;
@property (nonatomic, copy) NSString *F_SIZE;
@property (nonatomic, copy) NSString *GUID;
@property (nonatomic, copy) NSString *avgdiscount;
@property (nonatomic, copy) NSString *avgprice;
@property (nonatomic, copy) NSString *mindiscount;

@end

NS_ASSUME_NONNULL_END
