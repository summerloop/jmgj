//
//  MCCaculateWidthOrHeight.m
//  MyCommunity
//
//  Created by Junheng on 15/8/21.
//  Copyright (c) 2015年 Junheng. All rights reserved.
//

#import "MCCaculateWidthOrHeight.h"

@implementation MCCaculateWidthOrHeight


+ (CGFloat)getWidth:(NSString *)str labelFont:(UIFont *)font Height:(float)height
{

    CGSize size = CGSizeMake(MAXFLOAT, height);
    
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    
    CGSize actualSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    
    return actualSize.width;
    
    

}


+ (CGFloat)getHeight:(NSString *)str labelFont:(UIFont *)font Width:(float)width
{

    CGSize size = CGSizeMake(width, MAXFLOAT);
    
    NSDictionary *tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    
    
    
    CGSize actualSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    return actualSize.height;
    
    



}

+ (NSMutableAttributedString *)attributedStringWithStirng:(NSString *)string paragraphStyle:(NSParagraphStyle *)style font:(UIFont *)font foregroundColor:(UIColor *)color
{
    NSMutableAttributedString *attriIndroduce = [[NSMutableAttributedString alloc] initWithString:string];
    
    
    [attriIndroduce setAttributes:@{
                                    NSParagraphStyleAttributeName :style,
                                    NSFontAttributeName:font,
                                    NSForegroundColorAttributeName:color
                                    } range:NSMakeRange(0, string.length)];
    
    return attriIndroduce;
}

+ (NSMutableAttributedString *)attributedStringWithStirng:(NSString *)string lineSpace:(CGFloat)lineSpace font:(UIFont *)font foregroundColor:(UIColor *)color
{
    
    NSMutableAttributedString *attriIndroduce = [[NSMutableAttributedString alloc] initWithString:string];
    
        /*
         NSLineBreakByWordWrapping = 0,     	// Wrap at word boundaries, default
         NSLineBreakByCharWrapping,		// Wrap at character boundaries
         NSLineBreakByClipping,		// Simply clip
         NSLineBreakByTruncatingHead,	// Truncate at head of line: "...wxyz"
         NSLineBreakByTruncatingTail,	// Truncate at tail of line: "abcd..."
         NSLineBreakByTruncatingMiddle
         */
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [attriIndroduce setAttributes:@{
                                    NSParagraphStyleAttributeName :style,
                                    NSFontAttributeName:font,
                                    NSForegroundColorAttributeName:color
                                    } range:NSMakeRange(0, string.length)];
    
    return attriIndroduce;
}


+ (NSMutableAttributedString *)attributedStringWithStirng:(NSString *)string strWidth:(CGFloat)strWidth minHeight:(CGFloat)minHeight lineSpace:(CGFloat)lineSpace font:(UIFont *)font foregroundColor:(UIColor *)color
{
    // 先判断是否是一行
    CGFloat height = [self getHeight:string labelFont:font Width:strWidth];
    //CGFloat baselineOffset = 0.0f; // 基线偏移值，正值上偏
    
    if (height < (minHeight + minHeight/2.0)) {
        //baselineOffset = -1.0f;
        lineSpace = 0.0f;
    }
    
    
    return [self attributedStringWithStirng:string lineSpace:lineSpace font:font foregroundColor:color];



}

+ (NSMutableAttributedString *)attributedStringWithStirng:(NSString *)string lineSpace:(CGFloat)lineSpace font:(UIFont *)font foregroundColor:(UIColor *)color baselineOffset:(CGFloat)lineOffset
{
    
    NSMutableAttributedString *attriIndroduce = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
    
    [attriIndroduce setAttributes:@{
                                    NSParagraphStyleAttributeName :style,
                                    NSFontAttributeName:font,
                                    NSForegroundColorAttributeName:color,
                                    NSBaselineOffsetAttributeName:@(lineSpace)
                                    } range:NSMakeRange(0, string.length)];
    
    return attriIndroduce;
}


+ (CGFloat)getHeigt:(NSString *)str WithlabelFont:(UIFont *)font lineSpace:(CGFloat)lineSpace Width:(CGFloat)width{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
    
    CGSize size = CGSizeMake(width, MAXFLOAT);
    
    NSDictionary *tdic = @{
                           NSFontAttributeName:font,
                           NSParagraphStyleAttributeName:style
                           
                           };
    
    
    //    [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    
    
    
    CGSize actualSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    
    return actualSize.height;
}

#pragma mark -  删除线
+(NSMutableAttributedString *)attributedStringWith:(NSString *)string font:(UIFont *)font StrikethroughColor:(UIColor *)color
{
    //富文本 增加删除线
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    
    [attributedString addAttributes:@{
                                      NSFontAttributeName:font,
                                      NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
                                      NSStrikethroughColorAttributeName:color}
                              range:NSMakeRange(0, string.length)];
    
    
    return attributedString;
}

@end
