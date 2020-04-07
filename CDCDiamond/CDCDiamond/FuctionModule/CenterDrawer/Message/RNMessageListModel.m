//
//  RNMessageListModel.m
//  RapNet
//
//  Created by liufulin on 2019/11/20.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNMessageListModel.h"

@implementation RNMessageListModel

- (void)setIsOpen:(BOOL)isOpen {
    _isOpen = isOpen;
}


- (CGFloat)rowHeight {
    return self.isOpen?[Utility getTextString:self.F_CONTENTS?self.F_CONTENTS:@"" textFont:[UIFont systemFontOfSize:16] frameWidth:App_Frame_Width-27 attributedString:nil].height + 24 + 44:44;
}
@end
