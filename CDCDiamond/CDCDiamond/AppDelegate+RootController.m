//
//  AppDelegate+RootController.m
//  RapNet
//
//  Created by liufulin on 2019/7/12.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "AppDelegate+RootController.h"
#import "RNCenterViewController.h"
#import "RNLanguageManager.h"
#import "RNLoginViewController.h"

static NSString *drawerControllerKey = @"drawerControllerKey";

@implementation AppDelegate (RootController)

- (void)setupRootViewController {
    
    if ([RNLanguageManager shareManager].languageType == 3) {
        [[RNLanguageManager shareManager] setLanguageForEnglish];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setTintColor:UIColor.whiteColor];
    
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:isLogin];
    
    if (value && [value boolValue] == YES) {
        [self.window setRootViewController:[[RNNavigationController alloc] initWithRootViewController:[[RNCenterViewController alloc] init]]];
    } else {
        [self.window setRootViewController:[[RNNavigationController alloc] initWithRootViewController:[[RNLoginViewController alloc] init]]];
    }
    
    
    
}



@end
