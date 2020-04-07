//
//  RNHightSearchPeopleControllerViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/14.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNHightSearchPeopleControllerViewController.h"
#import "RNHightSearchPeopleTableViewCell.h"
#import "RNPositionTableViewCell.h"
#import "RNHightSearchArrowTableViewCell.h"
#import "RNSingleChooseView.h"
#import "RNHightSearchPeopleModel.h"
#import "RNPeopleModel.h"
#import "RNSearchResultViewController.h"

@interface RNHightSearchPeopleControllerViewController ()<RNHightSearchPeopleTableViewCellDelegate, RNPositionTableViewCellDelegate>

@property (nonatomic, strong) RNHightSearchPeopleModel *searchModel;

@property (nonatomic, strong) NSMutableArray *allCountry;
@property (nonatomic, strong) NSMutableArray *allState;
@property (nonatomic, strong) NSMutableArray *allCity;

@end

@implementation RNHightSearchPeopleControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RNLocalized(@"Advanced Search");
    [self setupTableView];
    [self.view setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    [self.tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-56);
    }];
    [self.tableView registerClass:[RNHightSearchPeopleTableViewCell class] forCellReuseIdentifier:hightSearchPeopleidentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNPositionTableViewCell" bundle:nil] forCellReuseIdentifier:positionIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNHightSearchArrowTableViewCell" bundle:nil] forCellReuseIdentifier:hightSearchArrowIdentifier];
    [self setupBottomView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    //bottomView.frame = CGRectMake(0, APP_Frame_Height-56-kTopBarHeight-kStatusBarHeight, App_Frame_Width, 56);
    bottomView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(56);
    }];
    
    UIButton *leftBtn = [UIButton yz_buttonWithTitle:RNLocalized(@"Reset") titleColor:UIColorFromRGB(0x222222) textFont:[UIFont yz_PingFangSC_RegularFontOfSize:16]];
    leftBtn.layer.borderWidth = 1;
    leftBtn.layer.borderColor = UIColorFromRGB(0xe6e6e6).CGColor;
    leftBtn.frame = CGRectMake(16, 8, 128, 40);
    [bottomView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [UIButton yz_buttonWithTitle:RNLocalized(@"Search") titleColor:UIColor.whiteColor textFont:[UIFont yz_PingFangSC_RegularFontOfSize:16]];
    rightBtn.backgroundColor = [RNGlobalUIStandard defaultMainColor];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame)+12, 8, (App_Frame_Width-32-12-128), 40);
    [bottomView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)rightClick {
    __weak typeof(self)weakself = self;
    NSDictionary *dict = [self.searchModel mj_keyValues];
    [HttpRequestTool  postWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/MemberServlet?method=advancedSearch")  parameters:dict success:^(id responseObject, ResponseState state) {
         NSLog(@"%@", responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSArray class]] && [responseObject count]) {
            [weakself.dataArray removeAllObjects];
            NSArray *array = responseObject;
            for (NSDictionary *dict in array) {
               [weakself.dataArray addObject:[RNPeopleModel mj_objectWithKeyValues:dict]];
            }
            
            if (weakself.dataArray.count) {
                RNSearchResultViewController *vc = [[RNSearchResultViewController alloc] init];
                vc.dataArray = weakself.dataArray;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)leftClick {
    self.searchModel = [[RNHightSearchPeopleModel alloc] init];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RNHightSearchPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hightSearchPeopleidentifier];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.line.hidden = NO;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.placehold = RNLocalized(@"Company Name");
            cell.field.text = self.searchModel.comname;
        } else if (indexPath.row == 1) {
            cell.placehold = RNLocalized(@"Member Name");
            cell.field.text = self.searchModel.mname;
        } else if (indexPath.row == 2) {
            cell.placehold = RNLocalized(@"Company Code");
            cell.field.text = self.searchModel.comcode;
        } else {
            RNHightSearchArrowTableViewCell *arrowCell = [tableView dequeueReusableCellWithIdentifier:hightSearchArrowIdentifier];
            arrowCell.contentLab.text = RNLocalized(@"Company Type");
            arrowCell.line.hidden = YES;
            arrowCell.detailLB.text = self.searchModel.comtype?self.searchModel.comtype:@"";
            return arrowCell;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            RNPositionTableViewCell *positionCell = [tableView dequeueReusableCellWithIdentifier:positionIdentifier];
            positionCell.delegate = self;
            if (self.searchModel.country) {
                [positionCell.countryBtn setTitle:[NSString stringWithFormat:@"%@", self.searchModel.country] forState:UIControlStateNormal];
            } else {
                [positionCell.countryBtn setTitle:RNLocalized(@"Country/Region") forState:UIControlStateNormal];
            }
            if (self.searchModel.sheng) {
                [positionCell.proviceBtn setTitle:[NSString stringWithFormat:@"%@", self.searchModel.sheng] forState:UIControlStateNormal];
            } else {
                [positionCell.proviceBtn setTitle:RNLocalized(@"State/Province") forState:UIControlStateNormal];
            }
            
            return positionCell;
        } else if (indexPath.row == 1) {
            cell.placehold = RNLocalized(@"City");
            cell.field.text = self.searchModel.city;
        } else {
            cell.placehold = RNLocalized(@"Telephone");
            cell.line.hidden = YES;
            cell.field.text = self.searchModel.phone;
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            RNHightSearchArrowTableViewCell *arrowCell = [tableView dequeueReusableCellWithIdentifier:hightSearchArrowIdentifier];
            arrowCell.contentLab.text = RNLocalized(@"Score");
            arrowCell.line.hidden = NO;
            arrowCell.detailLB.text = self.searchModel.ratings?self.searchModel.ratings:@"";
            return arrowCell;
        } else {
            RNHightSearchArrowTableViewCell *arrowCell = [tableView dequeueReusableCellWithIdentifier:hightSearchArrowIdentifier];
            arrowCell.contentLab.text = RNLocalized(@"List Diamonds");
            arrowCell.line.hidden = YES;
            arrowCell.detailLB.text = self.searchModel.dialist?self.searchModel.dialist:@"";
            return arrowCell;
        }
    } else {
        if (indexPath.row == 0) {
           cell.placehold = RNLocalized(@"Website");
           cell.field.text = self.searchModel.website;
        } else {
           cell.placehold = @"CDC ID";
           cell.line.hidden = YES;
           cell.field.text = self.searchModel.rapID;
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 2;
    } else {
        return 2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [UIView new];
    v.frame = CGRectMake(0, 0, App_Frame_Width, 10.f);
    v.backgroundColor = UIColorFromRGB(0xf8f8f8);
    return v;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:3 inSection:0]]) {
       __weak typeof(self)weakself = self;
        NSArray *list = @[@"All", @"Diamond Mannufacture/Cultter", @"Diamond Dealer/Broker", @"Diamond Mining", @"Jewelry Retail Chain", @"Indenpendent Jeweler", @"Online Jewelery Store", @"Jewelry Manufacturer", @"Designer", @"Gold Buyer", @"Refine", @"Appraiser", @"Laboratory", @"Auctioneer" ,@"Trade Association", @"Watch Dealer"];
        RNSingleChooseView *chooseView = [[RNSingleChooseView alloc] initWithDataSource:list chooseBlock:^(NSInteger index) {
            weakself.searchModel.comtype = [list objectAtIndex:index];
            [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        [chooseView show];
    } else if ([indexPath isEqual:[NSIndexPath indexPathForRow:0 inSection:2]]) {
        __weak typeof(self)weakself = self;
        NSArray *list = @[@"All", @"0", @"10", @"20", @"30", @"40", @"50", @"60", @"70", @"80", @"90", @"100"];
        RNSingleChooseView *chooseView = [[RNSingleChooseView alloc] initWithDataSource:list chooseBlock:^(NSInteger index) {
            weakself.searchModel.ratings = [list objectAtIndex:index];
            [weakself.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        [chooseView show];
    } else if ([indexPath isEqual:[NSIndexPath indexPathForRow:1 inSection:2]]) {
           __weak typeof(self)weakself = self;
           NSArray *list = @[@"All", @"Small", @"Medium", @"Large"];
           RNSingleChooseView *chooseView = [[RNSingleChooseView alloc] initWithDataSource:list chooseBlock:^(NSInteger index) {
               weakself.searchModel.dialist = [list objectAtIndex:index];
               [weakself.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
           }];
           [chooseView show];
    }
}



#pragma mark - RNPositionTableViewCellDelegate
- (void)onPositionTableViewCellCountryClick:(UIButton *)countryBtn {
    __weak typeof(self)weakself = self;
    [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/AppSearch?method=onload") parameters:@{@"lang" : [NSString stringWithFormat:@"%d", [RNLanguageManager shareManager].languageType]} success:^(id responseObject, ResponseState state) {
        NSLog(@"%@", responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            [weakself.allState removeAllObjects];
            [weakself.allCountry removeAllObjects];
            [weakself.allCity removeAllObjects];
            
            if (responseObject[@"allCity"]) {
                [weakself.allCity addObjectsFromArray:responseObject[@"allCity"]];
            }
            
            if (responseObject[@"allCountry"]) {
                [weakself.allCountry addObjectsFromArray:responseObject[@"allCountry"]];
            }
            
            if (responseObject[@"allState"]) {
                [weakself.allState addObjectsFromArray:responseObject[@"allState"]];
            }
            
            if (weakself.allCountry.count) {
                NSMutableArray *list = [NSMutableArray array];
                for (NSDictionary *dict in weakself.allCountry) {
                    [list addObject:dict[@"name"]];
                }
                
                RNSingleChooseView *chooseView = [[RNSingleChooseView alloc] initWithDataSource:list chooseBlock:^(NSInteger index) {
                    weakself.searchModel.country = [list objectAtIndex:index];
                    [countryBtn setTitle:[list objectAtIndex:index] forState:UIControlStateNormal];
                }];
                [chooseView show];
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)onPositionTableViewCellProviceBtnClick:(UIButton *)proviceBtn {
    __weak typeof(self)weakself = self;
    [HttpRequestTool   getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/CityAccessController?method=getAllCountry") parameters:@{} success:^(id responseObject, ResponseState state) {
        NSLog(@"%@", responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            [weakself.allState removeAllObjects];
            [weakself.allCountry removeAllObjects];
            [weakself.allCity removeAllObjects];
            
            if (responseObject[@"allCity"]) {
                [weakself.allCity addObjectsFromArray:responseObject[@"allCity"]];
            }
            
            if (responseObject[@"allCountry"]) {
                [weakself.allCountry addObjectsFromArray:responseObject[@"allCountry"]];
            }
            
            if (responseObject[@"allState"]) {
                [weakself.allState addObjectsFromArray:responseObject[@"allState"]];
            }
            
            if (weakself.allCountry.count) {
                NSMutableArray *list = [NSMutableArray array];
                for (NSDictionary *dict in weakself.allState) {
                    [list addObject:dict[@"name"]];
                }
                
                RNSingleChooseView *chooseView = [[RNSingleChooseView alloc] initWithDataSource:list chooseBlock:^(NSInteger index) {
                    weakself.searchModel.sheng = [list objectAtIndex:index];
                    [proviceBtn setTitle:[list objectAtIndex:index] forState:UIControlStateNormal];
                }];
                [chooseView show];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - RNHightSearchPeopleTableViewCellDelegate

- (void)onHightSearchPeopleTableViewCellEditChanged:(RNHightSearchPeopleTableViewCell *)cell {
    if ([cell.indexPath isEqual:[NSIndexPath indexPathForRow:0 inSection:0]]) {
        self.searchModel.comname = cell.field.text;
    } else if ([cell.indexPath isEqual:[NSIndexPath indexPathForRow:1 inSection:0]]) {
        self.searchModel.mname = cell.field.text;
    } else if ([cell.indexPath isEqual:[NSIndexPath indexPathForRow:2 inSection:0]]) {
        self.searchModel.comcode = cell.field.text;
    } else if ([cell.indexPath isEqual:[NSIndexPath indexPathForRow:1 inSection:1]]) {
        self.searchModel.city = cell.field.text;
    } else if ([cell.indexPath isEqual:[NSIndexPath indexPathForRow:2 inSection:1]]) {
        self.searchModel.phone = cell.field.text;
    } else if ([cell.indexPath isEqual:[NSIndexPath indexPathForRow:0 inSection:3]]) {
        self.searchModel.website = cell.field.text;
    } else if ([cell.indexPath isEqual:[NSIndexPath indexPathForRow:1 inSection:3]]) {
        self.searchModel.rapID = cell.field.text;
    }
}


- (RNHightSearchPeopleModel *)searchModel {
    if (!_searchModel) {
        _searchModel = [[RNHightSearchPeopleModel alloc] init];
    }
    return _searchModel;
}

- (NSMutableArray *)allCity {
    if (!_allCity) {
        _allCity = [NSMutableArray array];
    }
    return _allCity;
}

- (NSMutableArray *)allCountry {
    if (!_allCountry) {
        _allCountry = [NSMutableArray array];
    }
    return _allCountry;
}

- (NSMutableArray *)allState {
    if (!_allState) {
        _allState = [NSMutableArray array];
    }
    return _allState;
}
@end
