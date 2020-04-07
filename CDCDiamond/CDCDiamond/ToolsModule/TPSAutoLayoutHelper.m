//
//  TPSAutoLayoutHelper.m
//  TPSLIVE
//
//  Created by tps on 2018/5/12.
//  Copyright © 2018年 HS. All rights reserved.
//

#import "TPSAutoLayoutHelper.h"

@implementation TPSAutoLayoutHelper

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static TPSAutoLayoutHelper *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - fit
- (CGFloat)autoWidth:(CGFloat)width {
    return (width * self.originalSreenWidth / (self.originalSreenWidth != 375.0f ? 375.0f : self.originalSreenWidth));
}

- (CGFloat)autoHeight:(CGFloat)height {
//    if (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max) {
//        return height;
//    }
    return (height * self.originalSreenHeight / (self.originalSreenHeight != 667.0f ? 667.0f : self.originalSreenHeight));
}

- (CGFloat)autoFontSize:(CGFloat)fontSize {
    return (fontSize * self.originalSreenWidth / (self.originalSreenWidth != 375.0f ? 375.0f : self.originalSreenWidth));
}

#pragma mark - getter
- (CGFloat)originalSreenX {
    return self.originalSreenFrame.origin.x;
}

- (CGFloat)originalSreenY {
    return self.originalSreenFrame.origin.y;
}

- (CGFloat)originalSreenWidth {
    return self.originalSreenFrame.size.width;
}

- (CGFloat)originalSreenHeight {
    return self.originalSreenFrame.size.height;
}
@end
