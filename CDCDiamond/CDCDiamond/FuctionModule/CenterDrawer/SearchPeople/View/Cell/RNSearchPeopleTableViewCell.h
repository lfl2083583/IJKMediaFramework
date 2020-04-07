//
//  RNSearchPeopleTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/14.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RNPeopleModel;

NS_ASSUME_NONNULL_BEGIN

static NSString *const searchPeopleIndentifier = @"RNSearchPeopleTableViewCell";

@interface RNSearchPeopleTableViewCell : UITableViewCell

@property (nonatomic, strong) RNPeopleModel *model;

@end

NS_ASSUME_NONNULL_END
