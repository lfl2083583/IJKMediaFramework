//
//  RNUserDefault.h
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNUserDefault : NSObject

+ (void)setDefaultValue:(id)v forKey:(NSString *)k;
+ (id)defaultValueForKey:(NSString *)k;
+ (void)removeValueForKey:(NSString *)k;

@end

NS_ASSUME_NONNULL_END
