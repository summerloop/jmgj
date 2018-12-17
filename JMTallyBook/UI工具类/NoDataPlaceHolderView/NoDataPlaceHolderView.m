//
//  NoDataPlaceHolderView.m
//  JMTallyBook
//
//  Created by Junheng on 2018/12/12.
//  Copyright © 2018 azx. All rights reserved.
//

#import "NoDataPlaceHolderView.h"

@implementation NoDataPlaceHolderView

+ (instancetype)noDataPlaceHolderView{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
