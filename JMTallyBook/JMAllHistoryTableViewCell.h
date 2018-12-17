//
//  JMAllHistoryTableViewCell.h
//  JMTallyBook
//
//  Created by JM on 16/3/11.
//  Copyright © 2016年 JM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMAllHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;


@property (weak, nonatomic) IBOutlet UILabel *inComeMoney;


@property (weak, nonatomic) IBOutlet UILabel *costMoney;
@end
