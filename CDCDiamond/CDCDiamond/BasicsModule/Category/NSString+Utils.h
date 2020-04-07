//
//  NSString+Utils.h
//  eduParent
//
//  Created by hjg on 16/10/4.
//  Copyright © 2016年 hjg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

#pragma mark - 计算字符串大小 （对象方法）
/**
 *  计算字符串实际大小
 *
 *  @param font 字体大小
 *  @param size 最大限制
 *
 *  @return 字符串Size
 */
-(CGSize)calculateStringWithFont:(CGFloat)font Size:(CGSize)size;


#pragma mark - 计算单个中文字符串大小 （类方法）

/**
 *  计算单个中文字的大小
 *
 *  @param font 字体大小
 *
 *  @return size
 */
+ (CGSize)calculateSingleStringWithFont:(CGFloat)font;

#pragma mark - 富文本
/** 修改字符串指定下标区域文字大小 */
-(NSMutableAttributedString *)changeTextFont:(CGFloat)font range:(NSRange)range;
/** 修改字符串指定下标区域文字颜色 */
-(NSMutableAttributedString *)changeTextColor:(UIColor *)color range:(NSRange)range;
/** 设置最第一个字符字体大小 */
-(NSMutableAttributedString *)setStringWithFirstCharFont:(UIFont *)font;
/** 设置最后一个字符字体大小 */
-(NSMutableAttributedString *)setStringWithLastCharFont:(UIFont *)font;
/** 修改小数点后面字体大小 */
-(NSMutableAttributedString *)setMoneyBehindFont:(UIFont *)behindFont;
/** 修改¥字体大小、小数点后字体大小 */
-(NSMutableAttributedString *)setMoneyFrontFont:(UIFont *)frontFont behindFont:(UIFont *)behindFont;

#pragma mark - 全局方法
/** 追加字符串 */
-(NSString *)yz_appendString:(NSString *)str;
/** 删除字符串最后一个字符 */
-(NSString *)deleteEndString;
/** 隐藏手机号中间 4 位 */
-(NSString *)hidePhoneNumber;
/** 限制字符串个数 */
-(NSString *)yz_stringLimitNumber:(int)num;
/** 把数量改为万单位，保留两位小数 */
+(NSString *)changeNumberUnit:(NSInteger)number;
/** 字符串转 json */
+ (NSDictionary *)yz_dictionaryWithJsonString:(NSString *)jsonString;

#pragma mark - 金额相关
/** 金额拆分，根据需求加个逗号 */
-(NSString *)moneySplitWithNumber:(NSInteger)number;

- (NSURL *)formatUrlString;


@end
