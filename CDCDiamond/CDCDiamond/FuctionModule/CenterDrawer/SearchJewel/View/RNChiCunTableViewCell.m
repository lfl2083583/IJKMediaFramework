//
//  RNChiCunTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/7.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNChiCunTableViewCell.h"
#import "ZTTextField.h"

@interface RNChiCunTableViewCell ()

@property (nonatomic, strong) ZTTextField *leftTf;
@property (nonatomic, strong) ZTTextField *rightTf;

@end

@implementation RNChiCunTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.text = RNLocalized(@"chicun");
        titleLab.font = [UIFont yz_PingFangSC_RegularFontOfSize:14.f];
        titleLab.textColor = UIColorFromRGB(0x030303);
        titleLab.frame = CGRectMake(12, 0, App_Frame_Width-12, 36);
        [self.contentView addSubview:titleLab];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(12, 36, App_Frame_Width - 24, 49)];
        bottomView.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:bottomView];
        
        ZTTextField *leftTf = [[ZTTextField alloc] init];
        leftTf.font = [UIFont systemFontOfSize:13.f];
        leftTf.placeholder = RNLocalized(@"Any");
        leftTf.keyboardType = UIKeyboardTypeDecimalPad;
        leftTf.frame = CGRectMake(12, 12, (App_Frame_Width-85)/2.0, 25);
        leftTf.layer.borderWidth = 1;
        leftTf.layer.borderColor = UIColorFromRGB(0xe6e6e6).CGColor;
        [leftTf addTarget:self action:@selector(tfChanged:) forControlEvents:UIControlEventAllEditingEvents];
        [bottomView addSubview:leftTf];
        _leftTf = leftTf;
        
        ZTTextField *rightTf = [[ZTTextField alloc] init];
        rightTf.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        rightTf.placeholder = RNLocalized(@"Any");
        rightTf.keyboardType = UIKeyboardTypeDecimalPad;
        rightTf.frame = CGRectMake(CGRectGetMaxX(leftTf.frame)+37, 12, (App_Frame_Width-85)/2.0, 25);
        rightTf.layer.borderWidth = 1;
        rightTf.layer.borderColor = UIColorFromRGB(0xe6e6e6).CGColor;
        [rightTf addTarget:self action:@selector(tfChanged:) forControlEvents:UIControlEventAllEditingEvents];
        [bottomView addSubview:rightTf];
        _rightTf = rightTf;
        
        UILabel *centerlab = [[UILabel alloc] init];
        centerlab.backgroundColor = UIColorFromRGB(0xe6e6e6);
        centerlab.frame = CGRectMake((App_Frame_Width-44)/2.0, 24, 20, 1);
        [bottomView addSubview:centerlab];
    }
    return self;
}

- (void)tfChanged:(ZTTextField *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onChiCunTableViewCellMinInput:maxInput:)]) {
        [self.delegate onChiCunTableViewCellMinInput:self.leftTf.text maxInput:self.rightTf.text];
    }
}

- (void)setJewelModel:(RNSearchJewelModel *)jewelModel {
    _jewelModel = jewelModel;
    if ([Utility isString:jewelModel.size]) {
       _leftTf.text = jewelModel.size;
    } else {
       _leftTf.text = @"";
    }
    if ([Utility isString:jewelModel.maxsize]) {
        _rightTf.text = jewelModel.maxsize;
    } else {
        _rightTf.text = @"";
    }
}

- (void)setAddModel:(RNBuyRequestAddModel *)addModel {
    _addModel = addModel;
    if ([Utility isString:addModel.F_SIZEMIN]) {
       _leftTf.text = addModel.F_SIZEMIN;
    } else {
       _leftTf.text = @"";
    }
    
    if ([Utility isString:addModel.F_SIZE]) {
        NSArray *array = [addModel.F_SIZE componentsSeparatedByString:@"-"];
        if (array && [array isKindOfClass:[NSArray class]] && array.count) {
            self.rightTf.text = [NSString stringWithFormat:@"%@", array.lastObject];
        }
    } else {
        _rightTf.text = @"";
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/** */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
