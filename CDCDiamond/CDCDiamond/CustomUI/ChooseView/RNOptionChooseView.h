//
//  RNOptionChooseView.h
//  FKGPopSelected
//
//  Created by tjl on 2019/11/5.
//  Copyright © 2019 forkingghost. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OptionChooseViewBlock)(NSArray *array);

@interface RNOptionChooseView : UIView

@property (nonatomic, assign) CGFloat topSpace;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *normalImges;
@property (nonatomic, strong) NSArray *seletedImgs;
@property (nonatomic, strong) NSArray *defaultArray;
@property (nonatomic, assign) BOOL singleEnable; // 单选是否可以
@property (nonatomic, copy) OptionChooseViewBlock chooseBlock;

- (instancetype)initWithTopSpace:(CGFloat)topspace;
- (instancetype)initWithTopSpace:(CGFloat)topspace searchAvaliable:(BOOL)searchAvaliable;
- (void)showWithDataSource:(NSArray *)dataSource chooseBlock:(OptionChooseViewBlock)chooseBlock defaultArray:(NSArray *)defaultArray;
- (void)showWithDataSource:(NSArray *)dataSource normalImges:(NSArray *)normalImges seletedImgs:(NSArray *)seletedImgs  chooseBlock:(OptionChooseViewBlock)chooseBlock;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
