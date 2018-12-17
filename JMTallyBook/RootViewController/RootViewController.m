//
//  RootViewController.m
//  MiAiApp
//
//  Created by 贺俊恒 on 2017/5/18.
//  Copyright © 2017年 贺俊恒. All rights reserved.
//

#import "RootViewController.h"

#import "MJRefresh.h"

//#import "LoginViewController.h"
//#import <UShareUI/UShareUI.h>

#import "RLNotFoundView.h"
#import "MCCaculateWidthOrHeight.h"
#import "NoDataPlaceHolderView.h"
//#import "BindPromptView.h"
@interface RootViewController ()<UINavigationControllerDelegate>

//@property (nonatomic,strong) UIImageView* noDataView;

@property (nonatomic,strong) NoDataPlaceHolderView *noDataView;



@property (nonatomic,strong) UIView *scrollViewContainerView;

@property (strong, nonatomic) RLNotFoundView *notFoundView;
//@property (nonatomic,strong) BindPromptView *promptView;

@end

@implementation RootViewController



- (RLNotFoundView *)notFoundView{
    
    if (!_notFoundView) {
        
        
        _notFoundView = [RLNotFoundView notFoundView];
        
        [_notFoundView.refreshButton addTarget:self action:@selector(refrshAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _notFoundView;
    
}

- (void)refrshAction{
    
    
    
    
    
}
//- (BindPromptView *)promptView{
//
//    if (!_promptView) {
//
//
//        _promptView = [BindPromptView bindPrompt];
//    }
//
//    return _promptView;
//
//}


- (BOOL)prefersStatusBarHidden{
    
    
    return _hideStatusBar;
    
    
    
}

- (void)setHideStatusBar:(BOOL)hideStatusBar{
    
    _hideStatusBar = hideStatusBar;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return _StatusBarStyle;
}
//动态更新状态栏颜色
-(void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle{
    _StatusBarStyle=StatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DefaultBgColor;
    
 
 
    //是否显示返回按钮
    
    //由自定义导航控制器控制
//    self.isShowLiftBack = YES;
    
    //默认黑色
    self.StatusBarStyle = UIStatusBarStyleDefault;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSString *eventStr = NSStringFromClass([self class]);
//    [MobClick beginLogPageView:eventStr];
  
    self.navigationController.delegate = self;

}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
//    NSString *eventStr = NSStringFromClass([self class]);
//    [MobClick endLogPageView:eventStr];
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    
//        if ([SVProgressHUD isVisible]) {
//            [SVProgressHUD dismiss];
//        }
    
    
}


- (void)viewDidDisappear:(BOOL)animated{


    [super viewDidDisappear:animated];
    
//
//    if ([SVProgressHUD isVisible]) {
//        [SVProgressHUD dismiss];
//    }
//

}


//提示需要登录或者跳到登录界面
- (void)showShouldLoginPoint{
    
    
    
}

- (void)showLoadingAnimation
{
   
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

- (void)stopLoadingAnimation
{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
   
}




-(void)removeNoDataView{
    
    if (self.noDataView && self.noDataView.superview) {
   
        [_noDataView removeFromSuperview];
        
        _noDataView = nil;
    }
}

- (void)showNoDataViewWithFrame:(CGRect)frame{
    
    if (self.noDataView.superview) {
        
        return;
    }
    
    
    
    _noDataView = [NoDataPlaceHolderView noDataPlaceHolderView];
    _noDataView.layer.shadowColor = RGBCOLOR(0x9C, 0x9C, 0x9C, 1).CGColor;
    _noDataView.layer.shadowOpacity = 0.3f;
    _noDataView.layer.shadowRadius = 3.f;
    _noDataView.layer.cornerRadius = 10.f;
    _noDataView.layer.shadowOffset = CGSizeMake(0,3);
    self.noDataView.frame = frame;
//    self.noDataView.backgroundColor = self.view.backgroundColor;
    
      [self.view addSubview:self.noDataView];

}

-(void)showNoDataView
{
    
    if (self.noDataView.superview) {
        
        return;
    }
    
    
    
    _noDataView = [NoDataPlaceHolderView noDataPlaceHolderView];
    [self.view.subviews enumerateObjectsUsingBlock:^(UITableView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            [self.noDataView setFrame:CGRectMake(obj.frame.origin.x, obj.frame.origin.y,obj.frame.size.width, obj.frame.size.height)];
            [self.view addSubview:self.noDataView];
        }
    }];
}








- (MasCotainerScrollView *)scrollView{
    
    if (!_scrollView) {
        
        
        _scrollView = [[MasCotainerScrollView alloc]initWithFrame:CGRectMake(0, kTopHeight, KScreenWidth, KScreenHeight - kTopHeight)];
        
        
    }
    
    return _scrollView;
    
}




/**
 *  懒加载UITableView
 *
 *  @return UITableView
 */
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        //头部刷新
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = NO;
        _tableView.mj_header = header;
        
        //底部刷新
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        
//        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
//        _tableView.footer.ignoredScrollViewContentInsetTop = 30;
        
//        _tableView.backgroundColor= [UIColor colorWithHexString:@"f2f2f2"];
        
        _tableView.scrollsToTop = YES;
        //        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //        _tableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, -10);//{top, left, bottom, right}
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

/**
 *  懒加载collectionView
 *
 *  @return collectionView
 */
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flow];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = NO;
        _collectionView.mj_header = header;
        
        //底部刷新
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
//        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
//        _collectionView.footer.ignoredScrollViewContentInsetTop = 30;
        
//        _collectionView.backgroundColor= [UIColor colorWithHexString:@"f2f2f2"];
        _collectionView.scrollsToTop = YES;
    }
    return _collectionView;
}
-(void)headerRereshing{
    
}

-(void)footerRereshing{
    
}

/**
 *  是否显示返回按钮
 */
//- (void)setIsShowLiftBack:(BOOL)isShowLiftBack
//{
//    _isShowLiftBack = isShowLiftBack;
//    NSInteger VCCount = self.navigationController.viewControllers.count;
//    //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
//    if (isShowLiftBack && ( VCCount > 1 || self.navigationController.presentingViewController != nil)) {
//        [self addNavigationItemWithImageNames:@[@"icon_back_black"] isLeft:YES target:self action:@selector(backBtnClicked) tags:nil];
//
//    } else {
//        self.navigationItem.hidesBackButton = YES;
//        UIBarButtonItem * NULLBar=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
//        self.navigationItem.leftBarButtonItem = NULLBar;
//    }
//}
//- (void)backBtnClicked
//{
////    if (self.presentingViewController) {
////        [self dismissViewControllerAnimated:YES completion:nil];
////    }else{
//        [self.navigationController popViewControllerAnimated:YES];
////    }
//}


//- (void)addCustomerServiceEntrance{
//
//     [self addNavigationItemWithImageNames:@[@"icon_customerservice"] isLeft:NO target:self action:@selector(goToCustomService) tags:nil];
//
//
//}

//- (void)goToCustomService{
//    [WebViewPushTool pushCustomerServiceViewControllerByViewController:self];
//    
//}

#pragma mark ————— 导航栏 添加图片按钮 —————
/**
 导航栏添加图标按钮
 
 @param imageNames 图标数组
 @param isLeft 是否是左边 非左即右
 @param target 目标
 @param action 点击方法
 @param tags tags数组 回调区分用
 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    NSMutableArray * items = [[NSMutableArray alloc] init];
    //调整按钮位置
    //    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    //将宽度设为负值
    //    spaceItem.width= -5;
    //    [items addObject:spaceItem];
    NSInteger i = 0;
    for (NSString * imageName in imageNames) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        if (isLeft) {
            
              [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
//            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        }else{
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        }
        
        btn.tag = [tags[i++] integerValue];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

#pragma mark ————— 导航栏 添加文字按钮 —————
- (void)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    
    NSMutableArray * items = [[NSMutableArray alloc] init];
    
    //调整按钮位置
    //    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    //将宽度设为负值
    //    spaceItem.width= -5;
    //    [items addObject:spaceItem];
    
    NSMutableArray * buttonArray = [NSMutableArray array];
    NSInteger i = 0;
    for (NSString * title in titles) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setTitle:title forState:UIControlStateNormal];
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = SYSTEMFONT(16);
        [btn setTitleColor:HexColor(@"444444") forState:UIControlStateNormal];
        btn.tag = [tags[i++] integerValue];
        [btn sizeToFit];
        
        //设置偏移
        if (isLeft) {
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }
        
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        [buttonArray addObject:btn];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
//    return buttonArray;
}



- (void)cancelRequestWithUrlString:(NSString *)urlString{
    
//    [PPNetworkHelper cancelRequestWithURL:DEFAULT_Domain(urlString)];
    
    
}
//取消请求
- (void)cancelRequest
{
    
    
   
//    + (void)cancelRequestWithURL:(NSString *)URL;
    
}


- (void)showNotFoundView
{
    
    if (self.notFoundView.superview) {
        
        return;
    }
    
    

    [self.view addSubview:self.notFoundView];
    [self.notFoundView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat bottom = self.hidesBottomBarWhenPushed ? 0:-49;
        make.top.mas_equalTo(kTopHeight);
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@(bottom));
    }];
}

- (void)removeNotFoundView{
    
    
    if (self.notFoundView && self.notFoundView.superview) {
        
        
        
        [self.notFoundView removeFromSuperview];
        
          self.notFoundView = nil;
        
        
    }
    
}
- (void)dealloc
{
    [self cancelRequest];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.navigationController.delegate = nil;
}


-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
//    self.isShowLiftBack = YES;
  
    
#ifdef DEBUG
    if (navigationController.viewControllers.count > 1) {
        NSUInteger count = navigationController.viewControllers.count;
        NSArray *controllers = navigationController.viewControllers;
        NSString *last = NSStringFromClass([[controllers lastObject] class]);
        NSString *previous = NSStringFromClass([controllers[count-2] class]);
        
        JYLog(@"\n当前控制器：%@\n上一个控制器：%@",last,previous);
    }else {
        JYLog(@"\n当前控制器：%@",NSStringFromClass([viewController class]));
    }
    
    
#endif
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
