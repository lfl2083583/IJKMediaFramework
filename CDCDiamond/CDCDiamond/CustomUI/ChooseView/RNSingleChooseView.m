//
//  RNSingleChooseView.m
//  FKGPopSelected
//
//  Created by tjl on 2019/11/6.
//  Copyright © 2019 forkingghost. All rights reserved.
//

#import "RNSingleChooseView.h"

@interface RNSingleChooseView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation RNSingleChooseView

- (instancetype)initWithDataSource:(NSArray *)dataSource chooseBlock:(SingleOptionChooseViewBlock)chooseBlock {
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        _chooseBlock = chooseBlock;
        _dataSource = dataSource;
        self.userInteractionEnabled = YES;
        CGFloat height = MIN(40 * dataSource.count, [UIScreen mainScreen].bounds.size.height - 120);
        CGFloat width = MAX([self getMaxWidthFrom:dataSource], 220);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [self addSubview:self.tableView];
        [self.tableView setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - width)/2.0, ([UIScreen mainScreen].bounds.size.height - height)/2.0, width, height)];
        [self.tableView reloadData];
    }
    return self;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.tableView.alpha = 1;
    }];
}

- (void)hide {
    self.tableView.alpha = 0;
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (!CGRectContainsPoint(self.tableView.frame, point)) {
        [self hide];
    }
}


- (CGFloat)getMaxWidthFrom:(NSArray <NSString *>*)menus {
    if (menus.count <= 0) {
        return 0;
    }
    [menus sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"length" ascending:YES]]];
    CGFloat width = [[menus lastObject] boundingRectWithSize:CGSizeMake(MAXFLOAT, 40.f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.width;
    return width+20;
}


#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SingleChooseID = @"RNSingleChooseViewID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SingleChooseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SingleChooseID];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.chooseBlock) {
        self.chooseBlock(indexPath.row);
    }
    [self hide];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 40;
        _tableView.userInteractionEnabled = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
    }
    return _tableView;
}
@end
