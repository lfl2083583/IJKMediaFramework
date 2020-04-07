//
//  RNTrackJewelTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RNTrackJewelModel;

NS_ASSUME_NONNULL_BEGIN

static NSString *const trackJewelIdentifier = @"RNTrackJewelTableViewCell";

@interface RNTrackJewelTableViewCell : UITableViewCell

@property (nonatomic, strong) RNTrackJewelModel *model;

@end

NS_ASSUME_NONNULL_END
