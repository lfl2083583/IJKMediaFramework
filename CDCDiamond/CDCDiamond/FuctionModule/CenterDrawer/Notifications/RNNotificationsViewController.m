//
//  RNNotificationsViewController.m
//  RapNet
//
//  Created by tjl on 2019/10/11.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNNotificationsViewController.h"

@interface RNNotificationsViewController ()

@end

@implementation RNNotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Notifications");
    [self setupTableView];
    [self showNoDataImage];
    // Do any additional setup after loading the view.
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
