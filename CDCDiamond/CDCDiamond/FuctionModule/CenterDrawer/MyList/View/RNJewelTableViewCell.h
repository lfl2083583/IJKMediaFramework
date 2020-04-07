//
//  RNJewelTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/18.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNTrackJewelModel.h"
@class RNJewelTableViewCell;

NS_ASSUME_NONNULL_BEGIN

static NSString * jewelTableViewCellIndentifier = @"RNJewelTableViewCell";

@protocol RNJewelTableViewCellDelegate <NSObject>
@optional
- (void)onJewelTableViewCellAddLike:(RNJewelTableViewCell *)cell;
- (void)onJewelTableViewCellCancelLike:(RNJewelTableViewCell *)cell;

@end

@interface RNJewelTableViewCell : UITableViewCell

@property (weak, nonatomic) id<RNJewelTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (nonatomic, strong) RNTrackJewelListModel *trackListModel;

@end





NS_ASSUME_NONNULL_END
