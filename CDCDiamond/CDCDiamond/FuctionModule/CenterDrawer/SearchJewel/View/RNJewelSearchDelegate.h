//
//  RNJewelSearchDelegate.h
//  RapNet
//
//  Created by tjl on 2019/11/8.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#ifndef RNJewelSearchDelegate_h
#define RNJewelSearchDelegate_h

@protocol RNJewelSearchDelegate <NSObject>

@optional
- (void)onJewelSearchDidSeltedXingzhuang:(NSString *)xz;
- (void)onJewelSearchDidSeltedDaxiao:(NSString *)dx;
- (void)onJewelSearchDidSeltedYanse:(NSString *)ys;
- (void)onJewelSearchDidSeltedQiege:(NSString *)qg;
- (void)onJewelSearchDidSeltedJingdu:(NSString *)jd;
- (void)onJewelSearchDidSeltedXiushi:(NSString *)xs;
- (void)onJewelSearchDidSeltedPaoguang:(NSString *)pg;
- (void)onJewelSearchDidSeltedDuicheng:(NSString *)dc;
- (void)onJewelSearchDidSeltedYingguang:(NSString *)qd ys:(NSString *)ys;
- (void)onJewelSearchDidSeltedDengji:(NSString *)dj;
- (void)onJewelSearchDidSeltedWeizhi:(NSString *)wz;
- (void)onJewelSearchDidSeltedJiage:(NSString *)jg;
- (void)onJewelSearchDidSeltedJinxianshi:(NSString *)jxs;
- (void)onJewelSearchDidSeltedShiyanshiNum:(NSString *)sys;

@end



#endif /* RNJewelSearchDelegate_h */
