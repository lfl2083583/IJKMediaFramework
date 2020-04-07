//
//  RNChangePriceListTableViewCell.m
//  RapNet
//
//  Created by jt on 2019/11/7.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNChangePriceListTableViewCell.h"

@interface RNChangePriceListTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *portLB;
@property (weak, nonatomic) IBOutlet UILabel *colorLB;
@property (weak, nonatomic) IBOutlet UILabel *beforeLB;
@property (weak, nonatomic) IBOutlet UILabel *neatnessLB;
@property (weak, nonatomic) IBOutlet UILabel *lafterLB;
@property (weak, nonatomic) IBOutlet UILabel *changeLB;
@property (weak, nonatomic) IBOutlet UILabel *rateLB;


@end

@implementation RNChangePriceListTableViewCell

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
    if (source && [source isKindOfClass:[NSDictionary class]]) {
        self.portLB.text = [NSString stringWithFormat:@"%@", source[@"PAPAPORT"]];
        self.colorLB.text = [NSString stringWithFormat:@"%@", source[@"F_TYPE"]];
        self.beforeLB.text = [NSString stringWithFormat:@"%@", source[@"before"]];
        self.neatnessLB.text = [NSString stringWithFormat:@"%@", source[@"neatness"]];
        self.lafterLB.text = [NSString stringWithFormat:@"%@", source[@"later"]];
        self.changeLB.text = [NSString stringWithFormat:@"%.2f",[source[@"change"] floatValue]];
        self.rateLB.text = [NSString stringWithFormat:@"%.2f",[source[@"rate"] floatValue]];
    }
}

@end
