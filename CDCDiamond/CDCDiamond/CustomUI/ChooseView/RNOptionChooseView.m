//
//  RNOptionChooseView.m
//  FKGPopSelected
//
//  Created by tjl on 2019/11/5.
//  Copyright © 2019 forkingghost. All rights reserved.
//

#import "RNOptionChooseView.h"
#import "UIView+YZCorner.h"
#import "RNChooseTableViewCell.h"

@interface RNOptionChooseView ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *seletedArray;
@property (nonatomic, strong) NSMutableArray *searchResult;
@property (nonatomic, assign) BOOL searchActive;

@end

@implementation RNOptionChooseView

- (instancetype)initWithTopSpace:(CGFloat)topspace {
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        self.topSpace = topspace;
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.tableView];
        [self setupbottomView];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [self.contentView yz_setCornerOnTopWithRadius:10.f];
    }
    return self;
}

- (instancetype)initWithTopSpace:(CGFloat)topspace searchAvaliable:(BOOL)searchAvaliable {
    self = [self initWithTopSpace:topspace];
    if (self) {
        [self.contentView addSubview:self.searchBar];
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), self.width, CGRectGetHeight(self.contentView.frame)-CGRectGetMaxY(self.searchBar.frame)-56);
    }
    return self;
}

- (void)setupbottomView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 56, [UIScreen mainScreen].bounds.size.width, 56)];
    bottomView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:bottomView];
    
    UIButton *leftBtn = [UIButton yz_buttonWithTitle:RNLocalized(@"Cancel") titleColor:UIColorFromRGB(0x222222) textFont:[UIFont yz_PingFangSC_RegularFontOfSize:16]];
    leftBtn.layer.borderWidth = 1;
    leftBtn.layer.borderColor = UIColorFromRGB(0xe6e6e6).CGColor;
    leftBtn.frame = CGRectMake(16, 8, 128, 40);
    [leftBtn yz_setAllCornerWithCornerRadius:3.f];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:leftBtn];

    UIButton *rightBtn = [UIButton yz_buttonWithTitle:RNLocalized(@"Comfirm") titleColor:UIColor.whiteColor textFont:[UIFont yz_PingFangSC_RegularFontOfSize:16]];
    rightBtn.backgroundColor = [RNGlobalUIStandard defaultMainColor];
    [rightBtn yz_setAllCornerWithCornerRadius:3.f];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame)+12, 8, ([UIScreen mainScreen].bounds.size.width-32-12-128), 40);
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rightBtn];
}

- (void)setDefaultArray:(NSArray *)defaultArray {
    _defaultArray = defaultArray;
}

- (void)setSingleEnable:(BOOL)singleEnable {
    _singleEnable = singleEnable;
}
#pragma mark - public

- (void)showWithDataSource:(NSArray *)dataSource chooseBlock:(OptionChooseViewBlock)chooseBlock defaultArray:(NSArray *)defaultArray {
    self.dataSource = dataSource;
    self.chooseBlock = chooseBlock;
    self.defaultArray = defaultArray;
    [self.seletedArray removeAllObjects];
    if (self.defaultArray && [self.defaultArray isKindOfClass:[NSArray class]] && self.defaultArray.count) {
        for (int i = 0; i < self.defaultArray.count; i++) {
            NSString *string = self.defaultArray[i];
            if ([self.dataSource containsObject:KFormat(string)]) {
                [self.seletedArray addObject:string];
            }
        }
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y = self.topSpace;
        self.contentView.frame = rect;
    } completion:^(BOOL finished) {
        [self.tableView reloadData];
    }];
    
}

- (void)showWithDataSource:(NSArray *)dataSource normalImges:(NSArray *)normalImges seletedImgs:(NSArray *)seletedImgs chooseBlock:(OptionChooseViewBlock)chooseBlock {
    self.normalImges = normalImges;
    self.seletedImgs = seletedImgs;
    [self showWithDataSource:dataSource chooseBlock:chooseBlock defaultArray:@[]];
}

- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.contentView.frame = rect;
    } completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];
}

#pragma mark - action

- (void)leftBtnClick {
    [self hide];
}

- (void)rightBtnClick {
    NSMutableArray *array = [NSMutableArray array];
    if (self.seletedArray.count) {
        for (NSString *string in self.seletedArray) {
            [array addObject:@([self.dataSource indexOfObject:string])];
        }
    }
    if (self.chooseBlock) {
        self.chooseBlock(array);
    }
    [self hide];
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.normalImges && self.normalImges.count) {
        RNChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chooseTableViewCellIdentifier];
        return cell;
    } else {
        static NSString *const cellIdentider = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentider];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentider];
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_icon_select"]];
        }
        NSString *string = self.searchActive?self.searchResult[indexPath.row]:self.dataSource[indexPath.row];
        if ([self.seletedArray containsObject:string]) {
            cell.accessoryView.hidden = NO;
        } else {
            cell.accessoryView.hidden = YES;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = self.searchActive?self.searchResult[indexPath.row]:self.dataSource[indexPath.row];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchActive?self.searchResult.count:self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self endEditing:YES];
    NSString *string = self.searchActive?self.searchResult[indexPath.row]:self.dataSource[indexPath.row];
    if ([self.seletedArray containsObject:string]) {
        [self.seletedArray removeObject:string];
    } else {
        if (_singleEnable) {
            [self.seletedArray removeAllObjects];
        }
        [self.seletedArray addObject:string];
    }
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self onSearch:KFormat(searchBar.text)];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self onSearch:searchText];
}

- (void)onSearch:(NSString *)searchText {
    if (searchText.length == 0) {
        _searchActive = NO;
        [self.tableView reloadData];
        return;
    }
    self.searchActive = YES;
    [self.searchResult removeAllObjects];
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        [self.dataSource enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger adx, BOOL * _Nonnull stop) {
            NSString *pinyin = [Utility transformToPinyin:obj isQuanpin:NO];
            if ([KFormat(obj) rangeOfString:searchText].location != NSNotFound ||  [pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch].length > 0) {
                [self.searchResult addObject:obj];
            }
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}


#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.contentView.frame.size.height-56) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.userInteractionEnabled = YES;
        _tableView.tableFooterView = [UIView new];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_tableView registerClass:[RNChooseTableViewCell class] forCellReuseIdentifier:chooseTableViewCellIdentifier];
    }
    return _tableView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-self.topSpace)];
        _contentView.backgroundColor = WhiteColor;
    }
    return _contentView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, self.width, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = RNLocalized(@"Search");
        _searchBar.backgroundColor = UIColorFromRGB(0xf6f6f6);
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.tintColor = [RNGlobalUIStandard defaultMainColor];
    }
    return _searchBar;
}

- (NSMutableArray *)seletedArray {
    if (!_seletedArray) {
        _seletedArray = [NSMutableArray array];
    }
    return _seletedArray;
}

- (NSMutableArray *)searchResult {
    if (!_searchResult) {
        _searchResult = [NSMutableArray array];
    }
    return _searchResult;
}

@end
