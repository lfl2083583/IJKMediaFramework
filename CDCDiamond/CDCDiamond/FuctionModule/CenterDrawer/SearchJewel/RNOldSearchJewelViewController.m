//
//  RNOldSearchJewelViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/4.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNOldSearchJewelViewController.h"
#import "RNOldSearchTableViewCell.h"

@interface RNOldSearchJewelViewController ()

@end

@implementation RNOldSearchJewelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self.tableView setHeight:APP_Frame_Height-kTopBarHeight-kStatusBarHeight-kTopBarHeight];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf6f6f6)];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNOldSearchTableViewCell" bundle:nil] forCellReuseIdentifier:oldSearchIdentifier];
    // Do any additional setup after loading the view.
    [self setShowTableRefreshHeader:YES];
    //[self setShowTableRefreshFooter:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self staticRefreshFirstTableListData];
}


- (void)getListData:(void (^)(void))requestComplete {
    __weak typeof(self)weakself = self;
    [HttpRequestTool getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/DiamondSearchServlet?method=getSearchList") parameters:@{@"currentPage" : @(self.page) , @"pagesize" : @(defaultPageSize)}  success:^(id responseObject, ResponseState state) {
        NSLog(@"%@", responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            [weakself removeNoDataImage];
            if (weakself.page == 1) {
                [weakself.dataArray removeAllObjects];
            }
            for (NSDictionary *dict in responseObject) {
                [weakself.dataArray addObject:dict];
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
    RNOldSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oldSearchIdentifier];
    cell.source = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id source = self.dataArray[indexPath.row];
    [self getDetail:source[@"GUID"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, 10)];
    view.backgroundColor = UIColorFromRGB(0xf8f8f8);
    return view;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
 
// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
 
// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        __weak typeof(self)weakself = self;
        id source = self.dataArray[indexPath.row];
        [HttpRequestTool getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/DiamondSearchServlet?method=DeleteOne") parameters:@{@"type" : @"1", @"id" : source[@"GUID"]} success:^(id responseObject, ResponseState state) {
            NSLog(@"%@", responseObject);
            [weakself.dataArray removeObject:source];
            [weakself.tableView reloadData];
            [Utility shouldFeedbackGenerator];
            [YZHubTool showSuccessText:RNLocalized(@"Delete Success")];
        } failure:^(NSError *error) {
            
        }];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)getDetail:(NSString *)GUID {
    [HttpRequestTool getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/AppSearch?method=getsaveSearch") parameters:@{@"GUID" : GUID}  success:^(id responseObject, ResponseState state) {
        NSLog(@"%@", responseObject);
        RNSearchJewelModel *model = [RNSearchJewelModel mj_objectWithKeyValues:responseObject];
        model.pricemin = responseObject[@"price"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(onRNOldSearchJewelViewControllerSeletedRow:)]) {
            [self.delegate onRNOldSearchJewelViewControllerSeletedRow:model];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
