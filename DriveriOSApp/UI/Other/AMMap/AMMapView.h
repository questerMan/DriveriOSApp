//
//  AMMapView.h
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

typedef enum MapIndentState{
    MapIndentStateWait = 0,
    MapIndentStateWaitNavigation = 1,
    MapIndentStateWaitingList = 2,
    MapIndentStateHaveIndent = 3,
    MapIndentStateGetToPoint = 4,
    MapIndentStateWaitingPassengers = 5,
    MapIndentStateGoToDestination = 6,
    MapIndentStateForSettlement = 7,
    MapIndentStateForGathering = 8
}MapIndentState;


#import <UIKit/UIKit.h>

@interface AMMapView : UIView
//地图
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, assign) CLLocationCoordinate2D currentLocationCoordinate2D;

@property (nonatomic, assign) MAUserLocation *userLocation;

//** 地图订单状态 */
@property (nonatomic, assign) MapIndentState MapIndentState;
/**
 *                             绘制驾车路径
 * @param startCoordinate      起点经纬度
 * @param destinationCoordinat 终点经纬度
 * @param strategy             行驶道路规划
 */
//-(void)showRouteWithStartCoordinate:(CLLocationCoordinate2D)startCoordinate
//           andDestinationCoordinate:(CLLocationCoordinate2D)destinationCoordinat
//                        andStrategy:(NSInteger)strategy;
/**
 *     移除地图上的行驶绘制路线
 */

//-(void)clearRoute;


@end
