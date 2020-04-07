//
//  RNMoreSearchTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/30.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNSearchJewelModel.h"
@class RNMoreSearchTableViewCell;
@class ZTTextField;

NS_ASSUME_NONNULL_BEGIN

static NSString *const moreSearchIdentifier = @"RNMoreSearchTableViewCell";

@protocol RNMoreSearchTableViewCellDelegate <NSObject>

- (void)moreSearchTableViewCellDidClickMoreBtn:(RNMoreSearchTableViewCell *)cell;
- (void)onSearchMoreRapIDChanged:(NSString *)text;
- (void)onSearchMoreStockChaned:(NSString *)text;
- (void)onSearchMinTaimainChanged:(NSString *)text;
- (void)onSearchMaxTaimainChanged:(NSString *)text;
- (void)onSearchMinshenduChanged:(NSString *)text;
- (void)onSearchMaxshenduChanged:(NSString *)text;
- (void)onSearchMinchangChanged:(NSString *)text;
- (void)onSearchMaxchangChanged:(NSString *)text;
- (void)onSearchMinkuanduChanged:(NSString *)text;
- (void)onSearchMaxkuanduChanged:(NSString *)text;
- (void)onSearchMinshengduChaned:(NSString *)text;
- (void)onSearchMaxshengduChaned:(NSString *)text;
- (void)onSearchMinbiliChanged:(NSString *)text;
- (void)onSearchMaxbiliChanged:(NSString *)text;
- (void)onSearchMinguanjiaoChanged:(NSString *)text;
- (void)onSearchMaxguanjiaoChanged:(NSString *)text;
- (void)onSearchMindishenChaned:(NSString *)text;
- (void)onSearchMaxdishenChaned:(NSString *)text;
- (void)onSearchMindijiaoChanged:(NSString *)text;
- (void)onSearchMaxdijiaoChanged:(NSString *)text;
- (void)onSearchSaomiaoChanged:(NSString *)text;
- (void)onSearchJewelImgChanged:(NSString *)text;
- (void)onSearchVideoEnable:(NSString *)text;
- (void)onSearchEyeChanged:(NSString *)text;
- (void)onSearchMinyaoweiChanged:(NSString *)text;
- (void)onSearchMaxyaoweiChanged:(NSString *)text;
- (void)onSearchNeihanChanged:(NSString *)text;
- (void)onSearchWhiteNeihanChanged:(NSString *)text;
- (void)onSearchBlackNeihanChanged:(NSString *)text;
- (void)onSearchMinhundunChanged:(NSString *)text;
- (void)onSearchMaxhundunChanged:(NSString *)text;
- (void)onSearchYichuliChanged:(NSString *)text;
- (void)onSearchHanYichuliChanged:(NSString *)text;
- (void)onSearchMinGaoChanged:(NSString *)text;
- (void)onSearchMaxGaoChanged:(NSString *)text;
- (void)onSearchBianhaoChanged:(NSString *)text;
- (void)onSearchMinGuanGaoChanged:(NSString *)text;
- (void)onSearchMaxGuanGaoChanged:(NSString *)text;
- (void)onSearchShadowChanged:(NSString *)text;


@end

@interface RNMoreSearchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *moreSearchBtn;
@property (weak, nonatomic) IBOutlet UIView *moreContentView;
@property (nonatomic, strong) RNSearchJewelModel *model;

@property (weak, nonatomic) id<RNMoreSearchTableViewCellDelegate>delegate;

@end



NS_ASSUME_NONNULL_END
