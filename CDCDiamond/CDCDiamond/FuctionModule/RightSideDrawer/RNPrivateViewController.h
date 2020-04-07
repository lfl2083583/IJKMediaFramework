//
//  RNPrivateViewController.h
//  RapNet
//
//  Created by tjl on 2020/1/20.
//  Copyright © 2020 lptechnology. All rights reserved.
//

#import "RNViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNPrivateViewController : RNViewController

@property (nonatomic, assign) int type;

- (instancetype)initWithType:(int)type;

@end

NS_ASSUME_NONNULL_END
