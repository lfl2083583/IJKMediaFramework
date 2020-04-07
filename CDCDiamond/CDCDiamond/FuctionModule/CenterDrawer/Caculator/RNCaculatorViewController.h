//
//  RNCaculatorViewController.h
//  RapNet
//
//  Created by liufulin on 2019/10/18.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNViewController.h"

NS_ASSUME_NONNULL_BEGIN
/****shape
true string 无
形状（ROUND）
color
true string 无
颜色（1）
clarity
true string 无
净度（10）
size
true string 无
大小（1.0）*/
@interface RNCaculatorViewController : RNViewController

@property (nonatomic, copy) NSString *shape;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *clarity;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *percent;
@property (nonatomic, copy) NSString *pc;

@end

NS_ASSUME_NONNULL_END
