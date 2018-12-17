//
//  JMPieTableViewCell.h
//  JMTallyBook
//
//  Created by JM on 16/3/13.
//  Copyright © 2016年 JM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMPieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@end
