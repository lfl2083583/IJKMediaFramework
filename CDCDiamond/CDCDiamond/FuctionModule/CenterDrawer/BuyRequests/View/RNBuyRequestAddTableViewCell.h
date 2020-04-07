//
//  RNBuyRequestAddTableViewCell.h
//  RapNet
//
//  Created by jt on 2019/11/10.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNBuyRequestAddModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RNBuyRequestAddTableViewCellBlock)(RNBuyRequestAddModel *model);

static NSString *buyRequestAddTableViewCellIdentideir = @"RNBuyRequestAddTableViewCell";

@interface RNBuyRequestAddTableViewCell : UITableViewCell

@property (nonatomic, strong) RNBuyRequestAddModel *model;
@property (nonatomic, copy) RNBuyRequestAddTableViewCellBlock callBack;
@property (nonatomic, assign) BOOL singleEnable; // 单选是否可以

@end

NS_ASSUME_NONNULL_END
