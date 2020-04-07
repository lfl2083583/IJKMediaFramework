//
//  RNNewsDetailTableViewCell.h
//  RapNet
//
//  Created by liufulin on 2019/10/20.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const newsDetailIndenfier = @"RNNewsDetailViewController";

@interface RNNewsDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

NS_ASSUME_NONNULL_END
