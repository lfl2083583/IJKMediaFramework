//
//  RNAgencyViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/25.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNAgencyViewController.h"
#import "RNAgencyViewTableViewCell.h"

@interface RNAgencyViewController ()<RNAgencyViewTableViewCellDelegate>

@end

@implementation RNAgencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"District Office");
    self.view.backgroundColor = RGBOF(0xf1f2f1);
    [self setupTableView];
    [self.tableView setBackgroundColor:RGBOF(0xf1f1f1)];
    [self.tableView registerClass:[RNAgencyViewTableViewCell class] forCellReuseIdentifier:agencyIdentifier];
    [self setShowTableRefreshHeader:YES];
    [self setShowTableRefreshFooter:YES];
    [self staticRefreshFirstTableListData];
    
}

- (void)getListData:(void (^)(void))requestComplete {
    __weak typeof(self)weakself = self;
    [HttpRequestTool  postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/FeedbackServlet?method=Office") parameters:@{@"currentPage" : @(self.page) , @"pagesize" : @(defaultPageSize)} success:^(id responseObject, ResponseState state) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            [weakself removeNoDataImage];
            if (weakself.page == 1) {
                [weakself.dataArray removeAllObjects];
            }
            [weakself.dataArray addObjectsFromArray:responseObject];
            if (!weakself.dataArray.count) {
                [weakself showNoDataImage];
            }
        }
        [super getListData:requestComplete];
    } failure:^(NSError *error) {
        [super getListData:requestComplete];
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RNAgencyViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:agencyIdentifier];
    cell.delegate = self;
    cell.source = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self)weakself = self;
    return [tableView fd_heightForCellWithIdentifier:agencyIdentifier configuration:^(RNAgencyViewTableViewCell *cell) {
        cell.source = weakself.dataArray[indexPath.row];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, 10.f)];
    sectionHeader.backgroundColor = RGBOF(0xf1f1f1);
    return sectionHeader;
}

#pragma mark - RNAgencyViewTableViewCellDelegate

- (void)onEmailClick:(NSString *)email {
    UIPasteboard *pasterBoard = [UIPasteboard generalPasteboard];
    pasterBoard.string = KFormat(email);
    [YZHubTool showText:@"已复制至剪切板"];
}

- (void)onPhoneClick:(NSString *)phone {
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",callPhone]]];
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
