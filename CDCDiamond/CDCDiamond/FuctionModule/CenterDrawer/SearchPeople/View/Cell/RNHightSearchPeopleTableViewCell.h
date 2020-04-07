//
//  RNHightSearchPeopleTableViewCell.h
//  RapNet
//
//  Created by tjl on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNMagicField.h"
NS_ASSUME_NONNULL_BEGIN

@class RNHightSearchPeopleTableViewCell;


@protocol RNHightSearchPeopleTableViewCellDelegate <NSObject>

@optional
- (void)onHightSearchPeopleTableViewCellEditChanged:(RNHightSearchPeopleTableViewCell *)cell;

@end

static NSString *const hightSearchPeopleidentifier = @"RNHightSearchPeopleTableViewCell";


@interface RNHightSearchPeopleTableViewCell : UITableViewCell

@property (nonatomic, strong) RNMagicField *field;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, weak) id<RNHightSearchPeopleTableViewCellDelegate>delegate;
@property (nonatomic, copy) NSString *placehold;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end


NS_ASSUME_NONNULL_END
