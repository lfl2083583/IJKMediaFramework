//
//  RNMyBuyRequestTableViewCell.m
//  RapNet
//
//  Created by jt on 2019/11/5.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNMyBuyRequestTableViewCell.h"

@interface RNMyBuyRequestTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *riqiLB;
@property (weak, nonatomic) IBOutlet UILabel *daoqiLB;

@property (weak, nonatomic) IBOutlet UILabel *LB1;
@property (weak, nonatomic) IBOutlet UILabel *LB2;


@end

@implementation RNMyBuyRequestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.LB1.text = RNLocalized(@"Date");
    self.LB2.text = RNLocalized(@"Due Date");
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(RNBuyRequestModel *)model {
    _model = model;
    self.riqiLB.text = [NSString stringWithFormat:@"%@",model.F_TIME];
    self.daoqiLB.text = [NSString stringWithFormat:@"%@",model.F_EXPIRE];
    self.priceLB.text = self.priceLB.text = [NSString stringWithFormat:@"%@-%@", KFormat(model.F_PRICETOTALMIN), KFormat(model.F_PRICETOTAL)];
    
    NSString *title = @"";
    if ([self isString:model.F_SHAPE]) {
        title = [title stringByAppendingString:model.F_SHAPE];
    }
    if (model.F_COLOR && KFormat(model.F_COLOR).length) {
        NSArray *colorArr = @[@"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
        NSArray *list = [model.F_COLOR componentsSeparatedByString:@","];
        NSMutableArray *muarr = [NSMutableArray array];
        for (NSString *string in list) {
            if (![KFormat(string) isEqualToString:@","] && ![KFormat(string) isEqualToString:@"，"] && [string intValue] > 0 && [string intValue] <= colorArr.count ) {
                [muarr addObject:colorArr[[string intValue]-1]];
            }
        }
        NSString *colorString = [muarr componentsJoinedByString:@","];
        
        if (title.length) {
            title = [title stringByAppendingString:[NSString stringWithFormat:@",%@", colorString]];
        } else {
            title = [title stringByAppendingString:[NSString stringWithFormat:@"%@", colorString]];
        }
    }
    if (model.F_CLARITY && KFormat(model.F_CLARITY).length) {
        NSArray *clartyArr = @[@"FL", @"IF", @"VVS1", @"VVS2", @"VS1", @"VS2", @"SI1", @"SI2", @"SI3", @"I1", @"I2", @"I3"];
        NSArray *list = [model.F_CLARITY componentsSeparatedByString:@","];
        NSMutableArray *muarr = [NSMutableArray array];
        for (NSString *string in list) {
            if (![KFormat(string) isEqualToString:@","] && ![KFormat(string) isEqualToString:@"，"] && [string intValue] > 0 && [string intValue] <= clartyArr.count) {
                [muarr addObject:clartyArr[[string intValue]-1]];
            }
        }
        NSString *clartyString = [muarr componentsJoinedByString:@","];
        
        if (title.length) {
            title = [title stringByAppendingString:[NSString stringWithFormat:@",%@", clartyString]];
        } else {
            title = [title stringByAppendingString:[NSString stringWithFormat:@"%@", clartyString]];
        }
    }
    self.titleLB.text = title;
}

- (BOOL)isString:(NSString *)string {
    if (string && [string isKindOfClass:[NSString class]] && string.length) {
        return YES;
    } else {
        return NO;
    }
}
@end
