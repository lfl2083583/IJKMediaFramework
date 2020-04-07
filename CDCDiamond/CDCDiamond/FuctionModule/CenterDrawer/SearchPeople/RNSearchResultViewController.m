//
//  RNSearchResultViewController.m
//  RapNet
//
//  Created by jt on 2019/11/13.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNSearchResultViewController.h"
#import "RNSearchPeopleTableViewCell.h"
#import "RNUserDetailViewController.h"
#import "RNPeopleModel.h"

@interface RNSearchResultViewController ()

@end

@implementation RNSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Search Results");
    [self.view setBackgroundColor:UIColorFromRGB(0xf6f6f6)];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height  - kStatusBarHeight - kTopBarHeight) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedSectionHeaderHeight = 12.f;
    self.tableView.estimatedSectionFooterHeight = 12.f;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[RNSearchPeopleTableViewCell class] forCellReuseIdentifier:searchPeopleIndentifier];
    [self.tableView setBackgroundColor:UIColor.clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RNSearchPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchPeopleIndentifier];
    cell.model = [self.dataArray objectAtIndex:indexPath.section];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 12.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == 0)?12.f:0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, 12.f)];
    header.backgroundColor = UIColorFromRGB(0xf8f8f8);
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, 12.f)];
    footer.backgroundColor = UIColorFromRGB(0xf8f8f8);
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:searchPeopleIndentifier configuration:^(RNSearchPeopleTableViewCell *cell) {
         cell.model = [self.dataArray objectAtIndex:indexPath.section];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RNPeopleModel *model = self.dataArray[indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RNUserDetailViewController *userDetail = [[RNUserDetailViewController alloc] initIsFromSideMenue:NO GUID:model.UGUID];
    [self.navigationController pushViewController:userDetail animated:YES];
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
