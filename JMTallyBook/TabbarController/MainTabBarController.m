//
//  MainTabBarController.m
//  RapidLoan
//
//  Created by 黎剑宇 on 2016/10/12.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "MainTabBarController.h"


@interface MainTabBarController ()


@end

@implementation MainTabBarController


+ (void)initialize{
     [UITabBar appearance].translucent = NO;

    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = HexColor(@"bdbdbd");
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = HexColor(@"484848");
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
    
}


- (void)viewDidLoad {
    

    [super viewDidLoad];


//    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
 
    
 

}




@end
