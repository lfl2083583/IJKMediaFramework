//
//  RNNewsChildViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNNewsChildViewController.h"
#import "RNNewsTableViewCell.h"
#import "RNNewsModel.h"
#import "RNNewsInfoViewController.h"

@interface RNNewsChildViewController ()

@end

@implementation RNNewsChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self.tableView registerClass:[RNNewsTableViewCell class] forCellReuseIdentifier:newsIdentifier];
    [self.tableView setHeight:APP_Frame_Height-kTopBarHeight-kStatusBarHeight-kTopBarHeight];
    [self.tableView setRowHeight:91.f];
    [self.tableView setTableFooterView:[UIView new]];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    [self setShowTableRefreshHeader:YES];
    [self setShowTableRefreshFooter:YES];
    [self staticRefreshFirstTableListData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self staticRefreshFirstTableListData];
}

- (void)getListData:(void (^)(void))requestComplete {
     __weak typeof(self)weakself = self;
    [HttpRequestTool  getWithURLString:[NSString stringWithFormat:@"%@bpdm/servlet/NewsCollectionServlet?%@", BaseServer, self.index?@"GUID=2&method=news":@"method=getList"] parameters:@{@"currentPage" : @(self.page) , @"pagesize" : @(defaultPageSize)} success:^(id responseObject, ResponseState state) {
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    view.backgroundColor = UIColorFromRGB(0xf8f8f8);
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
    [self.parentVC.navigationController pushViewController:newsDetailVc animated:YES];
}

#pragma mark ---- 侧滑删除

// 点击了“左滑出现的Delete按钮”会调用这个方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    RNNewsModel *model = self.dataArray[indexPath.row];
    [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/NewsCollection?method=newsdele") parameters:@{@"cguid" : model.CREATEGUID} success:^(id responseObject, ResponseState state) {
        NSLog(@"%@", responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleNone;//self.index == 1?UITableViewCellEditingStyleDelete:
}

// 修改Delete按钮文字为“删除”
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RNLocalized(@"Delete");
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
