//
//  RNTableViewSectionHead.h
//  RapNet
//
//  Created by liufulin on 2019/7/22.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const sectionHeadIdentifier = @"RNTableViewSectionHead";

@interface RNTableViewSectionHead : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *contentLB;
@property (nonatomic, strong) UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
