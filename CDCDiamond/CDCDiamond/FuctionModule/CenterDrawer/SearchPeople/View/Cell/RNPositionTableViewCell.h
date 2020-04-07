//
//  RNPositionTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const positionIdentifier = @"RNPositionTableViewCell";

@protocol RNPositionTableViewCellDelegate <NSObject>

- (void)onPositionTableViewCellCountryClick:(UIButton *)countryBtn;
- (void)onPositionTableViewCellProviceBtnClick:(UIButton *)proviceBtn;
@end

@interface RNPositionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *countryBtn;
@property (weak, nonatomic) IBOutlet UIButton *proviceBtn;

@property (nonatomic, weak) id<RNPositionTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
