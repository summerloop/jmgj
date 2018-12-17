//
//  JMNewAccountTableViewController.h
//  JMTallyBook
//
//  Created by JM on 16/2/21.
//  Copyright © 2016年 JM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"

@class JMNewAccountTableViewController;

@protocol PassingDateDelegate <NSObject>;
@optional
- (void)viewController:(JMNewAccountTableViewController *)controller didPassDate:(NSString *)date;
// 使用代理将date值传给首页(让其筛选Fetch的managedObject)
@end

@interface JMNewAccountTableViewController : UITableViewController

@property (nonatomic, weak) id<PassingDateDelegate> delegate;

@property (nonatomic, assign) BOOL isSegueFromTableView; // 判断是否通过点击cell转来

@property (nonatomic, strong) Account *accountInSelectedRow; // 点击的cell是第几个
@end
