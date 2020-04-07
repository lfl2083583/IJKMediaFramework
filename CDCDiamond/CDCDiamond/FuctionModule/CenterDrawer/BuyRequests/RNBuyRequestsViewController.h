//
//  RNBuyRequestsViewController.h
//  RapNet
//
//  Created by tjl on 2019/10/11.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "FJSlidingController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNBuyRequestsViewController : FJSlidingController

@property (nonatomic, assign) int index;

- (instancetype)initIsFromSideMenue:(BOOL)isFromSideMenue seletedIndex:(int)seletedIndex;

@end

NS_ASSUME_NONNULL_END
