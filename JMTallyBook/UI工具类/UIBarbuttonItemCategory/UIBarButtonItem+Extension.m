//
//  UIBarButtonItem+Extension.m
//  MyCommunity
//
//  Created by Junheng on 15/10/19.
//  Copyright © 2015年 WenJim. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)


+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{


    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //设置图片
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    
    
    UIImage *Inimage = [UIImage imageNamed:image];
    
    
    
    
    btn.size = CGSizeMake(Inimage.size.width, Inimage.size.height);
    
  
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
    
}





+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action Title:(NSString *)title Font:(UIFont *)font TextColor:(UIColor *)color{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    
    btn.titleLabel.font = font;
    
    [btn setTitleColor:color forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(0, 0, 45, 20);
    
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
   
    


}
@end
