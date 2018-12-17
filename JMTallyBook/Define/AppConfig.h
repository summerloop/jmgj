//
//  AppConfig.h
//  RapidLoan
//
//  Created by 黎剑宇 on 16/8/18.
//  Copyright © 2016年 mark. All rights reserved.
//

#ifndef RapidLoan_AppConfig_H
#define RapidLoan_AppConfig_H




#define AppName @"CashNow"

//请求头Company字段配置
#define HEADER_Compnay @"JX"

#define  KEY_USERNAME_PASSWORD @"com.jinqianbao.jmd.usernamepassword"


//颜色快捷设置
#define HexColor(str)  [UIColor colorWithHexString:str]
#define RGBCOLOR(r,g,b,a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define DEFAULT_blueColor RGBCOLOR(78,140,238,1)
#define DEFAULT_grayColor RGBCOLOR(180,180,180,1)
#define DONOTCLICK_Color  RGBCOLOR(78,140,238,.3)
#define UICOLOR_EDEDED    RGBCOLOR(237,237,237,1)
#define UICOLOR_CCCCCC    RGBCOLOR(204,204,204,1)
#define UICOLOR_ED694C    RGBCOLOR(237,105,76,1)
#define UICOLOR_9B9B9B    RGBCOLOR(155,155,155,1)
#define UICOLOR_E3E3E3    RGBCOLOR(227,227,227,1)
#define UICOLOR_F9F9F9    RGBCOLOR(249,249,249,1)
#define UICOLOR_444444    RGBCOLOR(68,68,68,1)
#define UICOLOR_9C9C9C    RGBCOLOR(156,156,156,1)

#define UICOLOR_7589E9    RGBCOLOR(117,137,233,1)


#define LLPAY_UserId(userId)  [NSString stringWithFormat:@"jmd%@",userId]

#ifdef DEBUG

#define JYLog(format, ...) printf("\n%s\n",[[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);

#else
#define JYLog(...)
#endif

#define LOGREQUEST(URL,Param) \
JYLog(@"\n**************开始请求************\nURL:%@\nparam:%@",URL,Param);
#define LOGRESULT(msg,data)     \
JYLog(@"\n************%@************\n%@\n************************",msg,data);
#define LOGFAILED(flag,msg) \
JYLog(@"\n*********加载失败*********\n%@\n%@\n*********",flag,msg);

#define ISNSStringEmptyOrNULLValue(value) (value == nil || [value isEqual:[NSNull null]] || [value isEqualToString:@"0.00"])
#define ISNSStringNULLValue(value) (value == nil || [value isEqual:[NSNull null]])

#define NSStringNotEmptyOrNullValue(value) (value == nil||[value isEqual:[NSNull null]] || [value isEqualToString:@"0.00"]) ? @"" : value
#define NSStringNotNullValue(value) (value == nil||[value isEqual:[NSNull null]]) ? @"" : value

#define NotEmptyString(value,placeholder) (value == nil||value.length == 0||[value isEqual:[NSNull null]]) ? placeholder : value

#define NSArrayNotNullValue(array,index) (index<array.count) ? array[index]:nil
#define NSDictionaryNotNullValue(dictionary,key) (dictionary.count == 0 || !dictionary) ? @"":[dictionary valueForKey:key]

#define PAGE(count,size) (count/size)+(count%size > 0)+1

#define CHECK_MobilePhone if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]){\
            abort();\
        }else {\
            char *env = getenv("DYLD_INSERT_LIBRARIES");\
            if (env) {\
                abort();\
            }\
            \
            struct stat stat_info;\
            if (0 == stat("/Applications/Cydia.app", &stat_info)) {\
                abort();\
            }\
        }


/*------------------Junheng_add-------------------*/

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]


//系统版本比较
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//判断手机尺寸的宏

#define KDevice_Is_iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define KDevice_Is_iPhone5  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define KDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define KDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6PlusBigMode ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen]currentMode].size) : NO)



#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define kDevice_Is_iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define kDevice_Is_iPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)


#define KDevice_Is_iPhoneX_Series (kDevice_Is_iPhoneX || kDevice_Is_iPhoneXR || kDevice_Is_iPhoneXSMax)
#define K_iPhoneXStyle ((KScreenWidth == 375.f && KScreenHeight == 812.f ? YES : NO) || (KScreenWidth == 414.f && KScreenHeight == 896.f ? YES : NO))


//iOS 11 UI布局适配宏
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

// Tabbar safe bottom margin.
#define  LL_TabbarSafeBottomMargin         (KDevice_Is_iPhoneX_Series ? 34.f : 0.f)

#define LL_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})


//获取屏幕宽高
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreen_Bounds [UIScreen mainScreen].bounds

 //以6为基准图 字体宽高等比适配 舍弃掉3.5英寸适配   4英寸<->0.85
#define KsuitParam ((KDevice_Is_iPhone6Plus || kDevice_Is_iPhoneXR || kDevice_Is_iPhoneXSMax) ? 1.12 : (KDevice_Is_iPhone6 ? 1.0 : (iPhone6PlusBigMode ? 1.01 : (kDevice_Is_iPhoneX ? 1.0 : 0.85))))


//宽度适配
#define kARWidthTranslator(padding) (padding * KScreenWidth / 375.0)

//字体适配，高度适配
#define kARHeightTranslator(padding) (kDevice_Is_iPhoneX ? padding : ((kDevice_Is_iPhoneXR || kDevice_Is_iPhoneXSMax) ? (padding * KScreenWidth / 375.0) : (padding * KScreenHeight / 667.0)))




//image尺寸适配
#define kARImageSizeTranslator(imgView) (CGSizeMake(kARWidthTranslator(imgView.image.size.width), kARHeightTranslator(imgView.image.size.height)))


//强弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//property 属性快速声明 别用宏定义了，使用代码块+快捷键实现吧

///iOS 版本判断
#define IOSAVAILABLEVERSION(version) ([[UIDevice currentDevice] availableVersion:version] < 0)
// 当前系统版本
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
//当前语言
#define CurrentLanguage [[NSLocale preferredLanguages] objectAtIndex:0]


//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define MLLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define MLLog(format, ...)
#endif


//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//颜色
#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]
#define kRandomColor    KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)        //随机色生成

#define MCColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]



//字体
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]


//定义UIImage对象
#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]
#define IMAGE_NAMED(name) [UIImage imageNamed:name]

//数据验证
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")
#define HasString(str,eky) ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)


//弧度转角度
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)


//打印当前方法名
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)



//GCD
#define kDISPATCH_ASYNC_BLOCK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define kDISPATCH_MAIN_BLOCK(block) dispatch_async(dispatch_get_main_queue(),block)
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);


//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}


//自定义error的localizedDescription信息
#define kJHErrorTranslator(message) [NSError errorWithDomain:NSCocoaErrorDomain code:-10000 userInfo:@{NSLocalizedDescriptionKey: message}]

#define KJHErrorConstruct(message,codeInt) [NSError errorWithDomain:NSCocoaErrorDomain code:codeInt userInfo:@{NSLocalizedDescriptionKey: message}]


//绘制一像素的线
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)


#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
// 最终使用下面的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))



#define NumerOfMobilePhone 11


#endif /* AppConfig_h */

