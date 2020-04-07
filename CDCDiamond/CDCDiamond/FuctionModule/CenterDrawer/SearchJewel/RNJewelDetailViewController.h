//
//  RNJewelDetailViewController.h
//  RapNet
//
//  Created by liufulin on 2019/10/31.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNJewelDetailViewController : RNViewController

@property (nonatomic, copy) NSString *GUID;

- (instancetype)initWithGUID:(NSString *)GUID;

@end

NS_ASSUME_NONNULL_END
