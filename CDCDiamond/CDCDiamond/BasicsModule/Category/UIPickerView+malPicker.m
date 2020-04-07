//
//  UIPickerView+malPicker.m
//  RapNet
//
//  Created by jt on 2019/11/3.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "UIPickerView+malPicker.h"



@implementation UIPickerView (malPicker)

- (void)clearSpearatorLine
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.frame.size.height < 1)
        {
            [obj setBackgroundColor:[UIColor clearColor]];
        }
    }];
}

@end
