//
//  RNUserScoreTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/21.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNBaseUserInfoTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

static NSString *userScoreIdentifier = @"RNBaseUserInfoTableViewCell";

@interface RNUserScoreTableViewCell : RNBaseUserInfoTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *memberLB;
@property (weak, nonatomic) IBOutlet UILabel *scoreLB;
@property (weak, nonatomic) IBOutlet UILabel *fontLB;
@property (weak, nonatomic) IBOutlet UILabel *backLB;

@end

NS_ASSUME_NONNULL_END
