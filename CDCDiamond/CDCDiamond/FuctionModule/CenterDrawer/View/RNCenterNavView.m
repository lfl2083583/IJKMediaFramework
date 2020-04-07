//
//  RNCenterNavView.m
//  RapNet
//
//  Created by jt on 2019/11/25.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNCenterNavView.h"

@implementation RNCenterNavView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        UIButton *leftBtn = [UIButton yz_buttonWithImageStr:@"icon_menus"];
        [leftBtn setFrame:CGRectMake(5, kStatusBarHeight, 44, kTopBarHeight)];
        [leftBtn addTarget:self action:@selector(leftBtnclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        
        UIButton *rightBtn = [UIButton yz_buttonWithImageStr:@"icon_setting"];
        [rightBtn setFrame:CGRectMake(self.frame.size.width - 44 - 5, kStatusBarHeight, 44, kTopBarHeight)];
        [rightBtn addTarget:self action:@selector(rightBtnclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_logo"]];
        imgV.contentMode =  UIViewContentModeScaleAspectFit;
        [imgV setFrame:CGRectMake(100, kStatusBarHeight, self.frame.size.width-200, kTopBarHeight)];
        [self addSubview:imgV];
    }
    return self;
}

- (void)leftBtnclick {
    
    if (self.delegate && self.delegate && [self.delegate respondsToSelector:@selector(onLeftMenueClick)]) {
        [self.delegate onLeftMenueClick];
    }
}

- (void)rightBtnclick {
    if (self.delegate && self.delegate && [self.delegate respondsToSelector:@selector(onRightMenueClick)]) {
        [self.delegate onRightMenueClick];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
