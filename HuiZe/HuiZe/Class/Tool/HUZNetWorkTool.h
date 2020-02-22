#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class HUZUploadParam;

@interface HUZNetWorkTool : NSObject

/**
 对AFHTTPSessionManager的GET请求方法进行了封装
 
 @param URLString    请求的路径，即 ? 前面部分
 @param parameters   参数
 @param success      成功回调
 @param failure      失败回调

 @return dataTask
 */
+ (id)huz_GET:(NSString *)URLString
    parameters:(NSDictionary *)parameters
      success:(void (^)(id responseObject))success
      failure:(void (^)(NSUInteger statusCode,NSString *error))failure;
/**
 对AFHTTPSessionManager的POST请求方法进行了封装  JSON 传参
 
 @param URLString    请求的路径，即 ? 前面部分
 @param parameters   参数
 @param success      成功回调
 @param failure      失败回调
 @return dataTask
 */
+ (id)huz_POST:(NSString *)URLString
    parameters:(NSDictionary *)parameters
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSUInteger statusCode,NSString *error))failure;

/**
 对AFHTTPSessionManager的POST请求方法进行了封装  form 传参
 
 @param URLString    请求的路径，即 ? 前面部分
 @param parameters   参数
 @param success      成功回调
 @param failure      失败回调
 @return dataTask
 */
+ (id)huz_POSTWithForm:(NSString *)URLString
    parameters:(NSDictionary *)parameters
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSUInteger statusCode,NSString *error))failure;


/**
 *  上传图片
 
 @param URLString   上传图片的网址字符串
 @param parameters  上传图片的参数
 @param uploadParams 上传图片的信息
 @param success      成功回调
 @param failure      失败回调
 */
+ (id)huz_uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(NSArray <HUZUploadParam *> *)uploadParams
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSUInteger statusCode,NSString *error))failure;
/**
 异步下载
 
 @param URLString             文件网络地址
 @param downloadProgressBlock 进度回调
 @param destination           存放位置
 @param completionHandler     完成回调
 */
+ (void)huz_downloadWithURLString:(NSString *)URLString
                    progress:(void(^)(NSProgress *downloadProgress))downloadProgressBlock
                 destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
           completionHandler:(void(^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;

/**
 监听网络
 */
+ (void)huz_monitorNetwork;

@end

NS_ASSUME_NONNULL_END
