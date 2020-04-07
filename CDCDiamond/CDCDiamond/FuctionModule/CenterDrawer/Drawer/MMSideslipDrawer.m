//
//  MMSideslipDrawer.m
//  MMSideslipDrawer
//
//  Created by LEA on 2017/2/17.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MMSideslipDrawer.h"
#import "RNLeftSideItem.h"
#import "RNLeftSideTableHeadView.h"
#import "RNLeftSideTableViewCell.h"

@interface MMSideslipDrawer ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate, RNLeftSideTableHeadViewDelegate>

@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, strong) UIView *menuView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) RNLeftSideTableHeadView *headView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MMSideslipDrawer

- (instancetype)initWithDelegate:(id<MMSideslipDrawerDelegate>)delegate slipItem:(MMSideslipItem *)item;
{
    self = [super initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    if (self)
    {
        self.userInteractionEnabled = YES;
        
        //## 赋值
        _delegate = delegate;
        _item = item;
        
        //## 添加视图
        [self addSubview:self.alphaView];
        [self addSubview:self.menuView];
        
        //## 更新UI
        [self.tableView reloadData];
        
        //## 拖动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureCallback:)];
        [pan setDelegate:self];
        [self addGestureRecognizer:pan];
        
        [self showTopAvailableItem];
    }
    return self;
}

#pragma mark - 事件
- (void)colseLeftDrawerSide
{
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.alphaView.alpha = 0;
                         self.menuView.left =  -self.menuView.width;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)openLeftDrawerSide:(UIView *)view
{
    [view addSubview:self];
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.alphaView.alpha = 0.5;
                         self.menuView.left = 0;
                         [self.tableView reloadData];
                     }];
}

- (void)setUserInfo:(RNUserInfo *)userInfo {
    _userInfo = userInfo;
    _headView.userInfo = userInfo;
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - 手势处理
- (void)panGestureCallback:(UIPanGestureRecognizer *)panGesture
{
    switch (panGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            [panGesture setEnabled:YES];
            self.userInteractionEnabled = YES;
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            self.userInteractionEnabled = NO;
            CGPoint point = [panGesture translationInView:self];
            CGFloat left = self.menuView.left;
            left+= point.x;
            if (left > 0) {
                left = 0;
            }
            if (left < -kMMSideslipWidth) {
                left = -kMMSideslipWidth;
            }
            self.menuView.left = left;
            [panGesture setTranslation:CGPointZero inView:self.menuView];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            self.userInteractionEnabled = YES;
            //偏左向左滑，偏右向右滑
            if (self.menuView.left > -kMMSideslipWidth/4)  {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.menuView.left = 0;
                                 }];
            } else  {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     self.menuView.left = -kMMSideslipWidth;
                                     self.alphaView.alpha = 0;
                                 }
                                 completion:^(BOOL finished) {
                                     [self removeFromSuperview];
                                 }];
            }
            break;
        }
        default:
            break;
    }
}


#pragma mark - 视图
-(UIView *)alphaView
{
    if (!_alphaView) {
        _alphaView = [[UIView alloc] initWithFrame:self.bounds];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colseLeftDrawerSide)];
        [_alphaView addGestureRecognizer:tap];
    }
    return _alphaView;
}

- (UIView *)menuView
{
    if (!_menuView) {
        _menuView = [[UIView alloc] initWithFrame:CGRectMake(-kMMSideslipWidth, 0, kMMSideslipWidth, kHeight)];
        _menuView.backgroundColor = UIColor.whiteColor;
        [_menuView addSubview:self.headView];
        [_menuView addSubview:self.tableView];
    }
    return _menuView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.headView.height, kMMSideslipWidth-10, kHeight-self.headView.height)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        [self.tableView registerClass:[RNLeftSideTableViewCell class] forCellReuseIdentifier:leftSideIdentifier];
        [self.tableView registerClass:[RNLeftSideImgTableViewCell class] forCellReuseIdentifier:leftSideImgIdentifier];
    }
    return _tableView;
}

- (RNLeftSideTableHeadView *)headView {
    if (!_headView) {
        _headView = [[RNLeftSideTableHeadView alloc] initWithFrame:CGRectMake(0, 0, kMMSideslipWidth, 140)];
        _headView.backgroundColor = UIColor.whiteColor;
        _headView.delegate = self;
    }
    return _headView;
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    RNLeftSideItem *item = self.dataArray[section];
    return item.isOpen?item.subSideItems.count:1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RNLeftSideTableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:leftSideImgIdentifier];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:leftSideIdentifier];
    }
    RNLeftSideItem *item = self.dataArray[indexPath.section];
    NSString *title = item.subSideItems[indexPath.row];
    cell.contentLB.text = RNLocalized(title);
    cell.image = item.icon;
    if (indexPath.row == 0) {
        if (item.isOpen) {
            CGAffineTransform transform = CGAffineTransformIdentity;
            transform = CGAffineTransformRotate(transform, M_PI_2);
            cell.arrowImgView.transform = transform;
        } else {
            CGAffineTransform transform = CGAffineTransformIdentity;
            transform = CGAffineTransformRotate(transform, 0);
            cell.arrowImgView.transform = transform;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RNLeftSideItem *item = self.dataArray[indexPath.section];
    if ((!item.isOpen && indexPath.row == 0 && item.subSideItems.count > 1) || (item.isOpen && indexPath.row == 0 && item.subSideItems.count > 1)) {
        item.isOpen = !item.isOpen;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if (item.itemType == kRNSideMenuItemDashboard) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerDidSelectDashBoard)]) {
            [self.delegate slipDrawerDidSelectDashBoard];
        }
    }
    else if (item.itemType == kRNSideMenuItemFindDiamonds) {
        if (indexPath.row == 1) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerNewSearchDiamonds)]) {
                [self.delegate slipDrawerNewSearchDiamonds];
            }
        } else if (indexPath.row == 2) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerSavedSearchDiamonds)]) {
                [self.delegate slipDrawerSavedSearchDiamonds];
            }
        } else if (indexPath.row == 3) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerTrackDiamonds)]) {
                [self.delegate slipDrawerTrackDiamonds];
            }
        }
    }

    else if (item.itemType == kRNSideMenuItemDiamonds) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerDidDiamonds)]) {
            [self.delegate slipDrawerDidDiamonds];
        }
    }
    else if (item.itemType == kRNSideMenuItemPrice) {
        if (indexPath.row == 1) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerDidExchangeScreen)]) {
                [self.delegate slipDrawerDidExchangeScreen];
            }
        } else if (indexPath.row == 2) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerDidPrice)]) {
                [self.delegate slipDrawerDidPrice];
            }
        } else if (indexPath.row == 3) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerDidChangePrice)]) {
                [self.delegate slipDrawerDidChangePrice];
            }
        } else if (indexPath.row == 4) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerDidCaculator)]) {
                [self.delegate slipDrawerDidCaculator];
            }
        }
        
    }
    else if (item.itemType == kRNSideMenuItemPeople) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerDidPeople)]) {
            [self.delegate slipDrawerDidPeople];
        }
    }
    else if (item.itemType == kRNSideMenuItemNews) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerDidNews)]) {
            [self.delegate slipDrawerDidNews];
        }
    }
    else if (item.itemType == kRNSideMenuItemNotifications) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerDidNotifications)]) {
            [self.delegate slipDrawerDidNotifications];
        }
    }
    else if (item.itemType == kRNSideMenuItemContactUs) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerDidContact)]) {
            [self.delegate slipDrawerDidContact];
        }
    }
}


#pragma mark - RNLeftSideTableHeadViewDelegate

- (void)didSeletedUserInfo {
    if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerDidUserInfo)]) {
        [self.delegate slipDrawerDidUserInfo];
    }
}

- (void)didSeletedAvatar {
    if (self.delegate && [self.delegate respondsToSelector:@selector(slipDrawerDidAvatar)]) {
        [self.delegate slipDrawerDidAvatar];
    }
}

- (void)showTopAvailableItem
{
    for (RNSideMenuItem item = kRNSideMenuItemDashboard; item < kRNSideMenuItemContactUs+1; ++item) {
        if ([self isVisiableForItem:item]) {
            [self showItem:item];
        }
    }
}

- (void)showItem:(RNSideMenuItem)item {
    switch (item) {
        case kRNSideMenuItemDashboard:
        {
            [self.dataArray addObject:[[RNLeftSideItem alloc] initWithIcon:[UIImage imageNamed:@"mianban"] subSideItems:@[@"Dashboard"] itemType:item]];
        }
            break;
        case kRNSideMenuItemFindDiamonds:
        {
            [self.dataArray addObject:[[RNLeftSideItem alloc] initWithIcon:[UIImage imageNamed:@"center_zanshi"] subSideItems:@[@"Find Diamonds", @"New Search", @"Saved Search", @"Tracked Diamonds"] itemType:item]];
        }
            break;
        case kRNSideMenuItemDiamonds:
        {
            [self.dataArray addObject:[[RNLeftSideItem alloc] initWithIcon:[UIImage imageNamed:@"zuanshi"] subSideItems:@[@"Diamonds", @"My List"] itemType:item]];
        }
            break;
        case kRNSideMenuItemPrice:
        {
            [self.dataArray addObject:[[RNLeftSideItem alloc] initWithIcon:[UIImage imageNamed:@"center_jiage"] subSideItems:@[@"Prices", @"TradeScreen"] itemType:item]];
        }
            break;
        case kRNSideMenuItemPeople:
        {
            [self.dataArray addObject:[[RNLeftSideItem alloc] initWithIcon:[UIImage imageNamed:@"center_chazhao"] subSideItems:@[@"People"] itemType:item]];
        }
            break;
        case kRNSideMenuItemNews:
        {
            [self.dataArray addObject:[[RNLeftSideItem alloc] initWithIcon:[UIImage imageNamed:@"xinwen"] subSideItems:@[@"News"] itemType:item]];
        }
            break;
        case kRNSideMenuItemNotifications:
        {
            [self.dataArray addObject:[[RNLeftSideItem alloc] initWithIcon:[UIImage imageNamed:@"tingzhi"] subSideItems:@[@"Notifications"] itemType:item]];
        }
            break;
        case kRNSideMenuItemContactUs:
        {
            [self.dataArray addObject:[[RNLeftSideItem alloc] initWithIcon:[UIImage imageNamed:@"icon_contact"] subSideItems:@[@"Contact Us"] itemType:item]];
        }
            break;
        default:
            break;
    }
    
}


- (BOOL)isVisiableForItem:(RNSideMenuItem)item
{
    return YES;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end


@implementation MMSideslipItem

@end
