//
//  UIView+JYExtesion.h
//  链式编程思想
//
//  Created by 黎剑宇 on 16/4/14.
//  Copyright © 2016年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JYExtesion)

- (UIView *(^)(CGFloat theX))theX;
- (UIView *(^)(CGFloat theY))theY;
- (UIView *(^)(CGFloat width))width;
- (UIView *(^)(CGFloat height))height;

@end
