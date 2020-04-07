//
//  RNUserMemberTableViewCell.h
//  RapNet
//
//  Created by jt on 2019/11/5.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNBaseUserInfoTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const userMemberIdentifier = @"RNUserMemberTableViewCell";

@interface RNUserMemberTableViewCell : RNBaseUserInfoTableViewCell

@property (nonatomic, assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END
