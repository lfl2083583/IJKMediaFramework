//
//  RNImagePickerController.m
//  RapNet
//
//  Created by liufulin on 2019/11/19.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNImagePickerController.h"

@interface RNImagePickerController ()

@end

@implementation RNImagePickerController

#pragma mark status bar style
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark navigationBar tintColor & title textColor

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationBar.tintColor = RGBOF(0x222222);
        [self.navigationBar setTitleTextAttributes:@{
            NSForegroundColorAttributeName : RGBOF(0x222222), NSFontAttributeName:[UIFont systemFontOfSize:18]
                        }];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"wanc" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
     }
     return self;
}

- (void)rightBarButtonItemClick {
    [self dismissViewControllerAnimated:YES completion:nil];
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
