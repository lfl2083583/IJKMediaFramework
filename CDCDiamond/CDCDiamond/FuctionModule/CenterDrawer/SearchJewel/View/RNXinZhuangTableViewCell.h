//
//  RNXinZhuangTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/7.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const xinZhuangCellIndetifier = @"RNXinZhuangTableViewCell@@";

@protocol  RNXinZhuangTableViewCellDelegate <NSObject>

- (void)onXinZhuangTableViewCellSeletedShape:(NSArray *)shape;

@end

@interface RNXinZhuangTableViewCell : UITableViewCell

@property (nonatomic, weak) id<RNXinZhuangTableViewCellDelegate>delegate;
@property (nonatomic, strong) RNSearchJewelModel *jewelModel;
@property (nonatomic, strong) RNBuyRequestAddModel *addModel;
@property (nonatomic, assign) BOOL singleEnable; // 单选是否可以
@end



NS_ASSUME_NONNULL_END
