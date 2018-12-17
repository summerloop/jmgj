//
//  LineHeightConstraint.m
//  RapidLoan
//
//  Created by 黎剑宇 on 2016/11/18.
//  Copyright © 2016年 mark. All rights reserved.
//

#import "LineHeightConstraint.h"

@implementation LineHeightConstraint
+ (CGFloat)lineHeight
{
    static CGFloat lineHeight;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lineHeight = 1.f / [[UIScreen mainScreen] scale];
    });
    return lineHeight;
}


- (void)setConstant:(CGFloat)constant
{
    [super setConstant:[LineHeightConstraint lineHeight]];
}

- (CGFloat)constant
{
    return [LineHeightConstraint lineHeight];
}

@end
