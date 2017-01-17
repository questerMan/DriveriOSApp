//
//  NetWorkingManage.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/17.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "NetWorkingManage.h"
#import "IndentData.h"
@implementation NetWorkingManage

/** 单例 */
+ (NetWorkingManage *)shareInstance{
    
    static dispatch_once_t onceToken;
    static NetWorkingManage * netWorkingManager = nil;
    dispatch_once(&onceToken, ^{
        netWorkingManager = [[NetWorkingManage alloc]init];
        netWorkingManager.manager = [AFHTTPSessionManager manager];
        netWorkingManager.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return netWorkingManager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
//========================  全局网络监测  ===================

#pragma mark  - - 全局网络状态监测
+ (AFNetworkReachabilityStatus)ln_networkShareInstance
{
    AFNetworkReachabilityManager *networkManager = [AFNetworkReachabilityManager managerForDomain:@"http://www.baidu.com"];
    [networkManager startMonitoring];
    
    __block AFNetworkReachabilityStatus networkStatus;
    [networkManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        networkStatus = status;
        NSLog(@"当前网络状态 = %ld",(long)status);
    }];
    return networkStatus;
}
/** 获取本地模型数据 */
-(NSArray *)getShareData{
    NSError*error;
    //获取文件路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"IndentData"ofType:@"geojson"];
    
    //根据文件路径读取数据
    NSData *datas = [[NSData alloc]initWithContentsOfFile:filePath];
    
    //解读json数据
    NSArray *arrData = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableContainers error:&error];
    return arrData;
}
/** 获取tab数据 */
-(void)getTabDataWithBlock:(void(^)(NSArray *array))block{
    
  
    NSArray *arrData = [self getShareData];
    
    NSMutableArray *arrDatas = [NSMutableArray array];
    
    for (NSDictionary *dict in arrData) {
        TabModel *modelTab = [TabModel new];
        modelTab.title = dict[@"name"];
        modelTab.type = dict[@"type"];
        NSArray *arr = [dict objectForKey:@"indentArr"];
        if(arr.count > 0){
            modelTab.indentCount = [NSString stringWithFormat:@"%ld",arr.count];
        }
        
        [arrDatas addObject:modelTab];
    }
    
    block(arrDatas);

}
/** 获取即时单数据 */
-(void)getInstantIndentWithBlock:(void(^)(NSArray *array))block{

    NSArray *arrData = [self getShareData];
    
    NSMutableArray *arrDatas = [NSMutableArray array];
    
    for (NSDictionary *dict in arrData) {
        NSArray *arr = dict[@"indentArr"];
        if ([dict[@"name"] isEqualToString:@"即时单"] && arr.count > 0) {
            for (NSDictionary *dict in arr) {
                IndentData *model = [IndentData new];
                [model setValuesForKeysWithDictionary:dict];
                [arrDatas addObject:model];
            }
            break;
        }
    }

    block(arrDatas);
}


/** 获取预约单数据 */
-(void)getReservationIndentWithBlock:(void(^)(NSArray *array))block{
    NSArray *arrData = [self getShareData];
    
    NSMutableArray *arrDatas = [NSMutableArray array];
    
    for (NSDictionary *dict in arrData) {
        NSArray *arr = dict[@"indentArr"];
        if ([dict[@"name"] isEqualToString:@"预约单"] && arr.count > 0) {
            for (NSDictionary *dict in arr) {
                IndentData *model = [IndentData new];
                [model setValuesForKeysWithDictionary:dict];
                [arrDatas addObject:model];
            }
            break;
        }
    }
    block(arrDatas);
}

/** 获取送机数据 */
-(void)getSendIndentWithBlock:(void(^)(NSArray *array))block{
    NSArray *arrData = [self getShareData];
    
    NSMutableArray *arrDatas = [NSMutableArray array];
    
    for (NSDictionary *dict in arrData) {
        NSArray *arr = dict[@"indentArr"];
        if ([dict[@"name"] isEqualToString:@"送机"] && arr.count > 0) {
            for (NSDictionary *dict in dict[@"indentArr"]) {
                IndentData *model = [IndentData new];
                [model setValuesForKeysWithDictionary:dict];
                [arrDatas addObject:model];
            }
            break;
        }
    }
    
    block(arrDatas);
}

/** 获取接机数据 */
-(void)getMeetIndentWithBlock:(void(^)(NSArray *array))block{
    NSArray *arrData = [self getShareData];
    
    NSMutableArray *arrDatas = [NSMutableArray array];
    
    for (NSDictionary *dict in arrData) {
        NSArray *arr = dict[@"indentArr"];
        if ([dict[@"name"] isEqualToString:@"接机"] && arr.count > 0) {
            for (NSDictionary *dict in dict[@"indentArr"]) {
                IndentData *model = [IndentData new];
                [model setValuesForKeysWithDictionary:dict];
                [arrDatas addObject:model];
            }
            break;
        }
    }
    
    block(arrDatas);
}
@end
