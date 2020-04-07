//
//  RNLanguageViewController.m
//  RapNet
//
//  Created by liufulin on 2019/8/9.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNLanguageViewController.h"
#import <SSDataSources.h>
#import "SettingsTableViewCell.h"
#import "SettingsTableViewItem.h"
#import "RNLanguageManager.h"
#import "AppDelegate.h"
#import "AppDelegate+RootController.h"

@interface RNLanguageViewController ()

@property (nonatomic, strong) SSSectionedDataSource *dataSource;

@end

@implementation RNLanguageViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.tableView setSeparatorColor:RGBOF(0xe6e6e6)];
    [self.tableView setSeparatorColor:RGBOF(0xe6e6e6)];
    [self reloadDataSource];
    self.title = RNLocalized(@"Languages");
    // Do any additional setup after loading the view.
}

- (void)reloadDataSource {
    [self.dataSource removeAllSections];
    
   
    for (int i = 0; i < kRNLanguageTableViewItemCount; i++) {
        [self insertIfAllowWithItem:i items:self.dataArray];
    }
    
}

- (void)insertIfAllowWithItem:(RNLanguageTableViewItem)item items:(NSMutableArray *)items {
    SettingsTableViewItem *viewItem = [SettingsTableViewItem itemWithTitle:RNLocalized(RNLanguageTableViewItemNames[item]) rowType:item];
    [items addObject:viewItem];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const Identidier = @"UITableviewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identidier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identidier];
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.textLabel.textColor = RGBOF(0x222222);
    }
    SettingsTableViewItem *item = self.dataArray[indexPath.row];
    if (indexPath.row == 0 && ([RNLanguageManager shareManager].languageType == 2 || [RNLanguageManager shareManager].languageType == 3)) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:ImageName(@"list_icon_select")];
    }
    else if (indexPath.row == 1 && [RNLanguageManager shareManager].languageType == 0) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:ImageName(@"list_icon_select")];
    }
    else if (indexPath.row == 2 && [RNLanguageManager shareManager].languageType == 1) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:ImageName(@"list_icon_select")];
    } else {
        cell.accessoryView = [[UIImageView alloc] initWithImage:ImageName(@"")];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"   %@", item.title];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [[RNLanguageManager shareManager] setLanguageForEnglish];
    } else if (indexPath.row == 1) {
        [[RNLanguageManager shareManager] setLanguageForChinese];
    } else if (indexPath.row == 2) {
        [[RNLanguageManager shareManager] setLanguageForSimplified];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:RNLanguageChangedNotification object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}





@end
