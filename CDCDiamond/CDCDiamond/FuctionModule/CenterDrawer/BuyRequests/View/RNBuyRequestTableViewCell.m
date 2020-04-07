//
//  RNBuyRequestTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/17.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNBuyRequestTableViewCell.h"

@interface RNBuyRequestTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *qiegeTitle;
@property (weak, nonatomic) IBOutlet UILabel *qiegeLB;
@property (weak, nonatomic) IBOutlet UILabel *buyerTitle;
@property (weak, nonatomic) IBOutlet UILabel *buyerLB;
@property (weak, nonatomic) IBOutlet UILabel *paoguangTitle;
@property (weak, nonatomic) IBOutlet UILabel *paoguangLB;
@property (weak, nonatomic) IBOutlet UILabel *riqiTitle;
@property (weak, nonatomic) IBOutlet UILabel *riqiLB;
@property (weak, nonatomic) IBOutlet UILabel *duichengTitle;
@property (weak, nonatomic) IBOutlet UILabel *duichengLB;
@property (weak, nonatomic) IBOutlet UILabel *daoqiTitle;
@property (weak, nonatomic) IBOutlet UILabel *daoqiLB;

@end

@implementation RNBuyRequestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.qiegeTitle.text = RNLocalized(@"Cut");
    self.buyerTitle.text = RNLocalized(@"Seller");
    self.paoguangTitle.text = RNLocalized(@"Polishing");
    self.riqiTitle.text = RNLocalized(@"Date");
    self.duichengTitle.text = RNLocalized(@"Symmetry");
    self.daoqiTitle.text = RNLocalized(@"Due Date");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(RNBuyRequestModel *)model {
    _model = model;
    
    self.qiegeLB.text = [NSString stringWithFormat:@"%@", [Utility fomateString:model.F_CUT]];
    self.buyerLB.text = [NSString stringWithFormat:@"%@",[Utility fomateString:model.F_NAME]];
    self.paoguangLB.text = [NSString stringWithFormat:@"%@",[Utility fomateString:model.F_POLISHED]];
    NSString *dateString = [Utility fomateString:model.CREATETIME].length>10?[[Utility fomateString:model.CREATETIME] substringToIndex:10]:[Utility fomateString:model.CREATETIME];
    self.riqiLB.text = [NSString stringWithFormat:@"%@",dateString];
    self.duichengLB.text = [NSString stringWithFormat:@"%@",[Utility fomateString:model.F_SYMMETRICAL]];
    NSString *dueString = [Utility fomateString:model.UPDATETIME].length>10?[[Utility fomateString:model.UPDATETIME] substringToIndex:10]:[Utility fomateString:model.UPDATETIME];
    self.daoqiLB.text = [NSString stringWithFormat:@"%@",dueString];
    self.priceLB.text = [NSString stringWithFormat:@"%@-%@", KFormat(model.F_PRICETOTALMIN), KFormat(model.F_PRICETOTAL)];
    
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
