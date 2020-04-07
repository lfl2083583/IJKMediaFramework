//
//  RNMessageListModel.h
//  RapNet
//
//  Created by liufulin on 2019/11/20.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RNMessageListModel : NSObject

@property (nonatomic, copy) NSString *F_CONTENTS;
@property (nonatomic, copy) NSString *F_TIME;
@property (nonatomic, copy) NSString *F_TITLE;
@property (nonatomic, copy) NSString *GUID;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isRead;
@property (nonatomic, assign) CGFloat rowHeight;
@end

NS_ASSUME_NONNULL_END
