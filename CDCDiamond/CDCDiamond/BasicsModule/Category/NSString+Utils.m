//
//  NSString+Utils.m
//  eduParent
//
//  Created by hjg on 16/10/4.
//  Copyright © 2016年 hjg. All rights reserved.
//

#import "NSString+Utils.h"


@implementation NSString (Utils)

// 计算字符串Size
-(CGSize)calculateStringWithFont:(CGFloat)font Size:(CGSize)size {
    
    // 影响文字大小的因素有：
    // 1.跟文字的字体大小有关
    // 2.跟它限定的宽度有关，宽度越窄，高度越高
    
    // 第一个参数：传入一个 CGSize 用来限定它最大的宽度是多少，最大的高度是多少
    //   如果没有达到最大的宽度和最大的高度，那么久返回实际尺寸，如果超过了你限定的最大宽度和高度，那么只会返回你最大的宽度和高度
    // 第二个参数：直接传 NSStringDrawingUsesLineFragmentOrigin 就可以，因为它既可以计算单行，也可以计算多行
    // 第三个参数： 传入一个字典，这个字典就是让你设置字体的大小的，或者字体颜色
    
    NSDictionary *attr = @{ NSFontAttributeName : [UIFont systemFontOfSize:font]};
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    
}

// 计算单个中文字符串的实际大小
+ (CGSize)calculateSingleStringWithFont:(CGFloat)font {
    // 定义一个中文
    NSString *str = @"中";
    
    return [str calculateStringWithFont:font Size:CGSizeMake(App_Frame_Width, APP_Frame_Height)];
}


#pragma mark - 富文本

-(NSMutableAttributedString *)changeTextFont:(CGFloat)font range:(NSRange)range {
    // 创建Attributed
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:self];
    // 改变字体大小及类型
    [newStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
    
    return newStr;
}

-(NSMutableAttributedString *)changeTextColor:(UIColor *)color range:(NSRange)range {
    // 创建Attributed
    NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc] initWithString:self];
    // 改变颜色
    [newStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return newStr;
}

// 设置最第一个字符字体大小
-(NSMutableAttributedString *)setStringWithFirstCharFont:(UIFont *)font {
    
    if (self.length > 1) {
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:self];
        //小数点后面的字体大小
        [AttributedStr addAttribute:NSFontAttributeName
                              value:font
                              range:NSMakeRange(0, 1)];
        return AttributedStr;
    }else {
        return [[NSMutableAttributedString alloc] initWithString:self];
    }
}

// 设置最后一个字符字体大小
-(NSMutableAttributedString *)setStringWithLastCharFont:(UIFont *)font {
    
    if (self.length > 1) {
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:self];
        //小数点后面的字体大小
        [AttributedStr addAttribute:NSFontAttributeName
                              value:font
                              range:NSMakeRange(self.length - 1, 1)];
        return AttributedStr;
    }else {
        return [[NSMutableAttributedString alloc] initWithString:self];
    }
}

-(NSMutableAttributedString *)setMoneyBehindFont:(UIFont *)behindFont {
    //分隔字符串
    NSString *lastStr;
    NSString *firstStr;
    
    if ([self containsString:@"."]) {
        NSRange range = [self rangeOfString:@"."];
        lastStr = [self substringFromIndex:range.location];
        firstStr = [self substringToIndex:range.location];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:self];
        //小数点后面的字体大小
        [AttributedStr addAttribute:NSFontAttributeName
                              value:behindFont
                              range:NSMakeRange(firstStr.length, lastStr.length)];
        return AttributedStr;
    }else {
        return [[NSMutableAttributedString alloc] initWithString:self];
    }
}

-(NSMutableAttributedString *)setMoneyFrontFont:(UIFont *)frontFont behindFont:(UIFont *)behindFont {
    
    //分隔字符串
    NSString *lastStr;
    NSString *firstStr;
    
    if ([self containsString:@"."]) {
        NSRange range = [self rangeOfString:@"."];
        lastStr = [self substringFromIndex:range.location];
        firstStr = [self substringToIndex:range.location];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:self];
        
        // ¥ 字体大小
        [AttributedStr addAttribute:NSFontAttributeName
                              value:frontFont
                              range:NSMakeRange(0, 1)];
        
        //小数点后面的字体大小
        [AttributedStr addAttribute:NSFontAttributeName
                              value:behindFont
                              range:NSMakeRange(firstStr.length, lastStr.length)];
        
        return AttributedStr;
    }else {
        return [[NSMutableAttributedString alloc] initWithString:self];
    }
}

#pragma mark - 金额相关

-(NSString *)moneySplitWithNumber:(NSInteger)number {
    
    NSString *intStr = nil;
    
    NSString *floStr = nil;
    
    if ([self containsString:@"."]) {
        
        NSRange range = [self rangeOfString:@"."];
        
        floStr = [self substringFromIndex:range.location];
        
        intStr = [self substringToIndex:range.location];
        
    }else{
        
        floStr = @"";
        
        intStr = self;
        
    }
    
    if (intStr.length <= number) {
        
        return [intStr stringByAppendingString:floStr];
        
    }else{
        
        NSInteger length = intStr.length;
        
        NSInteger count = length / number;
        
        NSInteger y = length % number;
        
        
        NSString *tit = [intStr substringToIndex:y] ;
        
        NSMutableString *det = [[intStr substringFromIndex:y] mutableCopy];
        
        
        for (int i =0; i < count; i ++) {
            
            NSInteger index = i + i * number;
            
            [det insertString:@","atIndex:index];
            
        }
        
        if (y ==0) {
            
            det = [[det substringFromIndex:1] mutableCopy];
            
        }
        
        intStr = [tit stringByAppendingString:det];
        
        return [intStr stringByAppendingString:floStr];
        
    }
}

- (NSURL *)formatUrlString {
    BOOL ret = [self hasChinese];
    if (ret) {
        NSString *formatString = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return [NSURL URLWithString:formatString];
    }
    return [NSURL URLWithString:self];
}

- (BOOL)hasChinese {
    for (int i = 0; i < [self length]; i++) {
        int a = [self characterAtIndex:i];
        if ( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}


#pragma mark - 全局方法
/** 追加字符串 */
-(NSString *)yz_appendString:(NSString *)str {
    
    NSString *string = [NSString stringWithFormat:@"%@%@",self,str];
    
    return string;
}

/** 删除字符串最后一个字符 */
-(NSString *)deleteEndString {
    return [self substringWithRange:NSMakeRange(0, [self length] - 1)];
}

/** 隐藏手机号中间 4 位 */
-(NSString *)hidePhoneNumber {
//    if (![NSString regularPhone:self]) {
//        return @"";
//    }
    NSString *numberString = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return numberString;
}
/** 限制字符串个数 */
-(NSString *)yz_stringLimitNumber:(int)num {
    if (self.length < num) {
        return self;
    }
    NSString *newStr = [self substringToIndex:num];
    return newStr;
}

/** 把数量改为万单位，保留两位小数 */
+(NSString *)changeNumberUnit:(NSInteger)number {
    if (number < 10000) {
        return [NSString stringWithFormat:@"%zd", number];
    } else {
        double roundValue = number/10000.0;
        NSString *str = [NSString stringWithFormat:@"%.2lf", roundValue];
        if (str.length > 3) {
            NSString *strNew = [str substringFromIndex:str.length - 2];
            if ([strNew isEqualToString:@"00"]) {
                return [NSString stringWithFormat:@"%d万", (int)(number/10000)];
            }
        }
        return [NSString stringWithFormat:@"%.2lf万", roundValue];
    }
}

+ (NSDictionary *)yz_dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
