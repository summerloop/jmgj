//
//  MasCotainerScrollView.m
//  CashNow
//
//  Created by Junheng on 2018/5/6.
//  Copyright © 2018年 jinqianbao. All rights reserved.
//

#import "MasCotainerScrollView.h"

@implementation MasCotainerScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (UIView *)scrollContainerView{
    
    if (!_scrollContainerView) {
        
        
        _scrollContainerView = [[UIView alloc]init];
        _scrollContainerView.backgroundColor = DefaultBgColor;
        
        [self addSubview:_scrollContainerView];
        
        [_scrollContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            make.width.equalTo(self);
            
        }];
        
    }
    
    return _scrollContainerView;
    
}






- (void)setScrollContainerHeightWithKeyView:(UIView *)view ExtraSectionHeight:(CGFloat)height{
    
    
    [self.scrollContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(view.mas_bottom).offset(height);
        
    }];
    
    
    
    
}
@end
