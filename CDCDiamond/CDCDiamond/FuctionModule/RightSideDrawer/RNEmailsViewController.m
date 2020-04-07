//
//  RNEmailsViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/25.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNEmailsViewController.h"

static NSString *noticeSwtichName = @"noticeSwtichName";

@interface RNEmailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;

@end

@implementation RNEmailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Notifications");
    self.view.backgroundColor = UIColorFromRGB(0xF1F2F1);
    self.lb1.text = RNLocalized(@"Conventional");
    self.lb2.text = RNLocalized(@"Enable application notifications");
    self.lb3.text = RNLocalized(@"Make sure you turn on the CDC notification in your Settings. Go to Settings -> apply ->CDC");
    self.lb4.text = RNLocalized(@"Notification type");
    // Do any additional setup after loading the view from its nib.
    id isOn = [[NSUserDefaults standardUserDefaults] objectForKey:noticeSwtichName];
    [self.switchBtn setOn:(isOn && [isOn boolValue] == YES)?YES:NO];
}
- (IBAction)swithValueChanged:(UISwitch *)sender {
    [[NSUserDefaults standardUserDefaults] setValue:sender.isOn?@(1):@(0) forKey:noticeSwtichName];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
