
//
//  LXQRefuseIndentItem.m
//  DriveriOSApp
//
//  Created by mac on 17/1/13.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQRefuseIndentItem.h"

@implementation LXQRefuseIndentItem

+ (instancetype)LXQRefuseIndentItemWithTitle: (NSString *)title
{
    LXQRefuseIndentItem* item = [[LXQRefuseIndentItem alloc] init];
    item.title = title;
    return item;
}

@end
