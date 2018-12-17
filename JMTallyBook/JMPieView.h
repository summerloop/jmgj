//
//  JMPieView.h
//  JMTallyBook
//
//  Created by JM on 16/3/12.
//  Copyright © 2016年 JM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JMPieView;

@protocol JMPieViewDataSource <NSObject>

@required

- (NSArray *)percentsForPieView:(JMPieView *)pieView;
- (NSArray *)typesForPieView:(JMPieView *)pieView;
- (NSArray *)colorsForPieView:(JMPieView *)pieView;

@end

@interface JMPieView : UIView

@property (weak, nonatomic) id<JMPieViewDataSource> dataSource;

- (void)reloadData;

- (void)removeAllLabel;

@end
