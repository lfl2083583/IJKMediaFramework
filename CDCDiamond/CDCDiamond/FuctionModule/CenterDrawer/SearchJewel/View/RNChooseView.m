//
//  RNChooseView.m
//  RapNet
//
//  Created by liufulin on 2019/10/7.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNChooseView.h"
@interface RNChooseView ()

@property (nonatomic, strong) NSMutableArray *seletedArray;

@end

@implementation RNChooseView

- (instancetype)initWithChooses:(NSArray *)chooses rect:(CGRect)rect singleChoose:(BOOL)singleChoose {
    self = [self initWithChooses:chooses rect:rect];
    if (self) {
        _singleChoose = singleChoose;
    }
    return self;
}

- (instancetype)initWithChooses:(NSArray *)chooses rect:(CGRect)rect {
    self = [self initWithFrame:rect];
    if (self) {
        self.chooses = chooses;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupScrollView];
    }
    return self;
}

- (void)setupScrollView {
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _scrollerView.backgroundColor = UIColorFromRGB(0xf6f6f6);
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.layer.borderWidth = 1;
    _scrollerView.layer.borderColor = UIColorFromRGB(0xf6f6f6).CGColor;
    [self addGestureRecognizer:_scrollerView.panGestureRecognizer];
    [self addSubview:_scrollerView];
}

- (void)setChooses:(NSArray *)chooses {
    _chooses = chooses;
    CGFloat sumWidth = 0;
    for (UIView *subView in self.scrollerView.subviews) {
        [subView removeFromSuperview];
    }
    for (int i = 0; i < chooses.count; i++) {
        NSString *title = chooses[i];
        CGSize size = [Utility getTextString:title textFont:[UIFont yz_PingFangSC_RegularFontOfSize:14] frameWidth:App_Frame_Width attributedString:nil];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(sumWidth, 0, size.width + 40, self.height)];
        button.userInteractionEnabled = YES;
        [button setBackgroundImage:[UIImage graphicsImageWithColor:UIColor.whiteColor rect:CGRectMake(0, 0, self.width, self.height)] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont yz_PingFangSC_RegularFontOfSize:14]];
        [button setBackgroundImage:[UIImage graphicsImageWithColor:UIColorFromRGB(0xbbbbbb) rect:CGRectMake(0, 0, self.width, self.height)] forState:UIControlStateSelected];
        [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[chooses objectAtIndex:i] forState:UIControlStateNormal];
        [button setAdjustsImageWhenHighlighted:NO];
        [button setTag:101+i];
        [_scrollerView addSubview:button];
        
        sumWidth += size.width+41;
    }
    
    if (sumWidth < self.width) {
        _scrollerView.contentSize = CGSizeMake(self.width, 0);
        
        CGFloat width = (self.width - chooses.count - 1) / (chooses.count * 1.0);
    
        for (int i = 0; i < chooses.count; i++) {
            UIButton *button = [self viewWithTag:101+i];
            [button setFrame:CGRectMake((width+1)*i, 0, width, self.height)];
        }
        
    } else {
         _scrollerView.contentSize = CGSizeMake(sumWidth, 0);
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupScrollView];
}

- (void)buttonClick:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    if (self.singleChoose) {
        for (int i = 0; i < self.chooses.count; i++) {
            UIButton *button = [_scrollerView viewWithTag:101+i];
            if (![button isEqual:sender]) {
                [button setSelected:NO];
            }
        }
        [self.seletedArray removeAllObjects];
        if (sender.selected == YES) {
            [self.seletedArray addObject:@(sender.tag-100)];
        }
    } else {
        if (sender.isSelected) {
            if (![self.seletedArray containsObject:[self.chooses objectAtIndex:sender.tag-101]]) {
                [self.seletedArray addObject:[self.chooses objectAtIndex:sender.tag-101]];
            }
        } else {
            
            if ([self.seletedArray containsObject:[self.chooses objectAtIndex:sender.tag-101]]) {
                [self.seletedArray removeObject:[self.chooses objectAtIndex:sender.tag-101]];
            }
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onChooseViewDidSeletedOptions:chooseView:)]) {
        [self.delegate onChooseViewDidSeletedOptions:self.seletedArray chooseView:self];
    }
}


- (void)setDefaultChooses:(NSArray *)defaultChooses {
    _defaultChooses = defaultChooses;
    [self.seletedArray removeAllObjects];
    for (UIButton *btn in _scrollerView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn setSelected:NO];
        }
    }
    if (defaultChooses && [defaultChooses isKindOfClass:[NSArray class]] && defaultChooses.count) {
        
        NSString *name = [defaultChooses firstObject];
        if ([name isKindOfClass:[NSString class]]) {
            [self.seletedArray addObjectsFromArray:defaultChooses];
        }
        
        for (int i = 0; i < self.chooses.count; i++) {
            UIButton *btn = [_scrollerView viewWithTag:101+i];
            NSString *title = [self.chooses objectAtIndex:i];
            if (btn && [btn isKindOfClass:[UIButton class]] && [self.seletedArray containsObject:title]) {
                [btn setSelected:YES];
            }
        }
    }
}

- (NSMutableArray *)seletedArray {
    if (!_seletedArray) {
        _seletedArray = [NSMutableArray array];
    }
    return _seletedArray;
}


@end
