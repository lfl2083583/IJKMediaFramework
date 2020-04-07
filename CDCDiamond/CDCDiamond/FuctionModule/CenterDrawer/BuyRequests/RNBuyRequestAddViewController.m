//
//  RNBuyRequestAddViewController.m
//  RapNet
//
//  Created by jt on 2019/11/10.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNBuyRequestAddViewController.h"
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
#import "HttpRequestTool.h"
#import "RNBuyRequestAddTableViewCell.h"
#import "RNBuyRequestAddModel.h"
#import "RNBuyRequestsViewController.h"

@interface RNBuyRequestAddViewController ()<RNXinZhuangTableViewCellDelegate, RNChiCunTableViewCellDelegate, RNYanseTableViewCellDelegate, RNJiaGeTableViewCellDelegate, RNSearchCustomTableViewCellDelegate>

@property (nonatomic, assign) int positionType;


@end

@implementation RNBuyRequestAddViewController

- (void)setIsEdite:(BOOL)isEdite {
    _isEdite = isEdite;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.isEdite?RNLocalized(@"Edit Request"):RNLocalized(@"Add Request");
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    [self setupTableView];
    [self.tableView setFrame:CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height-56-kStatusBarHeight-kTopBarHeight)];
    self.view.backgroundColor = UIColorFromRGB(0xf8f8f8);
    [self setupBottomView];
    [self.tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    [self.tableView setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:searchCustomTableViewCellIndenfier];
    [self.tableView registerClass:[RNXinZhuangTableViewCell class] forCellReuseIdentifier:xinZhuangCellIndetifier];
    [self.tableView registerClass:[RNChiCunTableViewCell class] forCellReuseIdentifier:chiCunTableViewCellIndenfier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNYanseTableViewCell" bundle:nil] forCellReuseIdentifier:yanSeTableViewCellIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:jingDuIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:qieKouIndenfier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNJiaGeTableViewCell" bundle:nil] forCellReuseIdentifier:jiaGeAddRequestCellIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:paoGuangIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:duiChengIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:yaoweiIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:jiandiIndenfier];
    [self.tableView registerClass:[RNSearchCustomTableViewCell class] forCellReuseIdentifier:chuliIndenfier];
    [self.tableView registerNib:[UINib nibWithNibName:@"RNBuyRequestAddTableViewCell" bundle:nil] forCellReuseIdentifier:buyRequestAddTableViewCellIdentideir];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:xinZhuangCellIndetifier forIndexPath:indexPath];
        RNXinZhuangTableViewCell *xzCell = (RNXinZhuangTableViewCell *)cell;
        xzCell.addModel = self.model;
        xzCell.delegate = self;
        xzCell.singleEnable = YES;
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:chiCunTableViewCellIndenfier forIndexPath:indexPath];
        RNChiCunTableViewCell *ccCell = (RNChiCunTableViewCell *)cell;
        ccCell.delegate = self;
        ccCell.addModel = self.model;
    } else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:yanSeTableViewCellIndenfier forIndexPath:indexPath];
        RNYanseTableViewCell *ysCell = (RNYanseTableViewCell *)cell;
        ysCell.delegate = self;
        ysCell.addModel = self.model;
        ysCell.singleEnable = YES;
    } else if (indexPath.row == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:jingDuIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *jdCell = (RNSearchCustomTableViewCell *)cell;
        jdCell.delegate = self;
        jdCell.IdentifierString = jingDuIndenfier;
        jdCell.addModel = self.model;
        jdCell.singleEnable = YES;
    } else if (indexPath.row == 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:qieKouIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *xsCell = (RNSearchCustomTableViewCell *)cell;
        xsCell.delegate = self;
        xsCell.IdentifierString = qieKouIndenfier;
        xsCell.addModel = self.model;
    } else if (indexPath.row == 5) {
        cell = [tableView dequeueReusableCellWithIdentifier:jiaGeAddRequestCellIndenfier forIndexPath:indexPath];
        RNJiaGeTableViewCell *djCell = (RNJiaGeTableViewCell *)cell;
        djCell.delegate = self;
        djCell.addModel = self.model;
    } else if (indexPath.row == 6) {
        cell = [tableView dequeueReusableCellWithIdentifier:paoGuangIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *pgCell = (RNSearchCustomTableViewCell *)cell;
        pgCell.delegate = self;
        pgCell.IdentifierString = paoGuangIndenfier;
        pgCell.addModel = self.model;
    } else if (indexPath.row == 7) {
        cell = [tableView dequeueReusableCellWithIdentifier:duiChengIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *dcCell = (RNSearchCustomTableViewCell *)cell;
        dcCell.delegate = self;
        dcCell.IdentifierString = duiChengIndenfier;
        dcCell.addModel = self.model;
    } else if (indexPath.row == 8) {
        cell = [tableView dequeueReusableCellWithIdentifier:yaoweiIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *ygCell = (RNSearchCustomTableViewCell *)cell;
        ygCell.delegate = self;
        ygCell.IdentifierString = yaoweiIndenfier;
        ygCell.addModel = self.model;
    } else if (indexPath.row == 9) {
        cell = [tableView dequeueReusableCellWithIdentifier:jiandiIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *djCell = (RNSearchCustomTableViewCell *)cell;
        djCell.delegate = self;
        djCell.IdentifierString = jiandiIndenfier;
        djCell.addModel = self.model;
    } else if (indexPath.row == 10) {
        cell = [tableView dequeueReusableCellWithIdentifier:chuliIndenfier forIndexPath:indexPath];
        RNSearchCustomTableViewCell *chuliCell = (RNSearchCustomTableViewCell *)cell;
        chuliCell.delegate = self;
        chuliCell.IdentifierString = chuliIndenfier;
        chuliCell.addModel = self.model;
    }  else if (indexPath.row == 11){
        __weak typeof(self)weakself = self;
        cell = [tableView dequeueReusableCellWithIdentifier:buyRequestAddTableViewCellIdentideir];
        RNBuyRequestAddTableViewCell *addCell = (RNBuyRequestAddTableViewCell *)cell;
        addCell.callBack = ^(RNBuyRequestAddModel * _Nonnull model) {
            weakself.model = model;
        };
        addCell.model = self.model;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:searchCustomTableViewCellIndenfier forIndexPath:indexPath];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 104.f;
    switch (indexPath.row) {
        case 0:
            height = 200.f;
            break;
        case 1:
            height = 85.f;
            break;
        case 2:
            height = ([[NSString stringWithFormat:@"%@", self.model.F_ISCZ] isEqualToString:@"true"] || [[NSString stringWithFormat:@"%@", self.model.F_ISCZ] isEqualToString:@"1"])?333.f:150.f;
            break;
        case 3:
            height = 104.f;
            break;
        case 5:
            height = 122.f;
            break;
        case 11:
            height = 1085;
            break;
        default:
            break;
    }
    return height;
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
    leftBtn.layer.borderColor = UIColorFromRGB(0xe6e6e6).CGColor;
    leftBtn.frame = CGRectMake(16, 8, 128, 40);
    [bottomView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [UIButton yz_buttonWithTitle:self.isEdite?RNLocalized(@"Save Request"):RNLocalized(@"Add Request") titleColor:UIColor.whiteColor textFont:[UIFont yz_PingFangSC_RegularFontOfSize:16]];
    rightBtn.backgroundColor = [RNGlobalUIStandard defaultMainColor];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame)+12, 8, (App_Frame_Width-32-12-128), 40);
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rightBtn];
}

- (void)leftBtnClick {
    self.model = [[RNBuyRequestAddModel alloc] init];
    [self.tableView reloadData];
}


- (void)rightBtnClick {
    NSLog(@"-------------------%@", [self.model getParameters]);
    [YZHubTool showLoadingStatus:RNLocalized(@"Loading")];
    __weak typeof(self)weakself = self;
    [HttpRequestTool postWithURLString:KStringFormat(BaseServer, self.isEdite?@"bpdm/servlet/PurchaseServlet?method=updateApp":@"bpdm/servlet/PurchaseServlet?method=addApp") parameters:[self.model getParameters] success:^(id responseObject, ResponseState state) {
        [YZHubTool showSuccessText:weakself.isEdite?RNLocalized(@"Save success"):RNLocalized(@"Add success")];
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *array = responseObject[@"list"];
            if (array && [array isKindOfClass:[NSArray class]]) {
                NSMutableArray *muarray = [NSMutableArray array];
                for (NSDictionary *dict in array) {
                    RNTrackJewelListModel *model = [RNTrackJewelListModel mj_objectWithKeyValues:dict];
                    [muarray addObject:model];
                }
            }
        }
        RNBuyRequestsViewController *requestVc = [[RNBuyRequestsViewController alloc] initIsFromSideMenue:NO seletedIndex:1];
        [[Utility currentViewController].navigationController pushViewController:requestVc animated:YES];
    } failure:^(NSError *error) {
        [YZHubTool hide];
    }];
    
}

#pragma mark - RNXinZhuangTableViewCellDelegate

- (void)onXinZhuangTableViewCellSeletedShape:(NSArray *)shape {
    self.model.F_SHAPE = [shape componentsJoinedByString:@","];
}
#pragma mark - RNYanseTableViewCellDelegate

- (void)onYanseTableViewCellIsColorDiamondsClick:(id )model {
    self.model = model;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)onYanseTableViewCellBetifulClickWhiteClickColors:(NSArray *)colors {
    self.model.F_FANCYCCOLOR1 = [colors componentsJoinedByString:@","];
}
- (void)onYanseTableViewCellBetifulClickWhiteClickQiangDu:(NSArray *)qiangDu {
    self.model.F_FANCYCCOLORIMENSTFY = [qiangDu componentsJoinedByString:@","];
}
- (void)onYanseTableViewCellBetifulClickWhiteClickBnanse:(NSArray *)banse {
    self.model.F_FANCYCCOLOROVERTONE = [banse componentsJoinedByString:@","];
}
- (void)onYanseTableViewCellBetifulClickWhiteClickYanse:(NSArray *)yanse {
    self.model.F_COLOR = [yanse componentsJoinedByString:@","];
}


#pragma mark - RNChiCunTableViewCellDelegate

- (void)onChiCunTableViewCellMinInput:(NSString *)minInput maxInput:(NSString *)maxInput {
    self.model.F_SIZEMIN = minInput;
    self.model.F_SIZE = maxInput;
}
#pragma mark - RNJiaGeTableViewCellDelegate
- (void)onjiaGeTableViewCellDidChooseJiage:(NSString *)type {
    self.model.F_PRICE = type;
}
- (void)onjiaGeTableViewCellDidChooseJiageMinprice:(NSString *)minprice {
    self.model.F_PRICETOTALMIN = minprice;
}
- (void)onjiaGeTableViewCellDidChooseJiageMaxprice:(NSString *)maxprice {
    self.model.F_PRICETOTAL = maxprice;
}

#pragma mark - RNSearchCustomTableViewCellDelegate
- (void)onsearchCustomeTableViewCellDidChooseJingDu:(NSArray *)jd {
    self.model.F_CLARITY = [jd componentsJoinedByString:@","];
}
- (void)onsearchCustomeTableViewCellDidChooseQieGe:(NSArray *)qg {
    self.model.F_CUT = [qg componentsJoinedByString:@","];
}
- (void)onsearchCustomeTableViewCellDidChoosePaoGuang:(NSArray *)pg {
    self.model.F_POLISHED = [pg componentsJoinedByString:@","];
}
- (void)onsearchCustomeTableViewCellDidChooseDuiCheng:(NSArray *)dc {
    self.model.F_SYMMETRICAL = [dc componentsJoinedByString:@","];
}
- (void)onsearchCustomeTableViewCellDidChooseYaowei:(NSArray *)yw {
    self.model.F_WAISTTJ = [yw componentsJoinedByString:@","];
}
- (void)onsearchCustomeTableViewCellDidChooseJiandi:(NSArray *)jd {
    self.model.F_LOWTIPTJ = [jd componentsJoinedByString:@","];
}
- (void)onsearchCustomeTableViewCellDidChooseChuli:(NSArray *)cl {
    self.model.F_HANDLE = [cl componentsJoinedByString:@","];
}

- (RNBuyRequestAddModel *)model {
    if (!_model) {
        _model = [[RNBuyRequestAddModel alloc] init];
    }
    return _model;
}

@end
