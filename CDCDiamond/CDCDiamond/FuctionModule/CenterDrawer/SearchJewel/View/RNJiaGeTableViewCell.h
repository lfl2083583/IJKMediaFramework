//
//  RNJiaGeTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RNJiaGeTableViewCellDelegate <NSObject>

- (void)onjiaGeTableViewCellDidChooseJiage:(NSString *)type;
- (void)onjiaGeTableViewCellDidChooseJiageMinprice:(NSString *)minprice;
- (void)onjiaGeTableViewCellDidChooseJiageMaxprice:(NSString *)maxprice;

@end

static NSString *const jiaGeTableViewCellIndenfier = @"RNJiaGeTableViewCell";
static NSString *const jiaGeAddRequestCellIndenfier = @"RNJiaGeAddRequestTableViewCell";

@interface RNJiaGeTableViewCell : UITableViewCell

@property (nonatomic, weak) id<RNJiaGeTableViewCellDelegate>delegate;
@property (nonatomic, strong) RNSearchJewelModel *jewelModel;
@property (nonatomic, strong) RNBuyRequestAddModel *addModel;

@end



NS_ASSUME_NONNULL_END
