//
//  RNLeftSideItem.h
//  RapNet
//
//  Created by liufulin on 2019/7/22.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNLeftSideItem : NSObject

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSArray <NSString *>*subSideItems;
@property (nonatomic, assign) NSInteger rows;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) RNSideMenuItem itemType;

- (instancetype)initWithIcon:(UIImage *)icon subSideItems:(NSArray *)subSideItems itemType:(RNSideMenuItem)itemTye;

@end

NS_ASSUME_NONNULL_END
