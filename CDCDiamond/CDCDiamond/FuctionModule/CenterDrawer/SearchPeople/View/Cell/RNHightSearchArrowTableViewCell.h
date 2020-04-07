//
//  RNHightSearchArrowTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *hightSearchArrowIdentifier = @"RNHightSearchArrowTableViewCell";

@interface RNHightSearchArrowTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UILabel *detailLB;

@end

NS_ASSUME_NONNULL_END
