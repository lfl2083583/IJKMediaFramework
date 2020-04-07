
#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/** 比较当前时间和from时间的差值*/
-(NSDateComponents *)deltaFrom:(NSDate *)from;

/** 是否为今天*/
-(BOOL)isToday;

@end
