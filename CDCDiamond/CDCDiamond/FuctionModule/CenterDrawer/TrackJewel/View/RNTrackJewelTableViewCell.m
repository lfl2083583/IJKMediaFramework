//
//  RNTrackJewelTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNTrackJewelTableViewCell.h"
#import "RNTrackJewelModel.h"

@implementation RNTrackJewelTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *line = [UIView new];
        line.backgroundColor = UIColorFromRGB(0xe6e6e6);
        [self.contentView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(RNTrackJewelModel *)model {
    _model = model;
    self.textLabel.text = [NSString stringWithFormat:@"%@ | %@", RNLocalized(@"To choose"), model.F_SAVENAME];
}

@end
