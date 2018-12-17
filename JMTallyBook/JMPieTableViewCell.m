//
//  JMPieTableViewCell.m
//  JMTallyBook
//
//  Created by JM on 16/3/13.
//  Copyright © 2016年 JM. All rights reserved.
//

#import "JMPieTableViewCell.h"

@implementation JMPieTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.colorView.layer.cornerRadius = 12.5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
