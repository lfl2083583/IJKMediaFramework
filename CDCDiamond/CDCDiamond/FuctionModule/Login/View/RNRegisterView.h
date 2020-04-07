//
//  RNRegisterView.h
//  CDCDiamond
//
//  Created by Frank on 2020/3/27.
//  Copyright © 2020 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNRegisterModel.h"

typedef void(^CoverClickBlock)(int index);

NS_ASSUME_NONNULL_BEGIN

@interface RNRegisterView : UIView

@property (nonatomic, strong) UIButton *nameCardBtn;
@property (nonatomic, strong) UIButton *idCardBtn;
@property (nonatomic, strong) UIButton *certificateBtn;

@property (nonatomic, strong) RNRegisterModel *registerModel;
@property (nonatomic, copy) CoverClickBlock coverBlock;


@end

NS_ASSUME_NONNULL_END
