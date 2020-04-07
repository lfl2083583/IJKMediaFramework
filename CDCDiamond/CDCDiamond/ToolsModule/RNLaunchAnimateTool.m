//
//  RNLaunchAnimateTool.m
//  RapNet
//
//  Created by jt on 2020/2/18.
//  Copyright © 2020 lptechnology. All rights reserved.
//

#import "RNLaunchAnimateTool.h"

@interface RNLaunchAnimateTool ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) NSString * penQiangStr;
@end

@implementation RNLaunchAnimateTool

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

+ (void)animateWithWindow:(UIWindow *)window {
    RNLaunchAnimateTool *tool = [[RNLaunchAnimateTool alloc] init];
    [window.rootViewController.view addSubview:tool.contentView];
}


- (void)setupUI {
    self.contentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.contentView.backgroundColor = RGBOF(0x2AAE33);
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIImage *image = [UIImage imageNamed:@"launch_pic.png"];
    UIImageView *imgV = [[UIImageView alloc] initWithImage:image];
    _imgView = imgV;
    _imgView.alpha = 0.6;
    imgV.frame = CGRectMake((width-image.size.width)/2.0, APP_Frame_Height/2.0-image.size.height+40, image.size.width, image.size.height);
    [self.contentView addSubview:imgV];
    
    UILabel *label = [[UILabel alloc] init];
    
    label.font = [UIFont boldSystemFontOfSize:28];
    label.textColor = [UIColor whiteColor];
    label.text = @"CDC DIAMOND";
    label.textAlignment = NSTextAlignmentLeft;
    _contentLab = label;
    CGSize size = [Utility getTextString:label.text textFont:[UIFont boldSystemFontOfSize:28] frameWidth:App_Frame_Width attributedString:nil];
    label.frame = CGRectMake((App_Frame_Width-size.width-10)/2.0, CGRectGetMaxY(imgV.frame)+40, size.width+10, 40);
    [self.contentView addSubview:label];
    
    self.penQiangStr = @"CDC DIAMOND";
    NSThread * thread = [[NSThread alloc]initWithTarget:self selector:@selector(inputString:) object:nil];
    [thread start];
    [self imageViewAnimation];
}

- (void)inputString:(NSThread *)thread{
    
    for (NSInteger i = 0; i < self.penQiangStr.length; i++)
    {
        [self performSelectorOnMainThread:@selector(refreshUIWithContentStr:) withObject:[self.penQiangStr substringWithRange:NSMakeRange(0, i+1)] waitUntilDone:YES];
        [NSThread sleepForTimeInterval:0.08];
    }
    [thread cancel];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.imgView.layer removeAllAnimations];
        self.imgView.alpha = 1;
        [UIView animateWithDuration:0.5 animations:^{
//
//                   [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
////                   self.contentView.transform=CGAffineTransformMakeScale(2.f, 2.f);
//                   self.contentView.alpha = 0;

               } completion:^(BOOL finished) {

                   [self.contentView removeFromSuperview];

               }];
    });
}

- (void)refreshUIWithContentStr:(NSString *)contentStr
{
    self.contentLab.text = contentStr;
}

- (void)imageViewAnimation {
    
    //使用CABasicAnimation创建基础动画
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.fromValue = [NSNumber numberWithFloat:0.6];
    anima.toValue = [NSNumber numberWithFloat:1];
    anima.duration = 0.3f;
    anima.repeatCount = MAXFLOAT;
    [self.imgView.layer addAnimation:anima forKey:@"opacityAniamtion"];

}
@end
