//
//  HUZShareHelper.m
//  HuiZe
//
//  Created by  YIQI on 2019/5/7.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZShareHelper.h"

@implementation HUZShareHelper

+ (void)shareWithTitle:(NSString *)title
            weiboTitle:(NSString *)weiboTitle
               content:(NSString *)content
                 image:(UIImage *)image
                imgUrl:(NSString *)imgUrl
               siteUrl:(NSString *)siteUrl
        viewController:(UIViewController *)viewController
              platform:(NSString *)platform{
    //此处处理分享的缩略图
    id img = nil;
    if (image != nil) {
        //1.调用时传入本地图片则分享本地图片
        img = image;
    } else {
        //2.否则分享网络图片,如果不存在网络图片则分享默认图
        if (imgUrl == nil || imgUrl.length == 0) {
            //分享默认图
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@""]];
            UIImage *image1 = [UIImage imageWithData:imageData];
            img = [UIImage thumbnailWithImage:image1 size:CGSizeMake(140, 140)];
        } else {
            //分享图片链接压缩
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            UIImage *image1 = [UIImage imageWithData:imageData];
            img = [UIImage thumbnailWithImage:image1 size:CGSizeMake(140, 140)];
        }
    }
    
    //微博官方目前分享内容的字数限制是140个字符,友盟分享没有对字数限制,可以直接分享不会报错,此处依旧截取140.
    if (content.length > 140) {
        content = [content substringToIndex:140];
    }
    
    //微博分享需要分享图文和链接,微信和qq只需要分享网页内容,因此分开创建分享的内容
    
    //1.此处创建微博分享内容
    //创建微博分享消息对象
    UMSocialMessageObject *wbMessageObject = [UMSocialMessageObject messageObject];
    //设置文本
    wbMessageObject.text = [NSString stringWithFormat:@"#%@# %@ %@",title,content,siteUrl];
    //创建图片分享对象
    UMShareImageObject *wbShareObject = [[UMShareImageObject alloc] init];
    //设置缩略图
    wbShareObject.thumbImage = img;
    if (imgUrl.length == 0) {
        [wbShareObject setShareImage:img];
        //分享消息对象设置分享内容对象
        wbMessageObject.shareObject = wbShareObject;
    }else{
        //设置分享的图片,友盟sdk不支持多图分享,只能分享一张图
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imgUrl]];
        [wbShareObject setShareImage:[UIImage imageWithData:imageData]];
        //分享消息对象设置分享内容对象
        wbMessageObject.shareObject = wbShareObject;
    }
    
    
    
    //2.此处创建微信,qq分享内容
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:img];
    //设置网页地址
    shareObject.webpageUrl = siteUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    if ([platform isEqualToString:@"weibo"]) {
        [self shareWebPageToPlatformType:UMSocialPlatformType_Sina
                              parameters:wbMessageObject
                          share_platform:4
                          viewController:viewController];
    }else if ([platform isEqualToString:@"wechat"]){
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession
                              parameters:messageObject
                          share_platform:1
                          viewController:viewController];
    }else if ([platform isEqualToString:@"wechatmoment"]){
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine
                              parameters:messageObject
                          share_platform:2
                          viewController:viewController];
    }else if ([platform isEqualToString:@"qq"]){
        [self shareWebPageToPlatformType:UMSocialPlatformType_QQ
                              parameters:messageObject
                          share_platform:3
                          viewController:viewController];
    }
    else if ([platform isEqualToString:@"QZone"]){
        [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone
                              parameters:messageObject
                          share_platform:5
                          viewController:viewController];
    }
    // QZone
    
}

//share_platform;//分享到平台，1-微信好友，2-微信朋友圈，3-QQ，4-新浪微博
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                        parameters:(UMSocialMessageObject *)messageObject
                    share_platform:(int)share_platform
                    viewController:(UIViewController *)viewController {
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:viewController completion:^(id data, NSError *error) {
        if (error) {
            /// 分享失败
            if ((int)error.code == 2003) {
                
            }
            /// 分享取消
            else if ((int)error.code == 2009){
            }
        }
        /// 分享成功
        else{

        }
    }];
    
}

@end
