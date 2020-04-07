//
//  RNHightSearchPeopleTableViewCell.m
//  RapNet
//
//  Created by tjl on 2019/10/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNHightSearchPeopleTableViewCell.h"


@interface RNHightSearchPeopleTableViewCell ()<UITextFieldDelegate>


@property (nonatomic, strong) UIView *bottomView;

@end

@implementation RNHightSearchPeopleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = UIColorFromRGB(0xf8f8f8);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(12, 0, App_Frame_Width - 24, 55)];
        self.bottomView.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:self.bottomView];
        
        self.field = [[RNMagicField alloc] initWithFrame:CGRectMake(12, 0, self.bottomView.width - 24, 55)];
        self.field.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        self.field.delegate = self;
        self.field.moveDistance = 20;
        self.field.textColor = UIColorFromRGB(0x222222);
        self.field.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        self.field.placeholdAnimationable = YES;
        [self.field addTarget:self action:@selector(fieldEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [self.bottomView addSubview:self.field];
        
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xe6e6e6);
        line.frame = CGRectMake(12, 54, self.bottomView.width - 12, 1);
        self.line = line;
        [self.bottomView addSubview:line];
        
    }
    return self;
}

- (void)setPlacehold:(NSString *)placehold {
    _placehold = placehold;
    self.field.placeholder = placehold;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

- (void)fieldEditeChanged:(RNMagicField *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(onHightSearchPeopleTableViewCellEditChanged:)]) {
        [self.delegate onHightSearchPeopleTableViewCellEditChanged:self];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
