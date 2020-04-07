//
//  RNTrackJewelListViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/31.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNTrackJewelListViewController.h"
#import "RNJewelTableViewCell.h"
#import "RNTrackJewelModel.h"
#import "RNJewelDetailViewController.h"

@interface RNTrackJewelListViewController ()<UIAlertViewDelegate, RNJewelTableViewCellDelegate>

@end

@implementation RNTrackJewelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Result List");
    [self setupTableView];
    [self.tableView setHeight:APP_Frame_Height-kStatusBarHeight-kTopBarHeight];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNJewelTableViewCell" bundle:nil] forCellReuseIdentifier:jewelTableViewCellIndentifier];
    [self.tableView setRowHeight:200];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf6f6f6)];
    
    [self setShowTableRefreshHeader:YES];
    [self setShowTableRefreshFooter:YES];
    [self staticRefreshFirstTableListData];

}

- (void)getListData:(void (^)(void))requestComplete {
    __weak typeof(self)weakself = self;
    if (self.isFromSearch) {
       
        NSMutableDictionary *mudict = [NSMutableDictionary dictionaryWithDictionary:self.pragem];
        [mudict setValue:@(self.page) forKey:@"currentPage"];
        NSLog(@"------%@", mudict);
        [HttpRequestTool  getWithURLString:[NSString stringWithFormat:@"%@bpdm/%@", BaseServer, _isMoreSearch == YES ?@"servlet/AppSearch?method=hignSearch":@"servlet/AppSearch?method=generalSearch"] parameters:mudict success:^(id responseObject, ResponseState state) {
            [YZHubTool hide];
            NSLog(@"%@", responseObject);
            [weakself removeNoDataImage];
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                NSArray *array = responseObject[@"list"];
                if (array && [array isKindOfClass:[NSArray class]]) {
                    if (weakself.page == 1) {
                        [weakself.dataArray removeAllObjects];
                    }
                    for (NSDictionary *dict in array) {
                        RNTrackJewelListModel *model = [RNTrackJewelListModel mj_objectWithKeyValues:dict];
                        [weakself.dataArray addObject:model];
                    }
                }
            }
            if (!weakself.dataArray.count) {
                [weakself showNoDataImage];
            }
            [super getListData:requestComplete];
        } failure:^(NSError *error) {
            [YZHubTool hide];
            [super getListData:requestComplete];
        }];
    } else {
        [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/DiamondLikeServlet?method=getOneList") parameters:@{@"saveName" : self.trackName,@"currentPage" : @(self.page) , @"pagesize" : @(defaultPageSize)} success:^(id responseObject, ResponseState state) {
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                if (weakself.page == 1) {
                    [weakself.dataArray removeAllObjects];
                }
                [weakself removeNoDataImage];
                NSArray *array = responseObject[@"list"];
                if (array && [array isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dict in array) {
                        RNTrackJewelListModel *model = [RNTrackJewelListModel mj_objectWithKeyValues:dict];
                        [weakself.dataArray addObject:model];
                    }
                }
                if (!weakself.dataArray.count) {
                    [weakself showNoDataImage];
                }
            } else {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No tracked diamonds were found" message:nil delegate:weakself cancelButtonTitle:nil otherButtonTitles:RNLocalized(@"Cancel")];
                [alertView show];
            }
            [super getListData:requestComplete];
        } failure:^(NSError *error) {
            [super getListData:requestComplete];
        }];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RNJewelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:jewelTableViewCellIndentifier];
    cell.trackListModel = self.dataArray[indexPath.section];
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RNTrackJewelListModel *model = self.dataArray[indexPath.section];
    [self.navigationController pushViewController:[[RNJewelDetailViewController alloc] initWithGUID:model.GUID] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, 10.f)];
    view.backgroundColor = UIColorFromRGB(0xf6f6f6);
    return view;
}

#pragma mark - RNJewelTableViewCellDelegate

- (void)onJewelTableViewCellAddLike:(RNJewelTableViewCell *)cell {
}

- (void)onJewelTableViewCellCancelLike:(RNJewelTableViewCell *)cell {
    if (!self.isFromSearch) {
        [self.dataArray removeObject:cell.trackListModel];
        [self.tableView reloadData];
    }
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
