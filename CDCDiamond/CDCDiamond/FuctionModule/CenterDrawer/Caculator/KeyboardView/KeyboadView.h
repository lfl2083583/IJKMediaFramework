//
//  KeyboadView.h
//  RapNet
//
//  Created by liufulin on 2019/10/28.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KeyboadViewDelegate <NSObject>

- (void)onkeyboardTextInput:(NSString *)inputString;
- (void)onkeyboardRestTextInput:(NSString *)inputString;
- (void)onkeyboardCompareTextInput:(NSString *)inputString;
- (void)onkeyboardSaveTextInput:(NSString *)inputString;

@end

@interface KeyboadView : UIView

@property (nonatomic, weak) id<KeyboadViewDelegate>delegate;
@property (nonatomic, copy) NSString *inputString;

@end



NS_ASSUME_NONNULL_END
