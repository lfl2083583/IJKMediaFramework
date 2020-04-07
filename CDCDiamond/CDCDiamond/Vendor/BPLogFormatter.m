//
//  BPLogFormatter.m
//  RapNet
//
//  Created by liufulin on 2019/8/8.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "BPLogFormatter.h"
#import "DDLog.h"

@interface BPLogFormatter ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation BPLogFormatter

- (id)init {
    if((self = [super init])) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss:SSS"];
    }
    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *dateAndTime = [self.dateFormatter stringFromDate:(logMessage.timestamp)];
    NSString *logMsg = logMessage.message;
    
    return [NSString stringWithFormat:@"%@ > %@\n", dateAndTime, logMsg];
}

@end
