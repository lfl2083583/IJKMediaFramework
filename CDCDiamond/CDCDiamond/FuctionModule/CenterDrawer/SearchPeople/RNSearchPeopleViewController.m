//
//  RNSearchPeopleViewController.m
//  RapNet
//
//  Created by tjl on 2019/10/10.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNSearchPeopleViewController.h"
#import "RNHightSearchPeopleControllerViewController.h"
#import "RNUserDetailViewController.h"
#import "RNSearchPeopleTableViewCell.h"
#import "RNPeopleModel.h"

@interface RNSearchPeopleViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation RNSearchPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Search People");
    [self.view setBackgroundColor:UIColorFromRGB(0xf6f6f6)];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, 52)];
    self.searchBar.placeholder = RNLocalized(@"Please enter ID or company name");
    self.searchBar.backgroundColor = UIColorFromRGB(0xf6f6f6);
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchBar.delegate = self;
    self.searchBar.tintColor = [RNGlobalUIStandard defaultMainColor];
    //[self.view addSubview:self.searchBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height-kStatusBarHeight-kTopBarHeight) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedSectionHeaderHeight = 12.f;
    self.tableView.estimatedSectionFooterHeight = 12.f;
    [self.tableView setTableHeaderView:self.searchBar];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[RNSearchPeopleTableViewCell class] forCellReuseIdentifier:searchPeopleIndentifier];
    [self.tableView setBackgroundColor:UIColor.clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self setShowTableRefreshHeader:YES];
    [self setShowTableRefreshFooter:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RNLocalized(@"Advanced") style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick)];
    // Do any additional setup after loading the view.
}

- (void)rightBarButtonItemClick {
    RNHightSearchPeopleControllerViewController *vc = [[RNHightSearchPeopleControllerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)searchPeople {
    [self staticRefreshFirstTableListData];
}


- (void)getListData:(void (^)(void))requestComplete {
    __weak typeof(self)weakself = self;
    [HttpRequestTool  postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/MemberServlet?method=quickSearch") parameters:@{@"name_text" : self.searchBar.text,@"currentPage" : @(self.page) , @"pagesize" : @(defaultPageSize)} success:^(id responseObject, ResponseState state) {
        NSLog(@"%@", responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            if (weakself.page == 1) {
               [weakself.dataArray removeAllObjects];
            }
            NSArray *array = responseObject;
            for (NSDictionary *dict in array) {
               [weakself.dataArray addObject:[RNPeopleModel mj_objectWithKeyValues:dict]];
            }
        }
        if (!weakself.dataArray.count) {
            [YZHubTool showText:RNLocalized(@"No search data")];
        }
        
        [super getListData:requestComplete];
    } failure:^(NSError *error) {
        [super getListData:requestComplete];
    }];
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
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, 12.f)];
    header.backgroundColor = UIColorFromRGB(0xf8f8f8);
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
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

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [self searchPeople];
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
