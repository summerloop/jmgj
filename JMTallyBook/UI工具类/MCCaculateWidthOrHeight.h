//
//  MCCaculateWidthOrHeight.h
//  MyCommunity
//
//  Created by Junheng on 15/8/21.
//  Copyright (c) 2015年 Junheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCCaculateWidthOrHeight : NSObject


+ (CGFloat)getHeigt:(NSString *)str WithlabelFont:(UIFont *)font lineSpace:(CGFloat)lineSpace Width:(CGFloat)width;


+ (CGFloat)getWidth:(NSString *)str  labelFont:(UIFont *)font Height:(float)height;

+ (CGFloat)getHeight:(NSString *)str  labelFont:(UIFont *)font Width:(float)width;

+ (NSMutableAttributedString *)attributedStringWithStirng:(NSString *)string paragraphStyle:(NSParagraphStyle *)style font:(UIFont *)font foregroundColor:(UIColor *)color;

+ (NSMutableAttributedString *)attributedStringWithStirng:(NSString *)string lineSpace:(CGFloat)lineSpace font:(UIFont *)font foregroundColor:(UIColor *)color;

+ (NSMutableAttributedString *)attributedStringWithStirng:(NSString *)string strWidth:(CGFloat)strWidth minHeight:(CGFloat)minHeight lineSpace:(CGFloat)lineSpace font:(UIFont *)font foregroundColor:(UIColor *)color;

/**
 删除线

 @param string 字符串
 @param font 字体
 @param color 删除线颜色
 */
+(NSMutableAttributedString *)attributedStringWith:(NSString *)string font:(UIFont *)font StrikethroughColor:(UIColor *)color;

@end
