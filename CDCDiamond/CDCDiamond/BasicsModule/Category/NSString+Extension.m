

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Extension)

- (CGSize)stringSizeWithFont:(UIFont *)font
{
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}

- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)width maxNumberLines:(int)num {
    CGSize size = CGSizeZero;
    if (num > 0) {
        CGFloat tmpHeight = ceilf(font.lineHeight * num);
        size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, tmpHeight) lineBreakMode:NSLineBreakByTruncatingTail];
    } else if (num == 0) {
        size = [self sizeWithFont:font maxWidth:width maxNumberLines:-10];
    } else if (num < 0) {
        num = num*-1;
        int i = 1;
        CGFloat h1, h2;
        do {
            size = [self sizeWithFont:font maxWidth:width maxNumberLines:num*i];
            h1 = size.height;
            h2 = ceilf(font.lineHeight*num*i++);
        } while (h1 >= h2);
    }
    size.width = ceilf(size.width);
    size.height = ceilf(size.height);
    return size;
}


- (NSString *)MD5String
{
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


- (NSUInteger)getBytesLength
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [self lengthOfBytesUsingEncoding:enc];
}


- (NSString *)avatarHandleWithSquare:(NSInteger)width
{
    return [self avatarHandleWithSize:CGSizeMake(width, width)];
}

- (NSString *)avatarHandleWithSize:(CGSize)size;
{
    NSString *avatarUrlString = [[self componentsSeparatedByString:@"?"] firstObject];
    if ([self rangeOfString:@"boshangquan"].location != NSNotFound || [self rangeOfString:@"ofa0vp1fo.bkt.clouddn.com"].location != NSNotFound) {
        avatarUrlString = [avatarUrlString stringByAppendingString:[NSString stringWithFormat:@"?imageView2/5/w/%d/h/%d", (int)size.width, (int)size.height]];
    }
    else
    {
        avatarUrlString = [avatarUrlString stringByAppendingString:[NSString stringWithFormat:@"?imageView&thumbnail=%dz%d", (int)size.width, (int)size.height]];
    }
    return avatarUrlString;
}

- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (NSString *)transformToPinyinFirst
{
    NSMutableString *mutStr = [NSMutableString stringWithString:self];
    
    //将mutStr中的汉字转化为带音标的拼音（如果是汉字就转换，如果不是则保持原样）
    CFStringTransform((__bridge CFMutableStringRef)mutStr, NULL, kCFStringTransformMandarinLatin, NO);
    //将带有音标的拼音转换成不带音标的拼音（这一步是从上一步的基础上来的，所以这两句话一句也不能少）
    CFStringTransform((__bridge CFMutableStringRef)mutStr, NULL, kCFStringTransformStripCombiningMarks, NO);
    if (mutStr.length > 0) {
        //全部转换为大写    取出首字母并返回
        NSString * res = [[mutStr uppercaseString] substringToIndex:1];
        return res;
    }
    else
        return @"";
}

- (NSString *)base64EncodedString;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (BOOL)regexPredicateWithRegex:(NSString *)regex{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

+ (NSString *)transToCountryCodeStyleWithCountryCode:(NSString *)countryCode{
    return countryCode?[NSString stringWithFormat:@"+%@",countryCode]:@"";
}

+ (NSString *)transToCountryCodeStyleWithCountryCode:(NSString *)countryCode phone:(NSString *)phone{
    return [NSString stringWithFormat:@"%@ %@",[self transToCountryCodeStyleWithCountryCode:countryCode],phone];
}

@end
