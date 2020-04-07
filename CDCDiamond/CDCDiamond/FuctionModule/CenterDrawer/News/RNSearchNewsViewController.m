//
//  RNSearchNewsViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/16.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNSearchNewsViewController.h"
#import "RNNewsInfoViewController.h"
#import "RNNewsTableViewCell.h"
#import "RNNewsModel.h"
#import "RNCustomSearchView.h"

@interface RNSearchNewsViewController ()
@property (nonatomic, strong) RNCustomSearchView *topView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, copy) NSString *keyword;

@end

@implementation RNSearchNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];

    [self setupTableView];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf6f6f6)];
    [self.tableView setFrame:CGRectMake(0, kStatusBarHeight+kTopBarHeight, App_Frame_Width, APP_Frame_Height-kStatusBarHeight)];
    [self.tableView registerClass:[RNNewsTableViewCell class] forCellReuseIdentifier:newsIdentifier];
    [self.tableView setRowHeight:91.f];

    [self setShowTableRefreshFooter:YES];
    [self setShowTableRefreshHeader:YES];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)getListData:(void (^)(void))requestComplete {
    __weak typeof(self)weakself = self;
    if (!self.keyword) {
        [super getListData:requestComplete];
        return;
    }
    [HttpRequestTool  postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/NewsCollectionServlet?method=getListbyTitle") parameters:@{@"name" : KFormat(weakself.keyword), @"currentPage" : @(self.page) , @"pagesize" : @(defaultPageSize)} success:^(id responseObject, ResponseState state) {
        
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            [weakself removeNoDataImage];
            if (weakself.page == 1) {
                [weakself.dataArray removeAllObjects];
            }
            NSArray *array = responseObject;
            for (NSDictionary *dict in array) {
                [weakself.dataArray addObject:[RNNewsModel mj_objectWithKeyValues:dict]];
            }
            if (!weakself.dataArray.count) {
                [weakself showNoDataImage];
            }
        }
        [super getListData:requestComplete];
    } failure:^(NSError *error) {
        [super getListData:requestComplete];
    }];
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RNNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsIdentifier];
    cell.newsModel = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, 10)];
    view.backgroundColor = UIColor.clearColor;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RNNewsModel *model = self.dataArray[indexPath.row];
    RNNewsInfoViewController *newsDetailVc = [[RNNewsInfoViewController alloc] init];
    newsDetailVc.newsID = model.GUID;
    [self.navigationController pushViewController:newsDetailVc animated:YES];
}

- (RNCustomSearchView *)topView {
    if (_topView == nil) {
        __weak typeof(self)weakself = self;
        _topView = [[RNCustomSearchView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, App_Frame_Width, kTopBarHeight)];
        _topView.backgroundColor = WhiteColor;
        _topView.cancelBlock = ^(){
            [weakself.navigationController popViewControllerAnimated:YES];
        };
        _topView.searchBlock = ^(NSString *keyword) {
            weakself.keyword = keyword;
            [weakself staticRefreshFirstTableListData];
        };
    }
    return _topView;
}



@end
