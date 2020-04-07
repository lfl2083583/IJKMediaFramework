//
//  RNBuyRequestDetalViewController.h
//  RapNet
//
//  Created by jt on 2019/11/6.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNBuyRequestDetalViewController : RNViewController


@property (nonatomic, assign) BOOL eidteEnable;

- (instancetype)initWithGUID:(NSString *)GUID eidteEnable:(BOOL)eidteEnable;


@end

NS_ASSUME_NONNULL_END
