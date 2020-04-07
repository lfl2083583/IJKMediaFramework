//
//  RNRegisterProtocolViewController.h
//  CDCDiamond
//
//  Created by Frank on 2020/4/6.
//  Copyright © 2020 Frank. All rights reserved.
//

#import "RNViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNRegisterProtocolViewController : RNViewController

@property (nonatomic, strong) NSDictionary *program;

- (instancetype)initWithProgram:(NSDictionary *)program;

@end

NS_ASSUME_NONNULL_END
