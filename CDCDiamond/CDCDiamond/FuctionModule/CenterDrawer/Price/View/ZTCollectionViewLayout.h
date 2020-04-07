//
//  ZTCollectionViewLayout.h
//  JTCarManage
//
//  Created by apple on 2018/12/11.
//  Copyright © 2018年 CD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZTCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) UIEdgeInsets sectionInset; //设置内边距

@end

NS_ASSUME_NONNULL_END
