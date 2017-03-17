//
//  AMPublicTools.h
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

//定位
typedef void (^LocationBlock) (AMapLocationManager *manager ,CLLocation *location ,AMapLocationReGeocode *reGeocode);
//地理搜索
typedef void (^OnReGeocodeSearchBlock) (id request, id response, NSError *error);

@interface AMPublicTools : NSObject

/**
 *  工具单例类
 *
 *  @return 返回一个工具对象🔧
 */
+ (AMPublicTools *)shareInstance;
//地图


//定位
@property (nonatomic, copy) LocationBlock locationBlock;
/**
 *   定位
 * @param locationBlock  代码块回调
 *
 */
-(void)locationWithLocationBlock:(LocationBlock)locationBlock;

//搜索
@property (nonatomic, strong) OnReGeocodeSearchBlock onReGeocodeSearchBlock;
/**
 *   搜索
 * @param request  请求条件
 * @param onReGeocodeSearchBlock  代码块回调
 *
 */
-(void)onReGeocodeSearchDoneWithRequest:(id)request
                               andBlock:(OnReGeocodeSearchBlock)onReGeocodeSearchBlock;


/**
 *   创建热力图
 * @param mapView  当前地图
 *
 */
-(void)creatHotMapWittMapView:(MAMapView *)mapView;
/**
 *   添加大头针
 * @param mapView  当前地图
 * @param coordinate  经纬度
 *
 */
+ (void)addPointAnnocationWithMap:(MAMapView *)mapView
                      Coordinate:(CLLocationCoordinate2D)coordinate;
/**
 *   绘制路径
 * @param mapView  当前地图
 * @param startCoordinate  起点经纬度
 * @param destinationCoordinat  终点经纬度
 * @param strategy  驾车导航策略
 * @param block  想要处理的事务代码快
 *
 */
-(void)showRouteWithMap:(MAMapView *)mapView
        StartCoordinate:(CLLocationCoordinate2D)startCoordinate
andDestinationCoordinate:(CLLocationCoordinate2D)destinationCoordinat
            andStrategy:(NSInteger)strategy
                  block:(void(^)())block;
/**
 *   清除路径
 * @param block  想要处理的事务代码快
 *
 */
-(void)clearRouteWithBlock:(void(^)())block;

@end
