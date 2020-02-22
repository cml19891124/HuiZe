#import "HUZNetWorkTool.h"
#import<CoreTelephony/CTCellularData.h>
#import "AFNetworking.h"
#import "HUZUploadParam.h"

@interface HUZNetWorkTool()

@end

@implementation HUZNetWorkTool

+ (AFHTTPSessionManager *)sessionManager {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/encode", nil];
    NSString *token = HUZUserCenterManager.userModel.token;
    HUZLOG(@"token: %@", token);
    if (token.length >  0) {
        [sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    return sessionManager;
}

+ (AFHTTPSessionManager *)sessionManagerForm {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*",@"text/encode", nil];
    NSString *token = HUZUserCenterManager.userModel.token;
    
    if (token.length >  0) {
        [sessionManager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    return sessionManager;
}


+ (AFNetworkReachabilityManager *)reachabilityManager {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    return reachabilityManager;
}

// get
+ (id)huz_GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSUInteger statusCode,NSString *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kUrl,URLString];
    HUZLOG(@"url: %@  params: %@",urlStr, parameters);
    return [[self sessionManager] GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        id jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        if (success) {
            success(jsonData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        if (failure) {
            failure([error code],[self paraseError:error]);
        }
    }];
}

// post  JSON
+ (id) huz_POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSUInteger statusCode,NSString *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kUrl,URLString];
    HUZLOG(@"url: %@  params: %@",urlStr, parameters);
    return [[self sessionManager] POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        id jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            success(jsonData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        if (failure) {
            failure([error code],[self paraseError:error]);
        }
    }];
}

/// post form
+ (id)huz_POSTWithForm:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSUInteger statusCode,NSString *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kUrl,URLString];
    HUZLOG(@"url: %@  params: %@",urlStr, parameters);
    return [[self sessionManagerForm] POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        id jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            success(jsonData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        if (failure) {
            failure([error code],[self paraseError:error]);
        }
    }];
}

// upload
+ (id)huz_uploadWithURLString:(NSString *)URLString
                     parameters:(id)parameters
                    uploadParam:(NSArray <HUZUploadParam *> *)uploadParams
                        success:(void (^)(id responseObject))success failure:(void (^)(NSUInteger statusCode,NSString *error))failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kUrl,URLString];
    return [[self sessionManager] POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (HUZUploadParam *uploadParam in uploadParams) {
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        id jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        if (success) {
            success(jsonData);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        if (failure) {
            failure([error code],[self paraseError:error]);
        }
    }];
}

// 异步下载
+ (void)huz_downloadWithURLString:(NSString *)URLString
                    progress:(void(^)(NSProgress *downloadProgress))downloadProgressBlock
                 destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
           completionHandler:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kUrl,URLString];
    [[[self sessionManager] downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] progress:downloadProgressBlock destination:destination completionHandler:completionHandler] resume];
}

// 监听网络
+ (void)huz_monitorNetwork {
    if (@available(iOS 10.0, *)) {
        // 1.获取网络权限
        [self huz_checkNetworkPermission];
        
    } else {
        // 2.监听网络状态
        [self huz_monitorNetworkStatus];
    }
}

// 获取网络权限
+ (void)huz_checkNetworkPermission {
    // CTCellularData在iOS9之前是私有类，权限设置是iOS10开始的，所以App Store审核没有问题，获取网络权限状态
    if (@available(iOS 9.0, *)) {
        CTCellularData *cellularData = [[CTCellularData alloc] init];
        // 此函数会在网络权限改变时再次调用
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
            switch (state) {
                case kCTCellularDataRestricted: {
                    HUZLOG(@"Restricted");
                    // 2.1权限关闭的情况下 再次请求网络数据会弹出设置网络提示
                    [self huz_monitorNetworkStatus];
                }
                    break;
                    
                case kCTCellularDataNotRestricted: {
                    HUZLOG(@"NotRestricted");
                    // 2.2已经开启网络权限 监听网络状态
                    [self huz_monitorNetworkStatus];
                }
                    break;
                    
                case kCTCellularDataRestrictedStateUnknown: {
                    HUZLOG(@"Unknown");
                    // 2.3未知情况（还没有遇到推测是有网络但是连接不正常的情况下）
                    [self huz_monitorNetworkStatus];
                }
                    break;
                    
                default:
                    break;
            }
        };
        
    } else {
        // Fallback on earlier versions
    }
    
}

// 监听网络状态
+ (void)huz_monitorNetworkStatus {
    [[HUZNetWorkTool reachabilityManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                HUZLOG(@"网络不通：%@",@(status));
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                HUZLOG(@"网络通过WIFI连接：%@",@(status));
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                HUZLOG(@"网络通过无线连接：%@",@(status));
            }
                break;
                
            default:
                break;
        }
    }];
    
    // 开启网络监视器；
    [[HUZNetWorkTool reachabilityManager] startMonitoring];
}

+ (NSString *)paraseError:(NSError * _Nonnull)error {
    NSLog(@" error= %zd === %@",[error code],[error localizedDescription]);
    NSString *tError = nil;
    switch ([error code]) {
        case NSURLErrorTimedOut:
            tError = [NSString stringWithFormat:@"连接服务器超时，请检查你的网络或稍后重试"];
            break;
        case NSURLErrorBadURL:
        case NSURLErrorUnsupportedURL:
        case NSURLErrorCannotFindHost:
        case NSURLErrorDNSLookupFailed:
        case NSURLErrorCannotConnectToHost:
        case NSURLErrorNetworkConnectionLost:
        case NSURLErrorNotConnectedToInternet:
        case NSURLErrorUserAuthenticationRequired:
        case NSURLErrorUserCancelledAuthentication:
        case NSURLErrorSecureConnectionFailed:
        case NSURLErrorServerCertificateHasBadDate:
        case NSURLErrorServerCertificateHasUnknownRoot:
        case NSURLErrorServerCertificateNotYetValid:
        case NSURLErrorServerCertificateUntrusted:
        case NSURLErrorClientCertificateRejected:
        case NSURLErrorClientCertificateRequired:
            tError = [NSString stringWithFormat:@"无法连接到服务器，请检查你的网络或稍后重试"];
            break;
        case NSURLErrorHTTPTooManyRedirects:
            tError = [NSString stringWithFormat:@"太多HTTP重定向，请检查你的网络或稍后重试"];
            break;
            
        default:
            tError = [NSString stringWithFormat:@"系统繁忙，请稍后再试"];
            break;
    }
    return tError;
}
@end
