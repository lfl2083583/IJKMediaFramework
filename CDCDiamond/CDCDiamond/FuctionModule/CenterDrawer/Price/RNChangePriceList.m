//
//  RNChangePriceList.m
//  RapNet
//
//  Created by jt on 2019/11/7.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNChangePriceList.h"
#import "RNChangePriceListTableViewCell.h"

@interface RNChangePriceList ()

@end

@implementation RNChangePriceList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self.tableView setRowHeight:137];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNChangePriceListTableViewCell" bundle:nil] forCellReuseIdentifier:changePriceListIdentifier];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf6f6f6)];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RNChangePriceListTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:changePriceListIdentifier];
    cell.source = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

@end
