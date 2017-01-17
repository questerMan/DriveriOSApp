//
//  AMPublicTools.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "AMPublicTools.h"


@interface AMPublicTools()<AMapLocationManagerDelegate,AMapSearchDelegate>

//定位
@property (nonatomic, strong) AMapLocationManager *locationManager;
//搜索
@property (nonatomic, strong) AMapSearchAPI *search;
//热力图
@property (nonatomic, strong) MAHeatMapTileOverlay *heatMapTileOverlay;
//大头针
@property (retain, nonatomic) MAPointAnnotation *pointAnnotation;

@property (nonatomic, strong) LXObjManage *objManage;

//地图
@property (nonatomic, strong) MAMapView *mapView;

/** 起点大头针 */
@property (retain, nonatomic) RoutPointAnnotation *startAnnotation;

/** 终点大头针 */
@property (retain, nonatomic) RoutPointAnnotation *endAnnotation;

@property (nonatomic,retain) NSArray *pathPolylines;


@end

@implementation AMPublicTools

-(AMapLocationManager *)locationManager{//定位
    
    if (!_locationManager) {
        
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
        
    }
    
    return _locationManager;
}

-(MAPointAnnotation *)pointAnnotation{
    if (!_pointAnnotation) {
        _pointAnnotation = [[MAPointAnnotation alloc] init];
    }
    return _pointAnnotation;
}

-(MAPointAnnotation *)startAnnotation{
    if (!_startAnnotation) {
        _startAnnotation = [[RoutPointAnnotation alloc] init];
    }
    return _startAnnotation;
}

-(MAPointAnnotation *)endAnnotation{
    if (!_endAnnotation) {
        _endAnnotation = [[RoutPointAnnotation alloc] init];
    }
    return _endAnnotation;
}

/** 单例 */
+ (AMPublicTools *)shareInstance{
    
    static dispatch_once_t onceToken;
    static AMPublicTools * shareTools = nil;
    dispatch_once(&onceToken, ^{
        shareTools = [[AMPublicTools alloc]init];
        
    });
    return shareTools;
}

-(instancetype)init{
    if (self = [super init]) {
        _search  = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return self;
}

/**========================定   位==============================*/
#pragma mark － 定位
-(void)locationWithLocationBlock:(LocationBlock)locationBlock{
    
    if (![CLLocationManager locationServicesEnabled]) {
        DLog(@"---> 定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    //开始连续定位
    [self.locationManager startUpdatingLocation];
    
    _locationBlock = locationBlock;
}
#pragma mark － AMapLocationManagerDelegate

//连续定位回调函数
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    if (_locationBlock != nil) {
        _locationBlock(manager,location,reGeocode);
    }
    
    //停止定位
    [self.locationManager stopUpdatingLocation];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    DLog(@"---> 错误(code ＝ 0 ,没有打开定位功能) %@",error);
    //停止定位
    [self.locationManager stopUpdatingLocation];
}
/**========================搜  索==============================*/
#pragma mark - 搜索
-(void)onReGeocodeSearchDoneWithRequest:(id)request
                               andBlock:(OnReGeocodeSearchBlock)onReGeocodeSearchBlock{
    
    //发起逆地理编码
    if ([request isKindOfClass:[AMapPOIKeywordsSearchRequest class]])
    {
        [self.search AMapPOIKeywordsSearch:request];
    }
    else if ([request isKindOfClass:[AMapDrivingRouteSearchRequest class]])
    {
        [self.search AMapDrivingRouteSearch:request];
    }
    else if ([request isKindOfClass:[AMapInputTipsSearchRequest class]])
    {
        [self.search AMapInputTipsSearch:request];
    }
    else if ([request isKindOfClass:[AMapGeocodeSearchRequest class]])
    {
        [self.search AMapGeocodeSearch:request];
    }
    else if ([request isKindOfClass:[AMapReGeocodeSearchRequest class]])
    {
        [self.search AMapReGoecodeSearch:request];
    }
    else
    {
        DLog(@"unsupported request");
        return;
    }
    
    _onReGeocodeSearchBlock = onReGeocodeSearchBlock;
}

#pragma mark - 搜索Helpers

- (void)performBlockWithRequest:(id)request withResponse:(id)response
{
    if (_onReGeocodeSearchBlock != nil) {
        _onReGeocodeSearchBlock(request,response,nil);
    }
}

#pragma mark - AMapSearchDelegate
- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    if (_onReGeocodeSearchBlock != nil) {
        _onReGeocodeSearchBlock(request,nil,error);
    }
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    [self performBlockWithRequest:request withResponse:response];
}

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    [self performBlockWithRequest:request withResponse:response];
}

- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [self performBlockWithRequest:request withResponse:response];
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    [self performBlockWithRequest:request withResponse:response];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    [self performBlockWithRequest:request withResponse:response];
}


//***************************创 建 热 力 图******************************//

#pragma mark - 创建热力图
-(void)creatHotMapWittMapView:(MAMapView *)mapView{
    
    self.heatMapTileOverlay = [[MAHeatMapTileOverlay alloc] init];
    
    //构造热力图数据，从locations.json中读取经纬度
    NSMutableArray* dataArray = [NSMutableArray array];
    
    
#define latitudinalRangeMeter 1000.0
#define longitudinalRangeMeter 1000.0
    
    MAMapRect rect = MAMapRectForCoordinateRegion(MACoordinateRegionMakeWithDistance(mapView.centerCoordinate, latitudinalRangeMeter, longitudinalRangeMeter));
    
    //在mapRect区域里随机生成coordinate
#define MAX_COUNT 120   //车辆
#define MIN_COUNT 5
    NSUInteger randCount = arc4random() % MAX_COUNT + MIN_COUNT;
    
    
    for (int i = 0; i < randCount; i++)
    {
        LXObj * obj = [LXObj driverWithID:@"粤 A168" coordinate:[self randomPointInMapRect:rect]];
        
        MAHeatMapNode *node = [[MAHeatMapNode alloc] init];
        
        node.coordinate = obj.coordinate;
        
        node.intensity = 1;//设置权重
        [dataArray addObject:node];
    }
    
    
    //构造渐变色对象
    MAHeatMapGradient *gradient = [[MAHeatMapGradient alloc] initWithColor:@[[UIColor blueColor],[UIColor greenColor], [UIColor redColor]] andWithStartPoints:@[@(0.2),@(0.5),@(0.9)]];
    self.heatMapTileOverlay.gradient = gradient;
    
    self.heatMapTileOverlay.data = dataArray;
    self.heatMapTileOverlay.radius = 20.0;
    //将热力图添加到地图上
    [mapView addOverlay: self.heatMapTileOverlay];
    
}
#pragma mark - Utility
- (CLLocationCoordinate2D)randomPointInMapRect:(MAMapRect)mapRect
{
    MAMapPoint result;
    result.x = mapRect.origin.x + arc4random() % (int)(mapRect.size.width);
    result.y = mapRect.origin.y + arc4random() % (int)(mapRect.size.height);
    
    return MACoordinateForMapPoint(result);

}

/**==========================添 加 大 头 针================================*/

#pragma mark - 添加大头针
+(void)addPointAnnocationWithMap:(MAMapView *)mapView
                      Coordinate:(CLLocationCoordinate2D)coordinate{
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    
    pointAnnotation.coordinate = coordinate;
    
    pointAnnotation.title = @"pointAnnotation";
    
    [mapView addAnnotation:pointAnnotation];
    //自动显示气泡信息
    [mapView selectAnnotation:pointAnnotation animated:YES];
    
}

/**==========================绘 制 路 径=====================================*/
#define RoutePlanningPaddingEdge MATCHSIZE(80)
#pragma mark - 绘制驾车路径
-(void)showRouteWithMap:(MAMapView *)mapView
        StartCoordinate:(CLLocationCoordinate2D)startCoordinate
andDestinationCoordinate:(CLLocationCoordinate2D)destinationCoordinat
            andStrategy:(NSInteger)strategy
                  block:(void(^)())block{
    
    self.mapView = mapView;
    
    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
    
    navi.requireExtension = YES;
    navi.strategy = strategy;//!< 驾车导航策略([default = 0]) 0-速度优先（时间）；1-费用优先（不走收费路段的最快道路）；2-距离优先；3-不走快速路；4-结合实时交通（躲避拥堵）；5-多策略（同时使用速度优先、费用优先、距离优先三个策略）；6-不走高速；7-不走高速且避免收费；8-躲避收费和拥堵；9-不走高速且躲避收费和拥堵
    
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:startCoordinate.latitude longitude:startCoordinate.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:destinationCoordinat.latitude longitude:destinationCoordinat.longitude];
    
    [self onReGeocodeSearchDoneWithRequest:navi andBlock:^(id request, id response, NSError *error) {
        AMapRouteSearchResponse *newRespone = (AMapRouteSearchResponse *)response;
        
        AMapPath *path = newRespone.route.paths[0]; //选择一条路径
        AMapStep *step = path.steps[0]; //这个路径上的导航路段数组
        NSLog(@"step.polyline %@",step.polyline);   //此路段坐标点字符串
        
        if (newRespone.count > 0)
        {
            //移除地图原本的遮盖
            [mapView removeOverlays:_pathPolylines];
            _pathPolylines = nil;
            // 只显⽰示第⼀条 规划的路径
            _pathPolylines = [self polylinesForPath:newRespone.route.paths[0]];
            NSLog(@"%@",newRespone.route.paths[0]);
            //添加新的遮盖，然后会触发代理方法进行绘制
            [mapView addOverlays:_pathPolylines];
            

            //展示路径
            [mapView setVisibleMapRect:[self mapRectForOverlays:self.pathPolylines] edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge) animated:YES];

        }
    }];
    
    //显示终点和起点大头针
    [self addAnnotationWithMap:mapView StartCoordinate:startCoordinate andEndCoordinate:destinationCoordinat];
}

#pragma mark - 添加终点和起点大头针
-(void)addAnnotationWithMap:(MAMapView *)mapView
            StartCoordinate:(CLLocationCoordinate2D)startCoordinate
           andEndCoordinate:(CLLocationCoordinate2D)endCoordinat{
    self.startAnnotation.coordinate = startCoordinate;
    self.startAnnotation.title = @"star";
    [mapView addAnnotation:self.startAnnotation];
    //自动显示气泡信息
    [mapView selectAnnotation:self.startAnnotation animated:YES];
    
    self.endAnnotation.coordinate = endCoordinat;
    self.endAnnotation.title = @"end";
    [mapView addAnnotation:self.endAnnotation];
    //自动显示气泡信息
    [mapView selectAnnotation:self.endAnnotation animated:YES];
}
#pragma mark - 移除地图上的行驶绘制路线
-(void)clearRouteWithBlock:(void(^)())block{

    [self.mapView removeOverlays:_pathPolylines];
    //移除终点和起点大头针
    [self.mapView removeAnnotation:self.startAnnotation];
    [self.mapView removeAnnotation:self.endAnnotation];
    
}

//路线解析
- (NSArray *)polylinesForPath:(AMapPath *)path
{
    if (path == nil || path.steps.count == 0)
    {
        return nil;
    }
    NSMutableArray *polylines = [NSMutableArray array];
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        NSUInteger count = 0;
        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
                                                         coordinateCount:&count
                                                              parseToken:@";"];
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
        
        [polylines addObject:polyline];
        free(coordinates), coordinates = NULL;
    }];
    return polylines;
}

- (MAMapRect)mapRectForOverlays:(NSArray *)overlays
{
    if (overlays.count == 0)
    {
        DLog(@"%s: 无效的参数.", __func__);
        return MAMapRectZero;
    }
    
    MAMapRect mapRect;
    
    MAMapRect *buffer = (MAMapRect*)malloc(overlays.count * sizeof(MAMapRect));
    
    [overlays enumerateObjectsUsingBlock:^(id<MAOverlay> obj, NSUInteger idx, BOOL *stop) {
        buffer[idx] = [obj boundingMapRect];
    }];
    
    mapRect = [self mapRectUnion:buffer count:overlays.count];
    
    free(buffer), buffer = NULL;
    
    return mapRect;
}
-(MAMapRect)mapRectUnion:(MAMapRect *)mapRects count:(NSUInteger)count
{
    if (mapRects == NULL || count == 0)
    {
        DLog(@"%s: 无效的参数.", __func__);
        return MAMapRectZero;
    }
    
    MAMapRect unionMapRect = mapRects[0];
    
    for (int i = 1; i < count; i++)
    {
        unionMapRect = [self unionMapRect1:unionMapRect mapRect2:mapRects[i]];
    }
    
    return unionMapRect;
}
-(MAMapRect)unionMapRect1:(MAMapRect)mapRect1 mapRect2:(MAMapRect)mapRect2
{
    CGRect rect1 = CGRectMake(mapRect1.origin.x, mapRect1.origin.y, mapRect1.size.width, mapRect1.size.height);
    CGRect rect2 = CGRectMake(mapRect2.origin.x, mapRect2.origin.y, mapRect2.size.width, mapRect2.size.height);
    
    CGRect unionRect = CGRectUnion(rect1, rect2);
    
    return MAMapRectMake(unionRect.origin.x, unionRect.origin.y, unionRect.size.width, unionRect.size.height);
}


//解析经纬度
- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    return coordinates;
}


@end
