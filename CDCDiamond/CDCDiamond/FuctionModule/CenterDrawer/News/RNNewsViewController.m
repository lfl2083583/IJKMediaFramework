//
//  RNNewsViewController.m
//  RapNet
//
//  Created by tjl on 2019/10/11.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNNewsViewController.h"
#import "HMSegmentedControl.h"
#import "RNNewsChildViewController.h"
#import "RNSearchNewsViewController.h"

@interface RNNewsViewController ()<FJSlidingControllerDataSource>

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) RNNewsChildViewController *vc1;
@property (nonatomic, strong) RNNewsChildViewController *vc2;

@end

@implementation RNNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.segmentedControl];
    [self setupComponent];
    [self reloadData];
}

- (void)setupComponent{
    self.title = RNLocalized(@"News");
    
    self.datasouce = self;
    self.vc1 = [[RNNewsChildViewController alloc] init];
    self.vc1.index = 0;
    self.vc1.parentVC = self;
    
    self.vc2 = [[RNNewsChildViewController alloc] init];
    self.vc2.index = 1;
    self.vc2.parentVC = self;
    
    self.controllers = @[self.vc1, self.vc2];
    self.isDisableScroll = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_search"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick)];
}

- (void)rightBarButtonItemClick {
    [self.navigationController pushViewController:[[RNSearchNewsViewController alloc] init] animated:YES];
}

#pragma mark FJSlidingControllerDataSource
- (NSInteger)numberOfPageInFJSlidingController:(FJSlidingController *)fjSlidingController {
    return self.controllers.count;
}

- (UIViewController *)fjSlidingController:(FJSlidingController *)fjSlidingController controllerAtIndex:(NSInteger)index {
    return self.controllers[index];
}

- (HMSegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[RNLocalized(@"All"), RNLocalized(@"The Saved")]];
        _segmentedControl.frame = CGRectMake(0, 0, App_Frame_Width, kTopBarHeight);
        _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.backgroundColor = [UIColor clearColor];
        _segmentedControl.titleTextAttributes = @{
                                                  NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                                  NSForegroundColorAttributeName : UIColorFromRGB(0x22222),
                                                  };
        _segmentedControl.selectedTitleTextAttributes = @{
                                                          NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                                          NSForegroundColorAttributeName : [RNGlobalUIStandard defaultMainColor],
                                                          };
        _segmentedControl.selectionIndicatorColor = [RNGlobalUIStandard defaultMainColor];
        _segmentedControl.selectionIndicatorHeight = 2.0f;
        _segmentedControl.backgroundColor = UIColor.whiteColor;
        __weak typeof(self) weakself = self;
        _segmentedControl.indexChangeBlock = ^(NSInteger index) {
            [weakself selectedIndex:index];
        };
    }
    return _segmentedControl;
}
@end
