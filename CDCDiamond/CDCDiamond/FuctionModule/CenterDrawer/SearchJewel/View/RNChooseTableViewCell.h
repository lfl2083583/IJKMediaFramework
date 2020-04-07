//
//  RNChooseTableViewCell.h
//  RapNet
//
//  Created by jt on 2019/11/24.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const chooseTableViewCellIdentifier = @"RNChooseTableViewCell";

@interface RNChooseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UIImageView *checkView;


@end

NS_ASSUME_NONNULL_END
