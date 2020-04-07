//
//  RNOldSearchJewelViewController.h
//  RapNet
//
//  Created by liufulin on 2019/10/4.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RNOldSearchJewelViewControllerDelegate <NSObject>

@optional
- (void)onRNOldSearchJewelViewControllerSeletedRow:(id)source;

@end


@interface RNOldSearchJewelViewController : RNViewController

@property (nonatomic, weak) id<RNOldSearchJewelViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
