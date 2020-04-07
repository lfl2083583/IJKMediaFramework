//
//  RNLanguageViewController.h
//  RapNet
//
//  Created by liufulin on 2019/8/9.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNViewController.h"

typedef NS_ENUM(NSInteger, RNLanguageTableViewItem) {
    kRNLanguageTableViewItemNone = -1,
    kRNLanguageTableViewItemES = 0,
    kRNLanguageTableViewItemChs,
    kRNLanguageTableViewItemCht,
    kRNLanguageTableViewItemCount
};

NSString static *RNLanguageTableViewItemNames[] = {
    @"Ensglish",
    @"Chinese(Simplified)",
    @"Chinese(Traditional)",
};


NS_ASSUME_NONNULL_BEGIN

@interface RNLanguageViewController : RNViewController

@end

NS_ASSUME_NONNULL_END
