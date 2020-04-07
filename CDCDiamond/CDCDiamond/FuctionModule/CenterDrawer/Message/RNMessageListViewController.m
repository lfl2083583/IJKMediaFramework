//
//  RNMessageListViewController.m
//  RapNet
//
//  Created by tjl on 2019/10/10.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNMessageListViewController.h"
#import "RNMessageListTableViewCell.h"
#import "RNMessageListModel.h"

@interface RNMessageListViewController ()

@end

@implementation RNMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Notifications");
    [self setupTableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self.view);
    }];
    [self.tableView registerClass:[RNMessageListTableViewCell class] forCellReuseIdentifier:messageListIdentifier];
    [self.tableView setRowHeight:173];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    [self setShowTableRefreshHeader:YES];
    [self setShowTableRefreshFooter:YES];
    [self staticRefreshFirstTableListData];
}


- (void)getListData:(void (^)(void))requestComplete {
    __weak typeof(self)weakself = self;
    [HttpRequestTool postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/HomeServlet?method=getAll") parameters:@{@"currentPage" : @(self.page) , @"pagesize" : @(defaultPageSize)} success:^(id responseObject, ResponseState state) {
        if ((responseObject[@"list"] && [responseObject[@"list"] isKindOfClass:[NSArray class]]) ||
            (responseObject[@"listLook"] && [responseObject[@"listLook"] isKindOfClass:[NSArray class]])) {
            NSArray *array = responseObject[@"list"];
            [weakself removeNoDataImage];
            if (weakself.page == 1) {
                [weakself.dataArray removeAllObjects];
            }
            if (array && [array isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in array) {
                    RNMessageListModel *model = [RNMessageListModel mj_objectWithKeyValues:dict];
                    [weakself.dataArray addObject:model];
                }
                
            }
            
            NSArray *readArray = responseObject[@"listLook"];
            if (readArray && [readArray isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dict in readArray) {
                    RNMessageListModel *model = [RNMessageListModel mj_objectWithKeyValues:dict];
                    model.isRead = YES;
                    [weakself.dataArray addObject:model];
                }
            }
            
            if (!weakself.dataArray.count) {
                [weakself showNoDataImage];
            }
        }
        if (!weakself.dataArray.count) {
            [YZHubTool showText:RNLocalized(@"Data is empty")];
        }
        [super getListData:requestComplete];
    } failure:^(NSError *error) {
        [super getListData:requestComplete];
    }];
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RNMessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageListIdentifier];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    RNMessageListModel *model = self.dataArray[indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:messageListIdentifier configuration:^(RNMessageListTableViewCell *cell) {
        cell.model = model;
    }];
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
    RNMessageListModel *model = self.dataArray[indexPath.row];
    [model setIsOpen:!model.isOpen];
    [tableView reloadData];
    if (model.isOpen == YES) {
       [self getMessageDetail:model.GUID];
    }
}

- (void)getMessageDetail:(NSString *)GUID {
   [HttpRequestTool postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/HomeServlet?method=getList") parameters:@{@"GUID" : GUID} success:^(id responseObject, ResponseState state) {
        
    } failure:^(NSError *error) {
       
    }];
}

@end
