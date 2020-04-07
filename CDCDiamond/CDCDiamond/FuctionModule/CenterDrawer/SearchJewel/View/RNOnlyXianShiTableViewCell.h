//
//  RNOnlyXianShiTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RNOnlyXianShiTableViewCellDelegate <NSObject>

- (void)onOnlyXianShiTableViewCellDidChooseSuppier:(RNSearchJewelModel *)jewelModel;

@end

static NSString *const onlyXianShiIdentifier = @"RNOnlyXianShiTableViewCell";

@interface RNOnlyXianShiTableViewCell : UITableViewCell

@property (nonatomic, weak) id<RNOnlyXianShiTableViewCellDelegate>delegate;
@property (nonatomic, strong) RNSearchJewelModel *jewelModel;

@end



NS_ASSUME_NONNULL_END
