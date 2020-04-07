//
//  ZTFormListView.m
//  JTCarManage
//
//  Created by apple on 2018/12/11.
//  Copyright © 2018年 CD. All rights reserved.
//
#import "ZTFormListView.h"
#import "ZTCollectionView.h"
#import "ZTCollectionViewLayout.h"
#import "RNExchangeScreenModel.h"

@interface ZTFormViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *contentLB;
@property (nonatomic, strong) UILabel *topLeftLB;
@property (nonatomic, strong) UILabel *bottomLeftLB;
@property (nonatomic, strong) UILabel *topRightLB;
@property (nonatomic, strong) UILabel *bottomRightLB;


@end

@implementation ZTFormViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentLB = [[UILabel alloc] initWithFrame:self.bounds];
        self.contentLB.textColor = RGB(57, 150, 255);;
        self.contentLB.font = kTitleFont;
        self.contentLB.numberOfLines = 0;
        self.contentLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.contentLB];
        
        self.topLeftLB = [UILabel yz_labelWithText:@"" textColor:RGBCOLOR(51, 51, 51, 1) textFont:[UIFont yz_PingFangSC_MediumFontOfSize:12.f]];
        self.topLeftLB.adjustsFontSizeToFitWidth = YES;
        self.topLeftLB.minimumScaleFactor = 0.1;
        self.topLeftLB.frame = CGRectMake(0, 0, frame.size.width/2.0, frame.size.height/2.0);
        self.bottomLeftLB = [UILabel yz_labelWithText:@"" textColor:RGBCOLOR(51, 51, 51, 1) textFont:[UIFont yz_PingFangSC_MediumFontOfSize:12.f]];
        self.bottomLeftLB.adjustsFontSizeToFitWidth = YES;
        self.bottomLeftLB.minimumScaleFactor = 0.1;
        self.bottomLeftLB.frame = CGRectMake(0, frame.size.height/2.0, frame.size.width/2.0, frame.size.height/2.0);
        
        self.topRightLB = [UILabel yz_labelWithText:@"" textColor:[RNGlobalUIStandard defaultMainColor] textFont:[UIFont yz_PingFangSC_MediumFontOfSize:12.f] numberOfLines:1 textAlignment:NSTextAlignmentRight];
        self.topRightLB.adjustsFontSizeToFitWidth = YES;
        self.topRightLB.minimumScaleFactor = 0.1;
        self.topRightLB.frame = CGRectMake(frame.size.width/2.0, 0, frame.size.width/2.0-5, frame.size.height/2.0);
        self.bottomRightLB = [UILabel yz_labelWithText:@"" textColor:[RNGlobalUIStandard defaultMainColor] textFont:[UIFont yz_PingFangSC_MediumFontOfSize:12.f] numberOfLines:1 textAlignment:NSTextAlignmentRight];
        self.bottomRightLB.adjustsFontSizeToFitWidth = YES;
        self.bottomRightLB.minimumScaleFactor = 0.1;
        self.bottomRightLB.frame = CGRectMake(frame.size.width/2.0, frame.size.height/2.0, frame.size.width/2.0-5, frame.size.height/2.0);
        [self.contentView addSubview:self.topLeftLB];
        [self.contentView addSubview:self.bottomLeftLB];
        [self.contentView addSubview:self.topRightLB];
        [self.contentView addSubview:self.bottomRightLB];
        
    }
    return self;
}
@end




@interface ZTFormListView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UICollectionView *contentView;
@property (nonatomic, strong) ZTCollectionViewLayout *layout;
@property (nonatomic, strong) ZTCollectionView *topMenuBar;
@property (nonatomic, strong) ZTCollectionView *sideMenuBar;
@property (nonatomic, strong) UILabel *topMenuLB;
@property (nonatomic, assign) CGFloat topMenuWidth;
@property (nonatomic, assign) CGFloat sideMenuWidth;
@property (nonatomic, assign) BOOL shouldChangeMenuOffset;
@property (nonatomic, assign) BOOL shouldChangeChartViewOffset;

@end

static void *FormViewConstentOffsetContext  = &FormViewConstentOffsetContext;
static void *TopMenuConstentOffsetContext = &TopMenuConstentOffsetContext;
static void *SideMenuConstentOffsetContext = &SideMenuConstentOffsetContext;
static NSString * ChartViewCellIdfy = @"ChartViewCellIdfy";

@implementation ZTFormListView

- (void)dealloc {
    [_topMenuBar removeObserver:self forKeyPath:@"contentOffset"];
    [_sideMenuBar removeObserver:self forKeyPath:@"contentOffset"];
    [_contentView removeObserver:self forKeyPath:@"contentOffset"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.shouldChangeMenuOffset = YES;
        self.shouldChangeChartViewOffset = YES;
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.shouldChangeMenuOffset = YES;
    self.shouldChangeChartViewOffset = YES;
    [self setupViews];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame topMenus:(NSArray <NSString *>*)topMenus sideMenus:(NSArray <NSString *>*)sideMenus {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.topMenus = topMenus;
    self.sideMenus = sideMenus;
    self.shouldChangeMenuOffset = YES;
    self.shouldChangeChartViewOffset = YES;
    [self setupViews];
    return self;
}

- (void)setTopMenus:(NSArray <NSString *>*)topMenus sideMenus:(NSArray <NSString *>*)sideMenus {
    self.topMenus = topMenus;
    self.sideMenus = sideMenus;
    [self.sideMenuBar reloadData];
    [self.topMenuBar reloadData];
    [self.contentView reloadData];
}

- (void)setupViews {
    _selectedIndex = -1;
    _topMenuWidth = 90;
    _sideMenuWidth = 47;
    CGFloat itemWidth = _topMenuWidth;
    // container
    self.containerView = ({
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor redColor];
        view.clipsToBounds = YES;
        view;
    });
    // list
    self.contentView = ({
        self.layout.itemSize = CGSizeMake(itemWidth, kItemHeight);
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:_containerView.bounds collectionViewLayout:self.layout];
        collectionView.backgroundColor = kLineColor;
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        collectionView.contentInset = UIEdgeInsetsMake(kTopHeight + 2 *kLineWidth, _sideMenuWidth + 2 *kLineWidth, 0, 0);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.bounces = NO;
        collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        collectionView.showsVerticalScrollIndicator = false;
        collectionView.showsHorizontalScrollIndicator = false;
        [collectionView registerClass:ZTFormViewCell.class forCellWithReuseIdentifier:ChartViewCellIdfy];
        [collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:FormViewConstentOffsetContext];
        collectionView;
    });
    
    // left corner view
    UIView *leftCornerBgView = [UIView new];
    leftCornerBgView.tag = 500;
    leftCornerBgView.backgroundColor = RGBOF(0x2AAE33);
    leftCornerBgView.clipsToBounds = YES;
    leftCornerBgView.layer.borderWidth = 1;
    leftCornerBgView.layer.borderColor = WhiteColor.CGColor;
    UIView * leftCornerView = [UIView new];
    leftCornerView.backgroundColor = [UIColor whiteColor];
    leftCornerView.top = kLineWidth;
    leftCornerView.left = kLineWidth;
    [leftCornerBgView addSubview:leftCornerView];
    
    // top menu
    self.topMenuBar = ({
        ZTCollectionView *topMenu = [ZTCollectionView new];
        topMenu.size = CGSizeMake(self.width - leftCornerBgView.right , kItemHeight + 2 *kLineWidth);
        topMenu.top = 0;
        topMenu.left = leftCornerView.right + kLineWidth;
        topMenu.contentInset = UIEdgeInsetsZero;
        UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)topMenu.collectionViewLayout;
        layout.itemSize = CGSizeMake(_topMenuWidth, kItemHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(kLineWidth, 0, kLineWidth, kLineWidth);
        [topMenu addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:TopMenuConstentOffsetContext];
        [topMenu setMenus:_topMenus];
        topMenu;
    });
    
    // side menu
    self.sideMenuBar = ({
        ZTCollectionView *sideMenu = [ZTCollectionView new];
        sideMenu.size = CGSizeMake(_sideMenuWidth + 2 *kLineWidth, self.height - leftCornerBgView.bottom);
        sideMenu.top = leftCornerView.bottom + kLineWidth;
        sideMenu.left = 0;
        sideMenu.contentInset = UIEdgeInsetsZero;
        UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)sideMenu.collectionViewLayout;
        layout.itemSize = CGSizeMake(_sideMenuWidth, 30);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(0, kLineWidth, kLineWidth, kLineWidth);
        [sideMenu addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:SideMenuConstentOffsetContext];
        [sideMenu setMenus:_sideMenus];
        sideMenu;
    });
    
    self.topMenuLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _sideMenuWidth + 2 *kLineWidth, kTopHeight + 2 *kLineWidth)];
    self.topMenuLB.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];;
    self.topMenuLB.font = kTitleFont;
    self.topMenuLB.numberOfLines = 0;
    self.topMenuLB.hidden = YES;
    self.topMenuLB.backgroundColor = RGBOF(0x2AAE33);
    self.topMenuLB.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_containerView];
    [_containerView addSubview:_contentView];
    [_containerView addSubview:leftCornerBgView];
    [_containerView addSubview:_topMenuBar];
    [_containerView addSubview:_sideMenuBar];
    [_containerView addSubview:_topMenuLB];
}

- (ZTCollectionViewLayout *)layout {
    if (!_layout) {
        self.layout = [[ZTCollectionViewLayout alloc]init];
        _layout.minimumLineSpacing = kLineWidth;
        _layout.minimumInteritemSpacing = kLineWidth;
        _layout.sectionInset = UIEdgeInsetsMake(0, 0, kLineWidth, kLineWidth);
    }
    return _layout;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // list
    _contentView.contentInset = UIEdgeInsetsMake(kTopHeight + 2 *kLineWidth, _sideMenuWidth + 2 *kLineWidth, 0, 0);
    // left corner view
    UIView * leftCornerBgView = [self viewWithTag:500];
    UIView * leftCornerView = [[leftCornerBgView subviews]lastObject];
    if (_sideMenuWidth > 0) {
        leftCornerBgView.size = CGSizeMake(_sideMenuWidth + 2 *kLineWidth, kTopHeight + 2 *kLineWidth);
        leftCornerView.size = CGSizeMake(_sideMenuWidth, kTopHeight);
    }else {
        leftCornerBgView.size = CGSizeZero;
    }
    // top menu
    CGFloat height = (kItemHeight + kLineWidth) * _sideMenus.count;
    CGFloat width  = (_topMenuWidth + kLineWidth) * _topMenus.count;
    _topMenuBar.size = CGSizeMake(self.width - (leftCornerView.right + kLineWidth) , kTopHeight + 2 *kLineWidth);
    _topMenuBar.left = leftCornerBgView.right;
    UICollectionViewFlowLayout * t_layout = (UICollectionViewFlowLayout *)_topMenuBar.collectionViewLayout;
    t_layout.itemSize = CGSizeMake(_topMenuWidth, kItemHeight);
    // side menu
    _sideMenuBar.size = CGSizeMake(_sideMenuWidth + 2 *kLineWidth, self.height - (leftCornerView.bottom + kLineWidth));
    _sideMenuBar.top = leftCornerBgView.bottom;
    UICollectionViewFlowLayout * s_layout = (UICollectionViewFlowLayout *)_sideMenuBar.collectionViewLayout;
    s_layout.itemSize = CGSizeMake(_sideMenuWidth, kItemHeight);
    
    // container
    height += _sideMenuWidth > 0?kItemHeight + 2 *kLineWidth:0;
    width  += _topMenuWidth > 0?leftCornerBgView.width:0;
    height  = MIN(height-6, self.height);
    width   = MIN(width, self.width);
    _containerView.size = CGSizeMake(width, height);
    [_topMenuLB setFrame:CGRectMake(1, 0, _sideMenuWidth + 2 *kLineWidth - 2, kTopHeight + 2 *kLineWidth - 1)];
}

#pragma mark - set

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    _sideMenuBar.selectedIndex = selectedIndex;
    [_contentView reloadData];
    [_sideMenuBar reloadData];
}

- (void)setTopMenus:(NSArray<NSString *> *)topMenus {
    if (nil != topMenus) {
        if (topMenus.count) {
            [_topMenuLB setText:[topMenus firstObject]];
            NSMutableArray *muarr = [NSMutableArray arrayWithArray:topMenus];
            [_topMenuBar setMenus:[muarr subarrayWithRange:NSMakeRange(1, muarr.count-1)]];
            _topMenus = [muarr subarrayWithRange:NSMakeRange(1, muarr.count-1)];
            [_topMenuLB setHidden:NO];
        }
        
        //_topMenuWidth = [self getMaxWidthFrom:_topMenus];
        _layout.itemSize = CGSizeMake(_topMenuWidth, kItemHeight);
        
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
        [_contentView reloadData];
        [self adjustContentOffset];
    }
}

- (void)setSideMenus:(NSArray<NSString *> *)sideMenus {
    if (nil != sideMenus) {
        _sideMenus = sideMenus;
//        _sideMenuWidth = [self getMaxWidthFrom:_sideMenus];
        [_sideMenuBar setMenus:_sideMenus];
        [self setNeedsLayout];
        [self layoutIfNeeded];
        [_contentView reloadData];
        [self adjustContentOffset];
    }
}

- (void)setDataSource:(NSArray *)dataSource {
    if (nil != dataSource) {
        _dataSource = dataSource;
        [_contentView reloadData];
    }
}

//- (CGFloat)getMaxWidthFrom:(NSArray <NSString *>*)menus {
//    if (menus.count <= 0) {
//        return 0;
//    }
//    [menus sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"length" ascending:YES]]];
//    CGFloat paddingInsert = 8;
//    CGFloat width = [[menus lastObject] boundingRectWithSize:CGSizeMake(MAXFLOAT, kItemHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kTitleFont} context:nil].size.width;
//    width += 2 *paddingInsert;
//    width  = roundf(width);
//    return width;
//}

- (void)adjustContentOffset {
    
    CGPoint contentOffset = _contentView.contentOffset;
    contentOffset.x = - (_sideMenuWidth + 2 *kLineWidth);
    contentOffset.y = - (kTopHeight + 2 *kLineWidth);
    _shouldChangeChartViewOffset = false;
    _contentView.contentOffset   = contentOffset;
    _shouldChangeChartViewOffset = true;
    
    _shouldChangeMenuOffset    = false;
    _topMenuBar.contentOffset  = CGPointZero;
    _sideMenuBar.contentOffset = CGPointZero;
    _shouldChangeMenuOffset    = true;
}

#pragma mark - UICollectionView M

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _topMenus.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _sideMenus.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZTFormViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ChartViewCellIdfy forIndexPath:indexPath];
    cell.backgroundColor = RGBOF(0xf4f4f4);
    @try {
        id source = self.dataSource[indexPath.section][indexPath.row];
        if ([source isKindOfClass:[NSString class]]) {
            NSString * text = source;
            cell.contentLB.text = text;
            cell.contentLB.textColor = (self.selectedIndex == indexPath.section)?UIColor.blueColor:UIColorFromRGB(0x222222);
        } else if ([source isKindOfClass:[RNExchangeScreenModel class]]) {
            RNExchangeScreenModel *model = source;
//            cell.topLeftLB.text = ([model.F_PRICE integerValue])?[NSString stringWithFormat:@"  %ld", (long)[model.F_PRICE integerValue]]:@"";
//            cell.bottomLeftLB.text = ([model.avgprice integerValue])?[NSString stringWithFormat:@"  %ld", (long)[model.avgprice integerValue]]:@"";
//            cell.topRightLB.text = ([model.mindiscount integerValue])?[NSString stringWithFormat:@"  %ld%%", [model.mindiscount integerValue]]:@"";
//            cell.bottomRightLB.text = ([model.avgdiscount integerValue])?[NSString stringWithFormat:@"  %ld%%", [model.avgdiscount integerValue]]:@"";
            cell.contentLB.text = ([model.F_PRICE integerValue])?[NSString stringWithFormat:@"$%@/ct", [Utility countNumAndChangeformat:[NSString stringWithFormat:@"%ld", (long)[model.F_PRICE integerValue]]]]:@"";
            cell.contentLB.textColor = UIColorFromRGB(0x222222);
        } else if (self.dataSource && !self.dataSource.count) {
            cell.contentLB.text = @"";
        } else {
            cell.contentLB.text = @"";
        }
        
    } @catch (NSException *exception) {}
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(onDidSeletedFormListCell:)]) {
        [self.delegate onDidSeletedFormListCell:indexPath];
    }
}

#pragma mark - Observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (_shouldChangeChartViewOffset) {
        if (context == FormViewConstentOffsetContext) {
            
            CGPoint contentOffsetN  = [change[NSKeyValueChangeNewKey] CGPointValue];
            CGPoint contentOffsetO  = [change[NSKeyValueChangeOldKey] CGPointValue];
            CGFloat delt_x = contentOffsetN.x - contentOffsetO.x;
            CGFloat delt_y = contentOffsetN.y - contentOffsetO.y;
            
            CGPoint topbar_contentOffset  = _topMenuBar.contentOffset;
            CGPoint sidebar_contentOffset = _sideMenuBar.contentOffset;
            topbar_contentOffset.x  += delt_x;
            sidebar_contentOffset.y += delt_y;
            
            _shouldChangeMenuOffset = false;
            _topMenuBar.contentOffset  = topbar_contentOffset;
            _sideMenuBar.contentOffset = sidebar_contentOffset;
            _shouldChangeMenuOffset = true;
        }
    }
    
    if (_shouldChangeMenuOffset) {
        if (context == TopMenuConstentOffsetContext) {
            
            CGPoint topbar_contentOffsetN  = [change[NSKeyValueChangeNewKey] CGPointValue];
            CGPoint topbar_contentOffsetO  = [change[NSKeyValueChangeOldKey] CGPointValue];
            CGFloat delt_x = topbar_contentOffsetN.x - topbar_contentOffsetO.x;
            
            CGPoint content_contentOffset = _contentView.contentOffset;
            content_contentOffset.x += delt_x;
            _shouldChangeChartViewOffset = false;
            _contentView.contentOffset = content_contentOffset;
            _shouldChangeChartViewOffset = true;
            
        }
        if (context == SideMenuConstentOffsetContext) {
            
            CGPoint sidebar_contentOffsetN  = [change[NSKeyValueChangeNewKey] CGPointValue];
            CGPoint sidebar_contentOffsetO  = [change[NSKeyValueChangeOldKey] CGPointValue];
            CGFloat delt_y = sidebar_contentOffsetN.y - sidebar_contentOffsetO.y;
            
            CGPoint content_contentOffset = _contentView.contentOffset;
            content_contentOffset.y += delt_y;
            _shouldChangeChartViewOffset = false;
            _contentView.contentOffset = content_contentOffset;
            _shouldChangeChartViewOffset = true;
            
        }
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
