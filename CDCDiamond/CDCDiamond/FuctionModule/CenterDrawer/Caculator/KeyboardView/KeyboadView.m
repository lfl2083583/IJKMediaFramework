//
//  KeyboadView.m
//  RapNet
//
//  Created by liufulin on 2019/10/28.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "KeyboadView.h"

@interface KeyboadView ()


@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;



@end

@implementation KeyboadView


- (IBAction)backClick:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        [self.scrollerView setContentOffset:CGPointMake(0, 0)];
    }];
}


- (IBAction)bestClick:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        [self.scrollerView setContentOffset:CGPointMake(App_Frame_Width, 0)];
    }];
}

- (IBAction)keyClick:(UIButton *)sender {
    if (self.inputString && [self.inputString containsString:@"."] && sender.tag == 20) {
        return;
    }
    if (!self.inputString && sender.tag != 20) {
        self.inputString = [NSString stringWithFormat:@"%ld", sender.tag-10];
        if (self.delegate && [self.delegate respondsToSelector:@selector(onkeyboardTextInput:)]) {
            [self.delegate onkeyboardTextInput:self.inputString];
        }
        return;
    }
    if (!self.inputString && sender.tag == 20) {
        return;
    }
    if (self.inputString && sender.tag == 20) {
        self.inputString = [self.inputString stringByAppendingString:@"."];
        if (self.delegate && [self.delegate respondsToSelector:@selector(onkeyboardTextInput:)]) {
            [self.delegate onkeyboardTextInput:self.inputString];
        }
        return;
    }
    if (self.inputString) {
        if ([self.inputString containsString:@"."]) {
            NSArray *array = [self.inputString componentsSeparatedByString:@"."];
            if (array.count == 2) {
                NSString *str = [array lastObject];
                if (str.length == 2) {
                    return;
                }
            }
        }
        
        self.inputString = [self.inputString stringByAppendingString:[NSString stringWithFormat:@"%ld", sender.tag-10]];
        if (self.delegate && [self.delegate respondsToSelector:@selector(onkeyboardTextInput:)]) {
            [self.delegate onkeyboardTextInput:self.inputString];
        }
    }
    
}

- (IBAction)backplaceClick:(UIButton *)sender {
    if (self.inputString && self.inputString.length) {
        self.inputString = [self.inputString substringToIndex:self.inputString.length-1];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(onkeyboardTextInput:)]) {
        [self.delegate onkeyboardTextInput:self.inputString];
    }
}

- (IBAction)resetClick:(UIButton *)sender {
    self.inputString = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onkeyboardRestTextInput:)]) {
        [self.delegate onkeyboardRestTextInput:self.inputString];
    }
}

- (IBAction)compareClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onkeyboardCompareTextInput:)]) {
        [self.delegate onkeyboardCompareTextInput:self.inputString];
    }
}

- (IBAction)saveClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onkeyboardSaveTextInput:)]) {
        [self.delegate onkeyboardSaveTextInput:self.inputString];
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
