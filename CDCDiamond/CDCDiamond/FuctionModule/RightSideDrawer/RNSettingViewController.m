//
//  RNRightSideViewController.m
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNSettingViewController.h"
#import <SSDataSources.h>
#import "SettingsTableViewItem.h"
#import "SettingsTableViewCell.h"
#import "RNLanguageViewController.h"
#import "AppDelegate.h"
#import "RNLoginViewController.h"
#import "RNXuKePrivateViewController.h"
#import "RNXinWeiPrivateViewController.h"
#import "RNZhenCePrivateViewController.h"
#import "RNPriceSettingViewController.h"
#import "RNEmailsViewController.h"
#import "RNAgencyViewController.h"
#import "RNCurrentPlanViewController.h"
#import "RNFeedbackViewController.h"
#import "RNPrivateViewController.h"

@interface RNSettingViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) SSSectionedDataSource *dataSource;

@end

static NSString *const setIdentifier = @"UITableViewCell";

@implementation RNSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height-kStatusBarHeight-kTopBarHeight) style:UITableViewStyleGrouped];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    [self reloadDataSource];
 
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, 60)];
    UIButton *logout = [[UIButton alloc] initWithFrame:CGRectMake(24, 10, App_Frame_Width-48, 40)];
    logout.titleLabel.font = [UIFont yz_PingFangSC_MediumFontOfSize:16];
    [logout setTitle:RNLocalized(@"Log Out") forState:UIControlStateNormal];
    [logout setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [logout setBackgroundColor:[RNGlobalUIStandard defaultMainColor]];
    [foot addSubview:logout];
    [logout yz_setAllCornerWithCornerRadius:3.f];
    [logout addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = foot;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setSeparatorColor:RGBOF(0xe6e6e6)];
    // Do any additional setup after loading the view.
}



- (void)logoutClick {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:RNLocalized(@"Do you sure to quit") delegate:self cancelButtonTitle:RNLocalized(@"No") otherButtonTitles:RNLocalized(@"Yes"), nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:isLogin];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:userToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [AppDelegate sharedAppDelegate].window.rootViewController = [[RNNavigationController alloc] initWithRootViewController:[[RNLoginViewController alloc] init]];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const Identidier = @"UITableviewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identidier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identidier];
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.textLabel.textColor = RGBOF(0x222222);
    }
    NSArray *array = self.dataArray[indexPath.section];
    SettingsTableViewItem *item = array[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"  %@", item.title];
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",appVersion];
        cell.detailTextLabel.textColor = RGBOF(0x222222);
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.detailTextLabel.text = @"";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataArray[section];
    return array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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
//    if (indexPath.section == 0 && indexPath.row == 0) {
////        [self.navigationController pushViewController:[[RNPriceSettingViewController alloc] init] animated:YES];
//    } else
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self.navigationController pushViewController:[[RNEmailsViewController alloc] init] animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        [self.navigationController pushViewController:[[RNLanguageViewController alloc] init] animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        [self.navigationController pushViewController:[[RNAgencyViewController alloc] init] animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        [self.navigationController pushViewController:[[RNFeedbackViewController alloc] init] animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        
    }  else if (indexPath.section == 1 && indexPath.row == 1) {
        RNPrivateViewController *vc = [[RNPrivateViewController alloc] initWithType:0];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        RNPrivateViewController *vc = [[RNPrivateViewController alloc] initWithType:2];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 3) {
        RNPrivateViewController *vc = [[RNPrivateViewController alloc] initWithType:1];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//    else if (indexPath.section == 1 && indexPath.row == 1) {
//       // [self.navigationController pushViewController:[[RNCurrentPlanViewController alloc] init] animated:YES];
//    }
}

- (void)reloadDataSource {
    
    NSMutableArray *sectionOneItems = [NSMutableArray new];
    for (int i = 0; i < kRNSettingsTableViewItemsCount; i++) {
        [self insertIfAllowWithItem:i items:sectionOneItems];
    }
    [self.dataArray addObject:sectionOneItems];
    
    NSMutableArray *otherItems = [NSMutableArray new];
    
    for (int i = 0; i < kRNSettingsTableViewOtherItemsCount; i++) {
        [self insertIfAllowWithotherItem:i items:otherItems];
    }
    SSSection *otherSection = [SSSection sectionWithItems:otherItems];
    otherSection.headerHeight = 10.f;
    [self.dataArray addObject:otherItems];
    
}


- (void)insertIfAllowWithItem:(RNSettingsTableViewItem)item items:(NSMutableArray *)items {
    SettingsTableViewItem *viewItem = [SettingsTableViewItem itemWithTitle:RNLocalized(RNSettingsTableViewItemNames[item]) rowType:item];
    [items addObject:viewItem];
}

- (void)insertIfAllowWithotherItem:(RNSettingsTableViewOtherItem)item items:(NSMutableArray *)items {
    SettingsTableViewItem *viewItem = [SettingsTableViewItem itemWithTitle:RNLocalized(RNSettingsTableViewotherItemNames[item]) rowType:item];
    [items addObject:viewItem];
}

@end
