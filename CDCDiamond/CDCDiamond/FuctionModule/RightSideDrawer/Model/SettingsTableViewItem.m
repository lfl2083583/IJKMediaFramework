//
//  SettingsTableViewItem.m
//  RapNet
//
//  Created by liufulin on 2019/8/9.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "SettingsTableViewItem.h"

@implementation SettingsTableViewItem

+ (instancetype)itemWithTitle:(NSString *)title rowType:(NSInteger)rowType {
    SettingsTableViewItem *item = [SettingsTableViewItem new];
    item.title = title;
    item.rowType = rowType;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon rowType:(NSInteger)rowType {
    SettingsTableViewItem *item = [self itemWithTitle:title rowType:rowType];
    item.icon = icon;
    return item;
}

@end
