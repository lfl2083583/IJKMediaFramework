//
//  ZTCollectionView.m
//  JTCarManage
//
//  Created by apple on 2018/12/11.
//  Copyright © 2018年 CD. All rights reserved.
//

#import "ZTCollectionView.h"
@interface ZTCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation ZTCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BlackColor;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _titleLabel.textColor = kTextColor;
    _titleLabel.backgroundColor = RGBOF(0x2AAE33);;
    _titleLabel.font = kTitleFont;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];
}

@end

@interface ZTCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout * layout;

@end

static NSString * ChartMenuItemCellIdfy = @"ChartMenuItemCellIdfy";
@implementation ZTCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame collectionViewLayout:self.layout];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:self.layout];
    if (self) {
        self.selectedIndex = -1;
        self.delegate = self;
        self.dataSource = self;
        self.allowsSelection = NO;
        self.backgroundColor = kLineColor;
        self.bounces = false;
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        [self registerClass:ZTCollectionViewCell.class forCellWithReuseIdentifier:ChartMenuItemCellIdfy];
    }
    return self;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        self.layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.minimumLineSpacing = kLineWidth;
        _layout.minimumInteritemSpacing = kLineWidth;
        _layout.sectionInset = UIEdgeInsetsMake(kLineWidth, kLineWidth, kLineWidth, kLineWidth);
    }
    return _layout;
}

#pragma mark -

- (void)setMenus:(NSArray<NSString *> *)menus {
    if (nil != menus) {
        _menus = menus;
        [self reloadData];
    }
}

#pragma mark - UICollectionView M

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _menus.count;;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZTCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ChartMenuItemCellIdfy forIndexPath:indexPath];
    cell.titleLabel.text = _menus[indexPath.item];
    cell.titleLabel.textColor = (indexPath.row == self.selectedIndex)?UIColor.blueColor:WhiteColor;
    return cell;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

