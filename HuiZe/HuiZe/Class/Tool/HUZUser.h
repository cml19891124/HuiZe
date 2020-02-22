//
//  HUZUser.h
//  HuiZe
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 yiqi. All rights reserved.
//

#import "HUZModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HUZUser : HUZModel

@property (nonatomic,copy)NSString *token; // token值
@property (nonatomic,copy)NSString *loginType; // 登录类型：登录类别：1 手机登录，2 微信登录 3 QQ登录
@property (nonatomic,copy)NSString *createTime; // 创建时间
@property (nonatomic,copy)NSString *editTime; // 修改时间
@property (nonatomic,copy)NSString *estimateRanking; // 预估排名
@property (nonatomic,copy)NSString *estimateScore; // 预估分数
@property (nonatomic,copy)NSString *examinationProvince; // 高考省份id
@property (nonatomic,copy)NSString *examinationYear; // 高考年份
@property (nonatomic,copy)NSString *grade; // 文理科：0文教，1理科 
@property (nonatomic,copy)NSString *havePassword; // 是否有设置密码:0没有 1有
@property (nonatomic,copy)NSString *haveUserInfo; // 是否有设置个人信息:0没有 1有
@property (nonatomic,copy)NSString *haveMobile; //是否绑定手机号码 0有 1没有 ,
@property (nonatomic,copy)NSString *headUrl; // 头像url
@property (nonatomic,copy)NSString *mobile; // 手机号
@property (nonatomic,copy)NSString *openId; // openId
@property (nonatomic,copy)NSString *userId; // ID
@property (nonatomic,copy)NSString *userRole; // 用户角色 0代表学生 1代表家长 2代表老师
@property (nonatomic,copy)NSString *username; // 用户名
@property (nonatomic,copy)NSString *vip; // vip：0普通，1铂金，2钻石，3专家一对一
@property (nonatomic,copy)NSString *wechaName; // 微信名称
@property (nonatomic,copy)NSString *wechatOpenId; // 微信openId
@property (nonatomic,copy)NSString *registrationID; // 极光推送ID
@property (nonatomic,copy)NSString *schoolNum; // 备选志愿学校数量
@property (nonatomic,copy)NSString *majorNum; // 备选志愿专业数量
@property (nonatomic,copy)NSString *volunteerNum; // 志愿表数量
@property (nonatomic,copy)NSString *provinceName; // 省份名称
@property (nonatomic,copy)NSString *category; // 考生类型
@property (nonatomic,copy)NSString *area; // 所在地区
@property (nonatomic,copy)NSString *school; // 学校名称
@property (nonatomic,copy)NSString *gredes; // 所在年级


@end

NS_ASSUME_NONNULL_END
