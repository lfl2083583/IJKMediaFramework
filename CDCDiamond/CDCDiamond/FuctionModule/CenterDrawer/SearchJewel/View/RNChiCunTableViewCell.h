//
//  RNChiCunTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/7.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const chiCunTableViewCellIndenfier = @"RNXinZhuangTableViewCell";

@protocol RNChiCunTableViewCellDelegate <NSObject>

@optional;
- (void)onChiCunTableViewCellMinInput:(NSString *)minInput maxInput:(NSString *)maxInput;

@end


@interface RNChiCunTableViewCell : UITableViewCell

@property (nonatomic, weak) id<RNChiCunTableViewCellDelegate>delegate;
@property (nonatomic, strong) RNSearchJewelModel *jewelModel;
@property (nonatomic, strong) RNBuyRequestAddModel *addModel;
@end


NS_ASSUME_NONNULL_END
