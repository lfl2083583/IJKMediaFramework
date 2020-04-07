//
//  RNSearchJewelViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/4.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNSearchJewelViewController.h"
#import "HMSegmentedControl.h"
#import "RNNewSearchJewelViewController.h"
#import "RNOldSearchJewelViewController.h"

@interface RNSearchJewelViewController ()<FJSlidingControllerDataSource, UIAlertViewDelegate, RNOldSearchJewelViewControllerDelegate>

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) RNNewSearchJewelViewController *vc1;
@property (nonatomic, strong) RNOldSearchJewelViewController *vc2;

@end

@implementation RNSearchJewelViewController

- (instancetype)initIsFromSideMenue:(BOOL)isFromSideMenue seletedIndex:(int)seletedIndex {
    self = [self initIsFromSideMenue:isFromSideMenue];
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
    self.segmentedControl.selectedSegmentIndex = self.index;
    [self selectedIndex:self.index];
    // Do any additional setup after loading the view.
}

- (void)setupComponent{
    self.title = RNLocalized(@"Search");
    __weak typeof(self)weakself = self;
    self.datasouce = self;
    self.vc1 = [[RNNewSearchJewelViewController alloc] init];
    self.vc1.callBack = ^(RNSearchJewelModel * _Nonnull jewelModel) {
        weakself.jewelModel = jewelModel;
    };
    
    if (self.jewelModel && [self.jewelModel isKindOfClass:[RNSearchJewelModel class]]) {
        self.vc1.jewelModel = self.jewelModel;
    }
    
    self.vc2 = [[RNOldSearchJewelViewController alloc] init];
    self.vc2.delegate = self;
    
   
    self.controllers = @[self.vc1, self.vc2];
    self.isDisableScroll = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RNLocalized(@"Save") style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick)];
}


- (void)rightBarButtonItemClick {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:RNLocalized(@"Save Search") message:nil delegate:self cancelButtonTitle:RNLocalized(@"Cancel") otherButtonTitles:RNLocalized(@"Comfirm"), nil];
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    UITextField *passwordText = [alertView textFieldAtIndex:0];
    passwordText.placeholder = RNLocalized(@"Please enter the saved search name");
    passwordText.secureTextEntry = NO;
    [alertView show];
}

#pragma mark FJSlidingControllerDataSource
- (NSInteger)numberOfPageInFJSlidingController:(FJSlidingController *)fjSlidingController {
    return self.controllers.count;
}

- (UIViewController *)fjSlidingController:(FJSlidingController *)fjSlidingController controllerAtIndex:(NSInteger)index {
    return self.controllers[index];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *passwordText = [alertView textFieldAtIndex:0];
    if (buttonIndex == 1) {
        if (!passwordText.text.length) {
            [YZHubTool showText:RNLocalized(@"Please enter the saved search name")];
            return;
        }
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[self.jewelModel mj_keyValues]];
        parameters[@"searchname"] = passwordText.text;
        //NSLog(@"------%@", parameters);
        __weak typeof(self)weakself = self;
        [HttpRequestTool getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/AppSearch?method=saveSearch")  parameters:parameters success:^(id responseObject, ResponseState state) {
            [weakself performSelector:@selector(showTip) withObject:nil afterDelay:0.3];
        } failure:^(NSError *error) {
            
        }];
    }
}

- (void)showTip {
    dispatch_async(dispatch_get_main_queue(), ^{
        [YZHubTool showText:RNLocalized(@"Save success")];
    });
}

#pragma mark - RNOldSearchJewelViewControllerDelegate

- (void)onRNOldSearchJewelViewControllerSeletedRow:(id)source {
    self.vc1.jewelModel = source;
    [self.vc1 reloadData];
    [self selectedIndex:0];
    [self.segmentedControl setSelectedSegmentIndex:0];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RNLocalized(@"Save") style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemClick)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (HMSegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[RNLocalized(@"New search"), RNLocalized(@"Saved search")]];
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
            if (index == 0) {
                weakself.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RNLocalized(@"Save") style:UIBarButtonItemStyleDone target:weakself action:@selector(rightBarButtonItemClick)];
            } else {
                weakself.navigationItem.rightBarButtonItem = nil;
            }
        };
    }
    return _segmentedControl;
}


@end
