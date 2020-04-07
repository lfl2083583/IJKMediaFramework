//
//  RNChooseView.h
//  RapNet
//
//  Created by liufulin on 2019/10/7.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RNChooseView;

NS_ASSUME_NONNULL_BEGIN
@protocol RNChooseViewDelegate <NSObject>

@optional
- (void)onChooseViewDidSeletedOptions:(NSArray *)options;
- (void)onChooseViewDidSeletedOptions:(NSArray *)options chooseView:(RNChooseView *)chooseView;

@end

@interface RNChooseView : UIView

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) NSArray *chooses;
@property (nonatomic, strong) NSArray *defaultChooses;
@property (nonatomic, weak) id<RNChooseViewDelegate>delegate;
@property (nonatomic, assign) BOOL singleChoose;

- (instancetype)initWithChooses:(NSArray *)chooses rect:(CGRect)rect;
- (instancetype)initWithChooses:(NSArray *)chooses rect:(CGRect)rect singleChoose:(BOOL)singleChoose;

@end



NS_ASSUME_NONNULL_END
