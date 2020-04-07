//
//  YZBuyRequestAddAddressView.h
//  RapNet
//
//  Created by tjl on 2019/11/13.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YZBuyRequestAddAddressViewDelegate <NSObject>

- (void)onBuyRequestAddAddressViewDeleteAddressClick:(NSMutableArray *)addressList;
- (void)onBuyRequestAddAddressViewAddAddressClick;
@end

@interface YZBuyRequestAddAddressView : UIView

@property (nonatomic, weak) id<YZBuyRequestAddAddressViewDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *addressList;


@end

NS_ASSUME_NONNULL_END
