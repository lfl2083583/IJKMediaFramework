//
//  RNUserDetailViewController.h
//  RapNet
//
//  Created by liufulin on 2019/10/13.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNUserDetailViewController : RNViewController

@property (nonatomic, copy) NSString *GUID;

- (instancetype)initIsFromSideMenue:(BOOL)isFromSideMenue GUID:(NSString *)GUID;

@end

NS_ASSUME_NONNULL_END
