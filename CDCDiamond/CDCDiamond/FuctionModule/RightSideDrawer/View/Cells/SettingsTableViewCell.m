//
//  SettingsTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/8/9.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "SettingsTableViewCell.h"

@implementation SettingsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.textLabel setFont:[UIFont systemFontOfSize:15.f]];
        
        
        UIView * selectedBackgroundView =
        [[UIView alloc] initWithFrame:(CGRect){CGPointZero, self.frame.size}];
        [selectedBackgroundView setBackgroundColor:RGBCOLOR(230, 230, 230, 1)];
        [self setSelectedBackgroundView:selectedBackgroundView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
