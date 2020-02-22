//
//  HUZContants.m
//  HuiZe
//
//  Created by  YIQI on 2019/4/23.
//  Copyright © 2019年 yiqi. All rights reserved.
//

#import "HUZContants.h"

NSString * const UMengKey = @"5b94c2d5b27b0a5e5d0000c5";

NSString * const kAppKey_Wechat = @"wx31e917f39ca4dce1";
NSString * const kSecret_Wechat = @"05767e779caa866f5a1a26c10a3eb517";//@"3b912ce5e8757c48c4f5bebd86fe3aad";

NSString * const kAppKey_Tencent = @"1107818080";
NSString * const kSecret_Tencent = @"VDGmq6cN6w6nzQvx";

NSString * const kAppKey_Sina = @"1359578604";
NSString * const kSecret_Sina = @"12420d53181d88e0f2c975762576e892";

NSString * const Alipay_AppScheme = @"yuedingAlisdk";

NSString * const kAppKey_JPush = @"99f7fecc2b3d393e51162b39";

/*
 
 _,-----.
 _,------.__,-'        `.  .            .
 .-'                        `//__          \\
 |                           ((___`-_____    ))
 |                            \_alf)     \`=:'
 |                               `=|      |=,'
 /                                  | O   (|
 /  /\                               |      |
 /  /  \    .                          \     |
 |  /   /|  / `--.   ___            __,,-.    |
 | /   //  /      `-'   \  ,_    /''     |  o o|
 / |   | |  |             \ \ `.  |        ``--'
 mmm   | |  |              \ \ |  |
 | |\ |              |  ||  |
 | | ||              / / `. )
 \ \ \\            / /   | |
 |_| ||          / /    | |
 |_\         \_|    |  \
 \__\
 
 */

NSString * const kUrl = @"http://47.107.101.26:8081/yiqi-api"; // 线上

//NSString * const kUrl = @"http://192.168.31.234:8081/yiqi-api"; // 本地 刘
//NSString * const kUrl = @"http://192.168.31.95:8081/yiqi-api"; // 本地 汤
//NSString * const kUrl = @"http://192.168.1.136:8089/yiqi-api"; // 本地 肖

///////// 登录注册相关  //////////

NSString * const kUrl_loginOrRegist = @"/api/login"; // 登录/注册
NSString * const kUrl_login = @"/api/login2"; // 登录
NSString * const kUrl_logout = @"/api/logout"; // 退出
NSString * const kUrl_messagephone = @"/api/messagephone"; // 修改手机发送验证码
NSString * const kUrl_msgResetPassword = @"/api/msgResetPassword"; // 忘记密码核实验证码
NSString * const kUrl_msgResetphone = @"/api/msgResetphone"; // 忘记密码发送验证码
NSString * const kUrl_resetPassword = @"/api/resetPassword"; // 忘记密码设置密码
NSString * const kUrl_sms = @"/api/sms"; // 发送短信
NSString * const kUrl_updatephone = @"/api/updatephone"; // 更换手机
NSString * const kUrl_wechalogin = @"/api/wechalogin"; // 微信登陆


///////// 用户信息相关  //////////

NSString * const kUrl_userInfo = @"/api/query/userInfo"; // 查询用户信息
NSString * const kUrl_updatePassword = @"/api/updatePassword"; // 设置密码
NSString * const kUrl_updatedetails = @"/api/updatedetails"; // 修改高考信息
NSString * const kUrl_updateuser = @"/api/updeteuser"; //  修改用户个人资料
NSString * const kUrl_allprovince = @"/api/province/queryAll" ; // 所有省份
NSString * const kUrl_allmajorEntities = @"/api/volunteer/select/majorByOne"; // 所有专业
NSString * const kUrl_followlist = @"/api/follow/list"; //  用户关注列表
NSString * const kUrl_followdelete = @"/api/follow/deleteFollow"; //  取消关注
NSString * const kUrl_followsave = @"/api/follow/saveFollow"; //  根据类型关注
NSString * const KUrl_Feedback = @"/api/feedback/generalize";   // 反馈
NSString * const KUrl_UsermessageList = @"/api/usermessage/list";

///////// 填志愿相关  //////////

NSString * const kUrl_volunteerList = @"/api/volunteer/list/volunteer"; // 志愿表列表
NSString * const kUrl_volunteerDel = @"/api/volunteer/delete/volunteer"; // 删除志愿表
NSString * const kUrl_volunteerDynamicData = @"/api/volunteer/dynamicData"; // 填志愿页动态数据
NSString * const kUrl_volunteerPriorityApplication = @"/api/volunteer/priorityApplication"; // 院校优先报名
NSString * const kUrl_volunteerSchoolApplicationTest = @"/api/volunteer/SchoolApplicationTest";
NSString * const kUrl_volunteer_saveAlternative = @"/api/volunteer/save/alternative"; // 添加到备选志愿
NSString * const kUrl_volunteer_saveVolunteer = @"/api/volunteer/save/volunteer"; // 添加到我的志愿
//修改我的志愿 POST
NSString * const kUrl_Volunteer_Update_Volunteer = @"/api/volunteer/update/volunteer";
NSString * const kUrl_volunteerScoreAnalysis = @"/api/volunteer/scoreAnalysis"; // 我的成绩分析
NSString * const kUrl_volunteerUserinfo = @"/api/volunteer/userinfo"; // 用户信息
NSString * const kUrl_volunteerVoluntary = @"/api/volunteer/voluntaryTest"; // 我的备选志愿
NSString * const kUrl_volunteerVoluntaryID = @"/api/volunteer/voluntaryTest/"; // 根据学校获取专业
NSString * const kUrl_volunteerIntelligenceTest = @"/api/volunteer/intelligenceTest"; // 智能生成志愿表
NSString * const kUrl_volunteerIntelligenceScreen = @"/api/volunteer/intelligenceScreen"; // 智能筛选
NSString * const kUrl_volunteerVolunteerList = @"/api/volunteer/list/volunteer"; //  志愿表列表
NSString * const kUrl_volunteerVolunteerDetailInfo =@"/api/volunteer/volunteer/info";
NSString * const kUrl_volunteerMajorUniversity = @"/api/voluntary/majorSchoolCount"; // 根据专业获取大学信息

// 根据专业筛选大学信息
NSString * const KUrl_volunteerMajorUniversitySelect = @"/api/voluntary/majorFirstSchoolList";

NSString * const kUrl_volunteerBatchList = @"/api/batch/industryLea"; // 批次list
NSString * const kUrl_volunteerSelectSchoolAll = @"/api/volunteer/select/schoolAll";
//////////  主页相关   ///////////

/// 关键字搜索
NSString * const KUrl_SearchKeyword = @"/api/home/searchForKeyWord";
/// 搜索大学
NSString * const KUrl_searchUniList = @"/api/home/searchByUniversity";
/// 搜索专业
NSString * const KUrl_searchMajorList = @"/api/home/searchBySubject";
/// banner图  类型：0首页 1查大学 2查专业 3报考指南 4招录数据
NSString * const KUrl_Banner = @"/api/banner/getBannerByType";
/// 高考资讯列表
NSString * const KUrl_GkInfoList = @"/api/piccontent/list";
/// 一分一段
NSString * const KUrl_ScoreSection = @"/api/dateCore/getScoreChina";
/// 分数线
NSString * const KUrl_Scoreline = @"/api/dateCore/getScoreLine";
/// 投档线列表
NSString * const KUrl_DroplineList = @"/api/dateCore/getDeliveryLine/listAllDelivery";
/// 录取线列表
NSString * const KUrl_EnterlineList = @"/api/dateCore/getAdmissionLine/listAllAdmission";
/// 报考指南信息
NSString * const KUrl_RegisterGude = @"/api/guide/UserGuide";
/// 常识百科
NSString * const KUrl_CommonSense = @"/api/guide/encyclopedias";
/// 招生计划---历年招录数据
NSString * const KUrl_studentPlan = @"/api/recruitPlan/getStatisticsMajor";
/// 高考动态列表 类型:0教育部，1本省政策，2最新动态
NSString * const KUrl_GkDynamicList = @"/api/policy/list";
/// 政策解读列表
NSString * const KUrl_PolicyList = @"/api/policy/listPolicy";
/// 推荐院校
NSString * const KUrl_RecommendUni = @"/api/admissiondetails/getAdmissionDetails";
/// 推荐院校集合
NSString * const KUrl_RecommendUniList = @"/api/admissiondetails/getAdmissionDetailslist";
//推荐院校 
NSString *const kUrl_Voluntary_IntelligentFirst_SchoolList = @"/api/voluntary/intelligentFirst/schoolList";
/// 推荐专业
NSString * const KUrl_RecommendMajor = @"/api/admissiondetails/getAdmissionMajor";
//
/// 推荐专业 new
/*
 {
     "recruitAddress":当前省份
     "leMinScore":预估成绩
     "grade":文理科
 }
 */

NSString * const KUrl_New_RecommendMajor = @"/api/v1/index/majorList";
/// 推荐专业集合
NSString * const KUrl_RecommendMajorList = @"/api/admissiondetails/getAdmissionMajorlist";
/// 查专业---猜你喜欢
NSString * const KUrl_uLikeList = @"/api/major/guess/like";
/// 查专业---名企热招
NSString * const KUrl_hotList = @"/api/major/university/enterprise";
/// 查询专业目录
NSString * const KUrl_allMajorCategory = @"/api/major/guess/catalogue";
/// 查专业搜索 type:专科为1，本科为2
NSString * const KUrl_seachMajorByKey = @"/api/major/majorSearchByKey";
/// 查大学--猜你喜欢
NSString * const KUrl_searchUniUlike = @"/api/searchUniversity/recommendUniversity";
/// 查大学--名企热招
NSString * const KUrl_searchUniHot = @"/api/searchUniversity/university/enterprise";
/// 查大学---全部高校，本省高校
NSString * const KUrl_searchAllUniList = @"/api/searchUniversity/listAllUniversity";
/// 大学详情--毕业去向--前景概况
NSString * const KUrl_Generalize = @"/api/lea/generalize";
/// 大学详情--毕业去向--行业去向
NSString * const KUrl_IndustryLea = @"/api/lea/industryLea";
/// 大学详情--毕业去向--地区去向
NSString * const KUrl_RegionLea = @"/api/lea/regionLea";
/// 大学详情头部信息
NSString * const KUrl_UniInfo = @"/api/searchUniversity/getUniversity";


////////    朋友圈相关    ///////////
/// 根据帖子id查询评论内容  GET
NSString * const KUrl_friendCommentList = @"/api/Friend/comment/list";
/// 根据类型查询所有帖子  POST
NSString * const KUrl_friendList = @"/api/Friend/listNotRefinement";
/// 根据类型查询加精贴  POST
NSString * const KUrl_friendRefinementList = @"/api/Friend/listRefinement";
/// 帖子详情  GET
NSString * const KUrl_friendReleaseData = @"/api/Friend/release/data";
/// 获取分类列表  GET
NSString * const KUrl_friendReleaseType = @"/api/Friend/release/type";
/// 发布新帖  POST
NSString * const KUrl_friendSave = @"/api/Friend/save";
/// 点赞
NSString * const KUrl_like = @"/api/clickyes/save";
/// 评论
NSString * const KUrl_comment = @"/api/comment/save";

NSString * const kQQLogin = @"/api/qqlogin";

NSString * const kWechalogin = @"/api/wechalogin";
//查询用户信息
NSString * const kUrl_query_userInfo = @"/api/query/userInfo";
//该校专业查询
NSString * const kUrl_subject_query = @"/api/subject/query";
//该校所有专业查询
NSString * const kUrl_subject_majorList = @"/api/subject/majorList";
//学校排名
NSString * const kUrl_ranking_list = @"/api/ranking/list";
//专业排名
NSString * const kUrl_ranking_majorRankingSearch = @"/api/ranking/majorRankingSearch";
//新高考政策详情(新高考选课)
NSString * const kUrl_policy_newPolicy = @"/api/policy/newPolicy/data";
//会员价格类型
NSString * const kUrl_order_pay_getVipPrice = @"/api/order/pay/getVipPrice";
NSString * const kUrl_new_order_pay_getVipPrice = @"/api/order/pay/getVipPrice";

//支付宝下单购买会员
NSString * const kUrl_pay_alipay = @"/api/pay/alipay";
//微信下单购买会员
NSString * const kUrl_pay_wechatpay = @"/api/pay/wechatpay";
//加入pk
NSString * const kUrl_joinpk_shoolpk = @"/api/joinpk/shoolpk";
//POST 查询招生录取情况
NSString * const kUrl_recruitPlan_getEnrollsitTest = @"/api/recruitPlan/getEnrollsitTest";
//大学详情-历年录取数据(图表)
NSString * const kUrl_recruitPlan_schoolAdmissionData = @"/api/recruitPlan/schoolAdmissionData";
//历年专业录取数据测试
NSString * const kUrl_recruitPlan_getStatisticsMajorTwo = @"/api/recruitPlan/getStatisticsMajorTwo";
//POST 大学详情-专业录取数据（招生信息）
NSString * const kUrl_recruitPlan_majorAdmissionData = @"/api/recruitPlan/majorAdmissionData";
//招生章程列表
NSString * const kUrl_recruitPlan_recruitConstitutionList = @"/api/recruitPlan/recruitConstitutionList";
//获取专业详情
NSString * const kUrl_major_guess_data = @"/api/major/guess/data";
//专业开设课程
NSString * const kUrl_major_curriculum = @"/api/major/major/curriculum";
//可能感兴趣的专业
NSString * const kUrl_major_interested = @"/api/major/major/interested";
//根据专业获取大学信息
NSString * const kUrl_major_guess_university = @"/api/major/guess/university";
//POST 信息未读信息状态修改
NSString * const kUrl_usermessage_update = @"/api/usermessage/update";
//POST 图片上传
NSString * const kUrl_uploads_img = @"/api/uploads/img";
//查询所有中学
NSString * const kUrl_middleschool_selectSchool = @"/api/middleschool/selectSchool";
//用户关注学校列表
NSString * const kUrl_follow_listTest = @"/api/follow/listTest";
//POST用户关注专业列表
NSString * const kUrl_follow_listMajor = @"/api/follow/listMajor";
//会员激活码
NSString * const kUrl_uservip_activationr = @"/api/uservip/activationr";
//GET删除备选志愿学校
NSString * const kUrl_volunteer_delete_alternativeSchool = @"/api/volunteer/delete/alternativeSchool";
//POST删除备选志愿学校专业
NSString * const kUrl_volunteer_delete_alternativeMajor = @"/api/volunteer/delete/alternativeMajor";

//根据学校获取专业GET {id}
NSString * const kUrl_volunteer_voluntaryTest1 = @"/api/volunteer/voluntaryTest1/";

/*通知*/
/*更新会员状态*/
NSString * const HUZVIPUpdate_State_Noti_Key = @"HUZVIPUpdate_State_Noti_Key";
/*通知 end*/

//常识列表 http://m.hz985211.com/yiqi-api/api/guide/encyclopedias列表内容的接口
NSString * const kUrl_Guide_Encyclopedias_List = @"/api/guide/encyclopedias";

//POST /api/year/type/{type}
NSString * const kUrl_Year_Type_List = @"/api/year/type/";

//GET 获取评估学科目录
NSString * const kUrl_Assess_List = @"/api/assess/list";
// GET {assessMajorId} GET {assessMajorId} 获取评估学科详情
NSString * const kUrl_Assess_Result = @"/api/assess/result/";
//获取评估学科详情 GET {schoolId}
NSString * const kUrl_Assess_Result_school = @"/api/assess/result/school/";
//院校专业历年录取数据
NSString *const kUrl_University_majorAdmissionHistory = @"/api/university/majorAdmissionHistory";
//* 获取学校最新一年招生计划 api/university/recruitPlan/{schoolId} （post）
NSString *const kUrl_University_recruitPlany = @"/api/university/recruitPlan/";
//(GET)院校历年录取数据 /api/university/admissionHistory/{schoolId}
NSString *const kUrl_University_AdmissionHistory = @"/api/university/admissionHistory/";
//建议填报批次
NSString *const kUrl_Voluntary_TargetBatch = @"/api/voluntary/targetBatch";
//生成智能志愿表列表
NSString *const kUrl_IntelligentFirst = @"/api/voluntary/intelligentFirst";

