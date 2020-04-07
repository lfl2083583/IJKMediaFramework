//
//  RNViewController.h
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, YZTableType) {
    YZTableTypeFullScreen = 0,
    YZTableTypeNavigation,
    YZTableTypeTabbar,
    YZTableTypeNavigationAndTabbar
};
#define defaultPageSize 5

@class RNUserInfo;

//NS_ASSUME_NONNULL_BEGIN

@interface RNViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;

/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;

@property (nonatomic, assign) BOOL isFromSideMenue;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UICollectionView *collectionview;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableDictionary *dataDictionary;

@property (assign, nonatomic) int page;
@property (strong, nonatomic) UIView *defaultFooterView;
@property (nonatomic) BOOL cellAnimation;
@property (nonatomic, assign) BOOL showTableRefreshHeader;      // Table是否支持下拉刷新
@property (nonatomic, assign) BOOL showTableRefreshFooter;      // Table是否支持上拉加载
@property (nonatomic, assign) BOOL showCollectionRefreshHeader; // Table是否支持下拉刷新
@property (nonatomic, assign) BOOL showCollectionRefreshFooter; // Table是否支持上拉加载

- (instancetype)initIsFromSideMenue:(BOOL)isFromSideMenue;

- (void)setupLeftMenuButton;

- (void)setupTableView;

- (void)setupNotificate;

- (void)backBtnClicked;

- (void)leftDrawerButtonPress:(id)sender;

- (void)languageChangedNotification;

- (void)updateUserInfo:(RNUserInfo *)userinfo;

/**
 *  显示没有数据页面
 */
-(void)showNoDataImage;

/**
 *  移除无数据页面
 */
-(void)removeNoDataImage;

- (void)cancelRequest;

- (void)getListData:(void (^)(void))requestComplete;

/**
 加载第一页
 */
- (void)staticRefreshFirstTableListData;

/**
加载第一页
*/
- (void)staticRefreshFirstCollectionListData;


/**
 处理第一次加载
 */
- (void)handleFirstTableListData;

- (void)handleFirstCollectionListData;


@end

//NS_ASSUME_NONNULL_END
