//
//  RNNewsChildViewController.h
//  RapNet
//
//  Created by liufulin on 2019/10/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNNewsChildViewController : RNViewController

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) UIViewController *parentVC;

@end

NS_ASSUME_NONNULL_END
