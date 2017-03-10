//
//  LXQMyMessageGroupItem.h
//  DriveriOSApp
//
//  Created by mac on 17/3/10.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LXQMyMessageItem;

@interface LXQMyMessageGroupItem : NSObject

@property(nonatomic, strong)NSArray<LXQMyMessageItem*>* groupItemArr;

@property(nonatomic, assign)NSInteger cellHeight;



@end
