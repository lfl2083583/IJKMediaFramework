//
//  RNCaculatorViewController.m
//  RapNet
//
//  Created by liufulin on 2019/10/18.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNCaculatorViewController.h"
#import "KeyboadView.h"
#import "UIPickerView+malPicker.h"

@interface RNCaculatorViewController ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, KeyboadViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *xzPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *ysPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *jdPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pcPickerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet UIView *keyboardView;
@property (weak, nonatomic) IBOutlet UITextField *weightTF;
@property (nonatomic, strong) KeyboadView *keyboard;

@property (weak, nonatomic) IBOutlet UILabel *topleftLB;
@property (weak, nonatomic) IBOutlet UILabel *toprightLB;
@property (weak, nonatomic) IBOutlet UILabel *bottomleftLB;
@property (weak, nonatomic) IBOutlet UILabel *bottomrightLB;



@property (nonatomic, strong) NSArray *xzArray;
@property (nonatomic, strong) NSArray *ysArray;
@property (nonatomic, strong) NSArray *jdArray;
@property (nonatomic, strong) NSArray *pcArray;
@property (nonatomic, strong) NSArray *caculateArray;
@property (nonatomic, assign) CGFloat price;
 

@end

@implementation RNCaculatorViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"计算器";
    self.view.backgroundColor = UIColorFromRGB(0xf6f6f6);
    [self.weightTF setInputView:self.keyboard];
    
    self.xzArray = @[@"Princess", @"Radiant", @"Emerald", @"Sq. Emerald",@"Pear",@"Cushion (all)",@"Cushion Brilliant",@"Cushion Modified",@"Asscher",@"Asscher &amp Sq. Emer",@"Baguette",@"Briolette",@"Bullets",@"European Cut",@"Flanders",@"Half Moon",@"Heart",@"Hexagonal",@"Kite",@"Lozenge",@"Marquise",@"Octagonal",@"Old Miner",@"Other",@"Oval",@"Pentagonal",@"Rose",@"Round",@"Shield",@"Square",@"Star",@"Tapered Baguette",@"Trapezoid",@"Triangular",@"Trilliant0"];
    self.ysArray = @[@"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M"];
    self.jdArray = @[@"IF",@"VVS1",@"VVS2",@"VS1",@"VS2",@"SI1",@"SI2",@"SI3",@"I1",@"I2",@"I3"];
    CGFloat j = -99.0;
    CGFloat m = -0.99;
    NSMutableArray *array = [NSMutableArray array];
     NSMutableArray *otherArray = [NSMutableArray array];
    for (int i  = 0; i < 397; i++) {
        [array addObject:[NSString stringWithFormat:@"%.1f%%", j+0.5*i]];
        [otherArray addObject:[NSString stringWithFormat:@"%.1f", m+0.005*i]];
    }
    self.pcArray = array;
    self.caculateArray = otherArray;
    
    if (!_shape || _color || _clarity) {
        [self resetPicker];
        [self resetData];
    }
}

- (void)leftDrawerButtonPress:(id)sender {
    [super leftDrawerButtonPress:sender];
    [self.weightTF resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.weightTF becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.weightTF resignFirstResponder];
}

- (void)resetData {
    self.shape = self.xzArray[1];
    self.color = @"1";
    self.clarity = @"1";
    self.percent = self.pcArray[198];
    self.size = @"0.0";
    self.price = 0;
    [self updateUI];
}

- (void)resetPicker {
    [self.xzPickerView selectRow:1 inComponent:0 animated:YES];
    [self.ysPickerView selectRow:1 inComponent:0 animated:YES];
    [self.jdPickerView selectRow:1 inComponent:0 animated:YES];
    [self.pcPickerView selectRow:198 inComponent:0 animated:YES];
}

- (void)reloadData {
    if (self.shape && self.color && self.clarity && self.size) {
        NSDictionary *progem = @{@"shape" : self.shape, @"color" : self.color, @"clarity" : self.clarity, @"size" : self.size};
        __weak typeof(self)weakself = self;
        [HttpRequestTool getWithURLString:KStringFormat(BaseServer, @"bpdm/servlet/AppSearch?method=getAllPrice") parameters:progem success:^(id responseObject, ResponseState state) {
            NSLog(@"%@", responseObject);
            if (responseObject && [responseObject isKindOfClass:[NSArray class]] && [responseObject count]) {
                weakself.price = [self caculatePrice:responseObject];
                [weakself updateUI];
            }
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}

- (CGFloat)caculatePrice:(NSArray *)array {
    NSString *currentShape = [self.shape isEqualToString:@"Round"]?@"圆形":@"异形";
    NSString *price = @"";
    for (NSDictionary *dictionary in array) {
        NSString *kColor = [dictionary objectForKey:@"F_TYPE"];
        NSString *kShape = [dictionary objectForKey:@"SHAPE"];
        NSString *color = [self.ysArray objectAtIndex:self.color.integerValue-1];
        if ([color isEqualToString:kColor] && [currentShape isEqualToString:kShape]) {
            price = [dictionary objectForKey:[NSString stringWithFormat:@"F_%@", [self.jdArray objectAtIndex:self.clarity.integerValue-1]]];
            break;
        }
    }
    return [price floatValue] * 100;
}

- (void)updateUI {
    self.bottomrightLB.text = [NSString stringWithFormat:@"AED %d",(int)self.price];
    self.bottomleftLB.text = [NSString stringWithFormat:@"AED %d", (int)(self.price*[self.size floatValue]*10)];
    self.toprightLB.text = [NSString stringWithFormat:@"AED %d",(int)(self.price*(1+[self.pc floatValue]))];
    self.topleftLB.text = [NSString stringWithFormat:@"AED %d", (int)(self.price*[self.size floatValue]*10 *(1+[self.pc floatValue]))];
}


#pragma mark - UITextFieldDelegate


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:self.xzPickerView]) {
        return self.xzArray.count;
    } else if ([pickerView isEqual:self.ysPickerView]) {
        return self.ysArray.count;
    } else if ([pickerView isEqual:self.jdPickerView]) {
        return self.jdArray.count;
    } else if ([pickerView isEqual:self.pcPickerView]) {
        return self.pcArray.count;
    } else {
        return 0;
    }
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED {
    [pickerView clearSpearatorLine];
    if ([pickerView isEqual:self.xzPickerView]) {
        return self.xzArray[row];
    } else if ([pickerView isEqual:self.ysPickerView]) {
        return self.ysArray[row];
    } else if ([pickerView isEqual:self.jdPickerView]) {
        return self.jdArray[row];
    } else if ([pickerView isEqual:self.pcPickerView]) {
        return self.pcArray[row];
    } else {
        return @"";
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([pickerView isEqual:self.xzPickerView]) {
        self.shape = self.xzArray[row];
    } else if ([pickerView isEqual:self.ysPickerView]) {
        self.color = [NSString stringWithFormat:@"%ld", row + 1];
    } else if ([pickerView isEqual:self.jdPickerView]) {
        self.clarity = [NSString stringWithFormat:@"%ld", row + 1];
    } else if ([pickerView isEqual:self.pcPickerView]) {
        self.percent = self.pcArray[row];
        self.pc = self.caculateArray[row];
    }
    [self reloadData];
}

#pragma mark - KeyboadViewDelegate

- (void)onkeyboardTextInput:(NSString *)inputString {
    self.weightTF.text = inputString;
    self.size = [NSString stringWithFormat:@"%.2f", [self.weightTF.text floatValue]];
    [self reloadData];
    [Utility shouldFeedbackGenerator];
}

- (void)onkeyboardRestTextInput:(NSString *)inputString {
    self.weightTF.text = inputString;
    [self resetPicker];
    [self resetData];
}

- (void)onkeyboardCompareTextInput:(NSString *)inputString {
    self.weightTF.text = inputString;
}

- (void)onkeyboardSaveTextInput:(NSString *)inputString {
    self.weightTF.text = inputString;
}

- (KeyboadView *)keyboard {
    if (!_keyboard) {
        _keyboard = [[[NSBundle mainBundle] loadNibNamed:@"KeyboadView" owner:self options:nil] firstObject];
        _keyboard.backgroundColor = UIColor.redColor;
        _keyboard.delegate = self;
    }
    return _keyboard;
}
@end
