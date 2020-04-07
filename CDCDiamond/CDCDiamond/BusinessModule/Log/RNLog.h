//
//  RNLog.h
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>
#import "JSONKit.h"
#import "RNLogHelp.h"

#define BPLOG_FLAG_FATAL    (1 << 0)
#define BPLOG_FLAG_ERROR    (1 << 1)
#define BPLOG_FLAG_WARN     (1 << 2)
#define BPLOG_FLAG_NOTICE   (1 << 3)
#define BPLOG_FLAG_INFO     (1 << 4)
#define BPLOG_FLAG_DEBUG    (1 << 5)

#define BPLOG_LEVEL_FATAL    (BPLOG_FLAG_FATAL)
#define BPLOG_LEVEL_ERROR    (BPLOG_FLAG_ERROR | BPLOG_LEVEL_FATAL)
#define BPLOG_LEVEL_WARN     (BPLOG_FLAG_WARN | BPLOG_LEVEL_ERROR)
#define BPLOG_LEVEL_NOTICE   (BPLOG_FLAG_NOTICE | BPLOG_LEVEL_WARN)
#define BPLOG_LEVEL_INFO     (BPLOG_FLAG_INFO | BPLOG_LEVEL_NOTICE)
#define BPLOG_LEVEL_DEBUG    (BPLOG_FLAG_DEBUG | BPLOG_LEVEL_INFO)

#ifdef DEBUG
static const DDLogLevel ddLogLevel = BPLOG_LEVEL_DEBUG;
#else
static const DDLogLevel ddLogLevel = BPLOG_LEVEL_INFO;
#endif

#define BPLog(flg, evt, dict, frmt, ...) LOG_MAYBE(YES, ddLogLevel, flg, 0, nil, __PRETTY_FUNCTION__, @"%@", [RNLogHelp logInfoWithFlag:flg event:evt info:dict messsage:frmt, ##__VA_ARGS__])

#define BPDetailLogFatal(evt, dict, frmt, ...)      BPLog(BPLOG_FLAG_FATAL, evt, dict, frmt, ##__VA_ARGS__)
#define BPDetailLogError(evt, dict, frmt, ...)      BPLog(BPLOG_FLAG_ERROR, evt, dict, frmt, ##__VA_ARGS__)
#define BPDetailLogWarn(evt, dict, frmt, ...)      BPLog(BPLOG_FLAG_WARN, evt, dict, frmt, ##__VA_ARGS__)
#define BPDetailLogNotice(evt, dict, frmt, ...)      BPLog(BPLOG_FLAG_NOTICE, evt, dict, frmt, ##__VA_ARGS__)
#define BPDetailLogInfo(evt, dict, frmt, ...)      BPLog(BPLOG_FLAG_INFO, evt, dict, frmt, ##__VA_ARGS__)
#define BPDetailLogDebug(evt, dict, frmt, ...)      BPLog(BPLOG_FLAG_DEBUG, evt, dict, frmt, ##__VA_ARGS__)

#define BPSimpleLogFatal(evt, frmt, ...)      BPDetailLogFatal(evt, nil, frmt, ##__VA_ARGS__)
#define BPSimpleLogError(evt, frmt, ...)      BPDetailLogError(evt, nil, frmt, ##__VA_ARGS__)
#define BPSimpleLogWarn(evt, frmt, ...)      BPDetailLogWarn(evt, nil, frmt, ##__VA_ARGS__)
#define BPSimpleLogNotice(evt, frmt, ...)      BPDetailLogNotice(evt, nil, frmt, ##__VA_ARGS__)
#define BPSimpleLogInfo(evt, frmt, ...)      BPDetailLogInfo(evt, nil, frmt, ##__VA_ARGS__)
#define BPSimpleLogDebug(evt, frmt, ...)      BPDetailLogDebug(evt, nil, frmt, ##__VA_ARGS__)

#define BPLogFatal(frmt, ...)      BPSimpleLogFatal(nil, frmt, ##__VA_ARGS__)
#define BPLogError(frmt, ...)      BPSimpleLogError(nil, frmt, ##__VA_ARGS__)
#define BPLogWarn(frmt, ...)      BPSimpleLogWarn(nil, nil, frmt, ##__VA_ARGS__)
#define BPLogNotice(frmt, ...)      BPSimpleLogNotice(nil, frmt, ##__VA_ARGS__)
#define BPLogInfo(frmt, ...)      BPSimpleLogInfo( nil, frmt, ##__VA_ARGS__)
#define BPLogDebug(frmt, ...)      BPSimpleLogDebug(nil, frmt, ##__VA_ARGS__)

// Legacy, this macro uses dict as last param, so does not support formatted message, just keep it for legacy logs, for future, use BPDetailLog macros instead.
#define BPRemoteLogFatal(evt, msg, dict)  BPLog(BPLOG_FLAG_FATAL,  evt, dict, msg)
#define BPRemoteLogError(evt, msg, dict)  BPLog(BPLOG_FLAG_ERROR,  evt, dict, msg)
#define BPRemoteLogWarn(evt, msg, dict)   BPLog(BPLOG_FLAG_WARN,   evt, dict, msg)
#define BPRemoteLogNotice(evt, msg, dict) BPLog(BPLOG_FLAG_NOTICE, evt, dict, msg)
#define BPRemoteLogInfo(evt, msg, dict)   BPLog(BPLOG_FLAG_INFO,   evt, dict, msg)
#define BPRemoteLogDebug(evt, msg, dict)  BPLog(BPLOG_FLAG_DEBUG,  evt, dict, msg)
