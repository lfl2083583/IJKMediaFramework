//
//  RNMessageListTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/11/20.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNMessageListModel.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *messageListIdentifier = @"RNMessageListTableViewCell";

@interface RNMessageListTableViewCell : UITableViewCell

@property (nonatomic, strong) RNMessageListModel *model;

@end

NS_ASSUME_NONNULL_END
