//
//  RNCustomSearchView.m
//  RapNet
//
//  Created by tjl on 2020/1/19.
//  Copyright © 2020 lptechnology. All rights reserved.
//
#import "RNCustomSearchView.h"

@implementation RNCustomTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    return CGRectMake(4, 4, 30, 20);
}

@end

@implementation RNCustomSearchView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.tfKeyword = [[RNCustomTextField alloc] initWithFrame:CGRectMake(15, (self.height-27)/2.0, App_Frame_Width-15-70, 27)];
        self.tfKeyword.textColor = RGBOF(0X1a1a1a);
        self.tfKeyword.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        self.tfKeyword.backgroundColor = RGB(245, 245, 245);
        self.tfKeyword.layer.cornerRadius = 5.0;
        self.tfKeyword.returnKeyType = UIReturnKeySearch;
        self.tfKeyword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:RNLocalized(@"Search")
                                                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:RGB(153, 153, 153)}];
        self.tfKeyword.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon_light"]];
        self.searchIcon.contentMode = UIViewContentModeCenter;
        self.tfKeyword.leftView = self.searchIcon;
        self.tfKeyword.leftViewMode = UITextFieldViewModeAlways;
        self.tfKeyword.delegate = self;
        [self addSubview:self.tfKeyword];
        
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(App_Frame_Width-55, (self.height-40)/2.0, 40, 40)];
        [self.cancelButton setTitle:RNLocalized(@"Cancel") forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:MainColor forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:MainColor forState:UIControlStateHighlighted];
        self.cancelButton.titleLabel.font = [UIFont yz_PingFangSC_RegularFontOfSize:AUTO_WIDTH(16)];
        [self.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cancelButton];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-0.5, App_Frame_Width, 0.5)];
        self.lineView.backgroundColor = RGB(240, 240, 240);
        [self addSubview:self.lineView];
    }
    return self;
}

#pragma mark - actions
- (void)cancelAction:(id)obj {
    [self.tfKeyword endEditing:YES];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    if (textField.text.length == 0) {
        return NO;
    } else if (self.tfKeyword.text > 0) {
        if (self.searchBlock) {
            self.searchBlock(textField.text);
        }
    }
    return YES;
}


//- (CGSize)intrinsicContentSize {
//    return UILayoutFittingExpandedSize;
//}

@end
