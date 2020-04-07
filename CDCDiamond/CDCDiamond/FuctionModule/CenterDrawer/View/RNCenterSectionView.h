//
//  RNCenterSectionView.h
//  RapNet
//
//  Created by liufulin on 2019/10/13.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const centerSectionIndentifer = @"RNCenterSectionView";

@protocol RNCenterSectionViewDelegate <NSObject>

@optional
- (void)didClickNewsAll;

@end

@interface RNCenterSectionView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *sideButton;
@property (nonatomic, weak) id<RNCenterSectionViewDelegate>delegate;

@end



NS_ASSUME_NONNULL_END
