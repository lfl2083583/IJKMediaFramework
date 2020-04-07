//
//  RNNewsTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/9/26.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RNNewsModel;

NS_ASSUME_NONNULL_BEGIN

static NSString *const newsIdentifier = @"RNNewsTableViewCell";

@interface RNNewsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *subtitleLB;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) RNNewsModel *newsModel;

@end

NS_ASSUME_NONNULL_END
