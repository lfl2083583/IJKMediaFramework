
#import "BANetManager.h"

#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>

/*! 系统相册 */
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>



//#import "BANetManagerCache.h"
//#import "TPSBaseViewController.h"
//#import "TPSWelcomeToLoginVC.h"
//#import "TPSLoginVC.h"

static NSMutableArray *tasks;

//static void *isNeedCacheKey = @"isNeedCacheKey";

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...){}
#endif

@interface BANetManager ()



@end

@implementation BANetManager

+ (instancetype)sharedBANetManager
{
    /*! 为单例对象创建的静态实例，置为nil，因为对象的唯一性，必须是static类型 */
    static id sharedBANetManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBANetManager = [[super allocWithZone:NULL] init];
    });
    return sharedBANetManager;
}

+ (void)initialize
{
    [self setupBANetManager];
}

+ (void)setupBANetManager
{
    BANetManagerShare.sessionManager = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:BaseServer]];
    BANetManagerShare.requestSerializer = BAHttpRequestSerializerHTTP;
    BANetManagerShare.responseSerializer = BAHttpResponseSerializerJSON;
    
    /*! 设置请求超时时间，默认：20秒 */
    BANetManagerShare.timeoutInterval = 20;
    /*! 打开状态栏的等待菊花 */
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    /*! 设置返回数据类型为 json, 分别设置请求以及相应的序列化器 */
    /*!
     根据服务器的设定不同还可以设置：
     json：[AFJSONResponseSerializer serializer](常用)
     http：[AFHTTPResponseSerializer serializer]
     */
//    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
//    /*! 这里是去掉了键值对里空对象的键值 */
////    response.removesKeysWithNullValues = YES;
//    BANetManagerShare.sessionManager.responseSerializer = response;
    
    /* 设置请求服务器数类型式为 json */
    /*!
     根据服务器的设定不同还可以设置：
     json：[AFJSONRequestSerializer serializer](常用)
     http：[AFHTTPRequestSerializer serializer]
     */
//    AFJSONRequestSerializer *request = [AFJSONRequestSerializer serializer];
//    BANetManagerShare.sessionManager.requestSerializer = request;
    /*! 设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用*/
    //        [manager.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];
    
    /*! 复杂的参数类型 需要使用json传值-设置请求内容的类型*/
    //        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    /*! 设置响应数据的基本类型 */
    BANetManagerShare.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/xml", @"text/plain", @"application/javascript", @"image/*", nil];
    
    // 配置自建证书的Https请求
//    [self ba_setupSecurityPolicy];
//    if ([BaseServer hasPrefix:@"https"]) {
//        [self ba_setupCustomSecurityPolicy];
//    }
}

+ (void)ba_setupCustomSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"app2.yunke138.com" ofType:@"cer"];//证书的路径
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    BANetManagerShare.sessionManager.securityPolicy = securityPolicy;
}

/**
 配置自建证书的Https请求，只需要将CA证书文件放入根目录就行
 */
+ (void)ba_setupSecurityPolicy
{
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"app2.yunke138.com" ofType:@"cer"];
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
    
    if (cerSet.count == 0)
    {
        /*!
         采用默认的defaultPolicy就可以了. AFN默认的securityPolicy就是它, 不必另写代码. AFSecurityPolicy类中会调用苹果security.framework的机制去自行验证本次请求服务端放回的证书是否是经过正规签名.
         */
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        BANetManagerShare.sessionManager.securityPolicy = securityPolicy;
    }else{
        /*! 自定义的CA证书配置如下： */
        /*! 自定义security policy, 先前确保你的自定义CA证书已放入工程Bundle */
        /*!
         https://api.github.com网址的证书实际上是正规CADigiCert签发的, 这里把Charles的CA根证书导入系统并设为信任后, 把Charles设为该网址的SSL Proxy (相当于"中间人"), 这样通过代理访问服务器返回将是由Charles伪CA签发的证书.
         */
        // 使用证书验证模式
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        // 如果需要验证自建证书(无效证书)，需要设置为YES
        securityPolicy.allowInvalidCertificates = YES;
        // 是否需要验证域名，默认为YES
        securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
        
        BANetManagerShare.sessionManager.securityPolicy = securityPolicy;
        
        /*! 如果服务端使用的是正规CA签发的证书, 那么以下几行就可去掉: */
        NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        policy.allowInvalidCertificates = YES;
        BANetManagerShare.sessionManager.securityPolicy = policy;
    }
}

/**
 网络请求的实例方法 get
 
 @param urlString 请求的地址
 @param isNeedCache 是否需要缓存，只有 get / post 请求有缓存配置
 @param parameters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progress 进度
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_request_GETWithUrlString:(NSString *)urlString
                                      isNeedCache:(BOOL)isNeedCache
                                       parameters:(NSDictionary *)parameters
                                     successBlock:(BAResponseSuccess)successBlock
                                        failureBlock:(BAResponseFail)failureBlock
                                         progress:(BADownloadProgress)progress
{
    return [self ba_requestWithType:BAHttpRequestTypeGet isNeedCache:isNeedCache urlString:urlString parameters:parameters successBlock:successBlock failureBlock:failureBlock progress:progress];
}

/**
 网络请求的实例方法 post
 
 @param urlString 请求的地址
 @param isNeedCache 是否需要缓存，只有 get / post 请求有缓存配置
 @param parameters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progress 进度
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_request_POSTWithUrlString:(NSString *)urlString
                                       isNeedCache:(BOOL)isNeedCache
                                       parameters:(NSDictionary *)parameters
                                     successBlock:(BAResponseSuccess)successBlock
                                     failureBlock:(BAResponseFail)failureBlock
                                         progress:(BADownloadProgress)progress
{
    return [self ba_requestWithType:BAHttpRequestTypePost isNeedCache:isNeedCache urlString:urlString parameters:parameters successBlock:successBlock failureBlock:failureBlock progress:progress];
}

/**
 网络请求的实例方法 put
 
 @param urlString 请求的地址
 @param parameters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progress 进度
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_request_PUTWithUrlString:(NSString *)urlString
                                        parameters:(NSDictionary *)parameters
                                      successBlock:(BAResponseSuccess)successBlock
                                      failureBlock:(BAResponseFail)failureBlock
                                          progress:(BADownloadProgress)progress
{
    return [self ba_requestWithType:BAHttpRequestTypePut isNeedCache:NO urlString:urlString parameters:parameters successBlock:successBlock failureBlock:failureBlock progress:progress];
}

/**
 网络请求的实例方法 delete
 
 @param urlString 请求的地址
 @param parameters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progress 进度
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_request_DELETEWithUrlString:(NSString *)urlString
                                       parameters:(NSDictionary *)parameters
                                     successBlock:(BAResponseSuccess)successBlock
                                     failureBlock:(BAResponseFail)failureBlock
                                         progress:(BADownloadProgress)progress
{
    return [self ba_requestWithType:BAHttpRequestTypeDelete isNeedCache:NO urlString:urlString parameters:parameters successBlock:successBlock failureBlock:failureBlock progress:progress];
}

#pragma mark - 网络请求的类方法 --- get / post / put / delete
/*!
 *  网络请求的实例方法
 *
 *  @param type         get / post / put / delete
 *  @param isNeedCache  是否需要缓存，只有 get / post 请求有缓存配置
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 *  @param progress 进度
 */
+ (BAURLSessionTask *)ba_requestWithType:(BAHttpRequestType)type
                             isNeedCache:(BOOL)isNeedCache
                               urlString:(NSString *)urlString
                              parameters:(NSDictionary *)parameters
                            successBlock:(BAResponseSuccess)successBlock
                            failureBlock:(BAResponseFail)failureBlock
                                progress:(BADownloadProgress)progress
{
    if (urlString == nil)
    {
        return nil;
    }
    
    BAWeak;
    /*! 检查地址中是否有中文 */
    NSString *URLString = [NSURL URLWithString:urlString] ? urlString : [self strUTF8Encoding:urlString];
    
    NSString *requestType;
    switch (type) {
        case 0:
            requestType = @"GET";
            break;
        case 1:
            requestType = @"POST";
            break;
        case 2:
            requestType = @"PUT";
            break;
        case 3:
            requestType = @"DELETE";
            break;
            
        default:
            break;
    }
    
    //登陆后请求统一加上userId和token
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        parameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    } else {
        parameters = [NSMutableDictionary dictionary];
    }
    
    

    AFHTTPSessionManager *scc = BANetManagerShare.sessionManager;
    AFHTTPResponseSerializer *scc2 = scc.responseSerializer;
    AFHTTPRequestSerializer *scc3 = scc.requestSerializer;
    
    
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:isLogin];
    id token = [[NSUserDefaults standardUserDefaults] objectForKey:userToken];
    [scc3 setValue:@"application/x-www-form-urlencoded ;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [scc3 setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [scc3 setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    if (URLString && [URLString containsString:@"auth/oauth/token"]) {
        [scc3 setValue:@"Basic YXBwbGljYXRpb246YXBwbGljYXRpb24=" forHTTPHeaderField:@"Authorization"];
    }
    if (token && value && [value boolValue] == YES && KFormat(token).length > 0) {
        [scc3 setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    }
    
    
//    int lang = 1;
//    if ([RNLanguageManager shareManager].languageType == 0) {
//        lang = 1;
//    } else if ([RNLanguageManager shareManager].languageType == 1) {
//        lang = 2;
//    } else if ([RNLanguageManager shareManager].languageType == 2) {
//        lang = 3;
//    }
//
//    [scc3 setValue:[NSString stringWithFormat:@"%d", [RNLanguageManager shareManager].languageType] forHTTPHeaderField:@"lang"];
    
    
//    [scc3 setValue:[SystemUtils getTokenWithParams:parameters] forHTTPHeaderField:@"success-token"];
//    [scc3 setValue:[SystemUtils getUser_Agent] forHTTPHeaderField:@"User-Agent"];
    NSTimeInterval timeoutInterval = BANetManagerShare.timeoutInterval;
    
    NSString *isCache = isNeedCache ? @"开启":@"关闭";
    //CGFloat allCacheSize = [BANetManagerCache ba_getAllHttpCacheSize];
    
    NSLog(@"\n******************** 请求参数 ***************************");
   // NSLog(@"\n请求头: %@\n超时时间设置：%.1f 秒【默认：30秒】\nAFHTTPResponseSerializer：%@【默认：AFJSONResponseSerializer】\nAFHTTPRequestSerializer：%@【默认：AFJSONRequestSerializer】\n请求方式: %@\n请求URL: %@\n请求param: %@\n是否启用缓存：%@【默认：开启】\n目前总缓存大小：%.6fM\n", BANetManagerShare.sessionManager.requestSerializer.HTTPRequestHeaders, timeoutInterval, scc2, scc3, requestType, URLString, parameters, isCache, allCacheSize);
    NSLog(@"\n********************************************************");

    BAURLSessionTask *sessionTask = nil;
    
    // 读取缓存
//    id responseCacheData = [BANetManagerCache ba_httpCacheWithUrlString:urlString parameters:parameters];
//
//    if (isNeedCache && responseCacheData != nil)
//    {
//        if (successBlock)
//        {
//            successBlock(responseCacheData);
//        }
//        NSLog(@"取用缓存数据成功： *** %@", responseCacheData);
//
//        [[weakSelf tasks] removeObject:sessionTask];
//        return nil;
//    }
    
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:parameters?parameters:@{}];
    mutableDictionary[@"WORDS"] = @([RNLanguageManager shareManager].languageType);
    if (type == BAHttpRequestTypeGet)
    {
        sessionTask = [BANetManagerShare.sessionManager GET:URLString parameters:mutableDictionary  progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //[weakSelf checkUserStateWithResponse:responseObject url:URLString];
            NSDictionary *dict = responseObject;
            NSNumber *code = dict[@"code"];
//            if (code.integerValue == RES_CODE_USER_BAN || code.integerValue == RES_CODE_DISABLED || code.integerValue == 1015 || code.integerValue == 1013) {
//                return;
//            }
            if (successBlock)
            {
                successBlock(responseObject);
            }
            // 对数据进行异步缓存
//            [BANetManagerCache ba_setHttpCache:responseObject urlString:urlString parameters:parameters];
            [[weakSelf tasks] removeObject:sessionTask];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
            if (failureBlock)
            {
                failureBlock(error);
            }
            [[weakSelf tasks] removeObject:sessionTask];
            
        }];
        
    }
    else if (type == BAHttpRequestTypePost)
    {
        sessionTask = [BANetManagerShare.sessionManager POST:URLString parameters:mutableDictionary progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //[weakSelf checkUserStateWithResponse:responseObject url:URLString];
            NSDictionary *dict = responseObject;
            NSNumber *code = dict[@"code"];
//            if (code.integerValue == RES_CODE_USER_BAN || code.integerValue == RES_CODE_DISABLED || code.integerValue == 1015 || code.integerValue == 1013) {
//                [YZHubTool hide];
//                return;
//            }
            if (successBlock)
            {
                successBlock(responseObject);
            }
            NSLog(@"post请求数据成功： *** %@", responseObject);

            // 对数据进行异步缓存
//            [BANetManagerCache ba_setHttpCache:responseObject urlString:urlString parameters:parameters];
            [[weakSelf tasks] removeObject:sessionTask];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failureBlock)
            {
                failureBlock(error);
                NSLog(@"错误信息：%@",error);
            }
            [[weakSelf tasks] removeObject:sessionTask];
            
        }];
    }
    else if (type == BAHttpRequestTypePut)
    {
        sessionTask = [BANetManagerShare.sessionManager PUT:URLString parameters:mutableDictionary success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //[weakSelf checkUserStateWithResponse:responseObject url:URLString];
            
            if (successBlock)
            {
                successBlock(responseObject);
            }
            
            [[weakSelf tasks] removeObject:sessionTask];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failureBlock)
            {
                failureBlock(error);
            }
            [[weakSelf tasks] removeObject:sessionTask];
            
        }];
    }
    else if (type == BAHttpRequestTypeDelete)
    {
        sessionTask = [BANetManagerShare.sessionManager DELETE:URLString parameters:mutableDictionary success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //[weakSelf checkUserStateWithResponse:responseObject url:URLString];
            
            if (successBlock)
            {
                successBlock(responseObject);
            }
            
            [[weakSelf tasks] removeObject:sessionTask];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failureBlock)
            {
                failureBlock(error);
            }
            [[weakSelf tasks] removeObject:sessionTask];
            
        }];
    }
        
    if (sessionTask)
    {
        [[weakSelf tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}

/**
 上传图片(多图)
 
 @param urlString 上传的url
 @param parameters 上传图片预留参数---视具体情况而定 可移除
 @param imageArray 上传的图片数组
 @param fileName 上传的图片数组fileName
 @param successBlock 上传成功的回调
 @param failureBlock 上传失败的回调
 @param progress 上传进度
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_uploadImageWithUrlString:(NSString *)urlString
                                       parameters:(NSDictionary *)parameters
                                       imageArray:(NSArray *)imageArray
                                         fileName:(NSString *)fileName
                                     successBlock:(BAResponseSuccess)successBlock
                                      failurBlock:(BAResponseFail)failureBlock
                                   upLoadProgress:(BAUploadProgress)progress
{
    if (urlString == nil)
    {
        return nil;
    }
    AFHTTPSessionManager *scc = BANetManagerShare.sessionManager;
    AFHTTPRequestSerializer *scc3 = scc.requestSerializer;
    
    //登陆后请求统一加上userId和token
    //登陆后请求统一加上userId和token
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        parameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    } else {
        parameters = [NSMutableDictionary dictionary];
    }
//    if (kID) {
//        ((NSMutableDictionary *)parameters)[@"userId"] = kID;
//        if (kGetToken) {
//            ((NSMutableDictionary *)parameters)[@"token"] = kGetToken;
//        }
//    }
//
//    [scc3 setValue:[SystemUtils getTokenWithParams:parameters] forHTTPHeaderField:@"success-token"];
//    [scc3 setValue:[SystemUtils getUser_Agent] forHTTPHeaderField:@"User-Agent"];
    BAWeak;
    /*! 检查地址中是否有中文 */
    NSString *URLString = [NSURL URLWithString:urlString] ? urlString : [self strUTF8Encoding:urlString];
    
    NSLog(@"******************** 请求参数 ***************************");
    NSLog(@"请求头: %@\n请求方式: %@\n请求URL: %@\n请求param: %@\n\n",BANetManagerShare.sessionManager.requestSerializer.HTTPRequestHeaders, @"POST",URLString, parameters);
    NSLog(@"******************************************************");
    BAURLSessionTask *sessionTask = nil;
    sessionTask = [BANetManagerShare.sessionManager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /*! 出于性能考虑,将上传图片进行压缩 */
        [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
//            /*! image的压缩方法 */
//            UIImage *resizedImage;
//            /*! 此处是使用原生系统相册 */
//            if([obj isKindOfClass:[ALAsset class]])
//            {
//                // 用ALAsset获取Asset URL  转化为image
//                ALAssetRepresentation *assetRep = [obj defaultRepresentation];
//
//                CGImageRef imgRef = [assetRep fullResolutionImage];
//                resizedImage = [UIImage imageWithCGImage:imgRef
//                                                   scale:1.0
//                                             orientation:(UIImageOrientation)assetRep.orientation];
//                //                imageWithImage
//                NSLog(@"1111-----size : %@",NSStringFromCGSize(resizedImage.size));
//
//                resizedImage = [weakSelf imageWithImage:resizedImage scaledToSize:resizedImage.size];
//                NSLog(@"2222-----size : %@",NSStringFromCGSize(resizedImage.size));
//            }
//            else
//            {
//                /*! 此处是使用其他第三方相册，可以自由定制压缩方法 */
//                resizedImage = obj;
//            }
//
//            /*! 此处压缩方法是jpeg格式是原图大小的0.8倍，要调整大小的话，就在这里调整就行了还是原图等比压缩 */
//            NSData *imgData = UIImageJPEGRepresentation(resizedImage, 0.8);
//
//            /*! 拼接data */
//            if (imgData != nil)
//            {   // 图片数据不为空才传递 fileName
//                //                [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picflie%ld",(long)i] fileName:@"image.png" mimeType:@" image/jpeg"];
//
//                [formData appendPartWithFileData:imgData
//                                            name:[NSString stringWithFormat:@"picflie%ld",(long)idx]
//                                        fileName:fileName
//                                        mimeType:@"image/jpeg"];
//
//            }
            
            /*! 拼接data */
            NSData *imgData = obj;
            if (imgData != nil)
            {   // 图片数据不为空才传递 fileName
                //                [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picflie%ld",(long)i] fileName:@"image.png" mimeType:@" image/jpeg"];
                
                [formData appendPartWithFileData:imgData
                                            name:fileName
                                        fileName:@"image.png"
                                        mimeType:@"image/png"];
                
            }
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        
        if (progress)
        {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //[weakSelf checkUserStateWithResponse:responseObject url:URLString];
        
        NSLog(@"上传图片成功 = %@",responseObject);
        
        if (successBlock)
        {
            successBlock(responseObject);
        }
        
        [[weakSelf tasks] removeObject:sessionTask];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failureBlock)
        {
            failureBlock(error);
        }
        [[weakSelf tasks] removeObject:sessionTask];
    }];
    
    if (sessionTask)
    {
        [[weakSelf tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}

+ (BAURLSessionTask *)ba_uploadImagesWithUrlString:(NSString *)urlString
                                       parameters:(NSDictionary *)parameters
                                       imageArray:(NSArray *)imageArray
                                         fileNames:(NSArray *)fileNames
                                     successBlock:(BAResponseSuccess)successBlock
                                      failurBlock:(BAResponseFail)failureBlock
                                   upLoadProgress:(BAUploadProgress)progress
{
//    if (urlString == nil)
//    {
//        return nil;
//    }
//    AFHTTPSessionManager *scc = BANetManagerShare.sessionManager;
//    AFHTTPRequestSerializer *scc3 = scc.requestSerializer;
//
//    //登陆后请求统一加上userId和token
//    if ([parameters isKindOfClass:[NSMutableDictionary class]] || [parameters isKindOfClass:[NSDictionary class]]) {
//        if (kID) {
//            ((NSMutableDictionary *)parameters)[@"userId"] = kID;
//            if (kGetToken) {
//                ((NSMutableDictionary *)parameters)[@"token"] = kGetToken;
//            }
//        }
//    } else {
//        parameters = [NSMutableDictionary dictionary];
//        if (kID) {
//            ((NSMutableDictionary *)parameters)[@"userId"] = kID;
//            if (kGetToken) {
//                ((NSMutableDictionary *)parameters)[@"token"] = kGetToken;
//            }
//        }
//    }
//
//    [scc3 setValue:[SystemUtils getTokenWithParams:parameters] forHTTPHeaderField:@"success-token"];
//    [scc3 setValue:[SystemUtils getUser_Agent] forHTTPHeaderField:@"User-Agent"];
//    BAWeak;
//    /*! 检查地址中是否有中文 */
//    NSString *URLString = [NSURL URLWithString:urlString] ? urlString : [self strUTF8Encoding:urlString];
//
//    NSLog(@"******************** 请求参数 ***************************");
//    NSLog(@"请求头: %@\n请求方式: %@\n请求URL: %@\n请求param: %@\n\n",BANetManagerShare.sessionManager.requestSerializer.HTTPRequestHeaders, @"POST",URLString, parameters);
//    NSLog(@"******************************************************");
//
//    BAURLSessionTask *sessionTask = nil;
//    sessionTask = [BANetManagerShare.sessionManager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        /*! 出于性能考虑,将上传图片进行压缩 */
//        [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//            /*! 拼接data */
//            NSData *imgData = obj;
//            if (imgData != nil)
//            {   // 图片数据不为空才传递 fileName
//
//                [formData appendPartWithFileData:imgData
//                                            name:fileNames[idx]
//                                        fileName:[NSString stringWithFormat:@"%@%@",fileNames[idx],@".png"]
//                                        mimeType:@"image/png"];
//
//            }
//        }];
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//        NSLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
//
//        if (progress)
//        {
//            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
//        }
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        [weakSelf checkUserStateWithResponse:responseObject url:URLString];
//
//        NSLog(@"上传图片成功 = %@",responseObject);
//
//        if (successBlock)
//        {
//            successBlock(responseObject);
//        }
//
//        [[weakSelf tasks] removeObject:sessionTask];
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        if (failureBlock)
//        {
//            failureBlock(error);
//        }
//        [[weakSelf tasks] removeObject:sessionTask];
//    }];
//
//    if (sessionTask)
//    {
//        [[weakSelf tasks] addObject:sessionTask];
//    }
//
//    return sessionTask;
    return nil;
}

/**
 视频上传
 
 @param urlString 上传的url
 @param parameters 上传视频预留参数---视具体情况而定 可移除
 @param videoPath 上传视频的本地沙河路径
 @param successBlock 成功的回调
 @param failureBlock 失败的回调
 @param progress 上传的进度
 */
+ (void)ba_uploadVideoWithUrlString:(NSString *)urlString
                         parameters:(NSDictionary *)parameters
                          videoPath:(NSString *)videoPath
                       successBlock:(BAResponseSuccess)successBlock
                       failureBlock:(BAResponseFail)failureBlock
                     uploadProgress:(BAUploadProgress)progress
{}
//{
//    /*! 获得视频资源 */
//    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:videoPath]  options:nil];
//
//    /*! 压缩 */
//
//    //    NSString *const AVAssetExportPreset640x480;
//    //    NSString *const AVAssetExportPreset960x540;
//    //    NSString *const AVAssetExportPreset1280x720;
//    //    NSString *const AVAssetExportPreset1920x1080;
//    //    NSString *const AVAssetExportPreset3840x2160;
//
//    /*! 创建日期格式化器 */
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//
//    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
//
//    /*! 转化后直接写入Library---caches */
//    NSString *videoWritePath = [NSString stringWithFormat:@"output-%@.mp4",[formatter stringFromDate:[NSDate date]]];
//    NSString *outfilePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", videoWritePath];
//
//    AVAssetExportSession *avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
//
//    avAssetExport.outputURL = [NSURL fileURLWithPath:outfilePath];
//    avAssetExport.outputFileType =  AVFileTypeMPEG4;
//
//    //登陆后请求统一加上userId和token
//    if ([parameters isKindOfClass:[NSMutableDictionary class]] || [parameters isKindOfClass:[NSDictionary class]]) {
//        if (kID) {
//            ((NSMutableDictionary *)parameters)[@"userId"] = kID;
//            if (kGetToken) {
//                ((NSMutableDictionary *)parameters)[@"token"] = kGetToken;
//            }
//        }
//    } else {
//        parameters = [NSMutableDictionary dictionary];
//        if (kID) {
//            ((NSMutableDictionary *)parameters)[@"userId"] = kID;
//            if (kGetToken) {
//                ((NSMutableDictionary *)parameters)[@"token"] = kGetToken;
//            }
//        }
//    }
//
//    [avAssetExport exportAsynchronouslyWithCompletionHandler:^{
//        switch ([avAssetExport status]) {
//            case AVAssetExportSessionStatusCompleted:
//            {
//                [BANetManagerShare.sessionManager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//                    NSURL *filePathURL2 = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@", outfilePath]];
//                    // 获得沙盒中的视频内容
//                    [formData appendPartWithFileURL:filePathURL2 name:@"video" fileName:outfilePath mimeType:@"application/octet-stream" error:nil];
//
//                } progress:^(NSProgress * _Nonnull uploadProgress) {
//                    NSLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
//                    if (progress)
//                    {
//                        progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
//                    }
//                } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
//
//                    NSLog(@"上传视频成功 = %@",responseObject);
//
//                    if (successBlock)
//                    {
//                        successBlock(responseObject);
//                    }
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    NSLog(@"上传视频失败 = %@", error);
//                    if (failureBlock)
//                    {
//                        failureBlock(error);
//                    }
//                }];
//                break;
//            }
//            default:
//                break;
//        }
//    }];
//}

#pragma mark - ***** 文件下载
/**
 文件下载
 
 @param urlString 请求的url
 @param parameters 文件下载预留参数---视具体情况而定 可移除
 @param savePath 下载文件保存路径
 @param successBlock 下载文件成功的回调
 @param failureBlock 下载文件失败的回调
 @param progress 下载文件的进度显示
 @return BAURLSessionTask
 */
+ (BAURLSessionTask *)ba_downLoadFileWithUrlString:(NSString *)urlString
                                        parameters:(NSDictionary *)parameters
                                          savaPath:(NSString *)savePath
                                      successBlock:(BAResponseSuccess)successBlock
                                      failureBlock:(BAResponseFail)failureBlock
                                  downLoadProgress:(BADownloadProgress)progress
{
    if (urlString == nil)
    {
        return nil;
    }

    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    NSLog(@"******************** 请求参数 ***************************");
    NSLog(@"请求头: %@\n请求方式: %@\n请求URL: %@\n请求param: %@\n\n",BANetManagerShare.sessionManager.requestSerializer.HTTPRequestHeaders, @"download",urlString, parameters);
    NSLog(@"******************************************************");

    
    BAURLSessionTask *sessionTask = nil;
    
    sessionTask = [BANetManagerShare.sessionManager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"下载进度：%.2lld%%",100 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        /*! 回到主线程刷新UI */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (progress)
            {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
            
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        if (!savePath)
        {
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        }
        else
        {
            return [NSURL fileURLWithPath:savePath];
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self tasks] removeObject:sessionTask];
        
        NSLog(@"下载文件成功");
        if (error == nil)
        {
            if (successBlock)
            {
                /*! 返回完整路径 */
                successBlock([filePath path]);
            }
            else
            {
                if (failureBlock)
                {
                    failureBlock(error);
                }
            }
        }
    }];
    
    /*! 开始启动任务 */
    [sessionTask resume];
    
    if (sessionTask)
    {
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
}

#pragma mark - 网络状态监测
/*!
 *  开启网络监测
 */
+ (void)ba_startNetWorkMonitoringWithBlock:(BANetworkStatusBlock)networkStatus
{
    /*! 1.获得网络监控的管理者 */
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    /*! 当使用AF发送网络请求时,只要有网络操作,那么在状态栏(电池条)wifi符号旁边显示  菊花提示 */
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    /*! 2.设置网络状态改变后的处理 */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*! 当网络状态改变了, 就会调用这个block */
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                networkStatus ? networkStatus(BANetworkStatusUnknown) : nil;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                networkStatus ? networkStatus(BANetworkStatusNotReachable) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机自带网络");
                networkStatus ? networkStatus(BANetworkStatusReachableViaWWAN) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi 网络");
                networkStatus ? networkStatus(BANetworkStatusReachableViaWiFi) : nil;
                break;
        }
    }];
    [manager startMonitoring];
}

#pragma mark - 取消 Http 请求
/*!
 *  取消所有 Http 请求
 */
+ (void)ba_cancelAllRequest
{
    // 锁操作
    @synchronized(self)
    {
        [[self tasks] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self tasks] removeAllObjects];
    }
}

/*!
 *  取消指定 URL 的 Http 请求
 */
+ (void)ba_cancelRequestWithURL:(NSString *)URL
{
    if (!URL)
    {
        return;
    }
    @synchronized (self)
    {
        [[self tasks] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL])
            {
                [task cancel];
                [[self tasks] removeObject:task];
                *stop = YES;
            }
        }];
    }
}


#pragma mark - 压缩图片尺寸
/*! 对图片尺寸进行压缩 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    if (newSize.height > 375/newSize.width*newSize.height)
    {
        newSize.height = 375/newSize.width*newSize.height;
    }
    
    if (newSize.width > 375)
    {
        newSize.width = 375;
    }
    
    UIImage *newImage = nil;//[UIImage needCenterImage:image size:newSize scale:1.0];
    
    return newImage;
}

#pragma mark - url 中文格式化
+ (NSString *)strUTF8Encoding:(NSString *)str
{
    /*! ios9适配的话 打开第一个 */
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0)
    {
         return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    }
    else
    {
        return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

#pragma mark - setter / getter
/**
 存储着所有的请求task数组
 
 @return 存储着所有的请求task数组
 */
+ (NSMutableArray *)tasks
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"创建数组");
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval
{
    _timeoutInterval = timeoutInterval;
    BANetManagerShare.sessionManager.requestSerializer.timeoutInterval = timeoutInterval;
}

- (void)setRequestSerializer:(BAHttpRequestSerializer)requestSerializer
{
    _requestSerializer = requestSerializer;
    switch (requestSerializer) {
        case BAHttpRequestSerializerJSON:
        {
            BANetManagerShare.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer] ;
        }
            break;
        case BAHttpRequestSerializerHTTP:
        {
            BANetManagerShare.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer] ;
        }
            break;
            
        default:
            break;
    }
}

- (void)setResponseSerializer:(BAHttpResponseSerializer)responseSerializer
{
    _responseSerializer = responseSerializer;
    switch (responseSerializer) {
        case BAHttpResponseSerializerJSON:
        {
            BANetManagerShare.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer] ;
        }
            break;
        case BAHttpResponseSerializerHTTP:
        {
            BANetManagerShare.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
        }
            break;
            
        default:
            break;
    }
}

- (void)setHttpHeaderFieldDictionary:(NSDictionary *)httpHeaderFieldDictionary
{
    _httpHeaderFieldDictionary = httpHeaderFieldDictionary;
    
    if (![httpHeaderFieldDictionary isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"请求头数据有误，请检查！");
        return;
    }
    NSArray *keyArray = httpHeaderFieldDictionary.allKeys;
    
    if (keyArray.count <= 0)
    {
        NSLog(@"请求头数据有误，请检查！");
        return;
    }
    
    for (NSInteger i = 0; i < keyArray.count; i ++)
    {
        NSString *keyString = keyArray[i];
        NSString *valueString = httpHeaderFieldDictionary[keyString];
        
        [BANetManager ba_setValue:valueString forHTTPHeaderKey:keyString];
    }
}

/**
 *  自定义请求头
 */
+ (void)ba_setValue:(NSString *)value forHTTPHeaderKey:(NSString *)HTTPHeaderKey
{
    [BANetManagerShare.sessionManager.requestSerializer setValue:value forHTTPHeaderField:HTTPHeaderKey];
}

//检查用户状态
//+ (void)checkUserStateWithResponse:(id)response url:(NSString *)urlString {
//    if (response) {
//        NSNumber *codeValue = TPSDynamicCast(NSNumber, response[@"code"]);
//        if (codeValue.integerValue == RES_CODE_USER_BAN && App_Delegate.isAccountAbnormal == NO) {
//            App_Delegate.isAccountAbnormal = YES;
//            // 账号禁用，可申诉
//            NSDictionary *data = response[@"data"];
//            NSString *userID = data[@"userId"];
//            NSString *appealUrl = data[@"appealUrl"];
//            if ([appealUrl containsString:@"?"]) {
//                appealUrl = [appealUrl yz_appendString:[NSString stringWithFormat:@"&userId=%@", userID]];
//            } else {
//                appealUrl = [appealUrl yz_appendString:[NSString stringWithFormat:@"?userId=%@", userID]];
//            }
//            [YZAppService yz_AlertWithUserBan:response[@"desc"] appealUrl:appealUrl];
//        }
//        else if (codeValue.integerValue == RES_CODE_DISABLED && App_Delegate.isAccountAbnormal == NO){
//            App_Delegate.isAccountAbnormal = YES;
//            [YZAppService yz_AlertWithUserDisabled];
//        }
//        else if(codeValue.integerValue == 1015 && App_Delegate.isAccountAbnormal == NO) {
//            App_Delegate.isAccountAbnormal = YES;
//            // token 过期，提示被挤掉
//            [YZAppService yz_AlertWithTokenOverdue];
//        }else if(codeValue.integerValue == 1013) {
//            [YZHubTool showText:response[@"desc"]];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [YZAppService logout];
//            });
//        }
//    }
//}

@end
