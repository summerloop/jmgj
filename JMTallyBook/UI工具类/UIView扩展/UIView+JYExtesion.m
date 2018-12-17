//
//  UIView+JYExtesion.m
//  链式编程思想
//
//  Created by 黎剑宇 on 16/4/14.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "UIView+JYExtesion.h"

@implementation UIView (JYExtesion)

- (UIView *(^)(CGFloat width))width
{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat width){
        weakSelf.frame = CGRectMake(CGRectGetMinX(weakSelf.frame), CGRectGetMinY(weakSelf.frame), width, CGRectGetHeight(weakSelf.frame));
        return weakSelf;
    };
}

- (UIView *(^)(CGFloat height))height
{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat height){
        weakSelf.frame = CGRectMake(CGRectGetMinX(weakSelf.frame), CGRectGetMinY(weakSelf.frame), CGRectGetWidth(weakSelf.frame), height);
        return weakSelf;
    };
}

- (UIView *(^)(CGFloat theX))theX
{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat theX){
        weakSelf.frame = CGRectMake(theX, CGRectGetMinY(weakSelf.frame), CGRectGetWidth(weakSelf.frame), CGRectGetHeight(weakSelf.frame));
        return weakSelf;
    };
}

- (UIView *(^)(CGFloat theY))theY
{
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat theY){
        weakSelf.frame = CGRectMake(CGRectGetMinX(weakSelf.frame), theY, CGRectGetWidth(weakSelf.frame), CGRectGetHeight(weakSelf.frame));
        return weakSelf;
    };
}
@end
