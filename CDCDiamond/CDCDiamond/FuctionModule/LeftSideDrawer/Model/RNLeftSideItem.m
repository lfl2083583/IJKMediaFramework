//
//  RNLeftSideItem.m
//  RapNet
//
//  Created by liufulin on 2019/7/22.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNLeftSideItem.h"

@implementation RNLeftSideItem

- (instancetype)initWithIcon:(UIImage *)icon subSideItems:(NSArray *)subSideItems itemType:(RNSideMenuItem)itemTye {
    self = [super init];
    if (self) {
        self.icon = icon;
        self.subSideItems = subSideItems;
        self.rows = subSideItems.count;
        self.isOpen = NO;
        self.itemType = itemTye;
    }
    return self;
}

@end
