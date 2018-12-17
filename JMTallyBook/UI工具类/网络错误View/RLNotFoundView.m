//
//  RLNotFoundView.m
//  RapidLoan
//
//  Created by 黎剑宇 on 2017/7/27.
//  Copyright © 2017年 mark. All rights reserved.
//

#import "RLNotFoundView.h"

@interface RLNotFoundView()


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topVerConstraint;

@end
@implementation RLNotFoundView


- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    
    self.topVerConstraint.constant =  kARHeightTranslator(80);
    
    
    
    self.refreshButton.layer.cornerRadius = kARHeightTranslator(42) / 2;
    self.refreshButton.layer.masksToBounds = YES;
    
    
    
}
+ (instancetype)notFoundView
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
}

@end
