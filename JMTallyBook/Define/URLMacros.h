//
//  URLMacros.h
//  Loanmarket
//
//  Created by Junheng on 2017/10/26.
//  Copyright © 2017年 jinqianbao. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h


/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */
#define TestSever   0
#define PreReleaseSever     0
#define ProductSever    1



#pragma mark - ——————— HOST地址 ————————

#if TestSever
/**开发服务器*/
#define URL_main @"http://api.cash.jiumiaodai.com"

#define URL_UpdateVersion_main URL_main

#elif PreReleaseSever

/**预发布服*/
#define URL_main @"http://api.pre.cashfintech.net"

#define URL_UpdateVersion_main URL_main

#elif ProductSever

/**生产服务器*/
#define URL_main @"https://112.api.cashfintech.net"

//forever main
#define URL_UpdateVersion_main @"https://api.cashfintech.net"

#endif



#pragma mark - ——————— 完整请求地址拼接 ————————
#define DEFAULT_Domain(path) [URL_main stringByAppendingString:path]

#define Version_Domain(path) [URL_UpdateVersion_main stringByAppendingString:path]

#pragma mark - ——————— 详细接口地址 ————————


//绑定facebook
#define BIND_FACEBOOK @"/user/action/bind-facebook"

//运营商验证码
#define OTPCaptchaURL @"/captcha/telecom"

//AadHaarCheck验证码
#define AadHaarCheckCaptchaURL @"/captcha/aadhaar-check"


#define AadHaarCheckCheckOTPStatus @"/captcha/get-otp-status"
//短信验证码
#define SMSCaptchaURL(telNum) [NSString stringWithFormat:@"/captcha/%@/action/send",telNum]

//语音验证码
#define VoiceCaptchaURL @"/captcha/action/send-voice"

//邮箱验证码
#define EmailCaptchaURL @"/captcha/action/send-email"

//绑定手机号
#define BIND_TELEPHONE @"/user/action/bind-telephone"

//绑定邮箱
#define Bind_Eamil @"/user/action/bind-email"

#define Replace_FaceBook @"/user/action/replace-facebook"
//认证中心列表
#define Authority_list @"/shop-config/authority-list"

#define Residential_City @"/city/residential-city"


//提交basic detail信息
#define Create_user_basic @"/user/user-info/create-user-basic"

//提交basic info信息
#define Create_user_info @"/user/user-info/create-user-info"

//State地区选择信息
#define Get_state @"/city/get-state"

#define Get_City @"/city/get-city"


//绑银行卡
#define Create_BankCard @"/bankcard/create"

//查询银行卡信息或者查询银行卡绑定状态
#define BankCard_Index @"/bankcard/index"

#define Look_Up_Ifsc @"/bankcard/look-up-ifsc"

//开屏广告页
#define launchAd @"/common/app-start-ad-page"


//登录或者注册
#define LOGIN_URL @"/user/action/account"


//重设密码

#define RESETPASSWORD_URL @"/user/action/reset_password"


//注册
#define REGISTERURL  @"/user/action/register"

//绑定微信号

#define BINDWECHAT @"/user/bind-open-wechat"

#define PRODUCT @"/product"

//产品详情
#define PRODUCT_DETAIL(productId) [NSString stringWithFormat:@"/product/%@",productId]



//banner数据

#define AD_BANNER @"/ad/banner"

//首页通知数据
#define AD_NOTICE @"/ad/notice"

//刷新Token
#define REFRESH_Token @"/user/refresh_token"
#define ACCESS_Token @"/user/access_token"

//验证用户生日
#define USER_Check_YMD(accessToken) [NSString stringWithFormat:@"/user/action/check_user_ymd?accessToken=%@",accessToken]

//上传图片

//上传身份证正面图片
#define UPLOAD_IDCard(accessToken) [NSString stringWithFormat:@"/user/user-card/upload-aadhaar-card-front?accessToken=%@",accessToken]

////上传身份证背面图片
#define UPLOAD_IDCard_Back(accessToken)  [NSString stringWithFormat:@"/user/user-card/upload-aadhaar-card-back?accessToken=%@",accessToken]

//上传panCard
#define UPLOAD_PanCard(accessToken)  [NSString stringWithFormat:@"/user/user-card/upload-pan-card?accessToken=%@",accessToken]


#define UPLOAD_Face(accessToken) [NSString stringWithFormat:@"/authentication/faces/action/upload?accessToken=%@",accessToken]

//检查人脸识别与身份证是否是同一个人
#define CHECK(accessToken) [NSString stringWithFormat:@"/authentication/face/action/check?accessToken=%@",accessToken]

//用户详情(get)
#define USERDETAIL_Get @"/user/detail"
//获取用户填写信息
#define User_Fillin_Data @"/user/info"

//获取风控额度、天数
#define User_RiskLimit @"/user/risk-limit"
//用户下拉配置
#define USER_INFO_CONFIG @"/user/action/user_info_config"


//创建用户信息
#define CREAT_USER_INFO @"/user/action/create_user_info"


//借款订单
//最后一张订单(get)
#define LOAN_LastOrder @"/order/last"

//修改订单金额及借款天数
#define LOAN_UPDATE @"/order/update"
//取消订单
#define LOAN_CancelOrder(loanId,accessToken) [NSString stringWithFormat:@"/order/%@/action/cancel?accessToken=%@",loanId,accessToken]
//创建订单
#define Loan_Create @"/order"
#define LOAN_Create(accessToken) [NSString stringWithFormat:@"/order?accessToken=%@",accessToken]
//订单详情(get)
#define LOAN_Detail(loanId) [NSString stringWithFormat:@"/order/%@",loanId]

//我的借款(get)
#define LOAN_List @"/order"
//续期
#define LOAN_Renewal(repaymentPlanNo,accessToken) [NSString stringWithFormat:@"/repayment-plan/%@/action/extend?accessToken=%@",repaymentPlanNo,accessToken]
//续期协议(get)
#define LOAN_RenewalAgreement @"/contract/extend"

//续期的费用
#define LOAN_RenewalFee(repaymentPlanNo,accessToken) [NSString stringWithFormat:@"/repayment-plan/%@/action/calculate?accessToken=%@",repaymentPlanNo,accessToken]
//还款
#define LOAN_Repayment(repaymentPlanNo,accessToken) [NSString stringWithFormat:@"/repayment-plan/%@/action/repay?accessToken=%@",repaymentPlanNo,accessToken]

//更新还款状态
#define LOAN_UpdateStatus(planNo,accessToken) [NSString stringWithFormat:@"/repayment-plan/%@/action/query?accessToken=%@",planNo,accessToken]
//还款配置
#define PAYMENT_Setup @"/repayment-plan/channel"

//借款合同(协议)
#define LOAN_Contract(orderId,accessToken) [NSString stringWithFormat:@"/contract/%@?accessToken=%@",orderId,accessToken]
//居间服务协议
#define LOAN_Service(orderId,accessToken) [NSString stringWithFormat:@"/contract/%@/intermediary-service?accessToken=%@",orderId,accessToken]

//上传电子签名
#define Upload_SignImage @"/contract/sign-upload"

//上传签名认证到digio
#define Generate_contract @"/contract/generate-contract"

//获取签名认证方 digio链接
#define Get_Sign_Url @"/contract/get-sign-url"

#define Send_Constract @"/contract/send-contract"
//确认银行卡
#define LOAN_ConfirmBC(accessToken) [NSString stringWithFormat:@"/bank_card/confirm?accessToken=%@",accessToken]
//更换银行卡
#define LOAN_ReplaceBC(accessToken) [NSString stringWithFormat:@"/bank_card/change?accessToken=%@",accessToken];

//签约无抵用券

#define Loan_Sign(orderId)  [NSString stringWithFormat:@"/order/%@/action/sign",orderId]
#define LOAN_SigningWithCoupon(accessToken,loanId,couponId) [NSString stringWithFormat:@"/order/%@/%@/action/sign?accessToken=%@",loanId,couponId,accessToken]

//签约有抵用券
#define LOAN_Signing(accessToken,loanId) [NSString stringWithFormat:@"/order/%@/action/sign?accessToken=%@",loanId,accessToken]

//获得银行列表
#define BANK_List(accessToken) [NSString stringWithFormat:@"/bank_card/select_bank?accessToken=%@",accessToken]

//意见反馈
#define FEEDBACK(accessToken) [NSString stringWithFormat:@"/feedback?accessToken=%@",accessToken]

//公告(get)
//列表
#define NOTICE_List @"/notice"
//公告详情
#define NOTICE_Detail(noticeId) [NSString stringWithFormat:@"/notice/%@",noticeId]

//私信(get)
//列表
#define INBOX_LIST @"/inbox"
//私信详情(get)
#define INBOX_Detail(inboxId) [NSString stringWithFormat:@"/inbox/%@",inboxId]

//广告
#define ADVERT_List @"/promotion"
//手机验证web链接
#define AUTHENTICATION_phone(accessToken) [NSString stringWithFormat:@"/authentication/phone/step/1?accessToken=%@",accessToken]

//version(GET)
#define VERSION_API @"/version"

//芝麻信用（GET）
#define ZMXY_Param @"/zmxy/sign/action/generate"
//更新芝麻信用状态（GET）
#define ZMXY_Callback @"/zmxy/action/callback"


//首页信息
#define HOMEPAGE_UserData @"/user/home"

//获取用户身份认证信息
#define User_Identy @"/user/identity"

//**************************认证**************************
#define AUTH_FACEBOOK @"/user/auth-facebook"
//基础信息
#define CREATE_UserInfo(accessToken) [NSString stringWithFormat:@"/user/action/create_user_info?accessToken=%@",accessToken]

//筛选参数配置
#define PARAMETER_Config @"/user/action/user_info_config"

//紧急联系人
#define EmergencyContact(accessToken) [NSString stringWithFormat:@"/user/action/create_user_contact?accessToken=%@",accessToken]
//通讯录
#define UPLOAD_AddressBook(accessToken) [NSString stringWithFormat:@"/user/action/user_contact_list?accessToken=%@",accessToken]
//更新当前位置
#define UPDATE_Position(accessToken) [NSString stringWithFormat:@"/user/update-position?accessToken=%@",accessToken]
//设备信息
#define DEVICE_Info(accessToken) [NSString stringWithFormat:@"/user/action/create_hardware?accessToken=%@",accessToken]

//运营商验证
#define OTPCheck @"/captcha/telecom-check"

//验证aadhaarCard手机号
#define AadhaarTelephoneCheck @"/user/user-card/aadhaar-telephone-check"

#define User_Identity @"/user/identity"

//上传人脸识别自拍视频
#define UPLoad_Face @"/authentication/faces/action/upload"


#define Identify_Check @"/authentication/face/action/check"


#define Config_Profession @"/config/profession"

//**************************抵用券**************************
//可使用
#define VOUCHERS_CanUse @"/coupon/can"
//已使用
#define VOUCHERS_Already @"/coupon/already"
//已过期
#define VOUCHERS_Expire @"/coupon/expire"
//抵用券弹窗
#define VOUCHERS_Windows @"/coupon/windows"


//***********************邀请好友***************
//1获取活动分享
#define INVITE_GetUrl @"/invite/get-url"
//2邀请好友统计
#define INVITE_BillsCount @"/invite/friend-count"
//3获取交易流水列表
#define INVITE_DealFlow @"/trade-record"
//4交易流水详情
#define INVITE_DealParticulars @"/trade-record/detail"
//5用户余额查询
#define INVITE_Enquiries @"/user/detail"

//6银行信息
#define INVITE_BANKS @"/user/bank-card-no"
//7shou手续费文案
#define INVITE_Message @"/invite/service-charge-info"

//8提现（）
#define INVITE_GetCash @"/user/cash"
//9fe分享二维码（）
#define INVITE_QRCode @"/invite/get-qrcode"

//10提现手续费
#define INVITE_GetServiceCash @"/invite/get-service-charge"
//11获取好友列表
#define INVITE_GetfriendsList @"/invite/friends-list"
//12邀请好友统计
#define INVITE_InviteFriendCount @"/invite/friend-count"
//13获取当前配置的拉新手续费
#define INVITE_Getconfig @"/invite/invite-cash-config"

//tabbar配置
#define MENUSET @"/common/home-menu"

//审核期间判断
#define APPAudit @"/common/ios-check"

#define Config @"/config"
#endif /* URLMacros_h */
