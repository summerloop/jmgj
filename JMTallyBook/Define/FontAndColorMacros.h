//
//  FontAndColorMacros.h
//  MiAiApp
//
//  Created by 贺俊恒 on 2017/5/18.
//  Copyright © 2017年 贺俊恒. All rights reserved.
//

//字体大小和颜色配置

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark -  间距区

//默认间距
#define KNormalSpace 12.0f

#pragma mark -  颜色区
//导航栏颜色
#define CNavBgColor  [UIColor colorWithHexString:@"00AE68"]
//#define CNavBgColor  [UIColor colorWithHexString:@"ffffff"]
#define CNavBgFontColor  [UIColor colorWithHexString:@"ffffff"]

//APP主题色
#define MainColor [UIColor colorWithHexString:@"3e2af6"]

//高亮紫色
#define HighlightedPurpleColor  [UIColor colorWithHexString:@"5F77FF"]

#define disabledTextColor [UIColor colorWithHexString:@"CCCCCC"]

//按钮不可点击时的文本颜色
#define ButtonDisabledTextColor [UIColor hexStringToColor:@"1d1d1d" andAlpha:0.4]
//高亮黑色
#define HighlightedBlackColor  [UIColor colorWithHexString:@"1D1D1D"]
//默认页面背景色
#define DefaultBgColor [UIColor colorWithHexString:@"ffffff"]

//分割线颜色
#define CLineColor [UIColor colorWithHexString:@"ededed"]

//次级字色
#define CFontColor1 [UIColor colorWithHexString:@"1f1f1f"]

//再次级字色
#define CFontColor2 [UIColor colorWithHexString:@"5c5c5c"]


#pragma mark -  字体区


#define FFont1 [UIFont systemFontOfSize:12.0f]

#endif /* FontAndColorMacros_h */
