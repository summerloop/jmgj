//
//  PublicEnum.h
//  CashNow
//
//  Created by Junheng on 2018/10/25.
//  Copyright © 2018 jinqianbao. All rights reserved.
//

#ifndef PublicEnum_h
#define PublicEnum_h

typedef NS_ENUM(NSUInteger,HomePageType) {
    HomePageTypeAtLoan = 0,             //我要借款
    HomePageTypeAtConfirmBankCard = 1,  //确认银行卡
    HomePageTypeAtWaitingSign = 2,      //待签约
    HomePageTypeAtRefused = 4,          //拒绝
    HomePageTypeAtRefusedNeed_Atitude = 5,  //拒绝待补充资料
    HomePageTypeAtWaitingForPayment = 6,//待放款
    HomePageTypeAtWaitingForPaymentFaile = 7, //放款失败
    HomePageTypeAtPending = 8,          //待审核
    HomePageTypeAtPendingNeed_Atitude = 9, //待审核待补充资料
    HomePageTypeAtWaitingRepayment = 3, //待还款
    HomePageTypeAtRepaying = 10          //还款进行中
};

#endif /* PublicEnum_h */
