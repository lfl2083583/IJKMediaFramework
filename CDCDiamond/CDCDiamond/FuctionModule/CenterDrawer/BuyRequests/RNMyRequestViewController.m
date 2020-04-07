//
//  RNMyRequestViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/16.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNMyRequestViewController.h"
#import "RNBuyRequestDetalViewController.h"
#import "RNRequestDetailViewController.h"
#import "RNBuyRequestTableViewCell.h"
#import "RNMyBuyRequestTableViewCell.h"
#import "RNBuyRequestModel.h"

@interface RNMyRequestViewController ()

@end

@implementation RNMyRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height-kStatusBarHeight-kTopBarHeight-kTopBarHeight) style:UITableViewStyleGrouped];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNBuyRequestTableViewCell" bundle:nil] forCellReuseIdentifier:buyRequestIndentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNMyBuyRequestTableViewCell" bundle:nil] forCellReuseIdentifier:myBuyRequestIdentifier];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    [self setShowTableRefreshHeader:YES];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self staticRefreshFirstTableListData];
}

- (void)getListData:(void (^)(void))requestComplete {
    __weak typeof(self)weakself = self;
    [HttpRequestTool  postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/PurchaseServlet?method=allMy") parameters:@{@"currentPage" : [NSString stringWithFormat:@"%d", self.page] } success:^(id responseObject, ResponseState state) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (weakself.type == 0) {
                NSArray *array = responseObject[@"allrequest"];
                if (array && [array isKindOfClass:[NSArray class]]) {
                    [weakself removeNoDataImage];
                    if (weakself.page == 1) {
                        [weakself.dataArray removeAllObjects];
                    }
                    for (NSDictionary *dict in array) {
                        RNBuyRequestModel *model = [RNBuyRequestModel mj_objectWithKeyValues:dict];
                        model.CREATETIME = KFormat([dict objectForKey:@"F_TIME"]);
                        model.UPDATETIME = KFormat([dict objectForKey:@"F_EXPIRE"]);
                       [weakself.dataArray addObject:model];
                    }
                    if (!weakself.dataArray.count) {
                        [weakself showNoDataImage];
                    }
                }
            } else {
                NSArray *array = responseObject[@"myrequeest"];
                if (array && [array isKindOfClass:[NSArray class]]) {
                    [weakself removeNoDataImage];
                    if (weakself.page == 1) {
                        [weakself.dataArray removeAllObjects];
                    }
                    for (NSDictionary *dict in array) {
                       [weakself.dataArray addObject:[RNBuyRequestModel mj_objectWithKeyValues:dict]];
                    }
                    if (!weakself.dataArray.count) {
                        [weakself showNoDataImage];
                    }
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
    if (self.type == 0) {
        RNBuyRequestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:buyRequestIndentifier];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    } else {
        RNMyBuyRequestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myBuyRequestIdentifier];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 0) {
        __weak typeof(self)weakself = self;
        return [tableView fd_heightForCellWithIdentifier:buyRequestIndentifier configuration:^(RNBuyRequestTableViewCell *cell) {
            cell.model = weakself.dataArray[indexPath.row];
        }];
    } else {
        return 129;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.type == 1)?YES:NO;
}
 
// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
 
// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        __weak typeof(self)weakself = self;
        RNBuyRequestModel *model = self.dataArray[indexPath.row];
        [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/PurchaseServlet?method=Mydel") parameters:@{@"guid" : model.GUID} success:^(id responseObject, ResponseState state) {
            NSLog(@"%@", responseObject);
            [weakself.dataArray removeObject:model];
            [weakself.tableView reloadData];
            [Utility shouldFeedbackGenerator];
            [YZHubTool showSuccessText:RNLocalized(@"Delete Success")];
            [weakself staticRefreshFirstTableListData];
        } failure:^(NSError *error) {
            
      }];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RNLocalized(@"Delete");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RNBuyRequestModel *model = self.dataArray[indexPath.row];
    [[Utility currentViewController].navigationController pushViewController:[[RNBuyRequestDetalViewController alloc] initWithGUID:model.GUID eidteEnable:(self.type == 1)?YES:NO] animated:YES];
}

@end
