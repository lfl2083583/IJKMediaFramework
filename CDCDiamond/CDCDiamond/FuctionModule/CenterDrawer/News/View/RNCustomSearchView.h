//
//  RNCustomSearchView.h
//  RapNet
//
//  Created by tjl on 2020/1/19.
//  Copyright © 2020 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
typedef void(^CancelBlock)();
typedef void(^SearchBlock)(NSString *str);

@interface RNCustomTextField : UITextField
@end

@interface RNCustomSearchView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) RNCustomTextField *tfKeyword;
@property (nonatomic, strong) UIImageView *searchIcon;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, copy) CancelBlock cancelBlock;
@property (nonatomic, copy) SearchBlock searchBlock;

@end
