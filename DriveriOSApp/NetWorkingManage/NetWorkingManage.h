//
//  NetWorkingManage.h
//  DriveriOSApp
//
//  Created by lixin on 17/1/17.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkingManage : NSObject

@property (retain,nonatomic) AFHTTPSessionManager *manager;

/**类方法，单例*/
+(NetWorkingManage *)shareInstance;

/** 获取tab数据 */
-(void)getTabDataWithBlock:(void(^)(NSArray *array))block;

/** 获取即时单数据 */
-(void)getInstantIndentWithBlock:(void(^)(NSArray *array))block;

/** 获取预约单数据 */
-(void)getReservationIndentWithBlock:(void(^)(NSArray *array))block;

/** 获取送机数据 */
-(void)getSendIndentWithBlock:(void(^)(NSArray *array))block;

/** 获取接机数据 */
-(void)getMeetIndentWithBlock:(void(^)(NSArray *array))block;

/** 获取抢单数据 */
-(void)getRobIndentWithBlock:(void(^)(NSArray *array))block;

@end
