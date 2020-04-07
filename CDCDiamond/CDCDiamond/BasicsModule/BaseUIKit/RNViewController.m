//
//  RNViewController.m
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNViewController.h"
#import "Aspects.h"
#import "MJRefresh.h"
#import "MMSideslipDrawer.h"
#import "MMBarButtonItem.h"
#import "RNCenterViewController.h"
#import "RNChatViewController.h"
#import "RNPriceViewController.h"
#import "RNInboxViewController.h"
#import "RNNewsViewController.h"
#import "RNSearchJewelViewController.h"
#import "RNSearchPeopleViewController.h"
#import "RNBuyRequestsViewController.h"
#import "RNContactViewController.h"
#import "RNUserDetailViewController.h"
#import "RNTrackJewelViewController.h"
#import "RNNotificationsViewController.h"
#import "RNChangePriceViewController.h"
#import "RNCaculatorViewController.h"
#import "RNMyListViewController.h"
#import "RNNewSearchJewelViewController.h"
#import "ZTObtainPhotoTool.h"
#import "RNBuyRequestAddViewController.h"
#import "DAEmptyView.h"
#import "RNAgencyViewController.h"


@interface RNViewController ()<MMSideslipDrawerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIImageView* noDataView;
@property (nonatomic, strong) MMSideslipDrawer *slipDrawer;
@property (nonatomic, strong) RNUserInfo *userInfo;
@property (nonatomic, strong) NSIndexPath *lastAnimationIndexPath;
@property (nonatomic, assign) NSInteger dataCount;

@end

@implementation RNViewController

- (void)dealloc {
    
    [self cancelRequest];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return _StatusBarStyle;
//}
////动态更新状态栏颜色
//-(void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle{
//    _StatusBarStyle=StatusBarStyle;
//    [self setNeedsStatusBarAppearanceUpdate];
//}

- (instancetype)initIsFromSideMenue:(BOOL)isFromSideMenue {
    
    self = [super init];
    if (self) {
        _isFromSideMenue = isFromSideMenue;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([RNConfiguration isEqualToString:@"DEBUG"]) {
        [UIViewController aspect_hookSelector:NSSelectorFromString(@"dealloc")
                                  withOptions:AspectPositionBefore
                                   usingBlock:^(id <AspectInfo> aspectInfo)
         {
             BPLogInfo(@"%@-->:%@", @"Dealloc:😂😂😂", NSStringFromClass([aspectInfo.instance class]));
         }
                                        error:NULL];
    }
    
    if (!IOS11) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    self.view.backgroundColor = UIColor.whiteColor;
    [self setPage:1];
    [self setupNotificate];
   
    [self setupLeftMenuButton];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - public

- (void)setupLeftMenuButton{
    UIButton *backBtn = [UIButton yz_buttonWithImageStr:@"icon_nav_arrow"];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    backBtn.frame = CGRectMake(0, 0, 44, kTopBarHeight);
    [backBtn addTarget:self action:@selector(leftBarButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)setupTableView {
    [self.view addSubview:self.tableView];
}

- (void)backBtnClicked
{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setupNotificate {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChangedNotification) name:RNLanguageChangedNotification object:nil];
}


- (void)showNoDataImage {
    [DAEmptyView showOnView:self.tableView];
}

- (void)removeNoDataImage {
    [DAEmptyView hideFromView:self.tableView];
}

//取消请求
- (void)cancelRequest {
}

- (void)updateUserInfo:(RNUserInfo *)userinfo {
    _userInfo = userinfo;
    _slipDrawer.userInfo = userinfo;
}

#pragma mark - NSNotification

- (void)languageChangedNotification {
    
}

#pragma mark - Button Handlers
- (void)leftBarButtonItemClick:(id)sender {
    if (self.navigationController.viewControllers.count) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)leftDrawerButtonPress:(id)sender{
    self.slipDrawer.userInfo = [RNUserInfo shareUserInfo];
    [self.slipDrawer openLeftDrawerSide:self.view.window];
}

#pragma mark - MMSideslipDrawerDelegate

- (void)slipDrawerDidSelectDashBoard {
    [self.slipDrawer colseLeftDrawerSide];
    RNCenterViewController *vc = [[RNCenterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    self.navigationController.viewControllers = @[vc];
}
    
- (void)slipDrawerDidSearchJewel {
    [self.slipDrawer colseLeftDrawerSide];
    UIViewController *firstvc = [self.navigationController.viewControllers firstObject];
    RNSearchJewelViewController *vc = [[RNSearchJewelViewController alloc] initIsFromSideMenue:YES];
    [self.navigationController pushViewController:vc animated:YES];
    self.navigationController.viewControllers = @[firstvc, vc];
}

- (void)slipDrawerDidChat {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNChatViewController alloc] initIsFromSideMenue:NO]];
}

- (void)slipDrawerDidBuyRequests {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNBuyRequestsViewController alloc] initIsFromSideMenue:NO seletedIndex:0]];
}

- (void)slipDrawerDidMyRequests {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNBuyRequestsViewController alloc] initIsFromSideMenue:NO seletedIndex:1]];
}

- (void)slipDrawerDidAddRequests {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNBuyRequestAddViewController alloc] init]];
}

- (void)slipDrawerDidJewel {}

- (void)slipDrawerDidDiamonds {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNMyListViewController alloc] initIsFromSideMenue:NO]];
}

- (void)slipDrawerDidPrice {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNPriceViewController alloc] initIsFromSideMenue:NO priceType:0]];
}

- (void)slipDrawerDidExchangeScreen {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNPriceViewController alloc] initIsFromSideMenue:NO priceType:1]];
}

- (void)slipDrawerDidChangePrice {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNChangePriceViewController alloc] initIsFromSideMenue:NO]];
}

- (void)slipDrawerDidCaculator {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNCaculatorViewController alloc] initIsFromSideMenue:NO]];
}

- (void)slipDrawerDidPeople {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNSearchPeopleViewController alloc] initIsFromSideMenue:NO]];
}

- (void)slipDrawerDidInbox {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNInboxViewController alloc] initIsFromSideMenue:NO]];
}

- (void)slipDrawerDidContact {
//    [self.slipDrawer colseLeftDrawerSide];
//    [self onPushVC:[[RNContactViewController alloc] initIsFromSideMenue:NO]];
//    if ([RNUserInfo shareUserInfo].UF_ZPHONE && [[RNUserInfo shareUserInfo].UF_ZPHONE isKindOfClass:[NSString class]] && [RNUserInfo shareUserInfo].UF_ZPHONE.length) {
//        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", [RNUserInfo shareUserInfo].UF_ZPHONE];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",callPhone]]];
//    }
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNAgencyViewController alloc] initIsFromSideMenue:NO]];
    
    
}

- (void)slipDrawerDidNews {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNNewsViewController alloc] initIsFromSideMenue:NO]];
}

- (void)slipDrawerDidNotifications {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNNotificationsViewController alloc] initIsFromSideMenue:NO]];
}

- (void)slipDrawerDidReferAFriends {}

- (void)slipDrawerDidAvatar {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:RNLocalized(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:RNLocalized(@"Take Pictures"), RNLocalized(@"Select From Album"), nil];//按钮显示可以设置多个按钮显示
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;//设置样式
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)slipDrawerDidUserInfo {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNUserDetailViewController alloc] initIsFromSideMenue:NO GUID:KFormat([RNUserInfo shareUserInfo].UGUID)]];
}

- (void)slipDrawerNewSearchDiamonds {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNSearchJewelViewController alloc] initIsFromSideMenue:NO seletedIndex:0]];
}
- (void)slipDrawerSavedSearchDiamonds {
    [self.slipDrawer colseLeftDrawerSide];
    [self onPushVC:[[RNSearchJewelViewController alloc] initIsFromSideMenue:NO seletedIndex:1]];
}

- (void)slipDrawerTrackDiamonds {
    [self onPushVC:[[RNTrackJewelViewController alloc] initIsFromSideMenue:NO]];
}


- (void)onPushVC:(UIViewController *)vc {
    [self.slipDrawer colseLeftDrawerSide];
    UIViewController *firstvc = [self.navigationController.viewControllers firstObject];
    [self.navigationController pushViewController:vc animated:YES];
    self.navigationController.viewControllers = @[firstvc, vc];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [actionSheet removeFromSuperview];
    __weak typeof(self)weakself = self;
    if (buttonIndex == 0) {
        //[self.slipDrawer colseLeftDrawerSide];
        [[ZTObtainPhotoTool shareObtainPhotoTool] show:self sourceType:0 photoEditType:JTPhotoEditTypeCustom success:^(UIImage *image) {
            //[weakself leftDrawerButtonPress:nil];
            [weakself uploadAvatar:image];
        } cancel:^{
            //[weakself leftDrawerButtonPress:nil];
        }];
    } else if (buttonIndex == 1) {
        //[self.slipDrawer colseLeftDrawerSide];
        [[ZTObtainPhotoTool shareObtainPhotoTool] show:self sourceType:1 photoEditType:JTPhotoEditTypeCustom success:^(UIImage *image) {
            //[weakself leftDrawerButtonPress:nil];
            [weakself uploadAvatar:image];
        } cancel:^{
            //[weakself leftDrawerButtonPress:nil];
        }];
    }
}

- (void)uploadAvatar:(UIImage *)image {
    [YZHubTool showLoadingStatus:RNLocalized(@"Uppass...")];
    __weak typeof(self)weakself = self;
    [HttpRequestTool  postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/MemberServlet?method=ImageUploadingforPhone") parameters:@{@"imageBase64Str" : [self encodeToBase64String:image]} success:^(id responseObject, ResponseState state) {
        [YZHubTool showSuccessText:RNLocalized(@"Upload successful")];
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]] && responseObject[@"imgUrl"]) {
            [RNUserInfo shareUserInfo].UF_HEADIMG = [NSString stringWithFormat:@"%@", responseObject[@"imgUrl"]];
            weakself.slipDrawer.userInfo = [RNUserInfo shareUserInfo];
            [weakself.slipDrawer reloadData];
        }
        NSLog(@"%@", responseObject);
    } failure:^(NSError *error) {
        [YZHubTool showFailureText:RNLocalized(@"Upload fail")];
    }];
}
    
- (NSString*)encodeToBase64String:(UIImage*)image {
   return [@"data:image/png;base64," stringByAppendingString:[UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
}

#pragma mark - UItableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const cellIdentifier = @"UItableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

/***
 * Footer的状态根据刷新的接口来显示
 * 当数据长度等于0的时候 隐藏Footer状态
 * 当数据长度小于10的时候 提示没有更多的数据 并隐藏状态Lable
 * 当数据长度大于等于10的时候 重置没有更多的数据（消除没有更多数据的状态）
 ***/
- (void)setShowTableRefreshHeader:(BOOL)showTableRefreshHeader
{
    if (_showTableRefreshHeader != showTableRefreshHeader) {
        _showTableRefreshHeader = showTableRefreshHeader;
        if (_showTableRefreshHeader) {
            __weak typeof(self) weakself = self;
            
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                weakself.page = 1;
                if (weakself.cellAnimation) {
                    weakself.lastAnimationIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                }
                [weakself getListData:^{
                    [weakself.tableView.mj_header endRefreshing];
                    [weakself handleFirstTableListData];
                }];
            }];
//            [header setTitle:RNLocalized(@"Pull down to refresh") forState:MJRefreshStateIdle];
//            [header setTitle:RNLocalized(@"Release immediately refresh") forState:MJRefreshStatePulling];
//            [header setTitle:RNLocalized(@"Refreshing") forState:MJRefreshStateRefreshing];

            header.lastUpdatedTimeLabel.hidden = NO;
            self.tableView.mj_header = header;
        }
        else {
            self.tableView.mj_header = nil;
        }
    }
}

/***
 * 第一次设置tableView Footer的时候 隐藏状态
 * 当加载更多数据长度为0的时候 提示没有更多的数据
 ***/
- (void)setShowTableRefreshFooter:(BOOL)showTableRefreshFooter
{
    if (_showTableRefreshFooter != showTableRefreshFooter) {
        _showTableRefreshFooter = showTableRefreshFooter;
        if (_showTableRefreshFooter) {
            __weak typeof(self) weakself = self;
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                weakself.page++;
                [weakself getListData:^{
                    [weakself.tableView.mj_footer endRefreshing];
                    [weakself.tableView reloadData];
                    
                    if (weakself.dataCount != weakself.dataArray.count) {
                        weakself.dataCount = weakself.dataArray.count;
                        [weakself.tableView.mj_footer resetNoMoreData];
                    }
                    else
                    {
                        [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }];
            }];
            [footer setTitle:RNLocalized(@"Loading") forState:MJRefreshStateRefreshing];
            [footer setTitle:RNLocalized(@"Nothing more yet") forState:MJRefreshStateNoMoreData];
            self.tableView.mj_footer = footer;
            [(MJRefreshAutoNormalFooter *)weakself.tableView.mj_footer setHidden:YES];
        }
        else {
            self.tableView.mj_footer = nil;
        }
    }
}

/***
 * Footer的状态根据刷新的接口来显示
 * 当数据长度等于0的时候 隐藏Footer状态
 * 当数据长度小于10的时候 提示没有更多的数据 并隐藏状态Lable
 * 当数据长度大于等于10的时候 重置没有更多的数据（消除没有更多数据的状态）
 ***/
- (void)setShowCollectionRefreshHeader:(BOOL)showCollectionRefreshHeader
{
    if (_showCollectionRefreshHeader != showCollectionRefreshHeader) {
        _showCollectionRefreshHeader = showCollectionRefreshHeader;
        if (_showCollectionRefreshHeader) {
            __weak typeof(self) weakself = self;
            
            MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
                weakself.page = 1;
                if (weakself.cellAnimation) {
                    weakself.lastAnimationIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                }
                [weakself getListData:^{
                    [weakself.collectionview.mj_header endRefreshing];
                    [weakself.collectionview reloadData];
                    
                    if (weakself.collectionview.mj_footer) {
                        weakself.dataCount = weakself.dataArray.count;
                        if (weakself.dataCount < defaultPageSize) {
                            [weakself.collectionview.mj_footer endRefreshingWithNoMoreData];
                            [(MJRefreshAutoNormalFooter *)weakself.collectionview.mj_footer stateLabel].hidden = YES;
                        }
                        else
                        {
                            [weakself.collectionview.mj_footer resetNoMoreData];
                            [(MJRefreshAutoNormalFooter *)weakself.collectionview.mj_footer stateLabel].hidden = NO;
                        }
                    }
                }];
            }];
            [header setTitle:RNLocalized(@"Pull down to refresh") forState:MJRefreshStateIdle];
            [header setTitle:RNLocalized(@"Release immediately refresh") forState:MJRefreshStatePulling];
            [header setTitle:RNLocalized(@"Refreshing") forState:MJRefreshStateRefreshing];
            
            header.lastUpdatedTimeLabel.hidden = YES;
            self.collectionview.mj_header = header;
        }
        else {
            self.collectionview.mj_header = nil;
        }
    }
}

/***
 * 第一次设置CollectionView Footer的时候 隐藏状态
 * 当加载更多数据长度为0的时候 提示没有更多的数据
 ***/
- (void)setShowCollectionRefreshFooter:(BOOL)showCollectionRefreshFooter
{
    if (_showCollectionRefreshFooter != showCollectionRefreshFooter) {
        _showCollectionRefreshFooter = showCollectionRefreshFooter;
        if (_showCollectionRefreshFooter) {
            __weak typeof(self) weakself = self;
            MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                weakself.page++;
                [weakself getListData:^{
                    [weakself.collectionview.mj_footer endRefreshing];
                    [weakself.collectionview reloadData];
                    
                    if (weakself.dataCount != weakself.dataArray.count) {
                        weakself.dataCount = weakself.dataArray.count;
                        [weakself.collectionview.mj_footer resetNoMoreData];
                    }
                    else
                    {
                        [weakself.collectionview.mj_footer endRefreshingWithNoMoreData];
                    }
                }];
            }];
            [footer setTitle:RNLocalized(@"Loading")  forState:MJRefreshStateRefreshing];
            [footer setTitle:RNLocalized(@"Nothing more yet") forState:MJRefreshStateNoMoreData];
            [footer.stateLabel setHidden:YES];
            self.collectionview.mj_footer = footer;
        }
        else {
            self.collectionview.mj_footer = nil;
        }
    }
}

- (void)setCellAnimation:(BOOL)cellAnimation
{
    _cellAnimation = cellAnimation;
    _lastAnimationIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (tableView.sectionHeaderHeight == 0) ? 0.1 : tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (tableView.sectionFooterHeight == 0) ? 0.1 : tableView.sectionFooterHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_cellAnimation && indexPath > _lastAnimationIndexPath) {
        
        _lastAnimationIndexPath = indexPath;
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = [NSNumber numberWithFloat:.6];
        opacityAnimation.toValue = [NSNumber numberWithFloat:1.0];
        opacityAnimation.duration = .2f;
        opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:.6];
        scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
        scaleAnimation.duration = .2f;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        // 将上述两个动画编组
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        [animationGroup setAnimations:[NSArray arrayWithObjects:opacityAnimation, scaleAnimation, nil]];
        [cell.layer addAnimation:animationGroup forKey:@"basic"];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - getter

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (NSMutableDictionary *)dataDictionary
{
    if (_dataDictionary == nil) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    
    return _dataDictionary;
}

- (UIView *)defaultFooterView
{
    if (_defaultFooterView == nil) {
        _defaultFooterView = [[UIView alloc] init];
    }
    
    return _defaultFooterView;
}

- (void)createTalbeView:(UITableViewStyle)style rowHeight:(CGFloat)rowHeight
{
    [self createTalbeView:style tableHeightType:YZTableTypeNavigation rowHeight:rowHeight];
}

- (void)createTalbeView:(UITableViewStyle)style tableHeightType:(YZTableType)tableHeightType rowHeight:(CGFloat)rowHeight
{
    [self createTalbeView:style tableHeightType:tableHeightType rowHeight:rowHeight sectionHeaderHeight:0 sectionFooterHeight:0];
}

- (void)createTalbeView:(UITableViewStyle)style tableHeightType:(YZTableType)tableHeightType rowHeight:(CGFloat)rowHeight sectionHeaderHeight:(CGFloat)sectionHeaderHeight sectionFooterHeight:(CGFloat)sectionFooterHeight
{
    CGRect frame = CGRectZero;
    if (tableHeightType == YZTableTypeFullScreen) {
        frame = [UIScreen mainScreen].bounds;
    }
    else if (tableHeightType == YZTableTypeNavigation) {
        frame = CGRectMake(0, kStatusBarHeight+kTopBarHeight, App_Frame_Width, APP_Frame_Height-kStatusBarHeight-kTopBarHeight);
    }
    else if (tableHeightType == YZTableTypeTabbar) {
        frame = CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height-kBottomBarHeight);
    }
    else
    {
        frame = CGRectMake(0, kStatusBarHeight+kTopBarHeight, App_Frame_Width, APP_Frame_Height-kStatusBarHeight-kTopBarHeight-kBottomBarHeight);
    }
    [self createTalbeView:style tableFrame:frame rowHeight:rowHeight sectionHeaderHeight:sectionHeaderHeight sectionFooterHeight:sectionFooterHeight];
}

- (void)createTalbeView:(UITableViewStyle)style tableFrame:(CGRect)tableFrame rowHeight:(CGFloat)rowHeight sectionHeaderHeight:(CGFloat)sectionHeaderHeight sectionFooterHeight:(CGFloat)sectionFooterHeight
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:tableFrame style:style];
        _tableView.separatorColor = BlackColor;
        _tableView.rowHeight = rowHeight;
        _tableView.estimatedRowHeight = rowHeight;
        _tableView.backgroundColor = WhiteColor;
        _tableView.delegate = self;
        
        _tableView.sectionHeaderHeight = sectionHeaderHeight;
        _tableView.estimatedSectionHeaderHeight = sectionHeaderHeight;
        
        _tableView.sectionFooterHeight = sectionFooterHeight;
        _tableView.estimatedSectionFooterHeight = sectionFooterHeight;
        
        _tableView.tableFooterView = self.defaultFooterView;
    }
    [self.view addSubview:self.tableView];
}

- (void)getListData:(void (^)(void))requestComplete
{
    requestComplete();
}

- (void)staticRefreshFirstTableListData
{
    [self setPage:1];
    __weak typeof(self) weakself = self;
    [self getListData:^{
        [weakself handleFirstTableListData];
    }];
}

- (void)handleFirstTableListData
{
    [self.tableView reloadData];
    if (self.tableView.mj_footer) {
        self.dataCount = self.dataArray.count;
        if (self.dataCount < defaultPageSize) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setHidden:YES];
        }
        else
        {
            [self.tableView.mj_footer resetNoMoreData];
            [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setHidden:NO];
        }
    }
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width , APP_Frame_Height) style:UITableViewStylePlain];
        _tableView.rowHeight = 44;
        _tableView.estimatedRowHeight = 44;
        _tableView.backgroundColor = WhiteColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedSectionHeaderHeight = 0.f;
        _tableView.estimatedSectionFooterHeight = 0.f;
        _tableView.tableFooterView = self.defaultFooterView;
    }
    return _tableView;
}

- (UICollectionView *)collectionview {
    if (_collectionview == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width , APP_Frame_Height - kTopBarHeight - kStatusBarHeight) collectionViewLayout:flow];
        _collectionview.backgroundColor = UIColor.whiteColor;
        _collectionview.scrollsToTop = YES;
    }
    return _collectionview;
}


- (MMSideslipDrawer *)slipDrawer
{
    if (!_slipDrawer)
    {
        MMSideslipItem *item = [[MMSideslipItem alloc] init];
        _slipDrawer = [[MMSideslipDrawer alloc] initWithDelegate:self slipItem:item];
    }
    return _slipDrawer;
}

@end
