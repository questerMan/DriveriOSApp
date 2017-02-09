//
//  AMMapView.h
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

typedef enum MapIndentState{
    MapIndentStateWait = 0,             //等单
    MapIndentStateWaitNavigation = 1,   //等单导航
    MapIndentStateWaitingList = 2,      //待接单
    MapIndentStateHaveIndent = 3,       //已接单
    MapIndentStateGoToPoint = 4,        //去上车点
    MapIndentStateWaitingPassengers = 5,//免费or收费等候乘客上车
    MapIndentStateGoToDestination = 6,  //去目的地
    MapIndentStateForSettlement = 7,    //待结算
    MapIndentStateForGathering = 8      //待收款
}MapIndentState;


#import <UIKit/UIKit.h>

@interface AMMapView : UIView
//地图
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, assign) CLLocationCoordinate2D currentLocationCoordinate2D;

@property (nonatomic, assign) MAUserLocation *userLocation;

//** 地图订单状态 */
@property (nonatomic, assign) MapIndentState MapIndentState;


@end
