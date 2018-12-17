//
//  RootViewController.h
//  MiAiApp
//
//  Created by 贺俊恒 on 2017/5/18.
//  Copyright © 2017年 贺俊恒. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIViewController+AlertViewAndActionSheet.h"
#import "MasCotainerScrollView.h"


@interface RootViewController : UIViewController

/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;

@property (nonatomic,assign) BOOL hideStatusBar;



@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView * collectionView;


@property (nonatomic,strong) MasCotainerScrollView *scrollView;


/**
 *  显示网络错误View
 */
- (void)showNotFoundView;


- (void)removeNotFoundView;

/**
 *  展示无数据页面
 */
- (void)showNoDataView;

- (void)showNoDataViewWithFrame:(CGRect)frame;
/**
 *  移除无数据页面
 */
-(void)removeNoDataView;

/**
 *  需要登录
 */
- (void)showShouldLoginPoint;

/**
 *  加载视图
 */
- (void)showLoadingAnimation;

/**
 *  停止加载
 */
- (void)stopLoadingAnimation;

/**
 *  是否显示返回按钮,默认情况是YES 废弃
*   改为导航管理基类来实现
 */
@property (nonatomic, assign) BOOL isShowLiftBack;

/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL isHidenNaviBar;

/**
 导航栏添加文本按钮

 @param titles 文本数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

/**
 导航栏添加图标按钮

 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;


//- (void)addCustomerServiceEntrance;
/**
 *  默认返回按钮的点击事件，默认是返回，子类可重写
 */
//- (void)backBtnClicked;

//取消网络请求
- (void)cancelRequestWithUrlString:(NSString *)urlString;

@end
