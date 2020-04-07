//
//  RNRegisterView.m
//  CDCDiamond
//
//  Created by Frank on 2020/3/27.
//  Copyright © 2020 Frank. All rights reserved.
//

#import "RNRegisterView.h"
#import "RNMagicField.h"
#import "RNAddPhotoView.h"
#import "ZTObtainPhotoTool.h"
#import "PopoverView.h"
#import "RNSingleChooseView.h"

@interface RNRegisterView ()

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) RNMagicField *firstNameTF;
@property (nonatomic, strong) RNMagicField *lastNameTF;
@property (nonatomic, strong) RNMagicField *alisTF;
@property (nonatomic, strong) RNMagicField *sexTF;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *phoneRgTF;
@property (nonatomic, strong) RNMagicField *companyNameTF;
@property (nonatomic, strong) RNMagicField *companyIntrodusTF;
@property (nonatomic, strong) RNMagicField *zoomTF;
@property (nonatomic, strong) RNMagicField *cityTF;
@property (nonatomic, strong) RNMagicField *address1TF;
@property (nonatomic, strong) RNMagicField *address2TF;
@property (nonatomic, strong) RNMagicField *webTF;
@property (nonatomic, strong) RNMagicField *jobTF;
@property (nonatomic, strong) RNMagicField *partmentTF;
@property (nonatomic, strong) RNMagicField *emailTF;
@end

@implementation RNRegisterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollerView.backgroundColor = RGBOF(0xf8f8f8);
        _scrollerView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self addSubview:_scrollerView];
        
        UILabel *personLab = [UILabel yz_labelWithText:RNLocalized(@"Personal Details") textColor:RGBOF(0x222222) textFont:[UIFont boldSystemFontOfSize:14.f]];
        personLab.frame = CGRectMake(15, 21, 200, 18);
        [_scrollerView addSubview:personLab];
        
        CGFloat commonWidth = (frame.size.width-45)/2.0;
        UIView *personView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(personLab.frame)+10, frame.size.width, 208)];
        personView.backgroundColor = WhiteColor;
        [_scrollerView addSubview:personView];
        
        _firstNameTF = [[RNMagicField alloc] initWithFrame:CGRectMake(15, 0, commonWidth, 52)];
        _firstNameTF.placeholder = @"*firstName";
        _firstNameTF.keyboardType = UIKeyboardTypeASCIICapable;
        _firstNameTF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _firstNameTF.moveDistance = 18;
        _firstNameTF.textColor = UIColorFromRGB(0x222222);
        _firstNameTF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _firstNameTF.placeholdAnimationable = YES;
        [_firstNameTF addTarget:self action:@selector(firstNameTFEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [personView addSubview:_firstNameTF];
        
        _lastNameTF = [[RNMagicField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_firstNameTF.frame)+15, 0, commonWidth, 52)];
        _lastNameTF.placeholder = @"*lastName";
        _lastNameTF.keyboardType = UIKeyboardTypeASCIICapable;
        _lastNameTF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _lastNameTF.moveDistance = 18;
        _lastNameTF.textColor = UIColorFromRGB(0x222222);
        _lastNameTF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _lastNameTF.placeholdAnimationable = YES;
        [_lastNameTF addTarget:self action:@selector(lastNameTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [personView addSubview:_lastNameTF];
        
        _alisTF = [[RNMagicField alloc] initWithFrame:CGRectMake(15, 52, commonWidth, 52)];
        _alisTF.placeholder = RNLocalized(@"Chinese Name");
        _alisTF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _alisTF.moveDistance = 18;
        _alisTF.textColor = UIColorFromRGB(0x222222);
        _alisTF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _alisTF.placeholdAnimationable = YES;
        [_alisTF addTarget:self action:@selector(alisTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [personView addSubview:_alisTF];
        
        _sexTF = [[RNMagicField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_firstNameTF.frame)+15, 53, commonWidth, 52)];
        _sexTF.placeholder = [NSString stringWithFormat:@"*%@", RNLocalized(@"Gender")];
        _sexTF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _sexTF.moveDistance = 18;
        _sexTF.textColor = UIColorFromRGB(0x222222);
        _sexTF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _sexTF.placeholdAnimationable = YES;
        [_sexTF addTarget:self action:@selector(sexTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [personView addSubview:_sexTF];
        
        UIButton *sexButton = [[UIButton alloc] initWithFrame:_sexTF.frame];
        [sexButton addTarget:self action:@selector(sexButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [personView addSubview:sexButton];
        
        UILabel *phoneLab = [UILabel yz_labelWithText:[NSString stringWithFormat:@"*%@", RNLocalized(@"Phone")] textColor:RGBOF(0x999999) sizeFont:14];
        phoneLab.frame = CGRectMake(15, 104, 50, 52);
        [personView addSubview:phoneLab];
        [Utility richTextLabel:phoneLab fontNumber:[UIFont systemFontOfSize:14] andRange:[phoneLab.text rangeOfString:@"*"] andColor:RGBOF(0xE55156)];
        
        _phoneRgTF = [[UITextField alloc] initWithFrame:CGRectMake(15+60, 104, commonWidth-60, 52)];
        [personView addSubview:_phoneRgTF];
        _phoneRgTF.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneRgTF addTarget:self action:@selector(phoneRgTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        
        _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_phoneRgTF.frame)+10, 104, commonWidth, 52)];
        [_phoneTF addTarget:self action:@selector(phoneTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        [personView addSubview:_phoneTF];
        

        
        _emailTF = [[RNMagicField alloc] initWithFrame:CGRectMake(15, 156, frame.size.width-30, 52)];
        _emailTF.placeholder = [NSString stringWithFormat:@"*%@", RNLocalized(@"E-Mail")];
        _emailTF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _emailTF.moveDistance = 18;
        _emailTF.textColor = UIColorFromRGB(0x222222);
        _emailTF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _emailTF.placeholdAnimationable = YES;
        [_emailTF addTarget:self action:@selector(emailTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [personView addSubview:_emailTF];
        
        for (int i = 0; i < 7; i++) {
            int row = i/2;
            int cloum = i%2;
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15+(commonWidth+10)*cloum, 51+52*row, commonWidth, 1)];
            line.backgroundColor = RGBOF(0xe5e5e5);
            [personView addSubview:line];
            if (i == 4) {
                line.x = 15+60;
                line.width = commonWidth-60;
            }
            if (i == 6) {
                line.width = frame.size.width-30;
            }
        }
        
        UILabel *comapnyInfoLab = [UILabel yz_labelWithText:RNLocalized(@"Company Details") textColor:RGBOF(0x222222) textFont:[UIFont boldSystemFontOfSize:14.f]];
        comapnyInfoLab.frame = CGRectMake(15, CGRectGetMaxY(personView.frame)+21, 200, 18);
        [_scrollerView addSubview:comapnyInfoLab];
        
        UIView *companyInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(comapnyInfoLab.frame)+10, frame.size.width, 416)];
        companyInfoView.backgroundColor = WhiteColor;
        [_scrollerView addSubview:companyInfoView];
        
        _companyNameTF = [[RNMagicField alloc] initWithFrame:CGRectMake(15, 0, frame.size.width-30, 52)];
        _companyNameTF.placeholder = [NSString stringWithFormat:@"*%@", RNLocalized(@"Company Name")];
        _companyNameTF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _companyNameTF.moveDistance = 18;
        _companyNameTF.textColor = UIColorFromRGB(0x222222);
        _companyNameTF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _companyNameTF.placeholdAnimationable = YES;
        [_companyNameTF addTarget:self action:@selector(companyNameTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [companyInfoView addSubview:_companyNameTF];
        
        _companyIntrodusTF = [[RNMagicField alloc] initWithFrame:CGRectMake(15, 52, frame.size.width-30, 52)];
        _companyIntrodusTF.placeholder = [NSString stringWithFormat:@"*%@", RNLocalized(@"Company Abbreviation")];
        _companyIntrodusTF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _companyIntrodusTF.moveDistance = 18;
        _companyIntrodusTF.textColor = UIColorFromRGB(0x222222);
        _companyIntrodusTF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _companyIntrodusTF.placeholdAnimationable = YES;
        [_companyIntrodusTF addTarget:self action:@selector(companyIntrodusTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [companyInfoView addSubview:_companyIntrodusTF];
        
        _zoomTF = [[RNMagicField alloc] initWithFrame:CGRectMake(15, 104, frame.size.width-30, 52)];
        _zoomTF.placeholder = [NSString stringWithFormat:@"*%@", RNLocalized(@"Location")];
        _zoomTF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _zoomTF.moveDistance = 18;
        _zoomTF.textColor = UIColorFromRGB(0x222222);
        _zoomTF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _zoomTF.placeholdAnimationable = YES;
        [_zoomTF addTarget:self action:@selector(zoomTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [companyInfoView addSubview:_zoomTF];
        
        UIButton *zoomBtn = [[UIButton alloc] initWithFrame:_zoomTF.frame];
        [zoomBtn addTarget:self action:@selector(addressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [companyInfoView addSubview:zoomBtn];
        
        _cityTF = [[RNMagicField alloc] initWithFrame:CGRectMake(15, 156, frame.size.width-30, 52)];
        _cityTF.placeholder = [NSString stringWithFormat:@"*%@", RNLocalized(@"City")];
        _cityTF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _cityTF.moveDistance = 18;
        _cityTF.textColor = UIColorFromRGB(0x222222);
        _cityTF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _cityTF.placeholdAnimationable = YES;
        [_cityTF addTarget:self action:@selector(cityTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [companyInfoView addSubview:_cityTF];
        
        _address1TF = [[RNMagicField alloc] initWithFrame:CGRectMake(15, 208, frame.size.width-30, 52)];
        _address1TF.placeholder = [NSString stringWithFormat:@"*%@", RNLocalized(@"Address")];
        _address1TF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _address1TF.moveDistance = 18;
        _address1TF.textColor = UIColorFromRGB(0x222222);
        _address1TF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _address1TF.placeholdAnimationable = YES;
        [_address1TF addTarget:self action:@selector(address1TFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [companyInfoView addSubview:_address1TF];
        
        
        _address2TF = [[RNMagicField alloc] initWithFrame:CGRectMake(15, 260, frame.size.width-30, 52)];
        _address2TF.placeholder = [NSString stringWithFormat:@"%@", RNLocalized(@"Address2")];
        _address2TF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _address2TF.moveDistance = 18;
        _address2TF.textColor = UIColorFromRGB(0x222222);
        _address2TF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _address2TF.placeholdAnimationable = YES;
        [_address2TF addTarget:self action:@selector(address2TFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [companyInfoView addSubview:_address2TF];
        
        _webTF = [[RNMagicField alloc] initWithFrame:CGRectMake(15, 312, frame.size.width-30, 52)];
        _webTF.placeholder = [NSString stringWithFormat:@"%@", RNLocalized(@"Website")];
        _webTF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _webTF.moveDistance = 18;
        _webTF.textColor = UIColorFromRGB(0x222222);
        _webTF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _webTF.placeholdAnimationable = YES;
        [_webTF addTarget:self action:@selector(webTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [companyInfoView addSubview:_webTF];
        
        
        _jobTF = [[RNMagicField alloc] initWithFrame:CGRectMake(15, 364, commonWidth, 52)];
        _jobTF.placeholder = [NSString stringWithFormat:@"*%@", RNLocalized(@"Position")];
        _jobTF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _jobTF.moveDistance = 18;
        _jobTF.textColor = UIColorFromRGB(0x222222);
        _jobTF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _jobTF.placeholdAnimationable = YES;
        [_jobTF addTarget:self action:@selector(jobTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [companyInfoView addSubview:_jobTF];
        
        
        _partmentTF = [[RNMagicField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_jobTF.frame)+15, 364, commonWidth, 52)];
        _partmentTF.placeholder = [NSString stringWithFormat:@"%@", RNLocalized(@"Department")];
        _partmentTF.animationFont = [UIFont yz_PingFangSC_RegularFontOfSize:10];
        _partmentTF.moveDistance = 18;
        _partmentTF.textColor = UIColorFromRGB(0x222222);
        _partmentTF.font = [UIFont yz_PingFangSC_RegularFontOfSize:14];
        _partmentTF.placeholdAnimationable = YES;
        [_partmentTF addTarget:self action:@selector(partmentTFEditeChanged:) forControlEvents:UIControlEventEditingChanged];
        [companyInfoView addSubview:_partmentTF];
        
        for (int i = 0; i < 9; i++) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 51+52*i, frame.size.width-30, 1)];
            line.backgroundColor = RGBOF(0xe5e5e5);
            [companyInfoView addSubview:line];
            if (i == 7 || i == 8) {
                line.width = commonWidth;
                line.y = 51+52*7;
                line.x = (i == 7)?15:(commonWidth+25);
            }
        }
        
        CGFloat cardWidth = (frame.size.width-40)/2.0;
        CGFloat cardHight = cardWidth*92.f/160.f;
        
        UIView *nameCardView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(companyInfoView.frame)+46, cardWidth, cardHight+40)];
        [_scrollerView addSubview:nameCardView];
        RNAddPhotoView *nameCard = [[RNAddPhotoView alloc] initWithFrame:CGRectMake(0, 0, cardWidth, cardHight)];
        [nameCardView addSubview:nameCard];
        UILabel *nameCardTitle = [UILabel yz_labelWithText:[NSString stringWithFormat:@"%@", RNLocalized(@"Name Card")] textColor:RGBOF(0x222222) sizeFont:14 numberOfLines:1 textAlignment:NSTextAlignmentCenter];
        nameCardTitle.frame = CGRectMake(0, CGRectGetMaxY(nameCard.frame), cardWidth, 40);
        [nameCardView addSubview:nameCardTitle];
        UIButton *nameCardCover = [UIButton yz_buttonWithImageStr:@""];
        nameCardCover.frame = nameCard.bounds;
        [nameCardCover setContentMode:UIViewContentModeScaleAspectFill];
        [nameCardCover setClipsToBounds:YES];
        [nameCardCover addTarget:self action:@selector(nameCardCoverClick:) forControlEvents:UIControlEventTouchUpInside];
        _nameCardBtn = nameCardCover;
        [nameCardView addSubview:nameCardCover];
        
        UIView *idCardView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameCardView.frame)+10, CGRectGetMaxY(companyInfoView.frame)+46, cardWidth, cardHight+40)];
        [_scrollerView addSubview:idCardView];
        RNAddPhotoView *idCard = [[RNAddPhotoView alloc] initWithFrame:CGRectMake(0, 0, cardWidth, cardHight)];
        [idCardView addSubview:idCard];
        UILabel *idCardTitle = [UILabel yz_labelWithText:RNLocalized(@"Personal Identity Card") textColor:RGBOF(0x222222) sizeFont:14 numberOfLines:1 textAlignment:NSTextAlignmentCenter];
        idCardTitle.frame = CGRectMake(0, CGRectGetMaxY(idCard.frame), cardWidth, 40);
        [idCardView addSubview:idCardTitle];
        UIButton *idCardCover = [UIButton yz_buttonWithImageStr:@""];
        idCardCover.frame = idCard.bounds;
        [idCardCover addTarget:self action:@selector(idCardCoverClick:) forControlEvents:UIControlEventTouchUpInside];
        [idCardCover setContentMode:UIViewContentModeScaleAspectFill];
        [idCardCover setClipsToBounds:YES];
        _idCardBtn = idCardCover;
        [idCardView addSubview:idCardCover];
        
        UIView *certificateView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(nameCardView.frame), frame.size.width-30, cardHight+40)];
        [_scrollerView addSubview:certificateView];
        RNAddPhotoView *certificateCard = [[RNAddPhotoView alloc] initWithFrame:CGRectMake(0, 0, cardWidth, cardHight)];
        [certificateView addSubview:certificateCard];
        UILabel *certificateTitle = [UILabel yz_labelWithText:[NSString stringWithFormat:@"*%@", RNLocalized(@"Business registration certificate, business license, etc.")] textColor:RGBOF(0x222222) sizeFont:14 numberOfLines:1 textAlignment:NSTextAlignmentLeft];
        [Utility richTextLabel:certificateTitle fontNumber:[UIFont systemFontOfSize:12] andRange:[RNLocalized(@"Business registration certificate, business license, etc.") rangeOfString:@"*"] andColor:RGBOF(0xE55156)];
        certificateTitle.frame = CGRectMake(0, CGRectGetMaxY(certificateCard.frame), frame.size.width-30, 40);
        [certificateView addSubview:certificateTitle];
        UIButton *certificateCover = [UIButton yz_buttonWithImageStr:@""];
        certificateCover.frame = certificateCard.bounds;
        [certificateCover setContentMode:UIViewContentModeScaleAspectFill];
        [certificateCover setClipsToBounds:YES];
        [certificateCover addTarget:self action:@selector(certificateCoverClick:) forControlEvents:UIControlEventTouchUpInside];
        _certificateBtn = certificateCover;
        [certificateView addSubview:certificateCover];
        
        UILabel *tipLab = [UILabel yz_labelWithText:RNLocalized(@"File description: Supports formats such as jpg, png, pdf, etc.The file size is controlled within 5M") textColor:RGBOF(0x999999) sizeFont:12 numberOfLines:0 textAlignment:NSTextAlignmentLeft];
        tipLab.frame = CGRectMake(15, CGRectGetMaxY(certificateView.frame)+28, App_Frame_Width-30, 50);
        [_scrollerView addSubview:tipLab];
        
        
        [_scrollerView setContentSize:CGSizeMake(frame.size.width, CGRectGetMaxY(certificateView.frame)+92)];
        
    }
    return self;
}

- (void)firstNameTFEditingChanged:(RNMagicField *)sender {
    self.registerModel.usernameFirst = sender.text;
}

- (void)lastNameTFEditeChanged:(RNMagicField *)sender {
    self.registerModel.usernameLast = sender.text;
}

- (void)alisTFEditeChanged:(RNMagicField *)sender {
    self.registerModel.ChinseName = sender.text;
}

- (void)sexTFEditeChanged:(RNMagicField *)sender {
    self.registerModel.Gender = sender.text;
}

- (void)companyNameTFEditeChanged:(RNMagicField *)sender {
    self.registerModel.comname = sender.text;
}

- (void)companyIntrodusTFEditeChanged:(RNMagicField *)sender {
    self.registerModel.comcode = sender.text;
}

- (void)zoomTFEditeChanged:(RNMagicField *)sender {
    self.registerModel.country = sender.text;
}

- (void)cityTFEditeChanged:(RNMagicField *)sender {
    self.registerModel.city = sender.text;
}

- (void)address1TFEditeChanged:(RNMagicField *)sender {
    self.registerModel.address = sender.text;
}

- (void)address2TFEditeChanged:(RNMagicField *)sender {
    self.registerModel.address2 = sender.text;
}

- (void)webTFEditeChanged:(RNMagicField *)sender {
    self.registerModel.website = sender.text;
}

- (void)jobTFEditeChanged:(RNMagicField *)sender {
    self.registerModel.position = sender.text;
}

- (void)partmentTFEditeChanged:(RNMagicField *)sender {
    self.registerModel.department = sender.text;
}

- (void)emailTFEditeChanged:(RNMagicField *)sender {
    self.registerModel.email = sender.text;
}

- (void)nameCardCoverClick:(UIButton *)sender {
    if (self.coverBlock) {
        self.coverBlock(1);
    }
}

- (void)idCardCoverClick:(UIButton *)sender {
    if (self.coverBlock) {
        self.coverBlock(2);
    }
}

- (void)certificateCoverClick:(UIButton *)sender {
    if (self.coverBlock) {
        self.coverBlock(3);
    }
}


- (void)setRegisterModel:(RNRegisterModel *)registerModel {
    _registerModel = registerModel;
}

- (void)phoneRgTFEditeChanged:(UITextField *)sender {
    if (sender.text.length && ![sender.text containsString:@"+"]) {
        NSString *str = sender.text;
        sender.text = [NSString stringWithFormat:@"+%@", str];
    }
    _registerModel.address3 = sender.text;
}

- (void)phoneTFEditeChanged:(UITextField *)sender {
    _registerModel.phone = sender.text;
}

- (void)sexButtonClick:(UIButton *)sender {
    NSArray *titles = @[RNLocalized(@"Male"), RNLocalized(@"Female")];
    NSArray *values = @[@"Male", @"Female"];
    PopoverView *popveView = [PopoverView popoverView];
    popveView.showShade = YES;
    NSMutableArray *array = [NSMutableArray array];
    __weak typeof(self)weakself = self;
    for (NSString *str in titles) {
        PopoverAction *action  = [PopoverAction actionWithTitle:str handler:^(PopoverAction *action) {
            NSInteger index = [titles indexOfObject:action.title];
            weakself.registerModel.Gender = values[index];
            weakself.sexTF.text = action.title;
        }];
        [array addObject:action];
    }
    [popveView showToView:sender withActions:array];
}

- (void)addressBtnClick:(UIButton *)sender {
    __weak typeof(self)weakself = self;
    [HttpRequestTool  getWithURLString:KStringFormat(BaseServer, @"bpdm/sys/CityController?method=getAllCountry") parameters:@{@"lang" : [NSString stringWithFormat:@"%d", [RNLanguageManager shareManager].languageType]} success:^(id responseObject, ResponseState state) {
        NSLog(@"%@", responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
           
            NSArray *array = responseObject[@"allCountry"];
            
            
            if (array && array.count) {
                NSMutableArray *list = [NSMutableArray array];
                for (NSDictionary *dict in array) {
                    [list addObject:dict[@"name"]];
                }
                RNSingleChooseView *chooseView = [[RNSingleChooseView alloc] initWithDataSource:list chooseBlock:^(NSInteger index) {
                    weakself.zoomTF.text = [list objectAtIndex:index];
                    NSDictionary *dict = [array objectAtIndex:index];
                    weakself.registerModel.country = KFormat(dict[@"code"]);
                    
                }];
                [chooseView show];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
