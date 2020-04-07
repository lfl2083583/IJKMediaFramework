//
//  RNLeftSideTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/7/22.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const leftSideIdentifier = @"RNLeftSideTableViewCell";
static NSString *const leftSideImgIdentifier = @"RNLeftSideImgTableViewCell";

@interface RNLeftSideTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLB;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIImageView *arrowImgView;
@property (nonatomic, strong) UIView *line;

@end



@interface RNLeftSideImgTableViewCell : RNLeftSideTableViewCell

@property (nonatomic, strong) UIImageView *imgView;

@end

NS_ASSUME_NONNULL_END


