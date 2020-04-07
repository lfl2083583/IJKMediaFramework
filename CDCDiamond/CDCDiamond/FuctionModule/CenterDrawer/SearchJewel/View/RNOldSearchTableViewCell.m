//
//  RNOldSearchTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/24.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNOldSearchTableViewCell.h"

@interface RNOldSearchTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;


@end

@implementation RNOldSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSource:(id)source {
    _source = source;
    if (source) {
        [self.titleLB setText:source[@"F_SEARCHNAME"]];
        [self.timeLB setText:source[@"F_SAVEDATE"]];
    }
}


@end
