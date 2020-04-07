//
//  RNOnlyXianShiTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNOnlyXianShiTableViewCell.h"
#import "ZTTextField.h"

@interface RNOnlyXianShiTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet ZTTextField *laboratoryTF;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *supplierLB;
@property (weak, nonatomic) IBOutlet UILabel *matchLB;
@property (weak, nonatomic) IBOutlet UILabel *laboratoryLB;
@end

@implementation RNOnlyXianShiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.titleLB setText:RNLocalized(@"Show Only")];
    [self.supplierLB setText:RNLocalized(@"Major Suppliers")];
    [self.matchLB setText:RNLocalized(@"Matching")];
    [self.laboratoryLB setText:RNLocalized(@"Laboratory Report Number")];
    [self.laboratoryTF setPlaceholder:RNLocalized(@"Please enter the lab report number")];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btn1Click:(id)sender {
    
    
    [self.btn1 setSelected:!self.btn1.selected];
    self.jewelModel.isppd = (self.btn1.isSelected == YES)?@"true":@"false";
    if (self.delegate && [self.delegate respondsToSelector:@selector(onOnlyXianShiTableViewCellDidChooseSuppier:)]) {
        [self.delegate onOnlyXianShiTableViewCellDidChooseSuppier:self.jewelModel];
    }
}

- (IBAction)btn2Click:(id)sender {
    [self.btn2 setSelected:!self.btn2.selected];
    self.jewelModel.ishighmember = (self.btn2.isSelected == YES)?@"true":@"false";
    if (self.delegate && [self.delegate respondsToSelector:@selector(onOnlyXianShiTableViewCellDidChooseSuppier:)]) {
        [self.delegate onOnlyXianShiTableViewCellDidChooseSuppier:self.jewelModel];
    }
}

- (IBAction)laboratoryTFChanged:(ZTTextField *)sender {
    self.jewelModel.reportId = sender.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onOnlyXianShiTableViewCellDidChooseSuppier:)]) {
        [self.delegate onOnlyXianShiTableViewCellDidChooseSuppier:self.jewelModel];
    }
}

- (void)setJewelModel:(RNSearchJewelModel *)jewelModel {
    _jewelModel = jewelModel;
    [self.btn2 setSelected:[KFormat(jewelModel.isppd) isEqualToString:@"true"]];
    [self.btn1 setSelected:[KFormat(jewelModel.ishighmember) isEqualToString:@"true"]];
    if ([Utility isString:jewelModel.reportId]) {
        self.laboratoryTF.text = jewelModel.reportId;
    } else {
        self.laboratoryTF.text = @"";
    }
}

@end
