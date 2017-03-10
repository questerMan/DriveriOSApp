//
//  LXQMyMessageItem.m
//  DriveriOSApp
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQMyMessageItem.h"

@implementation LXQMyMessageItem

+ (instancetype)myMessageItemWithtitleLabel:(NSString*)titleLabel contentLabel :(NSString*)contentLabel : (void(^)(void))arrowBtnClick{
    LXQMyMessageItem* item = [[LXQMyMessageItem alloc] init];
    item.titleLabel = titleLabel;
    item.contentLabel = contentLabel;
    item.arrowBtnClick = arrowBtnClick;
    return item;
}

@end
