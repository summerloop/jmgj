//
//  UIBarButtonItem+Extension.h
//  MyCommunity
//
//  Created by Junheng on 15/10/19.
//  Copyright © 2015年 WenJim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)


+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;



+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action Title:(NSString *)title Font:(UIFont *)font TextColor:(UIColor *)color;


@end
