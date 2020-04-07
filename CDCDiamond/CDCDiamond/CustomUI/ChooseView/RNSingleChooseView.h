//
//  RNSingleChooseView.h
//  FKGPopSelected
//
//  Created by tjl on 2019/11/6.
//  Copyright © 2019 forkingghost. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SingleOptionChooseViewBlock)(NSInteger index);

@interface RNSingleChooseView : UIView

@property (nonatomic, copy) SingleOptionChooseViewBlock chooseBlock;

- (instancetype)initWithDataSource:(NSArray *)dataSource chooseBlock:(SingleOptionChooseViewBlock)chooseBlock;

- (void)show;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
