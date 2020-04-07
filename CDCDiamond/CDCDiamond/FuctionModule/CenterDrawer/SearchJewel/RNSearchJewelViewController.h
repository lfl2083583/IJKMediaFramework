//
//  RNSearchJewelViewController.h
//  RapNet
//
//  Created by liufulin on 2019/10/4.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJSlidingController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNSearchJewelViewController : FJSlidingController

@property (nonatomic, assign) int index;
@property (nonatomic, strong) RNSearchJewelModel *jewelModel;

- (instancetype)initIsFromSideMenue:(BOOL)isFromSideMenue seletedIndex:(int)seletedIndex;

@end

NS_ASSUME_NONNULL_END
