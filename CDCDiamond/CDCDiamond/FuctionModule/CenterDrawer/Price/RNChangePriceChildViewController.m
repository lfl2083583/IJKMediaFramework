//
//  RNChangePriceChildViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/25.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNChangePriceChildViewController.h"
#import "RNChangePriceList.h"

@interface RNChangePriceChildViewController ()


@property (nonatomic, strong) NSMutableArray *roundArray;
@property (nonatomic, strong) NSMutableArray *otherArray;

@property (nonatomic, copy) NSString *dateString;

@end

@implementation RNChangePriceChildViewController

- (NSMutableArray *)roundArray {
    if (!_roundArray) {
        _roundArray = [NSMutableArray array];
    }
    return _roundArray;
}

- (NSMutableArray *)otherArray {
    if (!_otherArray) {
        _otherArray = [NSMutableArray array];
    }
    return _otherArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self.tableView setRowHeight:44];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf6f6f6)];
    [self requestDatas];
    // Do any additional setup after loading the view.
}

- (void)requestDatas {
    __weak typeof(self)weakself = self;
    [HttpRequestTool getWithURLString:[NSString stringWithFormat:KStringFormat(BaseServer, @"bpdm/servlet/DiamondDetailServlet?method=updatePrices")] parameters:nil success:^(id responseObject, ResponseState state) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (responseObject[@"Alien"] && [responseObject[@"Alien"] isKindOfClass:[NSArray class]]) {
                [weakself.otherArray addObjectsFromArray:responseObject[@"Alien"]];
            }
            if (responseObject[@"Round"] && [responseObject[@"Round"] isKindOfClass:[NSArray class]]) {
                [weakself.roundArray addObjectsFromArray:responseObject[@"Round"]];
            }
            weakself.dateString = responseObject[@"OLDUPDATETIME"];
        }
        [weakself.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *changePriceIdentifier = @"RNChangePriceChildViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:changePriceIdentifier];
        cell.textLabel.font = [UIFont yz_PingFangSC_MediumFontOfSize:16];
        cell.textLabel.textColor = RGBOF(0x222222);
        cell.detailTextLabel.font = [UIFont yz_PingFangSC_RegularFontOfSize:16];
        cell.detailTextLabel.textColor = RGBOF(0x999999);
        cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dateString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld 更改", (self.type == 0)?self.roundArray.count:self.otherArray.count];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RNChangePriceList *listVC = [[RNChangePriceList alloc] init];
    listVC.dataArray = (self.type == 0)?self.roundArray:self.otherArray;
    listVC.title = (self.type == 0)?@"圆形":@"异形";
    [[Utility currentViewController].navigationController pushViewController:listVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
