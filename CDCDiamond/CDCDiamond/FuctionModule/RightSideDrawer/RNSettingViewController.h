//
//  RNRightSideViewController.h
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNViewController.h"

typedef NS_ENUM(NSInteger, RNSettingsTableViewItem) {
    kRNSettingsTableViewItemNone = -1,
//    kRNSettingsTableViewItemPrice = 0,
    kRNSettingsTableViewItemNotification,
    kRNSettingsTableViewItemLanguage,
    kRNSettingsTableViewItemZoom,
    kRNSettingsTableViewItemFeedback,
    kRNSettingsTableViewItemsCount
    
};

NSString static *RNSettingsTableViewItemNames[] = {
//    @"Price Settings",
    @"Notifications",
    @"Languages",
    @"Regional Offices",
    @"Send Feedback",
};


typedef NS_ENUM(NSInteger, RNSettingsTableViewOtherItem) {
    kRNSettingsTableViewOtherItemNone = -1,
    kRNSettingsTableViewItemVersions,
    kRNSettingsTaPbleViewItemProtocol,
    kRNSettingsTableViewItemCriterion,
    kRNSettingsTableViewItemPrivacy,
    kRNSettingsTableViewOtherItemsCount
};

NSString static *RNSettingsTableViewotherItemNames[] = {
    @"Version",
    @"Liense Agreement",
    @"Code of Conduct",
    @"Privacy Policy"
};


NS_ASSUME_NONNULL_BEGIN

@interface RNSettingViewController : RNViewController

@end

NS_ASSUME_NONNULL_END
