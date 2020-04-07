//
//  RNNavigationController.m
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNNavigationController.h"
#import "UIImage+Extension.h"

@interface RNNavigationController ()<UINavigationControllerDelegate>

@end

@implementation RNNavigationController

//+ (void)initialize
//{
    //导航栏主题 title文字属性
//    UINavigationBar *navBar = [UINavigationBar appearance];
//    //导航栏背景图
//    [[UINavigationBar appearance] setTintColor: UIColorFromRGB(0x222222)];
//    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x222222), NSFontAttributeName : [UIFont systemFontOfSize:18]}];
//    [navBar setBackgroundImage:[[UIImage imageWithColor:WhiteColor] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //[navBar setShadowImage:[UIImage new]];//去掉阴影线
     //navBar.topItem.title = @"";
    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
//    for (UIView *subView in self.navigationBar.subviews) {
//        if (subView.height == 1) {
//            subView.backgroundColor = RGBOF(0xf6f6f6);
//        }
//    }
    //毛玻璃效果
//    self.navigationBar.translucent = NO;
//    //设置标题的样式
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x222222)}];
//
//    //[[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:0.1], NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
    
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //通过对当前navigationController中viewControllers的数量来判断是否需要隐藏tabBar
    if (self.viewControllers.count > 1) {
        self.tabBarController.tabBar.hidden = YES;
    }else {
        self.tabBarController.tabBar.hidden = NO;
    }
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
////    if(self.mm_drawerController.showsStatusBarBackgroundView){
////        return UIStatusBarStyleLightContent;
////    }
////    else {
////        return UIStatusBarStyleDefault;
////    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
