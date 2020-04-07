//
//  MMSideslipDrawer.h
//  MMSideslipDrawer
//
//  Created by LEA on 2017/2/17.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString static * _Nonnull RNSideMenuNames[] = {
    @"sidebar.register",
    @"sidebar.register_sales",
    @"sidebar.pickupcontrol",
    @"sidebar.menusetup",
    @"sidebar.floorplansetup",
    @"sidebar.tablemanagement",
    @"sidebar.inventory",
    @"sidebar.modifiersets",
    @"sidebar.customers",
    @"sidebar.giftcards",
    @"sidebar.discounts",
    @"sidebar.suppliers",
    @"sidebar.purchaseorders",
    @"sidebar.invoices",
    @"sidebar.goodsreceivednotes",
};

NSString static * _Nonnull RNSideMenuImageNames[] = {
    @"sidebar_register",
    @"sidebar_register-shifts",
    @"rt_sidebar_sales",
    @"rt_sidebar_menusetup",
    @"rt_sidebar_floorplansetup",
    @"sidebar_table-management",
    @"sidebar_inventory",
    @"sidebar_modifier-sets",
    @"sidebar_customers",
    @"sidebar_gift-cards",
    @"sidebar_discounts",
    @"sidebar_suppliers",
    @"sidebar_purchase-orders",
    @"sidebar_invoices",
    @"sidebar_grn",
};

#define kWidth                  [UIScreen mainScreen].bounds.size.width
#define kHeight                 [UIScreen mainScreen].bounds.size.height
#define kMMSideslipWidth        320 * kWidth / 375.0
#define kMMSideslipTopHeight    180
#define kMMSideslipMainColor    [UIColor colorWithRed:74.0/255.0 green:75.0/255.0 blue:90.0/255.0 alpha:1.0]

@class RNUserInfo;
@class MMSideslipItem;
@protocol MMSideslipDrawerDelegate;
@interface MMSideslipDrawer : UIView

//展示的数据Model
@property (nonatomic, strong) MMSideslipItem * _Nonnull item;
//代理
@property (nonatomic, assign) id<MMSideslipDrawerDelegate> _Nonnull delegate;

@property (nonatomic, strong) RNUserInfo * _Nullable userInfo;
//外部接口
- (instancetype _Nonnull )initWithDelegate:(id<MMSideslipDrawerDelegate>_Nonnull)delegate slipItem:(MMSideslipItem *_Nonnull)item;
- (void)colseLeftDrawerSide;
- (void)openLeftDrawerSide:(UIView *_Nullable)view;
- (void)reloadData;

@end

@protocol MMSideslipDrawerDelegate <NSObject>

@optional

- (void)slipDrawerDidSelectDashBoard;
- (void)slipDrawerDidSearchJewel;
- (void)slipDrawerDidChat;
- (void)slipDrawerDidBuyRequests;
- (void)slipDrawerDidMyRequests;
- (void)slipDrawerDidAddRequests;
- (void)slipDrawerDidJewel;
- (void)slipDrawerDidDiamonds;
- (void)slipDrawerDidExchangeScreen;
- (void)slipDrawerDidPrice;
- (void)slipDrawerDidChangePrice;
- (void)slipDrawerDidCaculator;
- (void)slipDrawerDidPeople;
- (void)slipDrawerDidInbox;
- (void)slipDrawerDidContact;
- (void)slipDrawerDidNews;
- (void)slipDrawerDidNotifications;
- (void)slipDrawerDidReferAFriends;
- (void)slipDrawerDidAvatar;
- (void)slipDrawerDidUserInfo;
- (void)slipDrawerNewSearchDiamonds;
- (void)slipDrawerSavedSearchDiamonds;
- (void)slipDrawerTrackDiamonds;

@end


@interface MMSideslipItem : NSObject



@end
