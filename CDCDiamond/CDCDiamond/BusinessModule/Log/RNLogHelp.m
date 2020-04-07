//
//  RNLogHelp.m
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import "RNLogHelp.h"

@implementation RNLogHelp

+ (NSArray *)creditCardBlacklist
{
    static NSArray *_ccBlacklist;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ccBlacklist = @[@"mag_data",
                         @"holder",
                         @"ksn",
                         @"encrypted_track1",
                         @"encrypted_track2",
                         @"track1",
                         @"track2",
                         @"model",
                         @"tlvdata",
                         @"cvv",
                         @"exp_year",
                         @"exp_month",
                         @"number"];
    });
    return _ccBlacklist;
}

+ (NSDictionary *)_basicInfoToLogRemotely
{
//    FCUser * currentUser = [FCUser currentUser];
//    FCStore * currentStore = [FCStore currentStore];
    return @{// Current User
//             @"current_user":(currentUser.fullName ?: @""),
//             @"current_user_id":(currentUser.userID ?: [NSNull null]),
//             @"current_user_email":(currentUser.emailAddress ?: @""),
//             // Store
//             @"store_id":(currentStore.storeID ?: [NSNull null]),
//             @"store_name":(currentStore.title ?: @""),
//             @"store_type": (currentStore.isRestaurantFeaturesEnabled ? @"Restaurant" : @"Retail"),
//             @"terminal_type": @([FCDevice currentTerminalType]),
//             @"timezone":(currentStore.timezone ?: @""),
//             // Device
//             @"device_id":[[[UIDevice currentDevice] identifierForVendor] UUIDString],
//             @"lan_ip":([IPAddress LANIP] ?: @""),
//             // Thread
//             @"main_thread": @([NSThread isMainThread])
             };
}

+ (void)_serializeDictionary:(NSDictionary *)dict
                  intoString:(NSMutableString *)string
                   blacklist:(NSArray *)blacklist
{
    [string appendString:@"{"];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        if (!blacklist || ![blacklist containsObject:key]) {
            [string appendFormat:@"\"%@\":", key];
            
            NSArray *blacklist = [key isEqualToString:@"credit_cards"] ? [self creditCardBlacklist] : nil;
            
            if ([obj isKindOfClass:[NSDictionary class]]) {
                [self _serializeDictionary:(NSDictionary *)obj intoString:string blacklist:blacklist];
            } else if ([obj isKindOfClass:[NSArray class]]) {
                [string appendString:@"["];
                if ([(NSArray *)obj count]) {
                    for (id item in (NSArray *)obj) {
                        if ([item isKindOfClass:[NSDictionary class]]) {
                            [self _serializeDictionary:(NSDictionary *)item intoString:string blacklist:blacklist];
                        } else {
                            [string appendFormat:@"\"%@\",", item];
                        }
                    }
                    [string replaceCharactersInRange:NSMakeRange(string.length - 1, 1)
                                          withString:@"],"]; // replace last "," w/ "],"
                } else {
                    [string appendString:@"],"];
                }
            } else {
                if ([obj isKindOfClass:[NSString class]]) {
                    [string appendFormat:@"\"%@\",", [(NSString *)obj stringByReplacingOccurrencesOfString:@"\"" withString:@"'"]];
                } else {
                    [string appendFormat:@"\"%@\",", obj];
                }
            }
        }
    }];
    [string replaceCharactersInRange:NSMakeRange(string.length - 1, 1)
                          withString:@"},"];
}

#pragma mark - Public

+ (NSString *)serializedLogInfo:(NSDictionary *)logInfo extraInfo:(NSDictionary *)extraInfo
{
#ifdef DEBUG
    assert(logInfo == nil || [logInfo isKindOfClass:[NSDictionary class]]);
    assert(extraInfo == nil || [extraInfo isKindOfClass:[NSDictionary class]]);
#endif // END #ifdef DEBUG
    NSMutableDictionary * finalLogInfo = [NSMutableDictionary dictionaryWithDictionary:[self _basicInfoToLogRemotely]];
    if (logInfo) [finalLogInfo addEntriesFromDictionary:logInfo];
    if (extraInfo) [finalLogInfo addEntriesFromDictionary:@{@"data": extraInfo}];
    /*
     NSMutableString * serializedLog = [NSMutableString stringWithFormat:@"{"];
     [finalLogInfo enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
     [serializedLog appendFormat:@"\"%@\":\"%@\",", key, obj];
     }];
     [serializedLog replaceCharactersInRange:NSMakeRange(serializedLog.length - 1, 1)
     withString:@"}"];
     */
    NSMutableString * serializedLog = [NSMutableString string];
    [self _serializeDictionary:finalLogInfo intoString:serializedLog blacklist:nil];
    [serializedLog replaceCharactersInRange:NSMakeRange(serializedLog.length - 1, 1) withString:@""]; // rm last ","
    return serializedLog;
}

+ (NSString *)displayNameForLogFlag:(int)flag
{
    if (flag & BPLOG_FLAG_DEBUG) {
        return @"debug";
    } else if (flag & BPLOG_FLAG_INFO) {
        return @"info";
    } else if (flag & BPLOG_FLAG_NOTICE) {
        return @"notice";
    } else if (flag & BPLOG_FLAG_WARN) {
        return @"warn";
    } else if (flag & BPLOG_FLAG_ERROR) {
        return @"error";
    } else if (flag & BPLOG_FLAG_FATAL) {
        return @"fatal";
    }
    return @"unknown";
}


+ (NSString *)logInfoWithFlag:(int)flag event:(NSString *)event info:(NSDictionary *)info messsage:(NSString *)format, ...  {
    NSString *message = @"";
    if (format) {
        va_list args;
        va_start(args, format);
        message = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
    }
    
    // prevent messy json logs when debug
#ifdef DEBUG
    if (info) {
        return  [NSString stringWithFormat:@"%@, %@", message, info];
    }
    return message;
#endif
    
    return [self serializedLogInfo:@{@"bp_level":[self displayNameForLogFlag:flag], @"bp_event":(event?:@""), @"bp_message":message} extraInfo:info];
}


+ (void)uploadLogWithFileNamePostfix:(NSString *)fileNamePostfix
                          completion:(void (^)(NSError *error))completion {
    
//    NSString *folder = [NSString stringWithFormat:@"%@/%@%@",
//                        [[FCStore currentStore] storeID],
//                        [[BPDateFormatter sharedDateTimeDashStyle2Formatter] stringFromDate:[NSDate date]],
//                        (fileNamePostfix.length > 0) ? [NSString stringWithFormat:@"-%@",fileNamePostfix] : @""];
//
//    NSString *dbName = [NSString stringWithFormat:@"%@/db.zip", folder];
//
//    // Upload DB
//
//    AFAmazonS3Manager *s3Manager = [[AFAmazonS3Manager alloc] initWithAccessKeyID:AWSS3AccessKey secret:AWSS3SecretKey];
//    s3Manager.requestSerializer.region = AFAmazonS3APNortheast2Region;
//    s3Manager.requestSerializer.bucket = AWSS3BucketName;
//
//    NSString *dbFilePath = [self dbZipFilePath];
//
//    [s3Manager  putObjectWithFile:dbFilePath
//                  destinationPath:dbName
//                       parameters:nil
//                         progress:nil
//                          success:^(NSURLResponse *response, id responseObject) {
//                              BPLogFatal(@"DB Upload Complete: %@", responseObject);
//                              [[NSFileManager defaultManager] removeItemAtPath:dbFilePath error:nil];
//                              if (completion) {
//                                  completion(nil);
//                              }
//                          }
//                          failure:^(NSURLResponse *response, NSError *error) {
//
//                              BPLogFatal(@"Uploading DB got error: %@", [error localizedDescription]);
//                              [[NSFileManager defaultManager] removeItemAtPath:dbFilePath error:nil];
//
//
//                              if (completion) {
//                                  completion(error);
//                              }
//                          }];
    
}

+ (NSString *)dbZipFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"bindo_pos_v1.sqlite3"];
    
    NSString *tempDBFile = [NSTemporaryDirectory() stringByAppendingString:@"tempdb.zip"];
//    if ([SSZipArchive createZipFileAtPath:tempDBFile withFilesAtPaths:@[filePath]]) {
//        return tempDBFile;
//    }
    
    return nil;
}


+ (void)uploadScreenshot {
//    dispatch_async(dispatch_get_main_queue(), ^(void) {
//        UIView *screenshotView = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
//        UIGraphicsBeginImageContextWithOptions(screenshotView.bounds.size, YES, 0.0);
//        [screenshotView drawViewHierarchyInRect:screenshotView.bounds afterScreenUpdates:YES];
//        UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        NSData * data = UIImageJPEGRepresentation(img, 0.5);
//
//        NSString * fullPath = [NSTemporaryDirectory() stringByAppendingString:@"screenshot.jpg"];
//
//        [data writeToFile:fullPath atomically:YES];
//
//        AFAmazonS3Manager *s3Manager = [[AFAmazonS3Manager alloc] initWithAccessKeyID:AWSS3AccessKey secret:AWSS3SecretKey];
//        s3Manager.requestSerializer.region = AFAmazonS3APNortheast2Region;
//        s3Manager.requestSerializer.bucket = AWSS3BucketName;
//
//        NSString *folder = [NSString stringWithFormat:@"%@/%@",[[FCStore currentStore] storeID], [[BPDateFormatter sharedDateTimeDashStyle2Formatter] stringFromDate:[NSDate date]]];
//
//        NSString *fileName = [NSString stringWithFormat:@"%@/screenshot.jpg", folder];
//
//        [s3Manager  putObjectWithFile:fullPath
//                      destinationPath:fileName
//                           parameters:nil
//                             progress:nil
//                              success:^(NSURLResponse *response, id responseObject) {
//                                  BPLogFatal(@"Screenshot Upload Complete: %@", responseObject);
//                                  [[NSFileManager defaultManager] removeItemAtPath:fullPath error:nil];
//
//                              }
//                              failure:^(NSURLResponse *response, NSError *error) {
//                                  BPLogFatal(@"Uploading Screenshot got error: %@", [error localizedDescription]);
//                                  [[NSFileManager defaultManager] removeItemAtPath:fullPath error:nil];
//
//                              }];
//    });
    
    
}



@end
