//
//  RNCenterItemTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/7/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RNMenuModel;

NS_ASSUME_NONNULL_BEGIN

static NSString *const centerItemIdentifier = @"RNCenterItemTableViewCell";

@protocol RNCenterItemTableViewCellDelegate <NSObject>

@optional
- (void)didClickItem:(int)index;

@end

@interface RNCenterItemTableViewCell : UITableViewCell

@property (nonatomic, weak) id<RNCenterItemTableViewCellDelegate>delegate;
@property (nonatomic, strong) NSArray <RNMenuModel *>*centerMunus;
@property (nonatomic, assign) int unreadCount;

@end



NS_ASSUME_NONNULL_END
