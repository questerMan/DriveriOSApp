//
//  Indent.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/28.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//
/** 根据不同页面，设置同一个页面下的tag一样，以便于处理不同界面 */


#import "Indent.h"
#import "IndentData.h"
#import "ItemIndentModel.h"

@interface Indent ()
/** 等单 */

/** 即时单 */

/** 预约单 */

/** 接送机 */

/** 抢单 */


@property (nonatomic, strong) IndentPublicViewTools *indentTool;

@property (nonatomic, strong) AMPublicTools *amTool;

@property (nonatomic, strong) AMapNaviPoint *startLocatoin;

@property (nonatomic, strong) AMapNaviPoint *destinationPoint;

@property (nonatomic, strong) AMPublicTools *tool;

@property (nonatomic, strong) NSMutableArray *arrryData;

@end

@implementation Indent

-(AMPublicTools *)tool{
    if (!_tool) {
        _tool = [AMPublicTools shareInstance];
    }
    return _tool;
}

-(IndentPublicViewTools *)indentTool{
    if (!_indentTool) {
        _indentTool = [IndentPublicViewTools shareInstance];
        _indentTool.indentController = self;
    }
    return _indentTool;
}

-(AMPublicTools *)amTool{
    if (!_amTool) {
        _amTool = [AMPublicTools shareInstance];
    }
    return _amTool;
}

-(AMMapView *)map{
    if (!_map) {
        _map = [[AMMapView alloc] initWithFrame:CGRectMake(0, MATCHSIZE(80), SCREEN_W, VIEW_H - MATCHSIZE(80) - MATCHSIZE(130))];
    }
    return _map;
}

-(NSMutableArray *)arrryData{
    if (!_arrryData) {
        _arrryData = [NSMutableArray array];
    }
    return _arrryData;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self creatNAC];
    
}

/**
 *  创建导航栏
 */
-(void)creatNAC{
    
    self.title = @"丽新专车";
    
    //不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    
    //显示的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //导航栏字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //左上角菜单按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"菜单"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemOnclick:)];
    
    //右上角聊天按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"聊天"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemOnclick:)];
    
}
#pragma mark - 左上角菜单按钮
-(void)leftItemOnclick:(UIBarButtonItem *)itemBtn{
    
    //打开左侧栏
    [self setNavigationBarItem];
    
}
#pragma mark - 右上角聊天按钮
-(void)rightItemOnclick:(UIBarButtonItem *)itemBtn{
    
    
    //    Setup *setup = [[Setup alloc] init];
    //    [self.navigationController pushViewController:setup animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)creatAMMap{
    
    [self.view addSubview:self.map];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatAMMap];//先建立地图以免把其他view覆盖掉
    
    [self creatTab];
    
    self.indentTool.seachTextF.text = nil;
    self.indentTool.startNavigation.hidden = YES;
    self.indentTool.cancelBtn.hidden = YES;
    
}
#pragma mark - 获取tab数据
-(NSMutableArray *)getTabDataWithCount:(NSString *)count{
    
    NSError*error;
    //获取文件路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"IndentData"ofType:@"geojson"];
    
    //根据文件路径读取数据
    NSData *datas = [[NSData alloc]initWithContentsOfFile:filePath];
    
    //解读json数据
    NSArray *arrData = [NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableContainers error:&error];
    
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
    
    return arrDatas;
}

-(void)creatTab{
    
    
    TabClass *tabClass = [[TabClass alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, MATCHSIZE(60))];
    //获取tab数据
    NSMutableArray *arrData = [self getTabDataWithCount:@"2"];
    [tabClass getTabTitleDataWithArray:arrData];
    
    //显示第一个tab(获取第一个tab的type)
    TabModel *mode = arrData[0];
    int type = [mode.type intValue];
    //默认显示第一个tab（等单）的view
    [self.indentTool implementAllMethodWithIndent:type andIndent:self];
    
    [self.view addSubview:tabClass];
    
    
    __weak typeof(self) weakSelf = self;
    
    [tabClass didSelectTabWithBlock:^(NSString *type) {
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        [strongSelf.indentTool implementAllMethodWithIndent:[type intValue] andIndent:strongSelf];
    }];
    
    //等单页面搜索框跳转
    [self pusToSearchView];
    
    //等单页面导航页跳转
    [self pusToNavigationMap];
    
    [self clearRoute];
    
}

#pragma mark - 等单页面跳转到搜索框
-(void)pusToSearchView{
    __weak typeof(self) weakSelf = self;
    
    [self.indentTool pusToSearchWithSearchBlock:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        strongSelf.destinationPoint = nil;
        strongSelf.startLocatoin = nil;
        
        AMSearch *amSearch = [[AMSearch alloc] init];
        //搜索框回调
        [amSearch getSearchResultWithAMSearchBlock:^(AMLocationModel *model) {
            NSLog(@"搜索结果%@",model);
            strongSelf.destinationPoint = [AMapNaviPoint locationWithLatitude:[model.latitude floatValue] longitude:[model.longitude floatValue]];
            
            //在搜索文本框显示
            strongSelf.indentTool.seachTextF.text = model.name;
            if ((int)strongSelf.map.currentLocationCoordinate2D.latitude == 0 || model.address == nil) {
                [strongSelf showHint:@"本地定位功能尚未开启"];
            }else{
                //显示导航按钮 / 取消按钮
                strongSelf.indentTool.startNavigation.hidden = NO;
                strongSelf.indentTool.cancelBtn.hidden = NO;
                //绘制路径（全屏全图路径）
                //                [self.map showRouteWithStartCoordinate:self.map.currentLocationCoordinate2D andDestinationCoordinate:CLLocationCoordinate2DMake([model.latitude floatValue], [model.longitude floatValue]) andStrategy:5];
                AMPublicTools *amTool = [AMPublicTools shareInstance];
                [amTool showRouteWithMap:self.map.mapView StartCoordinate:self.map.currentLocationCoordinate2D andDestinationCoordinate:CLLocationCoordinate2DMake([model.latitude floatValue], [model.longitude floatValue]) andStrategy:5 block:^{
                    
                }];
                self.map.MapIndentState = MapIndentStateWaitNavigation;
            }
            
        }];
        
        [strongSelf.navigationController pushViewController:amSearch animated:YES];
    }];
    
}
#pragma mark - 等单页面导航页跳转
-(void)pusToNavigationMap{
    __weak typeof(self) weakSelf = self;
    
    [self.indentTool pusToNavigationMapWithNavigationMapBlock:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        AMNavigationMap *navigationMap = [[AMNavigationMap alloc] init];
        
        navigationMap.startLocatoin = [AMapNaviPoint locationWithLatitude:strongSelf.map.userLocation.coordinate.latitude longitude:strongSelf.map.userLocation.coordinate.longitude]; //获取当前定位
        
        navigationMap.destinationPoint = strongSelf.destinationPoint;
        
        if (navigationMap.startLocatoin != nil && navigationMap.description != nil) {
            [strongSelf.navigationController pushViewController:navigationMap animated:YES];
        }else{
            [strongSelf showHint:@"导航信息有误！"];
        }
        
    }];
}
#pragma mark - 移除驾车路径
-(void)clearRoute{
    [self.indentTool clearRouteWithBlock:^{
        //移除路径
    AMPublicTools *amTool = [AMPublicTools shareInstance];
        [amTool clearRouteWithBlock:^{
            
        }];
    }];
}




@end
