//
//  RNCurrentPlanViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/25.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNCurrentPlanViewController.h"

@interface RNCurrentPlanViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UILabel *content1LB;
@property (weak, nonatomic) IBOutlet UILabel *content2LB;
@property (weak, nonatomic) IBOutlet UILabel *content3LB;
@property (weak, nonatomic) IBOutlet UILabel *content4LB;

@end

@implementation RNCurrentPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Current Plan";
    self.content2LB.text = RNLocalized(@"Your subscription is about to expire");
    self.content3LB.text = [RNUserInfo shareUserInfo].loginname;
    self.content4LB.text = [NSString stringWithFormat:RNLocalized(@"Membership expires at %@"), [RNUserInfo shareUserInfo].F_ENDTIME];
    // Do any additional setup after loading the view from its nib.
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
