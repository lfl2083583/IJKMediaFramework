//
//  ZTFormListView.h
//  JTCarManage
//
//  Created by apple on 2018/12/11.
//  Copyright © 2018年 CD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZTFormListViewDelegate <NSObject>

@optional
- (void)onDidSeletedFormListCell:(NSIndexPath *)indexPath;

@end

@interface ZTFormListView : UIView

@property (nonatomic, strong) NSArray <NSString *>*topMenus;
@property (nonatomic, strong) NSArray <NSString *>*sideMenus;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) CGSize maxSize;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, weak) id<ZTFormListViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame topMenus:(NSArray <NSString *>*)topMenus sideMenus:(NSArray <NSString *>*)sideMenus;

- (void)setTopMenus:(NSArray <NSString *>*)topMenus sideMenus:(NSArray <NSString *>*)sideMenus;


@end



NS_ASSUME_NONNULL_END
