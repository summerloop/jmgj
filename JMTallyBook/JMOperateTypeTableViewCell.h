//
//  JMOperateTypeTableViewCell.h
//  JMTallyBook
//
//  Created by JM on 16/3/14.
//  Copyright © 2016年 JM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMOperateTypeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *type;

@property (weak, nonatomic) IBOutlet UILabel *operation;

@end
