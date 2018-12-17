//
//  RadiusCornerTextField.m
//  Loanmarket
//
//  Created by Junheng on 2017/9/20.
//  Copyright © 2017年 jinqianbao. All rights reserved.
//

#import "RadiusCornerTextField.h"

@implementation RadiusCornerTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
  
    [super awakeFromNib];
    

    [self setup];
    

}

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        [self setup];
    }

    return self;

}


- (void)setup{

    
    self.borderStyle =  UITextBorderStyleNone;
    
    self.leftViewMode = UITextFieldViewModeAlways;
    
//    self.rightViewMode = UITextFieldViewModeAlways;
    
    
    
     self.layer.borderWidth = 1;
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.height / 2;
    
    
    CGRect frame = self.frame;
    
    frame.size.width = 15;//设置左边距的大小
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
  
    
    self.leftView  = leftview;
    
//    UIView *rightView = [[UIView alloc] initWithFrame:frame];

//    self.rightView = rightView;
    
    
      self.layer.borderColor =  UICOLOR_E3E3E3.CGColor;
 
   
    
}
@end
