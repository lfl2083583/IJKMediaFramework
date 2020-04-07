//
//  RNPriceSettingViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/25.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNPriceSettingViewController.h"

@interface RNPriceSettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;

@end

@implementation RNPriceSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Price Setting");
    self.view.backgroundColor = UIColorFromRGB(0xF1F2F1);
    // Do any additional setup after loading the view from its nib.
    self.lb1.text = RNLocalized(@"Conventional");
    self.lb2.text = RNLocalized(@"Use the 10-carat price list");
    self.lb3.text = RNLocalized(@"Price update");
    self.lb4.text = RNLocalized(@"Last update");
    
    [self.updateBtn setTitle:RNLocalized(@"Update now") forState:UIControlStateNormal];
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
