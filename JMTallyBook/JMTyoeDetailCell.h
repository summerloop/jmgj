//
//  JMTyoeDetailCell.h
//  JMTallyBook
//
//  Created by Junheng on 2018/12/12.
//  Copyright © 2018 azx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMTyoeDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UILabel *money;
@end

NS_ASSUME_NONNULL_END
