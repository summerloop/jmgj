//
//  JYAlertView.m
//  RapidLoan
//
//  Created by 黎剑宇 on 2017/3/13.
//  Copyright © 2017年 mark. All rights reserved.
//

#import "JYAlertView.h"

@interface JYAlertView ()

@end

@implementation JYAlertView
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    if (buttonIndex == 1&&
        [self textFieldAtIndex:0].text.length !=8) {
        return;
    }
    [super dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

@end
