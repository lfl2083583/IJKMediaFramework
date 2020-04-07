//
//  RNCenterItem.h
//  RapNet
//
//  Created by liufulin on 2019/7/23.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNCenterItem : NSObject

@property (nonatomic, assign) Class class;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) NSInteger rows;

- (instancetype)initWithClass:(Class)class cellheight:(CGFloat)cellheight rows:(NSInteger)rows;

@end

NS_ASSUME_NONNULL_END
