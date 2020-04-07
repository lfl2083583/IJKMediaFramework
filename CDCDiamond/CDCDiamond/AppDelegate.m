//
//  AppDelegate.m
//  RapNet
//
//  Created by liufulin on 2019/7/12.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Logger.h"
#import "AppDelegate+Migration.h"
#import "AppDelegate+Service.h"
#import "AppDelegate+RootController.h"
#import "RNLaunchAnimateTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Shared Instance

+ (AppDelegate *)sharedAppDelegate
{
    id<UIApplicationDelegate> application = [UIApplication sharedApplication].delegate;
    return ([application isKindOfClass:[self class]]) ? (AppDelegate *)application : nil;
}


- (BOOL)application:(UIApplication *)app willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    [self setupLogger];
    [self setupRootViewController];
    [RNLaunchAnimateTool animateWithWindow:self.window];
    [self configTheme];
    [self test];
    return YES;
}

- (void)configTheme {
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[UINavigationBar appearance] setTintColor: UIColorFromRGB(0x222222)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x222222), NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageWithColor:WhiteColor] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]]setTitle:@"取消"];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]]setTintColor:MainColor];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
