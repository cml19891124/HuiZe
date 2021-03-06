//
//  HPUploadImageHandle.h
//  HPShareApp
//
//  Created by HP on 2018/12/10.
//  Copyright © 2018 Shenzhen Qianhai Hepai technology co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id _Nullable responseObject);
typedef void(^ProgressBlock)(double progress);
typedef void(^FailBlock)(NSError * _Nullable error);
NS_ASSUME_NONNULL_BEGIN

@interface SDUploadImageHandle : NSObject
+ (void)sendGETWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

/**
 发送一张图片
 */
+ (void)sendPOSTWithUrl:(NSString *)url withLocalImage:(UIImage *)image isNeedToken:(BOOL)isNeed parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
+ (void)sendPOSTWithUrlStr:(NSString *)url parameters:(NSString *)string success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

/**
 上传多张图片

 @param images 图片数组
 @param url 上传地址
 @param name formData 参数名
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)upLoadImages:(NSArray *)images withUrl:(NSString *)url parameterName:(NSString *)name success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

/**
 上传多张图片,progress中返回上传进度

 @param images 图片数组
 @param url 上传地址
 @param name 参数名
 @param successBlock 成功回调
 @param progressBlock 进度回调
 @param failBlock 失败回调
 */
+ (void)upLoadImages:(NSArray *)images withUrl:(NSString *)url parameterName:(NSString *)name success:(SuccessBlock)successBlock progress:(ProgressBlock)progressBlock fail:(FailBlock)failBlock;

@end

NS_ASSUME_NONNULL_END
