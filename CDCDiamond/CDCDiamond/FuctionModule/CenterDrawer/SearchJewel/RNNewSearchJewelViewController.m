//
//  RNNewSearchJewelViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/4.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNNewSearchJewelViewController.h"
#import "RNTrackJewelListViewController.h"
#import "RNMaoYiTableViewCell.h"
#import "RNXinZhuangTableViewCell.h"
#import "RNChiCunTableViewCell.h"
#import "RNYanSeTableViewCell.h"
#import "RNSearchCustomTableViewCell.h"
#import "RNYinGuangTableViewCell.h"
#import "RNWeizhiTableViewCell.h"
#import "RNJiaGeTableViewCell.h"
#import "RNXianShiTableViewCell.h"
#import "RNShiYanShiNumbTableViewCell.h"
#import "RNOnlyXianShiTableViewCell.h"
#import "RNYanseTableViewCell.h"
#import "RNMoreSearchTableViewCell.h"
#import "RNTrackJewelModel.h"
#import "RNOptionChooseView.h"

@interface RNNewSearchJewelViewController ()<RNMoreSearchTableViewCellDelegate, RNXinZhuangTableViewCellDelegate, RNChiCunTableViewCellDelegate, RNYanseTableViewCellDelegate, RNWeizhiTableViewCellDelegate, RNSearchCustomTableViewCellDelegate, RNOnlyXianShiTableViewCellDelegate, RNYinGuangTableViewCellDelegate, RNJiaGeTableViewCellDelegate>
{
    BOOL _isMoreSearch;
}
@end

@implementation RNNewSearchJewelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleIsMoreStatus];
    [self setupUI];
}

- (void)handleIsMoreStatus {
    if ([Utility isString:self.jewelModel.usercomid] || [Utility isString:self.jewelModel.gupcode] || [Utility isString:self.jewelModel.bottom] || [Utility isString:self.jewelModel.bottommax] || [Utility isString:self.jewelModel.depth] || [Utility isString:self.jewelModel.depthmax] || [Utility isString:self.jewelModel.chang] || [Utility isString:self.jewelModel.changmax] || [Utility isString:self.jewelModel.kuan] || [Utility isString:self.jewelModel.kuanmax] || [Utility isString:self.jewelModel.gao] || [Utility isString:self.jewelModel.gaomax] || [Utility isString:self.jewelModel.radio] || [Utility isString: self.jewelModel.radiomax] || [Utility isString:self.jewelModel.guanjiao] || [Utility isString:self.jewelModel.guanjiaomax] || [Utility isString:self.jewelModel.tingsheng] || [Utility isString:self.jewelModel.tingshengmax] || [Utility isString:self.jewelModel.tingjiao] || [Utility isString:self.jewelModel.tingjiaomax] || [Utility isString:self.jewelModel.reportfile] || [Utility isString:self.jewelModel.imgfile] || [Utility isString:self.jewelModel.videofile] || [Utility isString:self.jewelModel.eyeclean] || [Utility isString:self.jewelModel.waisttj] || [Utility isString:self.jewelModel.waisttjmax] || [Utility isString:self.jewelModel.centerinclusion] || [Utility isString:self.jewelModel.whiteinclusions] || [Utility isString:self.jewelModel.blackinclusions] || [Utility isString:self.jewelModel.jxhandle] || [Utility isString:self.jewelModel.bkhandle] || [Utility isString:self.jewelModel.gao] || [Utility isString:self.jewelModel.gaomax] || [Utility isString:self.jewelModel.diaNO] || [Utility isString:self.jewelModel.guangao] || [Utility isString:self.jewelModel.guangaomax] || [Utility isString:self.jewelModel.shadecos]) {
        _isMoreSearch = YES;
    }
}

- (void)reloadData {
    [self handleIsMoreStatus];
    [self.tableView reloadData];
}

- (void)setupUI {
    [self setupTableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-56);
    }];
    self.view.backgroundColor = UIColorFromRGB(0xf8f8f8);
    [self setupBottomView];
    [self.tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    [self.tableView registerClass:[RNXinZhuangTableViewCell class] forCellReuseIdentifier:xinZhuangCellIndetifier];
    [self.tableView registerClass:[RNChiCunTableViewCell class] forCellReuseIdentifier:chiCunTableViewCellIndenfier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNYanseTableViewCell" bundle:nil] forCellReuseIdentifier:yanSeTableViewCellIndenfier];
    
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:searchCustomTableViewCellIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:jingDuIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:xiuShiIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:qieKouIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:paoGuangIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:duiChengIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:jiBieIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:dengjiIndenfier];
    [self.tableView registerClass:[RNYinGuangTableViewCell class] forCellReuseIdentifier:yinGuangTableViewCellIndenfier];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RNWeizhiTableViewCell" bundle:nil] forCellReuseIdentifier:weiZhiTableViewCellIndenfier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNJiaGeTableViewCell" bundle:nil] forCellReuseIdentifier:jiaGeTableViewCellIndenfier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNOnlyXianShiTableViewCell" bundle:nil] forCellReuseIdentifier:onlyXianShiIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNMoreSearchTableViewCell" bundle:nil] forCellReuseIdentifier:moreSearchIdentifier];
}


- (void)setupBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(56);
    }];
    
    UIButton *leftBtn = [UIButton yz_buttonWithTitle:RNLocalized(@"Reset") titleColor:UIColorFromRGB(0x222222) textFont:[UIFont yz_PingFangSC_RegularFontOfSize:16]];
    leftBtn.layer.borderWidth = 1;
    leftBtn.layer.cornerRadius = 3.f;
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.borderColor = UIColorFromRGB(0xe6e6e6).CGColor;
    leftBtn.frame = CGRectMake(16, 8, 128, 40);
    [bottomView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [UIButton yz_buttonWithTitle:RNLocalized(@"Search") titleColor:UIColor.whiteColor textFont:[UIFont yz_PingFangSC_RegularFontOfSize:16]];
    rightBtn.layer.cornerRadius = 3.f;
    rightBtn.layer.masksToBounds = YES;
    rightBtn.backgroundColor = [RNGlobalUIStandard defaultMainColor];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame)+12, 8, (App_Frame_Width-32-12-128), 40);
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rightBtn];
}


- (void)requestForSearchJewel {
    self.jewelModel = [[RNSearchJewelModel alloc] init];
    
}

- (void)leftBtnClick {
    self.jewelModel = [[RNSearchJewelModel alloc] init];
    [self.tableView reloadData];
}

- (void)rightBtnClick {
    __weak typeof(self)weakself = self;
    [YZHubTool showLoadingStatus:RNLocalized(@"Loading")];
    NSMutableDictionary *parameters = [self.jewelModel getParameters];
    parameters[@"currentPage"] = @(self.page);
    parameters[@"currentLimit"] = @(defaultPageSize);
    NSLog(@"----------%@", parameters);
    [HttpRequestTool postWithURLString:[NSString stringWithFormat:@"%@bpdm/%@", BaseServer, _isMoreSearch == YES ?@"servlet/AppSearch?method=hignSearch":@"servlet/AppSearch?method=generalSearch"] parameters:parameters success:^(id responseObject, ResponseState state) {
        [YZHubTool hide];
        NSLog(@"%@", responseObject);
        NSMutableArray *muarray = [NSMutableArray array];
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *array = responseObject[@"list"];
            if (array && [array isKindOfClass:[NSArray class]]) {
                
                for (NSDictionary *dict in array) {
                    RNTrackJewelListModel *model = [RNTrackJewelListModel mj_objectWithKeyValues:dict];
                    [muarray addObject:model];
                }
                if (muarray.count) {
                    RNTrackJewelListViewController *jewelListVC = [[RNTrackJewelListViewController alloc] init];
                    jewelListVC.dataArray = muarray;
                    jewelListVC.isFromSearch = YES;
                    jewelListVC.isMoreSearch = self->_isMoreSearch;
                    jewelListVC.pragem = parameters;
                    [[Utility currentViewController].navigationController pushViewController:jewelListVC animated:YES];
                } else {
                   [YZHubTool showText:RNLocalized(@"No search data")];
                }
                
            }
        } 
    } failure:^(NSError *error) {
        [YZHubTool hide];
    }];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:xinZhuangCellIndetifier forIndexPath:indexPath];
        RNXinZhuangTableViewCell *xzCell = (RNXinZhuangTableViewCell *)cell;
        xzCell.delegate = self;
        xzCell.jewelModel = self.jewelModel;
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:chiCunTableViewCellIndenfier forIndexPath:indexPath];
        RNChiCunTableViewCell *ccCell = (RNChiCunTableViewCell *)cell;
        ccCell.delegate = self;
        ccCell.jewelModel = self.jewelModel;
    } else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:yanSeTableViewCellIndenfier forIndexPath:indexPath];
        RNYanseTableViewCell *ysCell = (RNYanseTableViewCell *)cell;
        ysCell.delegate = self;
        ysCell.jewelModel = self.jewelModel;
    } else if (indexPath.row == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:jingDuIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *jdCell = (RNSearchCustomTableViewCell *)cell;
        jdCell.delegate = self;
        jdCell.IdentifierString = jingDuIndenfier;
        jdCell.jewelModel = self.jewelModel;
    } else if (indexPath.row == 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:xiuShiIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *xsCell = (RNSearchCustomTableViewCell *)cell;
        xsCell.delegate = self;
        xsCell.IdentifierString = xiuShiIndenfier;
        xsCell.jewelModel = self.jewelModel;
    } else if (indexPath.row == 5) {
        cell = [tableView dequeueReusableCellWithIdentifier:qieKouIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *qgCell = (RNSearchCustomTableViewCell *)cell;
        qgCell.delegate = self;
        qgCell.IdentifierString = qieKouIndenfier;
        qgCell.jewelModel = self.jewelModel;
    } else if (indexPath.row == 6) {
        cell = [tableView dequeueReusableCellWithIdentifier:paoGuangIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *pgCell = (RNSearchCustomTableViewCell *)cell;
        pgCell.delegate = self;
        pgCell.IdentifierString = paoGuangIndenfier;
        pgCell.jewelModel = self.jewelModel;
    } else if (indexPath.row == 7) {
        cell = [tableView dequeueReusableCellWithIdentifier:duiChengIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *dcCell = (RNSearchCustomTableViewCell *)cell;
        dcCell.delegate = self;
        dcCell.IdentifierString = duiChengIndenfier;
        dcCell.jewelModel = self.jewelModel;
    } else if (indexPath.row == 8) {
        cell = [tableView dequeueReusableCellWithIdentifier:yinGuangTableViewCellIndenfier forIndexPath:indexPath];
        RNYinGuangTableViewCell *ygCell = (RNYinGuangTableViewCell *)cell;
        ygCell.delegate = self;
        ygCell.jewelModel = self.jewelModel;
    } else if (indexPath.row == 9) {
        cell = [tableView dequeueReusableCellWithIdentifier:dengjiIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *djCell = (RNSearchCustomTableViewCell *)cell;
        djCell.delegate = self;
        djCell.IdentifierString = dengjiIndenfier;
        djCell.jewelModel = self.jewelModel;
    } else if (indexPath.row == 10) {
        cell = [tableView dequeueReusableCellWithIdentifier:weiZhiTableViewCellIndenfier forIndexPath:indexPath];
        RNWeizhiTableViewCell *wzCell = (RNWeizhiTableViewCell *)cell;
        wzCell.delegate = self;
        wzCell.jewelModel = self.jewelModel;
    } else if (indexPath.row == 11) {
        cell = [tableView dequeueReusableCellWithIdentifier:jiaGeTableViewCellIndenfier forIndexPath:indexPath];
        RNJiaGeTableViewCell *ddjCell = (RNJiaGeTableViewCell *)cell;
        ddjCell.delegate = self;
        ddjCell.jewelModel = self.jewelModel;
    } else if (indexPath.row == 12) {
        cell = [tableView dequeueReusableCellWithIdentifier:onlyXianShiIdentifier forIndexPath:indexPath];
        RNOnlyXianShiTableViewCell *dxjCell = (RNOnlyXianShiTableViewCell *)cell;
        dxjCell.delegate = self;
        dxjCell.jewelModel = self.jewelModel;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:moreSearchIdentifier];
        RNMoreSearchTableViewCell *moreCell = (RNMoreSearchTableViewCell*)cell;
        moreCell.delegate = self;
        moreCell.moreContentView.hidden = !_isMoreSearch;
        moreCell.model = self.jewelModel;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 104.f;
    switch (indexPath.row) {
        case 0:
            height = 226.f;
            break;
        case 1:
            height = 85.f;
            break;
        case 2:
            height = (self.jewelModel.iscz == YES)?333.f:150.f;
            break;
        case 3:
            height = 104.f;
            break;
        case 8:
            height = 198.f;
            break;
        case 10:
        {
            height = 174.f;
            NSArray *array = @[];
            if ([Utility isString:self.jewelModel.loction]) {
                array = [self.jewelModel.loction componentsSeparatedByString:@","];
                if (array && [array isKindOfClass:[NSArray class]] && array.count) {
                    height = 174.f + 44 * array.count;
                }
            }
        }
            break;
        case 11:
            height = 122.f;
            break;
        case 12:
            height = 211.f;
            break;
        case 13:
            height = _isMoreSearch?1705:54;
            break;
        default:
            break;
    }
    return height;
}


#pragma mark - RNXinZhuangTableViewCellDelegate

- (void)onXinZhuangTableViewCellSeletedShape:(NSArray *)shape {
    self.jewelModel.shape = [shape componentsJoinedByString:@","];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

#pragma mark - RNChiCunTableViewCellDelegate

- (void)onChiCunTableViewCellMinInput:(NSString *)minInput maxInput:(NSString *)maxInput {
    self.jewelModel.size = minInput;
    self.jewelModel.maxsize = maxInput;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

#pragma mark - RNYanseTableViewCellDelegate

- (void)onYanseTableViewCellIsColorDiamondsClick:(id )model {
    self.jewelModel = model;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)onYanseTableViewCellBetifulClickWhiteClickColors:(NSArray *)colors {
    self.jewelModel.fancyccolor1 = [colors componentsJoinedByString:@","];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onYanseTableViewCellBetifulClickWhiteClickQiangDu:(NSArray *)qiangDu {
    self.jewelModel.fancyccolorimenstfy = [qiangDu componentsJoinedByString:@","];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onYanseTableViewCellBetifulClickWhiteClickBnanse:(NSArray *)banse {
    self.jewelModel.fancyccolorovertone = [banse componentsJoinedByString:@","];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onYanseTableViewCellBetifulClickWhiteClickYanse:(NSArray *)yanse {
    self.jewelModel.color = [yanse componentsJoinedByString:@","];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

#pragma mark - RNWeizhiTableViewCellDelegate

- (void)onWeizhiTableViewCellPositionTypeClick:(int)positionType {
    self.jewelModel.loctiontype = [NSString stringWithFormat:@"%d", positionType];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:10 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)onWeizhiTableViewCellAddPostionClick:(RNWeizhiTableViewCell *)cell {
    __weak typeof(self)weakself = self;
    [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/AppSearch?method=onload") parameters:@{@"lang" : [NSString stringWithFormat:@"%d", [RNLanguageManager shareManager].languageType]} success:^(id responseObject, ResponseState state) {
        NSLog(@"%@", responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSMutableArray *allCountry = [NSMutableArray array];
            
            if (responseObject[@"allCountry"]) {
                [allCountry addObjectsFromArray:responseObject[@"allCountry"]];
            }

            if (allCountry.count) {
                NSMutableArray *list = [NSMutableArray array];
                NSMutableDictionary *mudict = [NSMutableDictionary dictionary];
                for (NSDictionary *dict in allCountry) {
                    [list addObject:dict[@"name"]];
                    [mudict setValue:dict[@"code"] forKey:dict[@"name"]];
                }
                [RNUserInfo shareUserInfo].countryMap = mudict;
                [[RNUserInfo shareUserInfo] save];
                RNOptionChooseView *chooseView = [[RNOptionChooseView alloc] initWithTopSpace:120 searchAvaliable:YES];
                [chooseView showWithDataSource:list chooseBlock:^(NSArray * _Nonnull array) {
                    NSMutableArray *loctions = [NSMutableArray array];
                    for (NSNumber *number in array) {
                        [loctions addObject:list[[number integerValue]]];
                    }
                    weakself.jewelModel.loction = [loctions componentsJoinedByString:@","];
                    [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:10 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    if (weakself.callBack) {
                        weakself.callBack(weakself.jewelModel);
                    }
                } defaultArray:@[]];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)onWeizhiTableViewCellSellEnableClick:(RNWeizhiTableViewCell *)cell {
    self.jewelModel.isavalible = [NSString stringWithFormat:@"%@", cell.checkBoxBtn.isSelected == YES?@"true":@"false"];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

- (void)onWeizhiTableViewCellAddressChanged:(NSMutableArray *)addressList {
    self.jewelModel.loction = [addressList componentsJoinedByString:@","];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:10 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

#pragma mark - RNJiaGeTableViewCellDelegate

- (void)onjiaGeTableViewCellDidChooseJiage:(NSString *)type {
    self.jewelModel.pricetype = [NSString stringWithFormat:@"%@", type];
}
- (void)onjiaGeTableViewCellDidChooseJiageMinprice:(NSString *)minprice {
    self.jewelModel.pricemin = minprice;
}
- (void)onjiaGeTableViewCellDidChooseJiageMaxprice:(NSString *)maxprice {
    self.jewelModel.pricemax = maxprice;
}

#pragma mark - RNOnlyXianShiTableViewCellDelegate

- (void)onOnlyXianShiTableViewCellDidChooseSuppier:(RNSearchJewelModel *)jewelModel {
    self.jewelModel = jewelModel;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

#pragma mark - RNSearchCustomTableViewCellDelegate

- (void)onsearchCustomeTableViewCellDidChooseJingDu:(NSArray *)jd {
    self.jewelModel.clarity = [jd componentsJoinedByString:@","];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

- (void)onsearchCustomeTableViewCellDidChooseQieGe:(NSArray *)qg {
    self.jewelModel.cut = [qg componentsJoinedByString:@","];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

- (void)onsearchCustomeTableViewCellDidChoosePaoGuang:(NSArray *)pg {
    self.jewelModel.polished = [pg componentsJoinedByString:@","];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

- (void)onsearchCustomeTableViewCellDidChooseDuiCheng:(NSArray *)dc {
    self.jewelModel.symmetrical = [dc componentsJoinedByString:@","];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

- (void)onsearchCustomeTableViewCellDidChooseDengJi:(NSArray *)dj {
    self.jewelModel.jiandingsuo = [dj componentsJoinedByString:@","];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

- (void)onsearchYinGuangTableViewCellDidChooseYingGuangQiangdu:(NSArray *_Nullable)dd {
    self.jewelModel.fluorescent = [dd componentsJoinedByString:@","];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onsearchYinGuangTableViewCellDidChooseYingGuangYanse:(NSArray *_Nullable)yanse {
    self.jewelModel.fluorescentcorol = [yanse componentsJoinedByString:@","];
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

- (void)onsearchCustomeTableViewCellDidXiushi:(NSArray *)xs {
    if (xs && [xs isKindOfClass:[NSArray class]] && [xs count]) {
        int index = [[xs lastObject] intValue];
        if (index == 1) {
            self.jewelModel.cut = @"Ideal,Excellent";
            self.jewelModel.polished = @"Ideal,Excellent";
            self.jewelModel.symmetrical = @"Ideal,Excellent";
        } else if (index == 2) {
            self.jewelModel.cut = @"Ideal,Very Good";
            self.jewelModel.polished = @"Ideal,Very Good";
            self.jewelModel.symmetrical = @"Ideal,Very Good";
        } else if (index == 3) {
            self.jewelModel.cut = @"Ideal,Excellent";
            self.jewelModel.polished = @"Ideal,Very Good";
            self.jewelModel.symmetrical = @"Ideal,Very Good";
        }
        [self.tableView reloadData];
        if (self.callBack) {
            self.callBack(self.jewelModel);
        }
    }
    
}

#pragma mark - RNMoreSearchTableViewCellDelegate

- (void)moreSearchTableViewCellDidClickMoreBtn:(RNMoreSearchTableViewCell *)cell {
    _isMoreSearch = YES;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:13 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)onSearchMoreRapIDChanged:(NSString *)text {
    self.jewelModel.usercomid = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

- (void)onSearchMoreStockChaned:(NSString *)text {
    self.jewelModel.gupcode = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMinTaimainChanged:(NSString *)text {
    self.jewelModel.bottom = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMaxTaimainChanged:(NSString *)text {
    self.jewelModel.bottommax = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMinshenduChanged:(NSString *)text {
    self.jewelModel.depth = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMaxshenduChanged:(NSString *)text {
    self.jewelModel.depthmax = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMinchangChanged:(NSString *)text {
    self.jewelModel.chang = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMaxchangChanged:(NSString *)text {
    self.jewelModel.changmax = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMinkuanduChanged:(NSString *)text {
    self.jewelModel.kuan = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMaxkuanduChanged:(NSString *)text {
    self.jewelModel.kuanmax = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMinshengduChaned:(NSString *)text {
    self.jewelModel.gao = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMaxshengduChaned:(NSString *)text {
    self.jewelModel.gaomax = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMinbiliChanged:(NSString *)text {
    self.jewelModel.radio = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMaxbiliChanged:(NSString *)text {
    self.jewelModel.radiomax = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMinguanjiaoChanged:(NSString *)text {
    self.jewelModel.guanjiao = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMaxguanjiaoChanged:(NSString *)text {
    self.jewelModel.guanjiaomax = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMindishenChaned:(NSString *)text {
    self.jewelModel.tingsheng = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMaxdishenChaned:(NSString *)text {
    self.jewelModel.tingshengmax = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMindijiaoChanged:(NSString *)text {
    self.jewelModel.tingjiao = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMaxdijiaoChanged:(NSString *)text {
    self.jewelModel.tingjiaomax = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchSaomiaoChanged:(NSString *)text {
    self.jewelModel.reportfile = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchJewelImgChanged:(NSString *)text {
    self.jewelModel.imgfile = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchVideoEnable:(NSString *)text {
    self.jewelModel.videofile = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchEyeChanged:(NSString *)text {
    self.jewelModel.eyeclean = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMinyaoweiChanged:(NSString *)text {
    self.jewelModel.waisttj = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMaxyaoweiChanged:(NSString *)text {
    self.jewelModel.waisttjmax = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchNeihanChanged:(NSString *)text {
    self.jewelModel.centerinclusion = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchWhiteNeihanChanged:(NSString *)text {
    self.jewelModel.whiteinclusions = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchBlackNeihanChanged:(NSString *)text {
    self.jewelModel.blackinclusions = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMinhundunChanged:(NSString *)text {
//    self.jewelModel.blackinclusions = text;
//    if (self.callBack) {
//        self.callBack(self.jewelModel);
//    }
}
- (void)onSearchMaxhundunChanged:(NSString *)text {
//    self.jewelModel.blackinclusions = text;
//    if (self.callBack) {
//        self.callBack(self.jewelModel);
//    }
}
- (void)onSearchYichuliChanged:(NSString *)text {
    self.jewelModel.jxhandle = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchHanYichuliChanged:(NSString *)text {
    self.jewelModel.bkhandle = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMinGaoChanged:(NSString *)text {
    self.jewelModel.gao = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMaxGaoChanged:(NSString *)text {
    self.jewelModel.gaomax = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchBianhaoChanged:(NSString *)text {
    self.jewelModel.diaNO = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

- (void)onSearchMinGuanGaoChanged:(NSString *)text {
    self.jewelModel.guangao = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}
- (void)onSearchMaxGuanGaoChanged:(NSString *)text {
    self.jewelModel.guangaomax = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

- (void)onSearchShadowChanged:(NSString *)text {
    self.jewelModel.shadecos = text;
    if (self.callBack) {
        self.callBack(self.jewelModel);
    }
}

- (RNSearchJewelModel *)jewelModel {
    if (!_jewelModel) {
        _jewelModel = [[RNSearchJewelModel alloc] init];
    }
    return _jewelModel;
}

@end
