//
//  RNWeizhiTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RNWeizhiTableViewCell;

static NSString *const weiZhiTableViewCellIndenfier = @"RNWeiZhiTableViewCell";

@protocol RNWeizhiTableViewCellDelegate <NSObject>
@optional
- (void)onWeizhiTableViewCellPositionTypeClick:(int)positionType;
- (void)onWeizhiTableViewCellAddressChanged:(NSMutableArray *)addressList;
- (void)onWeizhiTableViewCellAddPostionClick:(RNWeizhiTableViewCell *)cell;
- (void)onWeizhiTableViewCellSellEnableClick:(RNWeizhiTableViewCell *)cell;

@end


@interface RNWeizhiTableViewCell : UITableViewCell

@property (nonatomic, assign) int positionType;
@property (nonatomic, weak) id<RNWeizhiTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxBtn;
@property (nonatomic, strong) NSMutableArray *addressList;
@property (nonatomic, strong) RNSearchJewelModel *jewelModel;

@end





NS_ASSUME_NONNULL_END
