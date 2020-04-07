//
//  ZTCollectionView.h
//  JTCarManage
//
//  Created by apple on 2018/12/11.
//  Copyright © 2018年 CD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTopHeight     44.f
#define kItemHeight    50.f
#define kTitleFont     [UIFont yz_PingFangSC_MediumFontOfSize:12]
#define kLineColor     WhiteColor
#define kTextColor     WhiteColor
#define kLineWidth     1.0f

NS_ASSUME_NONNULL_BEGIN

@interface ZTCollectionView : UICollectionView

@property (nonatomic, strong) NSArray <NSString *>*menus;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

NS_ASSUME_NONNULL_END
