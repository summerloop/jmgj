//
//  RootNavigationController.m
//  Loanmarket
//
//  Created by Junheng on 2017/9/27.
//  Copyright © 2017年 jinqianbao. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()


@end

@implementation RootNavigationController

+ (void)initialize
{
    
    //导航栏主题 title文字属性
        UINavigationBar *navBar = [UINavigationBar appearance];
//        //导航栏背景图
        //    [navBar setBackgroundImage:[UIImage imageNamed:@"tabBarBj"] forBarMetrics:UIBarMetricsDefault];
//        [navBar setBarTintColor:CNavBgColor];
//        [navBar setTintColor:CNavBgFontColor];
//        [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName :CNavBgFontColor, NSFontAttributeName : [UIFont systemFontOfSize:18]}];
//
//        [navBar setBackgroundImage:[UIImage imageWithColor:CNavBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//
        [navBar setShadowImage:[UIImage new]];//去掉阴影线
    
    //设置阴影线的颜色
//        [navBar setShadowImage:[UIImage imageWithColor:HexColor(@"ffffff")]];
//     navBar.translucent = NO;
    
   
    
    //设置导航栏背景色 
        [navBar setBarTintColor:[UIColor whiteColor]];

    
        //设置整个项目所有BarButtonItem的主题样式
        UIBarButtonItem *item = [UIBarButtonItem appearance];
    
        //设置普通状态
        //key NS*********AttributeName
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    
        //textAttrs[NSForegroundColorAttributeName] = MCColor(35, 177, 209, 1);
        textAttrs[NSForegroundColorAttributeName] = MCColor(33, 33, 33, 1);
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
        //设置不可用状态
        NSMutableDictionary *disabletextAttrs = [NSMutableDictionary dictionary];
    
        disabletextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        disabletextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        [item setTitleTextAttributes:disabletextAttrs forState:UIControlStateDisabled];
    
    
    
    //设置导航栏标题文字的颜色
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HexColor(@"333333"),NSFontAttributeName:FONT(@"PingFangSC-Medium", 17)}];
    

    
    //设置默认按钮颜色
    [[UINavigationBar appearance] setTintColor:HexColor(@"484848")];
    
   
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 20;
//    self.fd_interactivePopDisabled = YES;
    
    
    UIImage *image = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = image;
    
        //iOS10去掉导航栏下面黑线
        if ([self.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
        {
            
            NSArray *list = self.navigationBar.subviews;
            
            for (id obj in list)
            {
                
                if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
                {//10.0的系统字段不一样
                    UIView *view =   (UIView*)obj;
                    for (id obj2 in view.subviews) {
                        
                        if ([obj2 isKindOfClass:[UIImageView class]]) {
                            
                            UIImageView *image =  (UIImageView*)obj2;
                            image.hidden = YES;
                        }
                    }
                }else
                {
                    
                    if ([obj isKindOfClass:[UIImageView class]])
                    {
                        
                        UIImageView *imageView=(UIImageView *)obj;
                        NSArray *list2=imageView.subviews;
                        for (id obj2 in list2)
                        {
                            if ([obj2 isKindOfClass:[UIImageView class]])
                            {
                                
                                UIImageView *imageView2=(UIImageView *)obj2;
                                imageView2.hidden=YES;
                            }
                        }
                    }
                }
            }
        }
        
        
        
        
 
    
}
/**
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated
{
    id vc = [self getCurrentViewControllerClass:ClassName];
    if(vc != nil && [vc isKindOfClass:[UIViewController class]])
    {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    
    return NO;
}

/**
 *  重写这个方法的目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 *  @param animated       是否带动画效果
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {   //这时PUSH进来的控制器不是第一个控制器（根控制器）
        
        /* 自动显示或者隐藏tabbar  */
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        
    }
    
    [super pushViewController:viewController animated:animated];
    
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
    
}

//- (void)onBack{
//    
//    
//    if (self.presentingViewController) {
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }else{
//        [self popViewControllerAnimated:YES];
//    }
//
//    
//    
//}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDefault;
//}

/*!
 *  获得当前导航器显示的视图
 *
 *  @param ClassName 要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil;
 */
-(instancetype)getCurrentViewControllerClass:(NSString *)ClassName
{
    Class classObj = NSClassFromString(ClassName);
    
    NSArray * szArray =  self.viewControllers;
    for (id vc in szArray) {
        if([vc isMemberOfClass:classObj])
        {
            return vc;
        }
    }
    
    return nil;
}


- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden{
    
    return self.topViewController;
    
}

- (BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (void)dealloc
{
    

    
    MLLog(@"MCNavigation dealloc");
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
