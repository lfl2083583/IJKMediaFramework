//
//  RNJiaGeTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNJiaGeTableViewCell.h"
#import "ZTTextField.h"

@interface RNJiaGeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet ZTTextField *leftTF;
@property (weak, nonatomic) IBOutlet ZTTextField *rightTF;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;


@end

@implementation RNJiaGeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLB.text = RNLocalized(@"Prices");
    [self.leftTF setPlaceholder:RNLocalized(@"Any")];
    [self.rightTF setPlaceholder:RNLocalized(@"Any")];
    
    [self.btn1 setTitle:RNLocalized(@"Price $/Ct") forState:UIControlStateNormal];
    
    [self.btn2 setTitle:[NSString stringWithFormat:@"%@", RNLocalized(@"Total Price")] forState:UIControlStateNormal];
    
    [self.btn1 setBackgroundImage:[UIImage graphicsImageWithColor:UIColor.whiteColor rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateNormal];
    [self.btn1 setBackgroundImage:[UIImage graphicsImageWithColor:[RNGlobalUIStandard defaultMainColor] rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateSelected];
    [self.btn1 setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.btn1 setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    
    [self.btn2 setBackgroundImage:[UIImage graphicsImageWithColor:UIColor.whiteColor rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateNormal];
    [self.btn2 setBackgroundImage:[UIImage graphicsImageWithColor:[RNGlobalUIStandard defaultMainColor] rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateSelected];
    [self.btn2 setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    
    
//    [self.btn3 setBackgroundImage:[UIImage graphicsImageWithColor:UIColor.whiteColor rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateNormal];
//    [self.btn3 setBackgroundImage:[UIImage graphicsImageWithColor:[RNGlobalUIStandard defaultMainColor] rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateSelected];
//    [self.btn3 setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
//    [self.btn3 setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    
    self.btn1.selected = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setJewelModel:(RNSearchJewelModel *)jewelModel {
    _jewelModel = jewelModel;
    
    if ([Utility isString:jewelModel.pricemin]) {
        self.leftTF.text = jewelModel.pricemin;
    } else {
        self.leftTF.text = @"";
    }
    if ([Utility isString:jewelModel.pricemax]) {
        self.rightTF.text = jewelModel.pricemax;
    } else {
        self.rightTF.text = @"";
    }
    
    if ([Utility isString:jewelModel.pricetype]) {
        NSString *type = [NSString stringWithFormat:@"%@", jewelModel.pricetype];
        if ([type isEqualToString:@"%/Ct"]) {
            self.btn1.selected = YES;
            self.btn2.selected = NO;
    
        } else if ([type isEqualToString:[NSString stringWithFormat:@"$%@", RNLocalized(@"Total Price")]]) {
            self.btn1.selected = NO;
            self.btn2.selected = YES;
        } else {
            self.btn1.selected = NO;
            self.btn2.selected = NO;
        }
    } else {
        self.btn1.selected = NO;
        self.btn2.selected = NO;
    }
}

- (void)setAddModel:(RNBuyRequestAddModel *)addModel {
    _addModel = addModel;
    [self.btn1 setTitle:RNLocalized(@"$/Ct") forState:UIControlStateNormal];
    if ([Utility isString:addModel.F_PRICETOTALMIN]) {
        self.leftTF.text = addModel.F_PRICETOTALMIN;
    } else {
        self.leftTF.text = @"";
    }
    if ([Utility isString:addModel.F_PRICETOTAL]) {
        self.rightTF.text = KFormat(addModel.F_PRICETOTAL);
    } else {
        self.rightTF.text = @"";
    }
    
    if ([Utility isString:addModel.F_PRICE]) {
        NSString *type = [NSString stringWithFormat:@"%@", addModel.F_PRICE];
        if ([type isEqualToString:@"%/Ct"]) {
            self.btn1.selected = YES;
            self.btn2.selected = NO;
    
        } else if ([type isEqualToString:[NSString stringWithFormat:@"$%@", RNLocalized(@"Total Price")]]) {
            self.btn1.selected = NO;
            self.btn2.selected = YES;
        } else {
            self.btn1.selected = NO;
            self.btn2.selected = NO;
        }
    } else {
        self.btn1.selected = NO;
        self.btn2.selected = NO;
    }
}

- (IBAction)priceTypeClick:(UIButton *)sender {
    self.btn1.selected = NO;
    self.btn2.selected = NO;
    sender.selected = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onjiaGeTableViewCellDidChooseJiage:)]) {
        [self.delegate onjiaGeTableViewCellDidChooseJiage:[sender isEqual:self.btn1]?@"1":@"3"];
    }
}

- (IBAction)leftTFChanged:(ZTTextField *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onjiaGeTableViewCellDidChooseJiageMinprice:)]) {
        [self.delegate onjiaGeTableViewCellDidChooseJiageMinprice:sender.text];
    }
}

- (IBAction)rightTFChanged:(ZTTextField *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onjiaGeTableViewCellDidChooseJiageMaxprice:)]) {
        [self.delegate onjiaGeTableViewCellDidChooseJiageMaxprice:sender.text];
    }
}

@end
