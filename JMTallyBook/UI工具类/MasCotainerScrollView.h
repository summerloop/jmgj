//
//  MasCotainerScrollView.h
//  CashNow
//
//  Created by Junheng on 2018/5/6.
//  Copyright © 2018年 jinqianbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasCotainerScrollView : UIScrollView

@property (nonatomic,strong) UIView *scrollContainerView;

- (void)setScrollContainerHeightWithKeyView:(UIView *)view ExtraSectionHeight:(CGFloat)height;

@end
