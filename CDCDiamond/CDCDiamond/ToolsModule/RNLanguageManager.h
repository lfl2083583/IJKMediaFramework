//
//  RNLanguageManager.h
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNLanguageManager : NSObject

@property (nonatomic, assign) int languageType;

+ (instancetype)shareManager;

- (void)setLanguageForEnglish;

- (void)setLanguageForChinese;

- (void)setLanguageForSimplified;

@end

NS_ASSUME_NONNULL_END
