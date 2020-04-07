//
//  RNYanseTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const yanSeTableViewCellIndenfier = @"RNYanseTableViewCell";

@protocol RNYanseTableViewCellDelegate <NSObject>
@optional
- (void)onYanseTableViewCellBetifulClickWhiteClickColors:(NSArray *)colors;
- (void)onYanseTableViewCellBetifulClickWhiteClickQiangDu:(NSArray *)qiangDu;
- (void)onYanseTableViewCellBetifulClickWhiteClickBnanse:(NSArray *)banse;
- (void)onYanseTableViewCellBetifulClickWhiteClickYanse:(NSArray *)yanse;
- (void)onYanseTableViewCellIsColorDiamondsClick:(id )model;
@end

@interface RNYanseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *whiteBtn;
@property (weak, nonatomic) IBOutlet UIButton *beautifulBtn;
@property (nonatomic, weak) id<RNYanseTableViewCellDelegate>delegate;
@property (nonatomic, strong) RNSearchJewelModel *jewelModel;
@property (nonatomic, strong) RNBuyRequestAddModel *addModel;
@property (nonatomic, assign) int yanseType;
@property (nonatomic, assign) BOOL singleEnable; // 单选是否可以

@end





NS_ASSUME_NONNULL_END
