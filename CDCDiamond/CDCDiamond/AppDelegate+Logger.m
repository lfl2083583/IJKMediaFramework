//
//  AppDelegate+Logger.m
//  RapNet
//
//  Created by liufulin on 2019/7/12.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "AppDelegate+Logger.h"

#import "BPLogFormatter.h"
// Lib
#import "LogglyLogger.h"
#import "LogglyFormatter.h"


@implementation AppDelegate (Logger)

- (void)setupLogger
{
    
#if DB_ENVIRONMENT == DB_ENVIRONMENT_PRODUCTION
    /*
     Loggly
     */
    LogglyLogger * logglyLogger = [[LogglyLogger alloc] init];
    LogglyFormatter * logglyFormatter = [[LogglyFormatter alloc] init];
    logglyFormatter.alwaysIncludeRawMessage = NO;
    logglyLogger.logFormatter = logglyFormatter;
    logglyLogger.logglyKey = @"3b3bff02-2906-45d9-98b4-8375f5dd1490";
    // Set posting interval every 15 seconds, just for testing this out, but the default value of 600 seconds is better in apps
    // that normally don't access the network very often. When the user suspends the app, the logs will always be posted.
#ifdef DEBUG
    logglyLogger.saveInterval = 15;
#else
    logglyLogger.saveInterval = 120;
#endif // END #ifdef DEBUG
    
    [DDLog addLogger:logglyLogger withLevel:BPLOG_LEVEL_NOTICE];
#endif
    
#ifdef DEBUG
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:BPLOG_LEVEL_DEBUG];
#endif
    
}

@end
