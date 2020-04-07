//
//  RNCenterViewController.m
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNCenterViewController.h"
#import "RNSettingViewController.h"
#import "RNCenterTableViewCell.h"
#import "RNCenterItem.h"
#import "SDCycleScrollView.h"
#import "RootWebViewController.h"
#import "RNHomeModel.h"
#import "RNUserInfo.h"
#import "RNCenterSectionView.h"
#import "RNNewsTableViewCell.h"
#import "RNCenterLikeJewelryTableViewCell.h"
#import "RNCenterWarningTableViewCell.h"
#import "RNSearchJewelViewController.h"
#import "RNPriceViewController.h"
#import "RNSearchPeopleViewController.h"
#import "RNMyListViewController.h"
#import "RNMessageListViewController.h"
#import "RNCaculatorViewController.h"
#import "RNNewsInfoViewController.h"
#import "RNTrackJewelViewController.h"
#import "RNNewsViewController.h"
#import "RNNewsModel.h"
#import "RNNotificationsViewController.h"
#import "RNBuyRequestsViewController.h"
#import "RNNewsInfoViewController.h"
#import "RNCenterNavView.h"

@interface RNCenterViewController ()<SDCycleScrollViewDelegate, RNCenterItemTableViewCellDelegate, RNCenterSectionViewDelegate, RNCenterNavViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *scrollView;
@property (nonatomic, strong) RNCenterNavView *navView;
@property (nonatomic, strong) RNHomeModel *homeModel;

@end

@implementation RNCenterViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupItems];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    [self setupNavView];
    [self setShowTableRefreshHeader:YES];
    //[self setupGuideViewIfNeed];
}

- (void)setupNavView {
    UIButton *leftButton = [UIButton yz_buttonWithImageStr:@"icon_menus"];
    leftButton.frame = CGRectMake(0, 0, 44, kTopBarHeight);
    [leftButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *rightButton = [UIButton yz_buttonWithImageStr:@"icon_setting"];
    rightButton.frame = CGRectMake(0, 0, 44, kTopBarHeight);
    [rightButton addTarget:self action:@selector(rightBarButtonItemPress:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:ImageName(@"nav_logo")];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(0, 0, App_Frame_Width - 200, kTopBarHeight-20);
    self.navigationItem.titleView = imageView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    [self staticRefreshFirstTableListData];
}

- (void)rightBarButtonItemPress:(id)sender {
    RNSettingViewController *settingViewController = [[RNSettingViewController alloc] init];
    settingViewController.title = RNLocalized(@"Setting");
    [self.navigationController pushViewController:settingViewController animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)getListData:(void (^)(void))requestComplete {
    __weak typeof(self)weakself = self;
    /** 主页数据 */
    [HttpRequestTool postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/HomeServlet?method=home")  parameters:@{} success:^(id responseObject, ResponseState state) {
        weakself.homeModel = [RNHomeModel mj_objectWithKeyValues:responseObject];
        NSLog(@"%@", responseObject);
        [weakself.dataArray removeAllObjects];
        [weakself setupItems];
        
        [weakself loadUserInfo:[NSString stringWithFormat:@"%@", responseObject[@"userInfo"][@"guid"]]];
        
        NSMutableArray *array = [NSMutableArray array];
        for (RNBannerModel *model in self.homeModel.bannners) {
            [array addObject:model.imageUrl];
        }
        weakself.scrollView.imageURLStringsGroup = array;
        
        [super getListData:requestComplete];
    } failure:^(NSError *error) {
        [super getListData:requestComplete];
    }];
}


- (void)loadUserInfo:(NSString *)GUID  {
    __weak typeof(self)weakself = self;
   [HttpRequestTool postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/MemberServlet?method=getMemberDetail")  parameters:@{@"GUID" : GUID} success:^(id responseObject, ResponseState state) {
       if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
           RNUserInfo *userInfo = [RNUserInfo mj_objectWithKeyValues:responseObject];
           [userInfo save];
           [weakself updateUserInfo:userInfo];
       }
   } failure:^(NSError *error) {
       
   }];
}

- (UIStatusBarStyle)StatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - private

- (void)setupItems {
    //动态配置数据源
    RNCenterItem *menueItem = [[RNCenterItem alloc] initWithClass:NSClassFromString(@"RNCenterItemTableViewCell") cellheight:180.f rows:1];
    RNCenterItem *newsItem = [[RNCenterItem alloc] initWithClass:NSClassFromString(@"RNNewsTableViewCell") cellheight:91.f rows:self.homeModel.news.count];
    RNCenterItem *warnItem = [[RNCenterItem alloc] initWithClass:NSClassFromString(@"RNCenterWarningTableViewCell") cellheight:50.f rows:1];
    [self.dataArray addObjectsFromArray:@[menueItem, newsItem, warnItem]];
}

//第一次启动加载引导页
- (void)setupGuideViewIfNeed {
    
}


#pragma mark - overwrite
- (void)setupTableView {
    [super setupTableView];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setFrame:CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height-kStatusBarHeight-kTopBarHeight)];
    NSArray *array = @[@"RNCenterItemTableViewCell",  @"RNNewsTableViewCell", @"RNCenterWarningTableViewCell"];
    __weak typeof(self)weakself = self;
    [array enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakself.tableView registerClass:NSClassFromString(obj) forCellReuseIdentifier:obj];
    }];
    [self.tableView registerClass:[RNCenterSectionView class] forHeaderFooterViewReuseIdentifier:centerSectionIndentifer];
    [self.tableView setTableHeaderView:self.scrollView];
    
}

- (void)languageChangedNotification {
    [self.tableView reloadData];
}


#pragma mark - overwrite TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    RNCenterItem *item = self.dataArray[section];
    return item.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RNCenterItem *item = self.dataArray[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(item.class)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColorFromRGB(0xf8f8f8);
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell.reuseIdentifier isEqualToString:@"RNCenterItemTableViewCell"]) {
        RNCenterItemTableViewCell *newCell = (RNCenterItemTableViewCell *)cell;
        newCell.centerMunus = self.homeModel.centerMunus;
        newCell.delegate = self;
        newCell.unreadCount = self.homeModel.xzsize;
    } else if ([cell.reuseIdentifier isEqualToString:@"RNNewsTableViewCell"]) {
        RNNewsTableViewCell *newCell = (RNNewsTableViewCell *)cell;
        newCell.newsModel = self.homeModel.news[indexPath.row];
        newCell.line.hidden = (indexPath.row == self.homeModel.news.count-1);
    } else if ([cell.reuseIdentifier isEqualToString:@"RNCenterWarningTableViewCell"]) {
        RNCenterWarningTableViewCell *warnCell = (RNCenterWarningTableViewCell *)cell;
        warnCell.warnstring = [NSString stringWithFormat:@"%@  %@", self.homeModel.caveatContent, self.homeModel.caveatTime];
    } else if ([cell.reuseIdentifier isEqualToString:@"RNCenterTrackTableViewCell"]) {
        RNCenterTrackTableViewCell *trackCell = (RNCenterTrackTableViewCell *)cell;
        trackCell.titleLab.text = RNLocalized(@"Tracked Diamonds");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RNCenterItem *item = self.dataArray[indexPath.section];
    if (indexPath.section == 2) {
        return [tableView fd_heightForCellWithIdentifier:@"RNCenterWarningTableViewCell" configuration:^(RNCenterWarningTableViewCell *cell) {
            cell.warnstring = [NSString stringWithFormat:@"%@  %@", self.homeModel.caveatContent, self.homeModel.caveatTime];
        }];
    }
    return item.cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   if (section == 1) {
        RNCenterSectionView *sectionView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:centerSectionIndentifer];
        sectionView.title.text = RNLocalized(@"News");
        sectionView.sideButton.hidden = NO;
        sectionView.delegate = self;
        [sectionView.sideButton setTitle:RNLocalized(@"Look All") forState:UIControlStateNormal];
        return sectionView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 40.f;
    }
    return 0.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        RNNewsModel *model = self.homeModel.news[indexPath.row];
        RNNewsInfoViewController *newsDetailVc = [[RNNewsInfoViewController alloc] init];
        newsDetailVc.newsID = model.GUID;
        [self.navigationController pushViewController:newsDetailVc animated:YES];
    }
}

#pragma mark - RNCenterSectionViewDelegate

- (void)didClickNewsAll {
    [self.navigationController pushViewController:[[RNNewsViewController alloc] init] animated:YES];
}

#pragma mark - RNCenterNavViewDelegate

- (void)onLeftMenueClick {
    [self leftDrawerButtonPress:nil];
}

- (void)onRightMenueClick {
    RNSettingViewController *settingViewController = [[RNSettingViewController alloc] init];
    settingViewController.title = RNLocalized(@"Setting");
    [self.navigationController pushViewController:settingViewController animated:YES];
}

#pragma mark - RNCenterItemTableViewCellDelegate

- (void)didClickItem:(int)index{
    if (index == 0) {
        [self.navigationController pushViewController:[[RNSearchJewelViewController alloc] init] animated:YES];
    } else if (index == 1) {
        [self.navigationController pushViewController:[[RNMyListViewController alloc] init] animated:YES];
    } else if (index == 2) {
        [self.navigationController pushViewController:[[RNTrackJewelViewController alloc] init] animated:YES];
    } else if (index == 3) {
        [self.navigationController pushViewController:[[RNSearchPeopleViewController alloc] init] animated:YES];
    } else if (index == 4) {
        [self.navigationController pushViewController:[[RNPriceViewController alloc] initIsFromSideMenue:NO priceType:1] animated:YES];
    } else if (index == 5) {
        [self.navigationController pushViewController:[[RNMessageListViewController alloc] init] animated:YES];
    } else if (index == 6){
        [self.navigationController pushViewController:[[RNNotificationsViewController alloc] init] animated:YES];
    }
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:loginName] && [[[NSUserDefaults standardUserDefaults] objectForKey:loginName] isEqualToString:@"10001"]) {
        return;
    }
    RNBannerModel *bannerModel = self.homeModel.bannners[index];
    RootWebViewController *webView = [[RootWebViewController alloc] initWithUrl:[NSString stringWithFormat:@"%@", bannerModel.linkUrl]];
    [self.navigationController pushViewController:webView animated:YES];
}


#pragma mark - lazy

- (SDCycleScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0.f, 0.f, App_Frame_Width, 120.f) delegate:self placeholderImage:nil];
        _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _scrollView.autoScrollTimeInterval = 3;
    }
    return _scrollView;
}

- (RNCenterNavView *)navView {
    if (!_navView) {
        _navView = [[RNCenterNavView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, kStatusBarHeight+kTopBarHeight)];
        _navView.delegate = self;
    }
    return _navView;
}

@end
