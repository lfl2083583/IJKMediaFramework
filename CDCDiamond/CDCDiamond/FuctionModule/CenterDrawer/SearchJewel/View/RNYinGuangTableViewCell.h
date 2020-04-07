//
//  RNYinGuangTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/7.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RNYinGuangTableViewCellDelegate <NSObject>
- (void)onsearchYinGuangTableViewCellDidChooseYingGuangQiangdu:(NSArray *_Nullable)dd;
- (void)onsearchYinGuangTableViewCellDidChooseYingGuangYanse:(NSArray *_Nullable)yanse;
@end

NS_ASSUME_NONNULL_BEGIN


static NSString *const yinGuangTableViewCellIndenfier = @"RNYinGuangTableViewCell";

@interface RNYinGuangTableViewCell : UITableViewCell

@property (nonatomic, weak) id<RNYinGuangTableViewCellDelegate>delegate;
@property (nonatomic, strong) RNSearchJewelModel *jewelModel;

@end



NS_ASSUME_NONNULL_END
