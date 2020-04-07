//
//  RNCenterWarningTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/7/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const centerWarningIdentifier = @"RNCenterWarningTableViewCell";

@interface RNCenterWarningTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *warnstring;

@end

NS_ASSUME_NONNULL_END
