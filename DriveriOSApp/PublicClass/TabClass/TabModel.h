//
//  TabModel.h
//  DriveriOSApp
//
//  Created by lixin on 16/12/5.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabModel : NSObject
//订单名称
@property (nonatomic, copy) NSString *title;
//订单类型（即使单／预约单...）
@property (nonatomic, copy) NSString *type;
//订单数量
@property (nonatomic, copy) NSString *indentCount;
//上下拉状态（0：向上（上拉）； 1:向下（下拉））
@property (nonatomic, copy) NSString *indentState;


@end
