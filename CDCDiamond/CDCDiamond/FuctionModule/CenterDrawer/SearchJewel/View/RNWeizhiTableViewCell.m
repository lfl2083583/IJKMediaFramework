//
//  RNWeizhiTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNWeizhiTableViewCell.h"
#import "YZBuyRequestAddAddressView.h"

@interface RNWeizhiTableViewCell ()<YZBuyRequestAddAddressViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *avaliableLB;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIView *addressContentView;
@property (weak, nonatomic) IBOutlet UIView *sellContentView;
@property (nonatomic, strong) YZBuyRequestAddAddressView *addressView;


@end

@implementation RNWeizhiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLB.text = RNLocalized(@"Location");
    [self.btn1 setTitle:RNLocalized(@"Diamond") forState:UIControlStateNormal];
    [self.btn2 setTitle:RNLocalized(@"Both") forState:UIControlStateNormal];
    [self.btn3 setTitle:RNLocalized(@"Supplier") forState:UIControlStateNormal];
    
    self.avaliableLB.text = RNLocalized(@"Ensure Available Sale");
    
    // Initialization code
    [self.btn1 setBackgroundImage:[UIImage graphicsImageWithColor:UIColor.whiteColor rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateNormal];
    [self.btn1 setBackgroundImage:[UIImage graphicsImageWithColor:[RNGlobalUIStandard defaultMainColor] rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateSelected];
    [self.btn1 setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.btn1 setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    
    [self.btn2 setBackgroundImage:[UIImage graphicsImageWithColor:UIColor.whiteColor rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateNormal];
    [self.btn2 setBackgroundImage:[UIImage graphicsImageWithColor:[RNGlobalUIStandard defaultMainColor] rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateSelected];
    [self.btn2 setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.btn2 setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    
    
    [self.btn3 setBackgroundImage:[UIImage graphicsImageWithColor:UIColor.whiteColor rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateNormal];
    [self.btn3 setBackgroundImage:[UIImage graphicsImageWithColor:[RNGlobalUIStandard defaultMainColor] rect:CGRectMake(0, 0, App_Frame_Width/2.0, 30)] forState:UIControlStateSelected];
    [self.btn3 setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [self.btn3 setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    
    self.addressView = [[YZBuyRequestAddAddressView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width-36, 44)];
    self.addressView.delegate = self;
    [self.addressContentView addSubview:self.addressView];
    [self.sellContentView setY:CGRectGetMaxY(self.addressContentView.frame)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setJewelModel:(RNSearchJewelModel *)jewelModel {
    _jewelModel = jewelModel;
    if ([Utility isString:jewelModel.loctiontype]) {
        self.positionType = jewelModel.loctiontype.intValue;
    } else {
        self.positionType = 0;
    }
    
    if ([Utility isString:jewelModel.loction]) {
        self.addressList = [NSMutableArray arrayWithArray:[jewelModel.loction componentsSeparatedByString:@","]];
    } else {
        self.addressList = [NSMutableArray array];
    }
    
    [self.checkBoxBtn setSelected:jewelModel.isavalible == 1?YES:NO];
}

- (void)setPositionType:(int)positionType {
    _positionType = positionType;
    if (positionType == 0) {
        self.btn1.selected = NO;
        self.btn2.selected = NO;
        self.btn3.selected = NO;
    } else if (positionType == 1) {
        self.btn1.selected = YES;
        self.btn2.selected = NO;
        self.btn3.selected = NO;
    } else if (positionType == 2) {
        self.btn1.selected = NO;
        self.btn2.selected = YES;
        self.btn3.selected = NO;
    } else if (positionType == 3) {
        self.btn1.selected = NO;
        self.btn2.selected = NO;
        self.btn3.selected = YES;
    }
}

- (void)setAddressList:(NSMutableArray *)addressList {
    _addressList = addressList;
    self.addressView.addressList = addressList;
    [self.addressView setHeight:44*(addressList.count+1)];
    [self.addressContentView setHeight:44*(addressList.count+1)];
    [self.sellContentView setY:CGRectGetMaxY(self.addressContentView.frame)];
}

#pragma mark  - YZBuyRequestAddAddressViewDelegate

- (void)onBuyRequestAddAddressViewDeleteAddressClick:(NSMutableArray *)addressList {
    self.addressList = addressList;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onWeizhiTableViewCellAddressChanged:)]) {
        [self.delegate onWeizhiTableViewCellAddressChanged:self.addressList];
    }
}

- (void)onBuyRequestAddAddressViewAddAddressClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onWeizhiTableViewCellAddPostionClick:)]) {
        [self.delegate onWeizhiTableViewCellAddPostionClick:self];
    }
}


- (IBAction)positionClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onWeizhiTableViewCellPositionTypeClick:)]) {
        [self.delegate onWeizhiTableViewCellPositionTypeClick:(int)sender.tag];
    }
}

- (IBAction)addClick:(UIButton *)sender {
    
}

- (IBAction)checkBoxclick:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    if (self.delegate && [self.delegate respondsToSelector:@selector(onWeizhiTableViewCellSellEnableClick:)]) {
        [self.delegate onWeizhiTableViewCellSellEnableClick:self];
    }
}
@end
