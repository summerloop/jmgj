//
//  JMAccountTableViewCell.h
//  JMTallyBook
//
//  Created by JM on 16/3/7.
//  Copyright © 2016年 JM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMAccountTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *typeImage; // 图像显示名称为typeName的图片
@property (weak, nonatomic) IBOutlet UILabel *typeName;
@property (weak, nonatomic) IBOutlet UILabel *money;

@end
