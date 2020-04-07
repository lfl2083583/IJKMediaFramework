//
//  RNTrackJewelListViewController.h
//  RapNet
//
//  Created by liufulin on 2019/10/31.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNTrackJewelListViewController : RNViewController

@property (nonatomic, copy) NSString *trackName;
@property (nonatomic, strong) NSMutableDictionary *pragem;
@property (nonatomic, assign) BOOL isMoreSearch;
@property (nonatomic, assign) BOOL isFromSearch;


@end

NS_ASSUME_NONNULL_END
