//
//  RNRegisterViewController.m
//  CDCDiamond
//
//  Created by Frank on 2020/3/27.
//  Copyright © 2020 Frank. All rights reserved.
//

#import "RNRegisterViewController.h"
#import "RNRegisterView.h"
#import "ZTObtainPhotoTool.h"
#import "PopoverView.h"
#import "RNRegisterProtocolViewController.h"


@interface RNRegisterViewController ()<UIActionSheetDelegate>

@property (nonatomic, strong) RNRegisterView *registerView;

@property (nonatomic, strong) UIImage *nameCardImg;
@property (nonatomic, strong) UIImage *idCardImg;
@property (nonatomic, strong) UIImage *certificateImg;
@property (nonatomic, strong) RNRegisterModel *registerModel;
@property (nonatomic, strong) UIButton *rightBarBtn;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, assign) int index;
@end

@implementation RNRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBottomView];
    [self setupRightBarButton];
    [self setupRegisterView];
}

- (void)leftBtnClick {
    [self setupRegisterView];
    self.registerModel = [[RNRegisterModel alloc] init];
    self.nameCardImg = nil;
    self.idCardImg = nil;
    self.certificateImg = nil;
    self.registerView.registerModel = self.registerModel;
}

- (void)rightBtnClick {
    if ([self conditionalStatements]) {
            NSMutableDictionary *parameters = [[self.registerView.registerModel mj_keyValues] mutableCopy];
        if (self.nameCardImg) {
            [parameters setValue:[self encodeToBase64String:self.nameCardImg] forKey:@"fileb"];
        }
        if (self.idCardImg) {
            [parameters setValue:[self encodeToBase64String:self.idCardImg] forKey:@"filea"];
        }
        if (self.certificateImg) {
            [parameters setValue:[self encodeToBase64String:self.certificateImg] forKey:@"filec"];
        }
        
        RNRegisterProtocolViewController *vc = [[RNRegisterProtocolViewController alloc] initWithProgram:parameters];
        [self.navigationController pushViewController:vc animated:YES];

    }
}

- (void)rightBarBtnClick:(UIButton *)sender {
    NSArray *titles = @[RNLocalized(@"Ensglish"), RNLocalized(@"Chinese(Simplified)"), RNLocalized(@"Chinese(Traditional)")];
    PopoverView *popveView = [PopoverView popoverView];
    popveView.showShade = YES;
    NSMutableArray *array = [NSMutableArray array];
    __weak typeof(self)weakself = self;
    for (NSString *str in titles) {
        PopoverAction *action  = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action) {
            NSInteger index = [titles indexOfObject:action.title];
            if (index == 0) {
                [[RNLanguageManager shareManager] setLanguageForEnglish];
            } else if (index == 1) {
                [[RNLanguageManager shareManager] setLanguageForChinese];
            } else if (index == 2) {
                [[RNLanguageManager shareManager] setLanguageForSimplified];
            }
            [weakself setupRegisterView];
        }];
        [array addObject:action];
    }
    [popveView showToView:sender withActions:array];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [actionSheet removeFromSuperview];
    __weak typeof(self)weakself = self;
    if (buttonIndex == 0) {
       
        [[ZTObtainPhotoTool shareObtainPhotoTool] show:self sourceType:0 photoEditType:JTPhotoEditTypeNormal success:^(UIImage *image) {
            if (weakself.index == 1) {
                weakself.nameCardImg = image;
                [weakself.registerView.nameCardBtn setBackgroundImage:image forState:UIControlStateNormal];
            } else if (weakself.index == 2) {
                weakself.idCardImg = image;
                [weakself.registerView.idCardBtn setBackgroundImage:image forState:UIControlStateNormal];
            } else if (weakself.index == 3) {
                weakself.certificateImg = image;
                [weakself.registerView.certificateBtn setBackgroundImage:image forState:UIControlStateNormal];
            }
           
        } cancel:^{
            
        }];
    } else if (buttonIndex == 1) {
        
        [[ZTObtainPhotoTool shareObtainPhotoTool] show:self sourceType:1 photoEditType:JTPhotoEditTypeNormal success:^(UIImage *image) {
           if (weakself.index == 1) {
               weakself.nameCardImg = image;
               [weakself.registerView.nameCardBtn setBackgroundImage:image forState:UIControlStateNormal];
           } else if (weakself.index == 2) {
               weakself.idCardImg = image;
               [weakself.registerView.idCardBtn setBackgroundImage:image forState:UIControlStateNormal];
           } else if (weakself.index == 3) {
               weakself.certificateImg = image;
               [weakself.registerView.certificateBtn setBackgroundImage:image forState:UIControlStateNormal];
           }
        } cancel:^{
                
           
        }];
    }
}


- (void)setupRegisterView {
    self.title = RNLocalized(@"Member Register");
    [self.leftBtn setTitle:RNLocalized(@"Reset") forState:UIControlStateNormal];
    [self.rightBtn setTitle:RNLocalized(@"Next") forState:UIControlStateNormal];
    
    
    if ([RNLanguageManager shareManager].languageType == 0) {
         [self setBtnTitle:RNLocalized(@"Chinese(Simplified)")];
     } else if ([RNLanguageManager shareManager].languageType == 1) {
         [self setBtnTitle:RNLocalized(@"Chinese(Traditional)")];
     } else {
         [self setBtnTitle:RNLocalized(@"Ensglish")];
     }
    /**init view  / model*/
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[RNRegisterView class]]) {
            [subView removeFromSuperview];
        }
    }
    
    self.registerView = [[RNRegisterView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height-56-kStatusBarHeight-kTopBarHeight)];
    [self.view addSubview:self.registerView];
    self.registerView.registerModel = self.registerModel;
    __weak typeof(self)weakself = self;
    self.registerView.coverBlock = ^(int index) {
       UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:RNLocalized(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:RNLocalized(@"Take Pictures"), RNLocalized(@"Select From Album"), nil];//按钮显示可以设置多个按钮显示
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;//设置样式
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
        weakself.index = index;
    };
    
    [self.view bringSubviewToFront:self.bottomView];
}

- (void)setupBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
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
    self.leftBtn = leftBtn;
    [bottomView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [UIButton yz_buttonWithTitle:RNLocalized(@"Register") titleColor:UIColor.whiteColor textFont:[UIFont yz_PingFangSC_RegularFontOfSize:16]];
    rightBtn.layer.cornerRadius = 3.f;
    rightBtn.layer.masksToBounds = YES;
    rightBtn.backgroundColor = [RNGlobalUIStandard defaultMainColor];
    rightBtn.frame = CGRectMake(CGRectGetMaxX(leftBtn.frame)+12, 8, (App_Frame_Width-32-12-128), 40);
    self.rightBtn = rightBtn;
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rightBtn];
}

- (void)setupRightBarButton {
    UIButton *rightBarBtn = [UIButton yz_buttonWithTitle:@"" titleColor:[RNGlobalUIStandard defaultTableViewTextColor] textFont:[UIFont yz_PingFangSC_MediumFontOfSize:12]];
    rightBarBtn.frame = CGRectMake(120, 0, 160, 40);
    rightBarBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBarBtn addTarget:self action:@selector(rightBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBarBtn = rightBarBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBarBtn];
    
}


- (NSString*)encodeToBase64String:(UIImage*)image {
   return [@"data:image/png;base64," stringByAppendingString:[UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
}

- (void)setBtnTitle:(NSString *)title {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.bounds = CGRectMake(0, -2, 12, 12);
    attach.image = [UIImage imageNamed:@"nav_icon_arrowdown"];
    NSAttributedString *strAtt = [NSAttributedString attributedStringWithAttachment:attach];
    [attributedString appendAttributedString:strAtt];
    [self.rightBarBtn setAttributedTitle:attributedString forState:UIControlStateNormal];
}


- (BOOL)conditionalStatements {
    if (!KFormat(self.registerView.registerModel.usernameFirst).length || !KFormat(self.registerView.registerModel.usernameLast).length) {
        [YZHubTool showText:RNLocalized(@"The English name cannot Be empty")];
        return NO;
    }
    
    if ([Utility IsChinese:KFormat(self.registerView.registerModel.usernameFirst)] || [Utility IsChinese:KFormat(self.registerView.registerModel.usernameLast)]) {
        [YZHubTool showText:RNLocalized(@"Name must be in English")];
        return NO;
    }
    
    if (!KFormat(self.registerView.registerModel.address3).length || !KFormat(self.registerView.registerModel.phone).length) {
        [YZHubTool showText:RNLocalized(@"he phone number cannot be empty")];
        return NO;
    }
    
    if (!KFormat(self.registerView.registerModel.Gender).length) {
        [YZHubTool showText:RNLocalized(@"Gender cannot be empty")];
        return NO;
    }
    
    if (!KFormat(self.registerView.registerModel.email).length) {
        [YZHubTool showText:RNLocalized(@"E-mail can not be empty")];
        return NO;
    }
    
    if (![Utility isEmail:KFormat(self.registerView.registerModel.email)]) {
        [YZHubTool showText:RNLocalized(@"Email entered incorrectly")];
        return NO;
    }
    
    if (!KFormat(self.registerView.registerModel.comname).length) {
        [YZHubTool showText:RNLocalized(@"The Company Name Cannot Be Empty")];
        return NO;
    }
    
    if (KFormat(self.registerView.registerModel.comname).length < 3 || KFormat(self.registerView.registerModel.comname).length > 8) {
        [YZHubTool showText:RNLocalized(@"The Company Abbreviation Length Can Only Be 3-8 Characters")]; return NO;
    }
    
    if (!KFormat(self.registerView.registerModel.country).length) {
        [YZHubTool showText:RNLocalized(@"Please Select Location")];
        return NO;
    }
    
    if (!KFormat(self.registerView.registerModel.city).length) {
        [YZHubTool showText:RNLocalized(@"City cannot be empty")];
        return NO;
    }
    
    if (!KFormat(self.registerView.registerModel.position).length) {
        [YZHubTool showText:RNLocalized(@"Position cannot be empty")];
        return NO;
    }
    
    if (!KFormat(self.registerView.registerModel.address).length) {
        [YZHubTool showText:RNLocalized(@"The address cannot be Empty")];
        return NO;
    }
    
    if (!self.certificateImg) {
        [YZHubTool showText:RNLocalized(@"Company certificate cannot be empty")];
        return NO;
    }
    return YES;
}

- (RNRegisterModel *)registerModel {
    if (!_registerModel) {
        _registerModel = [[RNRegisterModel alloc] init];
    }
    return _registerModel;
}
@end
