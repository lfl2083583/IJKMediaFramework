//
//  RNUserDetailViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/13.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNUserDetailViewController.h"
#import "RNUserBaseInfoTableViewCell.h"
#import "RNUserCompanyTableViewCell.h"
#import "RNUserStockTableViewCell.h"
#import "RNUserScoreTableViewCell.h"
#import "RNUserMemberTableViewCell.h"

@interface RNUserDetailViewController ()

@property (nonatomic, strong) RNUserInfo *userInfo;

@end

@implementation RNUserDetailViewController

- (instancetype)initIsFromSideMenue:(BOOL)isFromSideMenue GUID:(NSString *)GUID {
    self = [super initIsFromSideMenue:isFromSideMenue];
    if (self) {
        _GUID = GUID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Membership information");               
    [self setupTableView];
    [self.tableView setHeight:APP_Frame_Height-kStatusBarHeight-kTopBarHeight];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf6f6f6)];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNUserBaseInfoTableViewCell" bundle:nil] forCellReuseIdentifier:useBaseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNUserCompanyTableViewCell" bundle:nil] forCellReuseIdentifier:useCompanyIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNUserStockTableViewCell" bundle:nil] forCellReuseIdentifier:userStockIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNUserScoreTableViewCell" bundle:nil] forCellReuseIdentifier:userScoreIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNUserMemberTableViewCell" bundle:nil] forCellReuseIdentifier:userMemberIdentifier];
    // Do any additional setup after loading the view.
    
    [self reloadData];
}

- (void)reloadData {
    __weak typeof(self)weakself = self;
    [self.dataArray removeAllObjects];
    [HttpRequestTool  postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/MemberServlet?method=getMemberDetail") parameters:@{@"GUID" : self.GUID} success:^(id responseObject, ResponseState state) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            weakself.userInfo = [RNUserInfo mj_objectWithKeyValues:responseObject];
        }
        [weakself.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:userToken]);
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        RNUserBaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:useBaseIdentifier];
        cell.userInfo = self.userInfo;
        return cell;
    } else if (indexPath.row == 1) {
        RNUserCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:useCompanyIdentifier];
        cell.userInfo = self.userInfo;
        return cell;
    } else if (indexPath.row == 2) {
        RNUserStockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userStockIdentifier];
        cell.userInfo = self.userInfo;
        return cell;
    } else if (indexPath.row == 3) {
        RNUserScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userScoreIdentifier];
        cell.userInfo = self.userInfo;
        cell.memberLB.hidden = !(self.userInfo.list&&self.userInfo.list.count);
        return cell;
    } else {
        RNUserMemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userMemberIdentifier];
        cell.userInfo = self.userInfo;
        cell.index = indexPath.row - 4;
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.userInfo) {
        if (self.userInfo.list) {
            return 4+self.userInfo.list.count;
        } else {
            return 4;
        }
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 196.f;
    } else if (indexPath.row == 1) {
        return 212.5f;
    } else if (indexPath.row == 2) {
        return 152.f;
    } else if (indexPath.row == 3) {
        return self.userInfo.list&&self.userInfo.list.count?199:164;
    } else {
        return 55;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

@end
