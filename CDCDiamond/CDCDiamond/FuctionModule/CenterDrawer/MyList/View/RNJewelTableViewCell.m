//
//  RNJewelTableViewCell.m
//  RapNet
//
//  Created by liufulin on 2019/10/18.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNJewelTableViewCell.h"

@interface RNJewelTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *qiegeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moguangLabel;
@property (weak, nonatomic) IBOutlet UILabel *duichengLabel;
@property (weak, nonatomic) IBOutlet UILabel *yingguangLabel;
@property (weak, nonatomic) IBOutlet UILabel *chicunLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiegeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;

@property (weak, nonatomic) IBOutlet UILabel *LB1;
@property (weak, nonatomic) IBOutlet UILabel *LB2;
@property (weak, nonatomic) IBOutlet UILabel *LB3;
@property (weak, nonatomic) IBOutlet UILabel *LB4;
@property (weak, nonatomic) IBOutlet UILabel *LB5;
@property (weak, nonatomic) IBOutlet UILabel *LB6;
@property (weak, nonatomic) IBOutlet UILabel *LB7;
@property (weak, nonatomic) IBOutlet UILabel *LB8;
@property (weak, nonatomic) IBOutlet UILabel *LB9;
@property (weak, nonatomic) IBOutlet UILabel *LB10;
@property (weak, nonatomic) IBOutlet UILabel *LB11;
@property (weak, nonatomic) IBOutlet UILabel *LB12;
@property (weak, nonatomic) IBOutlet UILabel *LB13;



@end

@implementation RNJewelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.LB1.text = RNLocalized(@"Cut");
    self.LB2.text = RNLocalized(@"Polishing");
    self.LB3.text = RNLocalized(@"Symmetry");
    self.LB4.text = RNLocalized(@"Fluorescence");
    self.LB5.text = RNLocalized(@"Chi Cun");
    self.LB6.text = RNLocalized(@"Per Price");
    self.LB7.text = RNLocalized(@"$Total");
    self.LB8.text = RNLocalized(@"Location");
    self.LB10.text = RNLocalized(@"Seller");
    self.LB12.text = RNLocalized(@"Lot Location");
    self.rightView.backgroundColor = RGBOF(0xD0F1CC);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)likeBtnClick:(UIButton *)sender {
    __weak typeof(self)weakself = self;
    if (self.likeBtn.isSelected) {
        [HttpRequestTool getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/DiamondLikeServlet?method=cancle") parameters:@{@"likeGuid" : [NSString stringWithFormat:@"%@",self.trackListModel.SGUID]} success:^(id responseObject, ResponseState state) {
            sender.selected = NO;
            [YZHubTool showSuccessText:RNLocalized(@"Cancelled collection")];
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(onJewelTableViewCellCancelLike:)]) {
                [weakself.delegate onJewelTableViewCellCancelLike:weakself];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    } else {
        [HttpRequestTool getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/DiamondLikeServlet?method=add") parameters:@{@"guid" : [NSString stringWithFormat:@"%@",self.trackListModel.GUID]} success:^(id responseObject, ResponseState state) {
            sender.selected = YES;
            [YZHubTool showSuccessText:RNLocalized(@"Collection success")];
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(onJewelTableViewCellAddLike:)]) {
                [weakself.delegate onJewelTableViewCellAddLike:weakself];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}

- (void)setTrackListModel:(RNTrackJewelListModel *)trackListModel {
    _trackListModel = trackListModel;
    self.chicunLabel.text = [Utility fomateString:trackListModel.F_SIZE];
    self.qiegeLabel.text = [Utility fomateString:trackListModel.F_CUT];
    self.moguangLabel.text = [Utility fomateString:trackListModel.F_POLISHED];
    self.duichengLabel.text = [Utility fomateString:trackListModel.F_SYMMETRICAL];
    self.yingguangLabel.text = [Utility fomateString:trackListModel.F_FLUORESCENT];
    
    self.LB9.text = [Utility fomateString:trackListModel.F_COUNTRY];
    self.LB11.text = [Utility fomateString:trackListModel.F_NAME];
    self.LB13.text = [Utility fomateString:trackListModel.F_COUNTRY2];
    self.chicunLabel.text = [NSString stringWithFormat:@"%@-%@x%@", trackListModel.F_CHANG, trackListModel.F_KUAN, trackListModel.F_GAO];
    self.jiegeLabel.text = [Utility fomateString:[NSString stringWithFormat:@"$%ld", (long)[trackListModel.F_PRICE integerValue]]];
    self.sumLabel.text = [Utility fomateString:[NSString stringWithFormat:@"$%ld", (long)[trackListModel.F_PRICETOTAL integerValue]]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",trackListModel.F_SHAPE,trackListModel.F_SIZE, trackListModel.F_COLOR, trackListModel.F_CLARITY, trackListModel.F_JIANDINGSUO];
    [self.likeBtn setSelected:(trackListModel.SGUID && [trackListModel.SGUID isKindOfClass:[NSString class]] && trackListModel.SGUID.length)?YES:NO];
}

@end
