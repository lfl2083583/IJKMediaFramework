//
//  RNSearchCustomTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/7.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RNSearchCustomTableViewCellDelegate <NSObject>

@optional
- (void)onsearchCustomeTableViewCellDidChooseJingDu:(NSArray *)jd;
- (void)onsearchCustomeTableViewCellDidChooseQieGe:(NSArray *)qg;
- (void)onsearchCustomeTableViewCellDidChoosePaoGuang:(NSArray *)pg;
- (void)onsearchCustomeTableViewCellDidChooseDuiCheng:(NSArray *)dc;

- (void)onsearchCustomeTableViewCellDidChooseDengJi:(NSArray *)dj;

- (void)onsearchCustomeTableViewCellDidChooseYaowei:(NSArray *)yw;
- (void)onsearchCustomeTableViewCellDidChooseJiandi:(NSArray *)jd;
- (void)onsearchCustomeTableViewCellDidChooseChuli:(NSArray *)cl;
- (void)onsearchCustomeTableViewCellDidXiushi:(NSArray *)xs;

@end


static NSString *const searchCustomTableViewCellIndenfier = @"RNSearchCustomTableViewCell";
static NSString *const jingDuIndenfier = @"jingDuIndenfier";
static NSString *const xiuShiIndenfier = @"xiuShiIndenfier";
static NSString *const qieKouIndenfier = @"qieKouIndenfier";
static NSString *const paoGuangIndenfier = @"paoGuangIndenfier";
static NSString *const duiChengIndenfier = @"duiChengIndenfier";
static NSString *const jiBieIndenfier = @"jiBieIndenfier";
static NSString *const dengjiIndenfier = @"dengjiIndenfier";

static NSString *const yaoweiIndenfier = @"yaoweiIndenfier";
static NSString *const jiandiIndenfier = @"jiandiIndenfier";
static NSString *const chuliIndenfier = @"chuliIndenfier";

@interface RNSearchCustomTableViewCell : UITableViewCell

@property (nonatomic, weak) id<RNSearchCustomTableViewCellDelegate>delegate;
@property (nonatomic, strong) RNSearchJewelModel *jewelModel;
@property (nonatomic, strong) RNBuyRequestAddModel *addModel;
@property (nonatomic, copy) NSString *IdentifierString;
@property (nonatomic, assign) BOOL singleEnable; // 单选是否可以
@end


NS_ASSUME_NONNULL_END
