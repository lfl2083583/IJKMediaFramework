//
//  RNTrackJewelViewController.m
//  RapNet
//
//  Created by tjl on 2019/10/10.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNTrackJewelViewController.h"
#import "RNTrackJewelListViewController.h"
#import "RNTrackJewelModel.h"
#import "RNTrackJewelTableViewCell.h"

@interface RNTrackJewelViewController ()

@end

@implementation RNTrackJewelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Tracked Diamonds");
    [self setupTableView];
    [self.tableView setHeight:APP_Frame_Height-kStatusBarHeight-kTopBarHeight];
    [self.tableView setRowHeight:48.f];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf6f6f6)];
    [self.tableView registerClass:[RNTrackJewelTableViewCell class] forCellReuseIdentifier:trackJewelIdentifier];
    [self setShowTableRefreshFooter:YES];
    [self setShowTableRefreshHeader:YES];
    [self staticRefreshFirstTableListData];
    // Do any additional setup after loading the view.
}

- (void)getListData:(void (^)(void))requestComplete {
    __weak typeof(self)weakself = self;
    [HttpRequestTool getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/DiamondLikeServlet?method=getList") parameters:@{@"currentPage" : @(self.page) , @"pagesize" : @(defaultPageSize)} success:^(id responseObject, ResponseState state) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            [weakself removeNoDataImage];
            if (weakself.page == 1) {
                [weakself.dataArray removeAllObjects];
            }
            NSArray *array = responseObject;
            for (NSDictionary *dict in array) {
                RNTrackJewelModel *model = [RNTrackJewelModel mj_objectWithKeyValues:dict];
                [weakself.dataArray addObject:model];
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


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RNTrackJewelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:trackJewelIdentifier];
    cell.model = self.dataArray[indexPath.row];
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
    RNTrackJewelModel *model = self.dataArray[indexPath.row];
    RNTrackJewelListViewController *trackListVC = [[RNTrackJewelListViewController alloc] init];
    trackListVC.trackName = model.F_SAVENAME;
    [self.navigationController pushViewController:trackListVC animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
