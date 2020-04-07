//
//  RNNewsDetailContentTableViewCell.h
//  RapNet
//
//  Created by jt on 2019/11/8.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNNewsModel.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *NewDetailContentIdentifier = @"RNNewsDetailContentTableViewCell";

@interface RNNewsDetailContentTableViewCell : UITableViewCell

@property (nonatomic, strong) RNNewsModel *model;

@end

NS_ASSUME_NONNULL_END
