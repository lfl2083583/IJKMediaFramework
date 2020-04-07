//
//  RNAddRequestStackView.m
//  RapNet
//
//  Created by Frank on 2020/3/16.
//  Copyright © 2020 lptechnology. All rights reserved.
//

#import "RNAddRequestStackView.h"

@implementation RNAddRequestStackView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, App_Frame_Width/2.0, frame.size.height)];
        self.titleLab.textColor = RGBOF(0x222222);
        self.titleLab.font = [UIFont systemFontOfSize:14];
        self.titleLab.text = title;
        [self addSubview:self.titleLab];
        
        self.subtitleLab = [[UILabel alloc] initWithFrame:CGRectMake(App_Frame_Width/2.0+12, 0, frame.size.width-App_Frame_Width/2.0-12, frame.size.height)];
        self.subtitleLab.textColor = RGBOF(0x999999);
        self.subtitleLab.font = [UIFont systemFontOfSize:14];
        self.subtitleLab.text = subTitle;
        [self addSubview:self.subtitleLab];
        
//        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.mas_left).offset(12);
//            make.top.bottom.mas_offset(self);
//            make.width.mas_equalTo(App_Frame_Width/2.0);
//        }];
//
//        [self.subtitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.titleLab.mas_left);
//            make.top.bottom.mas_offset(self);
//            make.right.equalTo(self.mas_right).offset(-12);
//        }];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        line.backgroundColor = RGBOF(0xe6e6e6);
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.left.right.bottom.mas_equalTo(self);
        }];
        
    }
    return self;
}



@end
