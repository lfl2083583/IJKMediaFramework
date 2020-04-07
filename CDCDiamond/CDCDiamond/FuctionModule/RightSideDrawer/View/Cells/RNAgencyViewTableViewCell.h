//
//  RNAgencyViewTableViewCell.h
//  RapNet
//
//  Created by tjl on 2019/11/11.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const agencyIdentifier = @"RNAgencyViewTableViewCell";

@protocol RNAgencyViewTableViewCellDelegate <NSObject>

- (void)onPhoneClick:(NSString *)phone;
- (void)onEmailClick:(NSString *)email;

@end

@interface RNAgencyViewTableViewCell : UITableViewCell

@property (nonatomic, strong) id source;
@property (nonatomic, weak) id<RNAgencyViewTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
