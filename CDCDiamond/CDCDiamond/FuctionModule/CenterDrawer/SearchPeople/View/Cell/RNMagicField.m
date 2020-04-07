//
//  RNMagicField.m
//  RNMagicFieldDemo
//
//  Created by bihongbo on 15/12/29.
//  Copyright © 2015年 bihongbo. All rights reserved.
//

#import "RNMagicField.h"

@interface RNMagicField ()

@property (nonatomic,copy) NSString * placeholderText;
@property (nonatomic,strong) UIFont * placeholderFont;
@property (nonatomic,strong) UIColor * placeholderColor;
@property (nonatomic,strong) UILabel * placeholderAnimationLbl;
@property (nonatomic,strong) NSAttributedString * placeHolderAttributedString;

@end

@implementation RNMagicField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tintColor = [RNGlobalUIStandard defaultMainColor];
        _placeholdAnimationable = YES;
        self.placeholderAnimationLbl = [[UILabel alloc] initWithFrame:self.bounds];
        self.placeholderAnimationLbl.userInteractionEnabled = NO;
        self.placeholderAnimationLbl.font = self.font;
        self.placeholderFont = self.font;
        self.placeholderAnimationLbl.textColor = [UIColor lightGrayColor];
        self.placeholderColor = self.placeholderAnimationLbl.textColor;
        self.animationColor = self.placeholderColor;
        self.animationFont = self.placeholderFont;
        self.placeholderAnimationLbl.textAlignment = NSTextAlignmentLeft;
        self.moveDistance = frame.size.height / 2;
        self.clipsToBounds = NO;
        [self addSubview:self.placeholderAnimationLbl];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEditing) name:UITextFieldTextDidChangeNotification object:nil];
        
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setText:(NSString *)text{
    [super setText:text];
    if (text.length > 0) {
        [self upAnimation];
    }else{
        [self restoreAnimation];
    }
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.placeholderAnimationLbl.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    if (self.moveDistance == 0) {
        self.moveDistance = frame.size.height / 2;
    }
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderFont = font;
    self.placeholderAnimationLbl.font = self.font;
    
}


/**
 *  文字提醒set方法
 *
 */
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholderText = placeholder;
    self.placeholderAnimationLbl.text = placeholder;
    if ([placeholder containsString:@"*"]) {
        [Utility richTextLabel:self.placeholderAnimationLbl fontNumber:[UIFont systemFontOfSize:12.f] andRange:[placeholder rangeOfString:@"*"] andColor:RGBOF(0xE55156)];
    }
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder{
    _placeHolderAttributedString = attributedPlaceholder;
    self.placeholderAnimationLbl.attributedText = attributedPlaceholder;
}


- (BOOL)becomeFirstResponder{
    [self upAnimation];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    [self restoreAnimation];
    return [super resignFirstResponder];
}

-(void)changeEditing
{
    if (!self.placeholdAnimationable) {
        if ([self.text isEqualToString:@""]) {
            self.placeholderAnimationLbl.hidden = NO;
        }
        else
        {
            self.placeholderAnimationLbl.hidden = YES;
        }
    }else{
        self.placeholderAnimationLbl.hidden = NO;
    }
    
}

- (void)upAnimation{
    if (self.placeholdAnimationable) {
        CGRect targetFrame = self.placeholderAnimationLbl.frame;
        targetFrame.origin.y = - self.moveDistance;
        [UIView animateWithDuration:.25 animations:^{
            self.placeholderAnimationLbl.frame = targetFrame;
            self.placeholderAnimationLbl.textColor = self.animationColor;
            self.placeholderAnimationLbl.font = self.animationFont;
        }];
    }
    
    if ([self.placeholderText containsString:@"*"]) {
        [Utility richTextLabel:self.placeholderAnimationLbl fontNumber:[UIFont systemFontOfSize:10.f] andRange:[self.placeholderText rangeOfString:@"*"] andColor:RGBOF(0xE55156)];
    }
}

- (void)restoreAnimation{
    if (self.placeholdAnimationable) {
        if (self.text.length > 0 || self.placeholderAnimationLbl.frame.origin.y == 0) {
            return ;
        }
        CGRect targetFrame = self.placeholderAnimationLbl.frame;
        targetFrame.origin.y = 0;
        [UIView animateWithDuration:.25 animations:^{
            self.placeholderAnimationLbl.frame = targetFrame;
            self.placeholderAnimationLbl.textColor = self.placeholderColor;
            self.placeholderAnimationLbl.font = self.placeholderFont;
            if (self.placeHolderAttributedString) {
                self.placeholderAnimationLbl.attributedText = self.placeHolderAttributedString;
            }
        }];
    }
    if ([self.placeholderText containsString:@"*"]) {
        [Utility richTextLabel:self.placeholderAnimationLbl fontNumber:[UIFont systemFontOfSize:12.f] andRange:[self.placeholderText rangeOfString:@"*"] andColor:RGBOF(0xE55156)];
    }

}

@end
