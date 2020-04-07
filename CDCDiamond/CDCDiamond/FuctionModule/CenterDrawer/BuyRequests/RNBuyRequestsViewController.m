//
//  RNBuyRequestsViewController.m
//  RapNet
//
//  Created by tjl on 2019/10/11.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNBuyRequestsViewController.h"
#import "RNMyRequestViewController.h"
#import "RNBuyRequestAddViewController.h"
#import "HMSegmentedControl.h"

@interface RNBuyRequestsViewController ()<FJSlidingControllerDataSource>

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) RNMyRequestViewController *vc1;
@property (nonatomic, strong) RNMyRequestViewController *vc2;

@end

@implementation RNBuyRequestsViewController

- (instancetype)initIsFromSideMenue:(BOOL)isFromSideMenue seletedIndex:(int)seletedIndex {
    
    self = [super initIsFromSideMenue:isFromSideMenue];
    if (self) {
        _index = seletedIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.segmentedControl];
    [self setupComponent];
    [self reloadData];
    [self selectedIndex:self.index];
    [self.segmentedControl setSelectedSegmentIndex:self.index];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setupComponent{
    self.title = RNLocalized(@"Buy Requests");
    
    self.datasouce = self;
    self.vc1 = [[RNMyRequestViewController alloc] init];
    self.vc1.type = 0;
    
    self.vc2 = [[RNMyRequestViewController alloc] init];
    self.vc2.type = 1;
    
    self.controllers = @[self.vc1, self.vc2];
    self.isDisableScroll = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RNLocalized(@"Add") style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick)];
}


- (void)rightBarButtonItemClick {
    RNBuyRequestAddViewController *vc = [[RNBuyRequestAddViewController alloc] init];
    vc.title = RNLocalized(@"Add Request");
    [self.navigationController pushViewController:vc animated:YES];
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
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[RNLocalized(@"All Request"), RNLocalized(@"My Request")]];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
