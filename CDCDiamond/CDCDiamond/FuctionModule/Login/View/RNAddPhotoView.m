//
//  RNAddPhotoView.m
//  CDCDiamond
//
//  Created by Frank on 2020/3/27.
//  Copyright © 2020 Frank. All rights reserved.
//

#import "RNAddPhotoView.h"

@interface RNAddPhotoView ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;

@end

@implementation RNAddPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBOF(0xefefef);
        _icon = [UIImageView new];
        _icon.image = ImageName(@"icon_camera_upload");
        [self addSubview:_icon];
        
        _title = [UILabel yz_labelWithText:RNLocalized(@"Upload Files") textColor:RGBOF(0x999999) sizeFont:12];
        [self addSubview:_title];
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.centerX.equalTo(self.mas_centerX).offset(-30);
        }];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self->_icon.mas_right).offset(5);
        }];
    }
    return self;
}



@end
