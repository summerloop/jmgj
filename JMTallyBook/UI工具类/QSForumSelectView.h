//
//  QSSelectView.h
//  MyCommunity
//
//  Created by JosQiao on 16/8/12.
//  Copyright © 2016年 WenJim. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol QSForumSelectViewDelegate <NSObject>

@optional
// 选择那个控件
- (void)seletedItemAtIndex:(NSInteger)index;

@end

@interface QSForumSelectView : UIView

/** 代理 */
@property (nonatomic ,weak)id <QSForumSelectViewDelegate> delegate ;


/** 滑块 */
@property(nonatomic,strong)UIView *sliderView;

/**
 *  初始化
 *
 *  @param titles 标题数组
 *
 *  @return 返回本身
 */
- (instancetype)initWithItemTitles:(NSArray<NSString *>*)titles;

/**
 *  添加选择Item
 *
 *  @param title 标题
 */
- (void)addSelectedItemWithTitle:(NSString *)title;


// 选择哪个控件
- (void)selectToItemAtIndex:(NSInteger)index;



- (void)slideViewAnimationWithContentOffset:(CGPoint)contentOffSet;



@end
