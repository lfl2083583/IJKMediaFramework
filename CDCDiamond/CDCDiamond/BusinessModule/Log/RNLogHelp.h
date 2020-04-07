//
//  RNLogHelp.h
//  RapNet
//
//  Created by liufulin on 2019/7/15.
//  Copyright © 2019 lptechnology. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RNLogHelp : NSObject

+ (NSString *)serializedLogInfo:(NSDictionary *)logInfo extraInfo:(NSDictionary *)extraInfo;
+ (NSString *)logInfoWithFlag:(int)flag event:(NSString *)event info:(NSDictionary *)info messsage:(NSString *)format , ...;
+ (NSString *)displayNameForLogFlag:(int)flag;

/// The folder will be sid/date_time-fileNamePostfix   eg.  2017-08-01 13:36:33-postfix   2017-08-01 13:36:33
+ (void)uploadLogWithFileNamePostfix:(NSString *)fileNamePostfix
                          completion:(void (^)(NSError *error))completion;

+ (void)uploadScreenshot;
@end

