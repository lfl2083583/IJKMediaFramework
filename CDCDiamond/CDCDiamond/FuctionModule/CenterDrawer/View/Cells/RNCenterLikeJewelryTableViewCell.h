//
//  RNCenterJewelryTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/7/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const centerLikeJewelryIdentifier = @"RNCenterLikeJewelryTableViewCell";

@interface RNCenterLikeJewelryTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *focusBtn;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subtitle;

@end

NS_ASSUME_NONNULL_END
