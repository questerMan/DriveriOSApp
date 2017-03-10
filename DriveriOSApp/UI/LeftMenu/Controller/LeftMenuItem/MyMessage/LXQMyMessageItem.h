//
//  LXQMyMessageItem.h
//  DriveriOSApp
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXQMyMessageItem : NSObject

@property(nonatomic, copy)NSString* titleLabel;

@property(nonatomic, copy)NSString* contentLabel;

@property(nonatomic, copy)void(^arrowBtnClick)(void);

+ (instancetype)myMessageItemWithtitleLabel:(NSString*)titleLabel contentLabel :(NSString*)contentLabel : (void(^)(void))arrowBtnClick;

@end
