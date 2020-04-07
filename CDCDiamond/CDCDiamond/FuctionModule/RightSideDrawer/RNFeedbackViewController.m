//
//  RNFeedbackViewController.m
//  RapNet
//
//  Created by jt on 2019/11/11.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNFeedbackViewController.h"
#import "GCPlaceholderTextView.h"

@interface RNFeedbackViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) GCPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation RNFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Send Feedback");
    self.view.backgroundColor = RGBOF(0xf1f1f1);
    self.textView = [[GCPlaceholderTextView alloc] initWithFrame:self.contentView.bounds];
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.placeholder = RNLocalized(@"Please enter feedback");
    [self.contentView addSubview:self.textView];
    self.titleTF.placeholder = RNLocalized(@"Please enter the feedback title");
    self.titleLB.text = RNLocalized(@"The Title");
    self.contentLB.text = RNLocalized(@"Content");
    [self.submitBtn setTitle:RNLocalized(@"Submit") forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)feedbackClick:(UIButton *)sender {
    
    if (!self.titleTF.text.length) {
        [YZHubTool showText:RNLocalized(@"Please enter the feedback title")]; return;
    }
    if (!self.textView.text.length) {
        [YZHubTool showText:RNLocalized(@"Please enter feedback")]; return;
    }
    __weak typeof(self)weakself = self;
    [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/FeedbackServlet?method=feedbackAdd") parameters:@{@"F_FEEDBACKTITLE" : self.titleTF.text, @"F_FEEDBACK" :self.textView.text} success:^(id responseObject, ResponseState state) {
        [YZHubTool showSuccessText:RNLocalized(@"Feedback successful!")];
        [weakself.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
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
