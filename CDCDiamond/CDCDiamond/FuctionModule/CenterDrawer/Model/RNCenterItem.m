//
//  RNCenterItem.m
//  RapNet
//
//  Created by liufulin on 2019/7/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNCenterItem.h"

@implementation RNCenterItem

- (instancetype)initWithClass:(Class)class cellheight:(CGFloat)cellheight rows:(NSInteger)rows {
    if (self = [super init]) {
        self.class = class;
        self.cellHeight = cellheight;
        self.rows = rows;
        self.className = NSStringFromClass(class);
    }
    return self;
}

@end
