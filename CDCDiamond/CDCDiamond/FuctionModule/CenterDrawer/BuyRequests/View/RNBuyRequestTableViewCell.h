//
//  RNBuyRequestTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/17.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNBuyRequestModel.h"
NS_ASSUME_NONNULL_BEGIN


static NSString *const buyRequestIndentifier = @"RNBuyRequestTableViewCell";

@interface RNBuyRequestTableViewCell : UITableViewCell

@property (nonatomic, strong) RNBuyRequestModel *model;

@end

NS_ASSUME_NONNULL_END
