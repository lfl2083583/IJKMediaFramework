//
//  RNRequestDetailViewController.h
//  RapNet
//
//  Created by Frank on 2020/3/16.
//  Copyright © 2020 lptechnology. All rights reserved.
//

#import "RNViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNRequestDetailViewController : RNViewController

@property (nonatomic, assign) BOOL eidteEnable;

- (instancetype)initWithGUID:(NSString *)GUID eidteEnable:(BOOL)eidteEnable;


@end

NS_ASSUME_NONNULL_END
