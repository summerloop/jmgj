//
//  RootNavigationController.h
//  Loanmarket
//
//  Created by Junheng on 2017/9/27.
//  Copyright © 2017年 jinqianbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootNavigationController : UINavigationController



/*!
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;
@end
