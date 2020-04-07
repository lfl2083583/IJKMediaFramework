//
//  SettingsTableViewItem.h
//  RapNet
//
//  Created by liufulin on 2019/8/9.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsTableViewItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) NSInteger rowType;

+ (instancetype)itemWithTitle:(NSString *)title rowType:(NSInteger)rowType;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon rowType:(NSInteger)rowType;

@end

NS_ASSUME_NONNULL_END
