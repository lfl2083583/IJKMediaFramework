//
//  RNMyListViewController.m
//  RapNet
//
//  Created by tjl on 2019/10/10.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNMyListViewController.h"
#import "RNJewelTableViewCell.h"
#import "RNUserInfo.h"
#import "RNTrackJewelModel.h"
#import "RNJewelDetailViewController.h"

@interface RNMyListViewController ()

@end

@implementation RNMyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"My List");
    [self setupTableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNJewelTableViewCell" bundle:nil] forCellReuseIdentifier:jewelTableViewCellIndentifier];
    [self.tableView setRowHeight:200];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    [self setShowTableRefreshHeader:YES];
    [self setShowTableRefreshFooter:YES];
    [self staticRefreshFirstTableListData];
}


- (void)getListData:(void (^)(void))requestComplete {
    __weak typeof(self)weakself = self;
    [HttpRequestTool postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/DiamondDetailServlet?method=getMemberList") parameters:@{@"currentPage" : @(self.page) , @"pagesize" : @(defaultPageSize)} success:^(id responseObject, ResponseState state) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *array = responseObject[@"list"];
            if (array && [array isKindOfClass:[NSArray class]]) {
                [weakself removeNoDataImage];
                if (weakself.page == 1) {
                    [weakself.dataArray removeAllObjects];
                }
                for (NSDictionary *dict in array) {
                    RNTrackJewelListModel *model = [RNTrackJewelListModel mj_objectWithKeyValues:dict];
                    [weakself.dataArray addObject:model];
                }
                if (!weakself.dataArray.count) {
                    [weakself showNoDataImage];
                }
            }
        }
        [super getListData:requestComplete];
    } failure:^(NSError *error) {
        [super getListData:requestComplete];
    }];
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RNJewelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:jewelTableViewCellIndentifier];
    [cell.likeBtn setHidden:YES];
    [cell.titleLabel setX:12];
    [cell.titleLabel setWidth:App_Frame_Width-104];
    cell.trackListModel = self.dataArray[indexPath.row];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, 10)];
    view.backgroundColor = UIColorFromRGB(0xf8f8f8);
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RNTrackJewelListModel *model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:[[RNJewelDetailViewController alloc] initWithGUID:model.GUID] animated:YES];
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
