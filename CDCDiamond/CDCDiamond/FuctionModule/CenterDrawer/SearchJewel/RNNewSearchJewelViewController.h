//
//  RNNewSearchJewelViewController.h
//  RapNet
//
//  Created by liufulin on 2019/10/4.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNViewController.h"
#import "RNSearchJewelModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^ RNNewSearchJewelBlock)(RNSearchJewelModel *jewelModel);

@interface RNNewSearchJewelViewController : RNViewController

@property (nonatomic, strong) RNSearchJewelModel *jewelModel;
@property (nonatomic, copy) RNNewSearchJewelBlock callBack;

- (void)reloadData;

@end




NS_ASSUME_NONNULL_END
