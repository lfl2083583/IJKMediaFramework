//
//  RNAddRequestStackView.h
//  RapNet
//
//  Created by Frank on 2020/3/16.
//  Copyright © 2020 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNAddRequestStackView : UIView

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subtitleLab;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle;


@end

NS_ASSUME_NONNULL_END
