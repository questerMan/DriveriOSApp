//
//  AMMapView.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

static const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
static const NSString *RoutePlanningViewControllerEndTitle         = @"终点";

#define RoutePlanningPaddingEdge MATCHSIZE(80)

#import "AMMapView.h"
#import "DriverAnnotationView.h"//测试自定义
#import "DriverPointAnnotation.h"
#import "LXObj.h"
#import "LXRequest.h"
#import "LXLocatiion.h"

#import "UserPointAnnotation.h"
#import "UserAnnotationView.h"

@interface AMMapView()<MAMapViewDelegate,AMapSearchDelegate,LXObjManagerDelegate>

@property (nonatomic, strong) AMPublicTools *tool;
//大头针
@property (retain, nonatomic) MAPointAnnotation *pointAnnotation;
@property (nonatomic, strong) UserPointAnnotation *userPointAnnotation;

@property (nonatomic, strong) UIImageView *centerLocationIMG;

//搜索
@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic,retain) NSArray *pathPolylines;

/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;

@property (nonatomic, strong) LXObjManage *objManage;
//汽车
@property (nonatomic, copy) NSArray *carAnnoArray;
@property (retain, nonatomic) DriverPointAnnotation *carAnnotation;

@end

@implementation AMMapView



- (MAMapView *)mapView{
    
    if (!_mapView) {
        
        _mapView = [[MAMapView alloc] initWithFrame:self.bounds];
        _mapView.delegate = self;
       
        //是否显示用户的位置
        _mapView.showsUserLocation = YES;
        
        //设置指南针compass，默认是开启状态，大小是定值，显示在地图的右上角
        _mapView.showsCompass = NO;
        
        //设置比例尺scale，默认显示在地图的左上角
        _mapView.showsScale = NO;
        
        //地图的缩放
        [_mapView setZoomLevel:16.2 animated:YES];
        
        //设置地图logo，默认字样是“高德地图”，用logoCenter来设置logo的位置
        _mapView.logoCenter = CGPointMake(0, 0);
        
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        
        // 去除精度圈。
        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        
        //不支持旋转
        _mapView.rotateEnabled = NO;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
            _mapView.allowsBackgroundLocationUpdates = YES;//iOS9以上系统必须配置
        }
        
        //获取实时路况（根据用户的设置）
        NSObject *objValue = [CacheClass getAllDataFromYYCacheWithKey:Traffic_KEY];
        if (objValue != nil) {
            NSInteger flag = [(NSString *)objValue integerValue];
            if(flag == 1){
                _mapView.showTraffic = YES;
            }else{
                _mapView.showTraffic = NO;
            }
        }
    }
    return _mapView;
}

-(UIImageView *)centerLocationIMG{
    if (!_centerLocationIMG) {
        UIImage *image = [UIImage imageNamed:@"map60"];
        _centerLocationIMG = [[UIImageView alloc] initWithImage:image];
    }
    return _centerLocationIMG;
}

- (MAPointAnnotation *)pointAnnotation {
    if (!_pointAnnotation) {
        _pointAnnotation = [[MAPointAnnotation alloc] init];
    }
    return _pointAnnotation;
}

- (UserPointAnnotation *)userPointAnnotation{
    if (!_userPointAnnotation) {
        _userPointAnnotation = [[UserPointAnnotation alloc] init];
    }
    return _userPointAnnotation;
}

- (void)setMapIndentState:(MapIndentState)MapIndentState
{
    _MapIndentState = MapIndentState;
}

-(LXObjManage *)objManage{
    if (!_objManage) {
        _objManage = [[LXObjManage alloc] init];
        _objManage.delegate = self;
    }
    return _objManage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatMap];
        
        [self creatLocationBtn];
        
        [self creatCenterLocationIMG];
       
        [self location];
    }
    return self;
}

#pragma mark - drivers
- (void)updatingDrivers{
    
#define latitudinalRangeMeters 500.0
#define longitudinalRangeMeters 500.0

    MAMapRect rect = MAMapRectForCoordinateRegion(MACoordinateRegionMakeWithDistance(self.mapView.centerCoordinate, latitudinalRangeMeters, longitudinalRangeMeters));
    [self.objManage searchDriversWithinMapRect:rect];
}


#pragma mark - LXObjManagerDelegate
- (void)searchDoneInMapRect:(MAMapRect)mapRect withDriversResult:(NSArray *)drivers timestamp:(NSTimeInterval)timestamp
{

    [self.mapView removeAnnotations:_carAnnoArray];
    NSMutableArray * currDrivers = [NSMutableArray arrayWithCapacity:[drivers count]];
    [drivers enumerateObjectsUsingBlock:^(LXObj * obj, NSUInteger idx, BOOL *stop) {
        _carAnnotation = [[DriverPointAnnotation alloc] init];

        _carAnnotation.coordinate = obj.coordinate;
        self.carAnnotation.title = obj.idInfo;
        [currDrivers addObject:_carAnnotation];
        
    }];

    [_mapView addAnnotations:currDrivers];
    
    _carAnnoArray = currDrivers;
    
}

//创建地图
-(void)creatMap{
    
    //显示地图
    [self addSubview:self.mapView];
    //接收通知
    PublicTool *tool = [PublicTool shareInstance];
    [tool getNotificationWithName:Traffic_KEY object:^(NSNotification *notify) {
        int flag = [(NSString *)notify.userInfo intValue];
        if(flag == 1){
            _mapView.showTraffic = YES;
        }else{
            _mapView.showTraffic = NO;
        }
    }];
    
}

-(void)creatCenterLocationIMG{
    [self.mapView addSubview:self.centerLocationIMG];
    
    [self.centerLocationIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(MATCHSIZE(-50));

    }];
}

-(void)creatLocationBtn{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    [self.mapView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mapView).offset(MATCHSIZE(-260));
        make.right.equalTo(self.mapView).offset(MATCHSIZE(-30));
        make.height.offset(MATCHSIZE(80));
        make.width.offset(MATCHSIZE(80));
    }];
    
    @weakify(self);
    
    self.tool = [AMPublicTools shareInstance];
    
    //点击事件
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        //开始连续定位
        [self location];
        
    }];
}

#pragma mark - 定位
- (void)location{
    __weak typeof(self) weakSelf = self;
    
    [self.tool locationWithLocationBlock:^(AMapLocationManager *manager, CLLocation *location, AMapLocationReGeocode *reGeocode) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        //定位获取到的数据
        DLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
        
        CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        
        strongSelf.mapView.centerCoordinate = coordinate2D;

        //地图的缩放
        [strongSelf.mapView setZoomLevel:16.2 animated:YES];
        
    }];
}

/** -------------------------------------------------------- */
/** -------------------MAMapViewDelegate-------------------- */
/** -------------------------------------------------------- */

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColorFromRGB(@"#ff6d00") colorWithAlphaComponent:0.9];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    
    //热力图
    if ([overlay isKindOfClass:[MATileOverlay class]])
    {
        MATileOverlayRenderer *render = [[MATileOverlayRenderer alloc] initWithTileOverlay:overlay];
        
        return render;
    }

    return nil;
}


/**
 * @brief 地图区域即将改变时会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    
}

/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    //逆地理编码
    [self searchReGeocodeWithCoordinate:CLLocationCoordinate2DMake(mapView.centerCoordinate.latitude, mapView.centerCoordinate.longitude)];
}

/**
 *  地图将要发生移动时调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
    
    if (mapView.annotations.count > 0) {
        [mapView removeAnnotation:self.userPointAnnotation];
    }
}


/**
 *  地图移动结束后调用此接口
 *
 *  @param mapView       地图view
 *  @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{
    
//    //测试显示附近司机
//    [self updatingDrivers];
    
//    //热力图
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self.tool creatHotMapWittMapView:mapView];
//    });
}

/**
 * @brief 地图开始加载
 * @param mapView 地图View
 */
- (void)mapViewWillStartLoadingMap:(MAMapView *)mapView{
    
}

/**
 * @brief 地图加载成功
 * @param mapView 地图View
 */
- (void)mapViewDidFinishLoadingMap:(MAMapView *)mapView{

   
}

/**
 * @brief 地图加载失败
 * @param mapView 地图View
 * @param error 错误信息
 */
- (void)mapViewDidFailLoadingMap:(MAMapView *)mapView withError:(NSError *)error{
}

/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
#pragma -mark添加大头针（自定义标注）
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{

    //司机（附近车辆）
    if ([annotation isKindOfClass:[DriverPointAnnotation class]]) {
        
        static NSString *reuseIndetifier = @"DriverAnnotationReuseIndetifier";
        DriverAnnotationView *annotationView = (DriverAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[DriverAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];

        }
        
        [annotationView getDataWithBlock:^(UILabel *label) {
            label.text = [annotation title];
        }];
        
        annotationView.image = [UIImage imageNamed:@"driver_car"];

        return annotationView;
        
    }
    
    //当前用户位置
    if ([annotation isKindOfClass:[UserPointAnnotation class]]) {
        
        static NSString *reuseIndetifier = @"UserAnnotationReuseIndetifier";
        UserAnnotationView *annotationView = (UserAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[UserAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];
            
        }
        
        [annotationView getDataWithBlock:^(UILabel *label) {
            label.text = [annotation title];
        }];
        
        annotationView.image = [UIImage imageNamed:@"map60"];
        
        [UIView animateWithDuration:0.3 animations:^{
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -MATCHSIZE(50));
        } completion:^(BOOL finished) {
            self.centerLocationIMG.y -= MATCHSIZE(50);
            annotationView.y -= MATCHSIZE(50);
            [UIView animateWithDuration:0.3 animations:^{
                //设置中心点偏移，使得标注底部中间点成为经纬度对应点
                annotationView.centerOffset = CGPointMake(0, -MATCHSIZE(50));
                self.centerLocationIMG.y += MATCHSIZE(50);
            }];
        }];

        return annotationView;
        
    }
    
    if ([annotation isKindOfClass:[RoutPointAnnotation class]])
    {

        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        /* 起点. */
        if ([[annotation title] isEqualToString:@"star"])
        {
            annotationView.image = [UIImage imageNamed:@"start"];
        }
        /* 终点. */
        else if([[annotation title] isEqualToString:@"end"])
        {
            annotationView.image = [UIImage imageNamed:@"end"];
        }
        return annotationView;
    }
    
//    /* 自定义userLocation对应的annotationView. */
//    if ([annotation isKindOfClass:[MAUserLocation class]])
//    {
//        static NSString *userLocationStyleReuseIndetifier = @"userLocationReuseIndetifier";
//        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
//                                                             reuseIdentifier:userLocationStyleReuseIndetifier];
//        }
//        annotationView.tag = 1002;
//        UIImage *image = [UIImage imageNamed:@"guides"];
//        annotationView.image = image;
//
//        annotationView.centerOffset = CGPointMake(0,0);
//        annotationView.canShowCallout = YES;
//        
//        
//        
//        return annotationView;
//    }
    return nil;
}



/**
 * @brief 当mapView新添加annotation views时，调用此接口
 * @param mapView 地图View
 * @param views 新添加的annotation views
 */
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    
}

/**
 * @brief 当选中一个annotation views时，调用此接口
 * @param mapView 地图View
 * @param view 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
   
    
    
}

/**
 * @brief 当取消选中一个annotation views时，调用此接口
 * @param mapView 地图View
 * @param view 取消选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
  
}

/**
 * @brief 在地图View将要启动定位时，会调用此函数
 * @param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView{
    
}
/**
 * @brief 定位失败后，会调用此函数
 * @param mapView 地图View
 * @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
}

/**
 * @brief 在地图View停止定位后，会调用此函数
 * @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView{
    
}

/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
//
//    // 让定位箭头随着方向旋转
//    MAAnnotationView *annotationView = (MAAnnotationView *)[self viewWithTag:1002];
//    
//    if (!updatingLocation && annotationView != nil)
//    {
//        [UIView animateWithDuration:0.1 animations:^{
//            double degree = userLocation.heading.trueHeading - self.mapView.rotationDegree;
//            annotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f);
//        }];
//    }
//   
    self.userLocation = mapView.userLocation;
    
//    self.currentLocationCoordinate2D = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
//
//    if (updatingLocation) {
//        
//        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_async(globalQueue, ^{
//            //子线程异步执行任务，防止主线程卡顿
//            if (_search == nil) {
//                _search  = [[AMapSearchAPI alloc] init];
//                _search.delegate = self;
//            }
//            AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
//            
//            regeo.location                    = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
//            regeo.requireExtension            = YES;
//            
//            [_search AMapReGoecodeSearch:regeo];
//        });
//    }
    
}

#pragma mark -逆地理编码代理方法 －－ 保存数据到本地

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil) {
        /*保存数据到本地*/
        UsersClass *usersModel = [UsersClass userInfoShareInstance];
        //省/直辖市
        usersModel.province = response.regeocode.addressComponent.province;
        //市
        usersModel.citycode = response.regeocode.addressComponent.citycode;
        //区
        usersModel.district = response.regeocode.addressComponent.district;
        //乡镇街道
        usersModel.town = response.regeocode.addressComponent.township;
        //街道＋门牌号
        usersModel.address = [NSString stringWithFormat:@"%@%@",response.regeocode.addressComponent.streetNumber.street,response.regeocode.addressComponent.streetNumber.number];
        //经度
        usersModel.latitude = [NSString stringWithFormat:@"%f",self.userLocation.coordinate.latitude];
        //纬度
        usersModel.longitude = [NSString stringWithFormat:@"%f",self.userLocation.coordinate.longitude];
        //方向
        usersModel.direction = response.regeocode.addressComponent.streetNumber.direction;
        //模型转字典
        NSDictionary *dict = [usersModel easy_modelInfo];
        //保存字典信息
        [CacheClass cacheFromYYCacheWithValue:dict AndKey:CACHE_DATA];
//        DLog(@"字典信息 %@",dict);
    }
}


#pragma mark - 逆地理编码
/**
 * coordinate 经纬度
 * isLocation 判断是定位使用该方法还是移动地图使用该方法 isLocation为YES定位使用该方法，保存当前位置
 */
- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 处理耗时操作的代码块...
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        
        regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        regeo.requireExtension            = YES;

        __weak typeof(self) weakSelf = self;
        
        [self.tool onReGeocodeSearchDoneWithRequest:regeo andBlock:^(id request, id response, NSError *error) {
            
            AMapReGeocodeSearchResponse *responseNew = (AMapReGeocodeSearchResponse *)response;
            
            __strong __typeof(weakSelf)strongSelf = weakSelf;//防止多次weakSelf会把之前方法置空而崩溃
            if ([responseNew isKindOfClass:[AMapRouteSearchResponse class]]) {
                return;
            }
            
            if (responseNew.regeocode != nil) {
                //注意这里，如果数据为空会出错，可以做字符串判断
                //通知主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回调或者说是通知主线程刷新
                    //头标题
                    strongSelf.userPointAnnotation.title = [NSString stringWithFormat:@"%@%@",responseNew.regeocode.addressComponent.streetNumber.street,responseNew.regeocode.addressComponent.building];
                    
                    //副标题
                    strongSelf.userPointAnnotation.subtitle = [NSString stringWithFormat:@"%@%@%@",responseNew.regeocode.addressComponent.township,responseNew.regeocode.addressComponent.streetNumber.street,responseNew.regeocode.addressComponent.streetNumber.number];
                    
                    //大头针坐标
                    strongSelf.userPointAnnotation.coordinate = CLLocationCoordinate2DMake(self.mapView.centerCoordinate.latitude, self.mapView.centerCoordinate.longitude);
                    
                    [strongSelf.mapView addAnnotation:self.userPointAnnotation];
                  
                    //自动显示气泡信息
                    [strongSelf.mapView selectAnnotation:self.userPointAnnotation animated:YES];
                    
                });
            }
        }];
    });
}

@end

/**
 *origin：起点坐标，必设。
 *destination：终点坐标，必设。
 *waypoints：途经点，最多支持16个途经点。
 *avoidpolygons：避让区域，最多支持100个避让区域，每个区域16个点。
 *avoidroad：避让道路，设置避让道路后，避让区域失效。
 *strategy：驾车导航策略，0-速度优先（时间）；1-费用优先（不走收费路段的最快道路）；2-距离优先；3-不走快速路；4-结合实时交通（躲避拥堵）；5-多策略（同时使用速度优先、费用优先、距离优先三个策略）；6-不走高速；7-不走高速且避免收费；8-躲避收费和拥堵；9-不走高速且躲避收费和拥堵
 */
