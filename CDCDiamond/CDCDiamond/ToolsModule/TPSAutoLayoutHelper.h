//
//  TPSAutoLayoutHelper.h
//  TPSLIVE
//
//  Created by tps on 2018/5/12.
//  Copyright © 2018年 HS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPSAutoLayoutHelper : NSObject

@property (nonatomic, assign) CGRect  originalSreenFrame;
@property (nonatomic, assign) CGFloat originalSreenWidth;
@property (nonatomic, assign) CGFloat originalSreenHeight;
@property (nonatomic, assign) CGFloat originalSreenX;
@property (nonatomic, assign) CGFloat originalSreenY;


- (CGFloat)autoWidth:(CGFloat)width;
- (CGFloat)autoHeight:(CGFloat)height;
- (CGFloat)autoFontSize:(CGFloat)fontSize;

+ (instancetype)sharedInstance;
@end
