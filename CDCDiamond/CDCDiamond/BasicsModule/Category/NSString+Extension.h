//
//  NSString+NTES.h
//  NIMDemo
//

#import <UIKit/UIKit.h>

@interface NSString (Extension)

- (CGSize)stringSizeWithFont:(UIFont *)font;

- (CGSize)sizeWithFont:(UIFont*)font maxWidth:(CGFloat)width maxNumberLines:(int)num;

- (BOOL)isChinese;

- (NSString *)MD5String;

- (NSUInteger)getBytesLength;

- (NSString *)avatarHandleWithSquare:(NSInteger)width;

- (NSString *)avatarHandleWithSize:(CGSize)size;

- (NSString *)transformToPinyinFirst;

- (NSString *)base64EncodedString;

- (NSString *)base64DecodedString;

- (BOOL)regexPredicateWithRegex:(NSString *)regex;

+ (NSString *)transToCountryCodeStyleWithCountryCode:(NSString *)countryCode;

+ (NSString *)transToCountryCodeStyleWithCountryCode:(NSString *)countryCode phone:(NSString *)phone;
@end
