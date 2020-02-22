//
//  HUZContants.h
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import <Foundation/Foundation.h>



static NSString *channel = @"Publish channel";
static BOOL isProduction = YES;

// 友盟统计
extern NSString * const UMengKey;

//微信
extern NSString * const kAppKey_Wechat;
extern NSString * const kSecret_Wechat;

// 腾讯
extern NSString * const kAppKey_Tencent;
extern NSString * const kSecret_Tencent;

// 微博
extern NSString * const kAppKey_Sina;
extern NSString * const kSecret_Sina;

// 支付宝
extern NSString * const Alipay_AppScheme;

// 极光
extern NSString * const kAppKey_JPush;


/* ---------------------------------------- 马甲线 ------------------------------------------------------- */

// URL
extern NSString * const kUrl;

///////// 登录注册相关  //////////

extern NSString * const kUrl_loginOrRegist;  // 登录/注册
extern NSString * const kUrl_login; // 登录
extern NSString * const kUrl_logout; // 退出
extern NSString * const kUrl_messagephone; // 修改手机发送验证码
extern NSString * const kUrl_msgResetPassword; // 忘记密码核实验
extern NSString * const kUrl_msgResetphone; // 忘记密码发送验证码
extern NSString * const kUrl_resetPassword; // 忘记密码设置密码
extern NSString * const kUrl_sms; // 发送短信
extern NSString * const kUrl_updatephone; // 更换手机
extern NSString * const kUrl_wechalogin; // 微信登陆

///////// 用户信息相关  //////////

extern NSString * const kUrl_userInfo; // 查询用户信息
extern NSString * const kUrl_updatePassword; // 设置密码
extern NSString * const kUrl_updatedetails; // 修改个人信息
extern NSString * const kUrl_updateuser; //  修改用户个人资料
extern NSString * const kUrl_allprovince; // 所有省份
extern NSString * const kUrl_followlist; // 用户关注列表
extern NSString * const kUrl_followdelete; // 取消关注
extern NSString * const kUrl_followsave; // 根据类型关注
extern NSString * const KUrl_Feedback;   // 反馈
extern NSString * const KUrl_UsermessageList;//消息列表
///////// 填志愿相关  //////////

extern NSString * const kUrl_volunteerList; // 志愿表列表
extern NSString * const kUrl_volunteerDel; // 删除志愿表
extern NSString * const kUrl_volunteerDynamicData; // 填志愿页动态数据
extern NSString * const kUrl_volunteerPriorityApplication; // 院校优先报名
// 院校优先报名---学校页面
extern NSString * const kUrl_volunteerSchoolApplicationTest;
extern NSString * const kUrl_volunteer_saveAlternative; // 添加到备选志愿
extern NSString * const kUrl_volunteer_saveVolunteer ; // 添加到我的志愿
extern NSString * const kUrl_volunteerScoreAnalysis ; // 我的成绩分析
extern NSString * const kUrl_volunteerUserinfo ; // 用户信息
extern NSString * const kUrl_volunteerVoluntary ; // 我的备选自愿
extern NSString * const kUrl_volunteerVoluntaryID ; // 根据学校获取专业
extern NSString * const kUrl_volunteerIntelligenceTest ; // 智能生成志愿表
extern NSString * const kUrl_volunteerIntelligenceScreen ; //  智能筛选
extern NSString * const kUrl_volunteerVolunteerList ; //  志愿表列表
extern NSString * const kUrl_volunteerVolunteerDetailInfo;//  志愿表列表详情
extern NSString * const kUrl_volunteerMajorUniversity ; //  根据专业获取大学信息
//根据专业筛选大学
extern NSString * const KUrl_volunteerMajorUniversitySelect;
extern NSString * const kUrl_allmajorEntities;//  根据偏好设置获取专业信息
extern NSString * const kUrl_volunteerBatchList ; //   批次list
extern NSString * const kUrl_volunteerSelectSchoolAll;
//////////  主页相关   ///////////
/// 关键字搜索
extern NSString * const KUrl_SearchKeyword;
/// 搜索大学
extern NSString * const KUrl_searchUniList;
/// 搜索专业
extern NSString * const KUrl_searchMajorList;
/// banner图  类型：0首页 1查大学 2查专业 3报考指南 4招录数据
extern NSString * const KUrl_Banner;
/// 高考资讯列表 "热门推荐", "独家解析", "资讯头条", "报考指南", "备考经验", "高考政策" , type从0开始
extern NSString * const KUrl_GkInfoList;
/// 一分一段
extern NSString * const KUrl_ScoreSection;
/// 分数线
extern NSString * const KUrl_Scoreline;
/// 投档线列表
extern NSString * const KUrl_DroplineList;
/// 录取线列表
extern NSString * const KUrl_EnterlineList;
/// 报考指南信息
extern NSString * const KUrl_RegisterGude;
/// 常识百科
extern NSString * const KUrl_CommonSense;
/// 招生计划---历年招录数据
extern NSString * const KUrl_studentPlan;
/// 高考动态列表 类型:0教育部，1本省政策，2最新动态
extern NSString * const KUrl_GkDynamicList;
/// 政策解读列表
extern NSString * const KUrl_PolicyList;
/// 推荐院校
extern NSString * const KUrl_RecommendUni;
/// 推荐院校集合
extern NSString * const KUrl_RecommendUniList;
/// 推荐专业
extern NSString * const KUrl_RecommendMajor;
extern NSString * const KUrl_New_RecommendMajor;
/// 推荐专业集合
extern NSString * const KUrl_RecommendMajorList;
/// 查专业---带你喜欢
extern NSString * const KUrl_uLikeList;
/// 查专业---名企热招
extern NSString * const KUrl_hotList;
/// 查询专业目录 type:专科为1，本科为2
extern NSString * const KUrl_allMajorCategory;
/// 查专业搜索 type:专科为1，本科为2
extern NSString * const KUrl_seachMajorByKey;
/// 查大学--猜你喜欢
extern NSString * const KUrl_searchUniUlike;
/// 查大学--名企热招
extern NSString * const KUrl_searchUniHot;
/// 查大学---全部高校，本省高校
extern NSString * const KUrl_searchAllUniList;
/// 大学详情--毕业去向--前景概况
extern NSString * const KUrl_Generalize;
/// 大学详情--毕业去向--行业去向
extern NSString * const KUrl_IndustryLea;
/// 大学详情--毕业去向--地区去向
extern NSString * const KUrl_RegionLea;
/// 大学详情头部信息
extern NSString * const KUrl_UniInfo;


//////////  朋友圈相关   //////////
/// 根据帖子id查询评论内容  GET
extern NSString * const KUrl_friendCommentList;
/// 根据类型查询普通帖子   POST
extern NSString * const KUrl_friendList;
/// 根据类型查询加精贴  POST
extern NSString * const KUrl_friendRefinementList;
/// 帖子详情 GET
extern NSString * const KUrl_friendReleaseData;
/// 获取分类列表  GET
extern NSString * const KUrl_friendReleaseType;
/// 发布新帖 POST
extern NSString * const KUrl_friendSave;
/// 点赞
extern NSString * const KUrl_like;
/// 评论
extern NSString * const KUrl_comment;
//QQ登陆 
extern NSString * const kQQLogin;
//微信登陆
extern NSString * const kWechalogin; 
//查询用户信息 
extern NSString * const kUrl_query_userInfo;
//该校专业查询 /api/subject/query
extern NSString * const kUrl_subject_query;
//该校所有专业查询
extern NSString * const kUrl_subject_majorList;
//学校排名
extern NSString * const kUrl_ranking_list;
//专业排名 /api/ranking/majorRankingSearch
extern NSString * const kUrl_ranking_majorRankingSearch;
//新高考政策详情(新高考选课)
extern NSString * const kUrl_policy_newPolicy;
//会员价格类型
extern NSString * const kUrl_order_pay_getVipPrice;
extern NSString * const kUrl_new_order_pay_getVipPrice;
//支付宝下单购买会员
extern NSString * const kUrl_pay_alipay;
//微信下单购买会员 /api/pay/wechatpay
extern NSString * const kUrl_pay_wechatpay;
//加入pk 
extern NSString * const kUrl_joinpk_shoolpk;
//POST 查询招生录取情况
extern NSString * const kUrl_recruitPlan_getEnrollsitTest;
//大学详情-历年录取数据(图表)
extern NSString * const kUrl_recruitPlan_schoolAdmissionData;
//历年专业录取数据测试 
extern NSString * const kUrl_recruitPlan_getStatisticsMajorTwo;
//大学详情-专业录取数据（招生信息）
extern NSString * const kUrl_recruitPlan_majorAdmissionData;
//招生章程列表
extern NSString * const kUrl_recruitPlan_recruitConstitutionList;
//获取专业详情
extern NSString * const kUrl_major_guess_data;
//专业开设课程
extern NSString * const kUrl_major_curriculum;
//可能感兴趣的专业
extern NSString * const kUrl_major_interested;
//根据专业获取大学信息
extern NSString * const kUrl_major_guess_university;
//POST 信息未读信息状态修改
extern NSString * const kUrl_usermessage_update;
//POST 图片上传
extern NSString * const kUrl_uploads_img;
//查询所有中学
extern NSString * const kUrl_middleschool_selectSchool;
//用户关注学校列表 
extern NSString * const kUrl_follow_listTest;
//POST用户关注专业列表
extern NSString * const kUrl_follow_listMajor;
//会员激活码
extern NSString * const kUrl_uservip_activationr;
//GET删除备选志愿学校
extern NSString * const kUrl_volunteer_delete_alternativeSchool;
//POST删除备选志愿学校专业
extern NSString * const kUrl_volunteer_delete_alternativeMajor;
//根据学校获取专业GET {id} /api/volunteer/voluntaryTest1/
extern NSString * const kUrl_volunteer_voluntaryTest1;

//常识列表 http://m.hz985211.com/yiqi-api/api/guide/encyclopedias列表内容的接口
extern NSString * const kUrl_Guide_Encyclopedias_List;

//POST /api/year/type/{type}
extern NSString * const kUrl_Year_Type_List;
/*通知*/
/*更新会员状态*/
extern NSString * const HUZVIPUpdate_State_Noti_Key;
/*通知 end*/
//GET 获取评估学科目录
extern NSString * const kUrl_Assess_List;
// GET {assessMajorId} GET {assessMajorId} 获取评估学科详情
extern NSString * const kUrl_Assess_Result;
//获取评估学科详情 GET /api/assess/result/school/{schoolId}
extern NSString * const kUrl_Assess_Result_school;
//院校专业历年录取数据
extern NSString *const kUrl_University_majorAdmissionHistory;
//* 获取学校最新一年招生计划 api/university/recruitPlan/{schoolId} （post）
extern NSString *const kUrl_University_recruitPlany;
//(GET)院校历年录取数据 /api/university/admissionHistory/{schoolId}
extern NSString *const kUrl_University_AdmissionHistory;
//推荐院校 api/voluntary/intelligentFirst/schoolList
extern NSString *const kUrl_Voluntary_IntelligentFirst_SchoolList;
//修改我的志愿 POST
extern NSString * const kUrl_Volunteer_Update_Volunteer;
//建议填报批次
extern NSString *const kUrl_Voluntary_TargetBatch;
//生成智能志愿表列表
extern NSString *const kUrl_IntelligentFirst;
