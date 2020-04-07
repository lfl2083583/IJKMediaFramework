//
//  RNNewsDetailContentTableViewCell.m
//  RapNet
//
//  Created by jt on 2019/11/8.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNNewsDetailContentTableViewCell.h"

@interface RNNewsDetailContentTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLB;

@end

@implementation RNNewsDetailContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(RNNewsModel *)model {
    _model = model;
    
    NSData *data = [model.F_CONTENT dataUsingEncoding:NSUnicodeStringEncoding];

    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};

    NSMutableAttributedString *contentText = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    self.contentLB.attributedText = contentText;
    
    //self.contentLB.text = [self filterHTML:self.model.F_CONTENT];

}


-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        //去除空格
        html = [html stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return html;
}

@end
