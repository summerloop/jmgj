//
//  CommonMacros.h
//  MiAiApp
//
//  Created by 贺俊恒 on 2017/5/31.
//  Copyright © 2017年 贺俊恒. All rights reserved.
//

//全局标记字符串，用于 通知 存储

#ifndef CommonMacros_h
#define CommonMacros_h







#pragma mark - ——————— 用户相关 ————————
//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"

//自动登录成功
#define KNotificationAutoLoginSuccess @"KNotificationAutoLoginSuccess"

//刷新RefreshToken三次失败  强制重新登录
#define KNotificationRefreshTokenFailed @"KNotificationRefreshTokenFailed"
//被踢下线
#define KNotificationOnKick @"KNotificationOnKick"

//用户信息缓存 名称
#define KUserCacheName @"KUserCacheName"

//用户model缓存
#define KUserModelCache @"KUserModelCache"



#pragma mark - ——————— 网络状态相关 ————————

//网络状态变化
#define KNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"


#define WXLoginSuccess @"WXLoginSuccess"




#define kNotificationRequestFailed @"kNotificationRequestFailed"//请求失败操作

#define HomePageNotificationNeedRefresh @"HomePageNotificationNeedRefresh" //首页刷新通知

#define BankCardNotificationAtReplaceFinish @"BankCardNotificationAtReplaceFinish"//更换银行卡完成通知


#define VouchersManagerNeedToRefreshNotification @"VouchersManagerNeedToRefreshNotification"//抵用券管理者刷新数据通知

#define KNotifcationPushToTuCaoWebView @"PushToTuCaoWebView"//意见反馈push操作

#define UserManagerNotificationAtLoginSuccessed @"UserManagerNotificationAtLoginSuccessed"//登录成功

#define UserManagerNotificationAtLoanSuccessed @"UserManagerNotificationAtLoanSuccessed"//贷款成功


#define UserManagerNotificationAtLogout @"UserManagerNotificationAtLogout"//退出


#define UserManagerNotificationAtPaymentSuccessed @"UserManagerNotificationAtPaymentSuccessed"//付款成功(续期、还款)


#define UserManagerNotificationAtHasNewMessage @"UserManagerNotificationAtHasNewMessage"//接收到新消息推送（公告、私信）


#define UserManagerNotificationAtAddBankCardSuccessed @"UserManagerNotificationAtAddBankCardSuccessed"


#define UserManagerNotificationAtAuthorizationSuccess @"UserManagerNotificationAtAuthorizationSuccess"//芝麻信用授权成功


#define UserManagerNotificationAtRefreshInfomation @"UserManagerNotificationAtRefreshInfomation"


#define UserManagerNotificationAtConfirmBankCardFinish @"UserManagerNotificationAtConfirmBankCardFinish"//确认银行卡完成


//认证中心列表刷新通知
#define PersonalFileViewControllerNeedRefresh  @"PersonalFileViewControllerNeedRefresh"

#define iSOpenFaceOrJustFinishDocumentVerify  @"isOpenFaceOrJustFinishDocumentVerify"

#define YZUpdateSubMenuTitleNote @"YZUpdateSubMenuTitleNote"

#define YZRestoreMenuTitleNote @"YZRestoreMenuTitleNote"

#endif /* CommonMacros_h */
