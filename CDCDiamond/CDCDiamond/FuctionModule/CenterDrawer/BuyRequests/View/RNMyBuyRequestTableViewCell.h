//
//  RNMyBuyRequestTableViewCell.h
//  RapNet
//
//  Created by jt on 2019/11/5.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RNBuyRequestModel.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const myBuyRequestIdentifier = @"RNMyBuyRequestTableViewCell";

@interface RNMyBuyRequestTableViewCell : UITableViewCell

@property (nonatomic, strong) RNBuyRequestModel *model;

@end

NS_ASSUME_NONNULL_END
