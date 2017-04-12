//
//  LXQMyMessageTableViewCell.h
//  DriveriOSApp
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXQMyMessageItem.h"
@interface LXQMyMessageTableViewCell : UITableViewCell

@property(nonatomic, copy)void(^arrowBtnClick)(void);

@property(nonatomic, strong)LXQMyMessageItem* item;

@end