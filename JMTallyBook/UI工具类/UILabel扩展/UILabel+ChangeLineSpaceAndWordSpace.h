//
//  UILabel+ChangeLineSpaceAndWordSpace.h
//  RLBaseFramework
//
//  Created by Junheng on 2018/1/29.
//  Base on Tof Templates
//Copyright © 2018年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -
#pragma mark Category ChangeLineSpaceAndWordSpace for UILabel 
#pragma mark -

@interface UILabel (ChangeLineSpaceAndWordSpace)


/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
