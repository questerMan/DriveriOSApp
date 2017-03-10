//
//  IndentPublicViewTools.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "IndentPublicViewTools.h"
#import "DeleteIndentAlert.h"
#import "AlertView.h"
#import "LXQDestinationTipsView.h"
#import "LXQDisposingLoadAlertViewController.h"
#import "LXQFinalSettlementViewController.h"
static NSTimeInterval acceptIndentCount;

@interface IndentPublicViewTools()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NetWorkingManage *netWorkingManage;

@property (nonatomic, weak) NSTimer* acceptIndentTimer;

@property (nonatomic, strong) UIButton* determinedBtn;

@property (nonatomic, strong) UIButton* passengerGetOn;

@property (nonatomic, strong) UIButton* getToPoint;
//救援电话
@property (nonatomic, strong) UIButton* rescueBtn;

//预约单背景图
@property (nonatomic, strong) UIImageView* reservationImageV;

@property (nonatomic, strong) AlertView* rescueAlert;

@property (nonatomic, strong) AlertView* passengerGetOnAlert;

@property (nonatomic, strong) AlertView* receiveOrderAlert;

@property (nonatomic, strong) AlertView* robIndentAlertAlert;

@property (nonatomic, assign) int type;

/** 乘客上车提示*/
@property (nonatomic, strong) LXQAfterDrivingTipsView* drivingTipsView;

/** 接单下拉窗口*/
@property (nonatomic, strong) LXQRecevingIndentView* recevingIndentView;

/** 去目的地提示框*/
@property (nonatomic, strong) LXQDestinationTipsView* destinationTipsView;

@end

//标志Yes已经点击接单按钮在此过程中保持接单倒计时定时器不会中断而重启  yes定时器启动 NO定时器关闭
//static BOOL timeFlag = NO;

@implementation IndentPublicViewTools

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(MATCHSIZE(0), MATCHSIZE(80),SCREEN_W, SCREEN_H - MATCHSIZE(90+44)) style:UITableViewStylePlain];
        UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0,- SCREEN_H, SCREEN_W, SCREEN_H)];
        bgView.backgroundColor = COLOR(245, 245, 245, 1);
        [_tableView addSubview:bgView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = YES;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = 0;
    }
    return _tableView;
}

-(NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}

-(UITextField *)seachTextF{
    if (!_seachTextF) {
        _seachTextF = [[UITextField alloc] init];
        _seachTextF.delegate = self;
        _seachTextF.text = nil;
        _seachTextF.frame = CGRectMake(MATCHSIZE(60), MATCHSIZE(100), SCREEN_W - MATCHSIZE(120), MATCHSIZE(60));
        _seachTextF.placeholder = @"查询地点、公交、地铁";
        [_seachTextF setValue:[UIColor orangeColor] forKeyPath:@"_placeholderLabel.textColor"];//修改颜色
        _seachTextF.textAlignment = NSTextAlignmentCenter;
        _seachTextF.textColor = [UIColor orangeColor];
        _seachTextF.backgroundColor = [UIColor whiteColor];
        _seachTextF.layer.cornerRadius = MATCHSIZE(5);
        _seachTextF.layer.masksToBounds = YES;
        _seachTextF.hidden = YES;

    }
    return _seachTextF;
}

-(UIButton *)startNavigation{
    if (!_startNavigation) {
        _startNavigation = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(46),SCREEN_H - MATCHSIZE(60) - MATCHSIZE(40) - StatusBar_H -MATCHSIZE(100), MATCHSIZE(290), MATCHSIZE(80)) Title:@"开始导航" backGround:UIColorFromRGB(@"#ff6d00") tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(40)];
        _startNavigation.hidden = YES;
    }
    return _startNavigation;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(40)*2 + (SCREEN_W - MATCHSIZE(40)*3)/2,SCREEN_H - MATCHSIZE(60) - MATCHSIZE(40) - StatusBar_H - MATCHSIZE(100), MATCHSIZE(290), MATCHSIZE(80)) Title:@"取消" backGround:UIColorFromRGB(@"#ffffff") tintColor:UIColorFromRGB(@"#ff6d00") cornerRadius:MATCHSIZE(40)];
        [_cancelBtn setTitleColor:UIColorFromRGB(@"#ff6d00") forState:0];
        _cancelBtn.hidden = YES;
    }
    return _cancelBtn;
}

-(UIButton *)acceptIndentBtn{
    if (!_acceptIndentBtn) {
        _acceptIndentBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(40),SCREEN_H - MATCHSIZE(60) - MATCHSIZE(20) - StatusBar_H -MATCHSIZE(100), (SCREEN_W - MATCHSIZE(40)*2), MATCHSIZE(60)) Title:@"接单" backGround:UIColorFromRGB(@"#ff6d00") tintColor:UIColorFromRGB(@"#ff6d00") cornerRadius:MATCHSIZE(40)];
        [_acceptIndentBtn setTitleColor:UIColorFromRGB(@"#ffffff") forState:UIControlStateNormal];
        _acceptIndentBtn.hidden = YES;
    }
    return _acceptIndentBtn;
}

- (UIButton *)setOutBtn{
    if (!_setOutBtn) {
        _setOutBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(40),SCREEN_H - MATCHSIZE(60) - MATCHSIZE(20) - StatusBar_H -MATCHSIZE(100), (SCREEN_W - MATCHSIZE(40)*2), MATCHSIZE(60)) Title:@"开始出发" backGround:UIColorFromRGB(@"#ff6d00") tintColor:UIColorFromRGB(@"#ff6d00") cornerRadius:MATCHSIZE(40)];
        [_setOutBtn setTitleColor:UIColorFromRGB(@"#ffffff") forState:UIControlStateNormal];
        _setOutBtn.hidden = YES;
    }
    return _setOutBtn;
}

-(InstantHeadView *)instantHeadView{
    if (!_instantHeadView) {
        _instantHeadView = [[InstantHeadView alloc] initWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(90), SCREEN_W - MATCHSIZE(40), MATCHSIZE(136))];
        _instantHeadView.layer.cornerRadius = MATCHSIZE(8);
        _instantHeadView.layer.masksToBounds = YES;
        _instantHeadView.hidden = YES;
    }
    return _instantHeadView;
}

-(NetWorkingManage *)netWorkingManage{
    if (!_netWorkingManage) {
        _netWorkingManage = [NetWorkingManage shareInstance];
    }
    return _netWorkingManage;
}

- (NSTimer *)acceptIndentTimer
{
    if (_acceptIndentTimer == nil) {
        
        NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {

            [self.acceptIndentBtn setTitle:[NSString stringWithFormat:@"接单 %.0fs",acceptIndentCount] forState:UIControlStateNormal];
            if (acceptIndentCount > 0) {
                acceptIndentCount --;
            }
            else
            {
                [self.acceptIndentBtn setTitle:@"接单" forState:UIControlStateNormal];
                [self presentRefuseIndent];
            }
        }];
        self.acceptIndentTimer = timer;
        return timer;
    }
    return _acceptIndentTimer;
}

- (UIButton *)determinedBtn
{
    if (!_determinedBtn) {
        UIButton* determinedBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(40)*2 + (SCREEN_W - MATCHSIZE(40)*3)/2,SCREEN_H - MATCHSIZE(60) - MATCHSIZE(40) - StatusBar_H - MATCHSIZE(100), MATCHSIZE(290), MATCHSIZE(80)) Title:@"到达上车点" backGround:UIColorFromRGB(@"#ffffff") tintColor:UIColorFromRGB(@"#ff6d00") cornerRadius:MATCHSIZE(40)];
        [determinedBtn setTitleColor:UIColorFromRGB(@"#ff6d00") forState:0];
        determinedBtn.hidden = YES;
        _determinedBtn = determinedBtn;
    }
    return _determinedBtn;
}

- (UIButton *)getToPoint
{
    if (!_getToPoint) {
        UIButton* getToPoint = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(40)*2 + (SCREEN_W - MATCHSIZE(40)*3)/2,SCREEN_H - MATCHSIZE(60) - MATCHSIZE(40) - StatusBar_H - MATCHSIZE(100), MATCHSIZE(290), MATCHSIZE(80)) Title:@"到达目的地" backGround:UIColorFromRGB(@"#ffffff") tintColor:UIColorFromRGB(@"#ff6d00") cornerRadius:MATCHSIZE(40)];
        [getToPoint setTitleColor:UIColorFromRGB(@"#ff6d00") forState:0];
        getToPoint.hidden = YES;
        _getToPoint = getToPoint;
    }
    return _getToPoint;
}

- (UIButton *)passengerGetOn{
    if (!_passengerGetOn) {
        UIButton* passengerGetOn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(74),SCREEN_H - MATCHSIZE(60) - MATCHSIZE(40) - StatusBar_H -MATCHSIZE(100), MATCHSIZE(600), MATCHSIZE(80)) Title:@"乘客上车 " backGround:UIColorFromRGB(@"#ff6d00") tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(40)];
        passengerGetOn.hidden = YES;
        _passengerGetOn = passengerGetOn;
    }
    return _passengerGetOn;
}

- (UIButton *)rescueBtn
{
    if (!_rescueBtn) {
        _rescueBtn = [UIButton buttonWithType:0];
        [_rescueBtn setImage:[UIImage imageNamed:@"rescue"] forState:0];
    }
    return _rescueBtn;
}

- (UIImageView *)reservationImageV{
    if (!_reservationImageV) {
        UIImage* protectImage = [[UIImage imageNamed:@"baseboard_"] stretchableImageWithLeftCapWidth:MATCHSIZE(374) topCapHeight:MATCHSIZE(149)];
        _reservationImageV = [[UIImageView alloc] initWithImage:protectImage];
        
    }
    return _reservationImageV;
}

- (LXQRecevingIndentView *)recevingIndentView
{
    if (!_recevingIndentView) {
        
        _recevingIndentView = [[LXQRecevingIndentView alloc] initWithFrame:CGRectMake(MATCHSIZE(26), MATCHSIZE(90), SCREEN_W - 2 * MATCHSIZE(26), MATCHSIZE(242))];
//        _recevingIndentView.backgroundColor = COLOR(1, 1, 1, 1);
        _recevingIndentView.hidden = YES;
    }
    return _recevingIndentView;
}

- (LXQAfterDrivingTipsView *)drivingTipsView
{
    if (!_drivingTipsView) {
        _drivingTipsView = [[LXQAfterDrivingTipsView alloc] init];
        _drivingTipsView.hidden = YES;

    }
    return _drivingTipsView;
}

- (LXQDestinationTipsView *)destinationTipsView{
    
    if (!_destinationTipsView) {
        _destinationTipsView = [[LXQDestinationTipsView alloc] init];
        _destinationTipsView.hidden = YES;
    }
    return _destinationTipsView;
}

- (AlertView *)rescueAlert{
    if (!_rescueAlert) {
        _rescueAlert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeEmergencyRescueAlert];
    }
    return _rescueAlert;
}

- (AlertView *)passengerGetOnAlert{
    if (!_passengerGetOnAlert) {
        _passengerGetOnAlert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypePassengerGetOnAlert];
    }
    return _passengerGetOnAlert;
}

- (AlertView *)robIndentAlertAlert{
    if (!_robIndentAlertAlert) {
        _robIndentAlertAlert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType: AlertViewTypeRobIndentAlert];
    }
    return _robIndentAlertAlert;
}

/** 单例 */
+ (IndentPublicViewTools *)shareInstance{
    
    static dispatch_once_t onceToken;
    static IndentPublicViewTools * shareTools = nil;
    dispatch_once(&onceToken, ^{
        shareTools = [[IndentPublicViewTools alloc]init];
    });
    return shareTools;
}

//所有控件的事件都在这里写，避免多次执行出现崩溃
- (instancetype)init{
    if (self = [super init]) {
        
        [self buttonOfIndent];
        
    }
    return self;
}

#pragma mark - 等单
- (void)addWaitIndentWithIndent:(UIViewController *)indent{
    
    [indent.view addSubview:self.seachTextF];
    
    //创建导航按钮
    [indent.view addSubview:self.startNavigation];
    
    //创建取消按钮
    [indent.view addSubview:self.cancelBtn];
    
    //创建救援按钮
    [indent.view addSubview:self.rescueBtn];
    [[self.rescueBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        [self.rescueAlert alertViewShow];
    }];
    [self.rescueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(MATCHSIZE(26));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getRobIndentData];
        __weak typeof(self) weakSelf = self;
        self.robIndentAlertAlert.robIndentAlertViewController.robIndentBtnClick = ^{
            [weakSelf.robIndentAlertAlert alertViewCloseWithBlock:nil];
        };
        self.robIndentAlertAlert.robIndentAlertViewController.robIndentTimerEnd = ^{
            [weakSelf.robIndentAlertAlert alertViewCloseWithBlock:nil];
        };
        [self.robIndentAlertAlert alertViewShow];
    });
}

- (void)getRobIndentData{
    
    [self.netWorkingManage getRobIndentWithBlock:^(NSArray *array) {
        self.robIndentAlertAlert.robIndentAlertViewController.model = array[0];
    }];
}

-(void)buttonOfIndent{
    
    //开始导航 点击事件
    [[self.startNavigation rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        if (_navigationMapBlock) {
            _navigationMapBlock();
        }
        
    }];
    
    //取消按钮 点击事件
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        self.seachTextF.text = @"";
        if(_clearRouteBlock){
            _clearRouteBlock();
        }
        self.indentController.map.MapIndentState = MapIndentStateWait;
        
        self.startNavigation.hidden = YES;
        self.cancelBtn.hidden = YES;
        
    }];
    
    //如果seachTextF有值时显示导航按钮
    [[[self.seachTextF rac_textSignal] filter:^BOOL(id value) {
        NSString *text = value;
        return text.length > 0 ;
    }] subscribeNext:^(id x) {
        self.startNavigation.hidden = NO;
        self.cancelBtn.hidden = NO;
    }];
    
    //如果seachTextF没有值时显示导航按钮
    [[[self.seachTextF rac_textSignal] filter:^BOOL(id value) {
        NSString *text = value;
        return text.length == 0 ;
    }] subscribeNext:^(id x) {
        self.startNavigation.hidden = YES;
        self.cancelBtn.hidden = YES;
    }];
    
    [[self.determinedBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self changeMapStateWithMapIndentState:MapIndentStateWaitingPassengers];
    }];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.seachTextF resignFirstResponder];
    //跳转到搜索页面
    if (_searchBlock != nil) {
        _searchBlock();
    }
}

-(void)pusToSearchWithSearchBlock:(IndentPublicViewToolsPusToSearchBlock)searchBlock{
    _searchBlock = searchBlock;
}

-(void)clearRouteWithBlock:(IndentPublicViewToolsPusOfClearRouteBlock)clearRouteBlock{
    _clearRouteBlock = clearRouteBlock;
}

-(void)pusToNavigationMapWithNavigationMapBlock:(IndentPublicViewToolsPusToNavigationMapBlock) navigationMapBlock{
    _navigationMapBlock = navigationMapBlock;
}

#pragma mark - 隐藏等单页面的view
-(void)hideWaitIndentAllView{
    
    self.seachTextF.hidden = YES;
    self.startNavigation.hidden = YES;
    self.cancelBtn.hidden = YES;
    
}

#pragma mark - 显示等单页面的view
-(void)showWaitIndentAllView{
    
    self.seachTextF.hidden = NO;
}

#pragma mark - 即时单
-(void)addInstantIndentWithIndent:(UIViewController *)indent {
    
    [indent.view addSubview:self.instantHeadView];
    
    [indent.view addSubview:self.acceptIndentBtn];
    
    acceptIndentCount = 10;
    //触发定时器
    [self.acceptIndentTimer fire];
    //接单按钮点击事件
    [self.acceptIndentBtn addTarget:self action:@selector(acceptIndentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.acceptIndentBtn.cs_acceptEventInterval = 3;
    
    //接单按钮位置布局
    [self.acceptIndentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.indentController.view).offset(0);
        make.bottom.equalTo(self.indentController.view).offset(MATCHSIZE(-75));
        make.width.offset(MATCHSIZE(600));
        make.height.offset(MATCHSIZE(80));
    }];
    //弹出有即时单提示框
    AlertView *alert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeInstantIndentCommingAlert];
    [alert alertViewShow];
    
    //获取即时单数据
    [self getstantIndentData];
}

- (void)acceptIndentBtnClick{
    [self presentOrderReceiving];
    //按钮状态显示“接单”
    [self.acceptIndentBtn setTitle:@"接单" forState:UIControlStateNormal];
    //取消定时器
    [self.acceptIndentTimer invalidate];
    self.acceptIndentTimer = nil;
}

//即时单接单按钮
- (void)presentOrderReceiving{
    //弹出提示：接单成功
    AlertView *alert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeIndentSucceedAlert];
    [alert alertViewShow];
    
    //关闭计时器
    [self.acceptIndentTimer invalidate];
    //延迟3s后执行进入地图”已接单状态“
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //关闭弹出框
        [alert alertViewCloseWithBlock:nil];
        //接单后进入地图“已接单”状态
        [self changeMapStateWithMapIndentState:MapIndentStateGoToPoint];
        //获取当前即时单数据
        NetWorkingManage *netManage = [NetWorkingManage shareInstance];
        [netManage getInstantIndentWithBlock:^(NSArray *array) {
        IndentData *model = array[0];
            //起始点地图坐标
            CLLocationCoordinate2D startCoor = CLLocationCoordinate2DMake([model.startLocationLat doubleValue], [model.startLocationLon doubleValue]);
            //描绘路径（起始点－－目的地）
            AMPublicTools *tool = [AMPublicTools shareInstance];
            [tool showRouteWithMap:self.indentController.map.mapView StartCoordinate:self.indentController.map.userLocation.coordinate  andDestinationCoordinate:startCoor andStrategy:5 block:nil];
            //把起点赋值给导航页面的目的地处
            self.indentController.destinationPoint = [AMapNaviPoint locationWithLatitude:[model.startLocationLat floatValue] longitude:[model.startLocationLon floatValue]];
        }];
    });
}

- (void)presentRefuseIndent
{
    AlertView* alertV = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeDeleteIndentAlert];
    [alertV alertViewShow];
    
    [self.acceptIndentTimer invalidate];
    self.acceptIndentTimer = nil;
}


#pragma mark - 隐藏即时单页面的view
-(void)hideInstantIndentAllView{

    self.instantHeadView.hidden = YES;
    
    self.acceptIndentBtn.hidden = YES;
    
}

#pragma mark - 显示即时单页面的view
-(void)showInstantIndentAllView{
    
    [UIView animateWithDuration:0.8 animations:^{
        
    } completion:^(BOOL finished) {
        
        self.instantHeadView.hidden = NO;
        
        self.acceptIndentBtn.hidden = NO;
        
    }];
}

#pragma mark - 预约单
-(void)addReservationIndentWithIndent:(UIViewController *)indent{
    
    [indent.view addSubview:self.setOutBtn];
    
    [self.setOutBtn addTarget:self action:@selector(setOutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //接单按钮位置布局
    [self.setOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.indentController.view).offset(0);
        make.bottom.equalTo(self.indentController.view).offset(MATCHSIZE(-75));
        make.width.offset(MATCHSIZE(600));
        make.height.offset(MATCHSIZE(80));
    }];
    
    //获取预约单table数据
    [self getReservationData];
    
    [self.tableView reloadData];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = MATCHSIZE(240);
    [indent.view insertSubview:self.tableView atIndex:1];
    
    self.reservationImageV.frame = CGRectMake(0, 0, SCREEN_W, self.arrayData.count * MATCHSIZE(240) + MATCHSIZE(70));
    [self.tableView insertSubview:self.reservationImageV atIndex:0];
}

- (void)setOutBtnClick{
    //弹出提示：接单成功
    AlertView *alert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeIndentSucceedAlert];
    [alert alertViewShow];
    
    //延迟3s后执行进入地图”已接单状态“
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //关闭弹出框
        [alert alertViewCloseWithBlock:nil];
        //接单后进入地图“已接单”状态
        [self changeMapStateWithMapIndentState:MapIndentStateGoToPoint];

        IndentData *model = self.arrayData[0];
        //起始点地图坐标
        CLLocationCoordinate2D startCoor = CLLocationCoordinate2DMake([model.startLocationLat doubleValue], [model.startLocationLon doubleValue]);
        
        //描绘路径（起始点－－目的地）
        AMPublicTools *tool = [AMPublicTools shareInstance];
        [tool showRouteWithMap:self.indentController.map.mapView StartCoordinate:self.indentController.map.userLocation.coordinate andDestinationCoordinate:startCoor andStrategy:5 block:nil];
        //把起点赋值给导航页面的目的地处
        self.indentController.destinationPoint = [AMapNaviPoint locationWithLatitude:[model.startLocationLat floatValue] longitude:[model.startLocationLon floatValue]];
    });
}

- (void)setOutBtnClickFailed{
    AlertView* alert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeReservationSetOutFailedAlert];
    [alert alertViewShow];
}

#pragma mark - 预约单tableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    ReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ReservationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.model = self.arrayData[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IndentData *model = self.arrayData[indexPath.row];
    NSInteger mouth = [model.dateTime substringWithRange:NSMakeRange(0, 2)].integerValue;
    NSInteger day = [model.dateTime substringWithRange:NSMakeRange(3, 2)].integerValue;
    NSInteger hour = model.time.integerValue;
    NSInteger minute = [model.time substringWithRange:NSMakeRange(3, 2)].integerValue;
    [self.setOutBtn removeTarget:self action:@selector(setOutBtnClickFailed) forControlEvents:1<<6];
    [self.setOutBtn addTarget:self action:@selector(setOutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    for (IndentData *tempModel in self.arrayData) {
        NSInteger tempMouth = [tempModel.dateTime substringWithRange:NSMakeRange(0, 2)].integerValue;
        NSInteger tempDay = [tempModel.dateTime substringWithRange:NSMakeRange(3, 2)].integerValue;
        NSInteger tempHour = tempModel.time.integerValue;
        NSInteger tempMinute = [tempModel.time substringWithRange:NSMakeRange(3, 2)].integerValue;
        if (mouth > tempMouth) {
            [self.setOutBtn removeTarget:self action:@selector(setOutBtnClick) forControlEvents:1<<6];
            [self.setOutBtn addTarget:self action:@selector(setOutBtnClickFailed) forControlEvents:UIControlEventTouchUpInside];
            break;
        }else if(mouth == tempMouth){
            if (day > tempDay) {
                [self.setOutBtn removeTarget:self action:@selector(setOutBtnClick) forControlEvents:1<<6];
                [self.setOutBtn addTarget:self action:@selector(setOutBtnClickFailed) forControlEvents:UIControlEventTouchUpInside];
                break;
            }else if (day == tempDay){
                if (hour > tempHour) {
                    [self.setOutBtn removeTarget:self action:@selector(setOutBtnClick) forControlEvents:1<<6];
                    [self.setOutBtn addTarget:self action:@selector(setOutBtnClickFailed) forControlEvents:UIControlEventTouchUpInside];
                    break;
                }else if (hour == tempHour){
                    if (minute > tempMinute) {
                        [self.setOutBtn removeTarget:self action:@selector(setOutBtnClick) forControlEvents:1<<6];
                        [self.setOutBtn addTarget:self action:@selector(setOutBtnClickFailed) forControlEvents:UIControlEventTouchUpInside];
                        break;
                    }else{
                        continue;
                    }
                }else{
                    continue;
                }
            }else{
                continue;
            }
        }else{
            continue;
        }
    }
    
    [self.arrayData removeAllObjects];
    [self.arrayData addObject:model];
    [tableView reloadData];
    self.recevingIndentView.model = model;
    self.reservationImageV.height = self.arrayData.count * MATCHSIZE(240) + MATCHSIZE(70);
    [self changeMapStateWithMapIndentState:MapIndentStateHaveIndent];
}

#pragma mark - 隐藏预约单页面的view
-(void)hideReservationIndentAllView{
    
    [UIView animateWithDuration:0.8 animations:^{
        self.tableView.y = - SCREEN_H;
        
    } completion:^(BOOL finished) {
//        self.tableView.hidden = YES;
    }];
}

#pragma mark - 显示预约单页面的view
-(void)showReservationIndentAllView{

    self.tableView.hidden = NO;
    
    [UIView animateWithDuration:0.8 animations:^{
        self.tableView.y = MATCHSIZE(80);

    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - tab点击显示相应的View
-(void)implementAllMethodWithIndent:(int)type andIndent:(UIViewController *)indent{
    
    self.type = type;
    
    [self hideMapStateChange];
    // 点击取消第一响应
    [self.seachTextF resignFirstResponder];
    
    switch (type) {
        case 0://等单
            //显示
            [self addWaitIndentWithIndent:indent];//已经加载
            [self showWaitIndentAllView];
            //隐藏
            [self hideReservationIndentAllView];
            [self hideInstantIndentAllView];
            break;
        case 1://即时单
            //显示
            [self addInstantIndentWithIndent:indent];
            [self showInstantIndentAllView];
//            [self loadInstantIndentView]; //加载即时单控件
            //非正确监听位置
            self.indentController.map.MapIndentState = MapIndentStateWaitingList;
            //隐藏
            [self hideReservationIndentAllView];
            [self hideWaitIndentAllView];
            break;
        case 2://预约单
            //显示
            [self addReservationIndentWithIndent:indent];
            [self showReservationIndentAllView];
           
            //隐藏
            [self hideWaitIndentAllView];
            [self hideInstantIndentAllView];
            break;
            
        default:
            [self hideIndentClassAndMapStateChange];
            break;
    }
}

//获取预约单table数据
- (void)getReservationData{
    [self.netWorkingManage getReservationIndentWithBlock:^(NSArray *array) {
        [self.arrayData removeAllObjects];
        [self.arrayData addObjectsFromArray:array];
    }];
}

//获取即时单数据
- (void)getstantIndentData{
    [self.netWorkingManage getInstantIndentWithBlock:^(NSArray *array) {
        self.instantHeadView.model = array[0];
        self.recevingIndentView.model = array[0];
    }];
}


- (void)changeMapStateWithMapIndentState: (MapIndentState)mapIndentState{
    
    [self hideIndentClassAndMapStateChange];
    
    switch (mapIndentState) {
        case MapIndentStateWait://等单
            [self hideRecevingIndentView];
            break;
            
        case MapIndentStateWaitNavigation://等单导航
            [self hideRecevingIndentView];
            break;
            
        case MapIndentStateWaitingList://待接单
            [self hideRecevingIndentView];
            break;
            
        case MapIndentStateHaveIndent://已接单
            [self showSetOutBtn];
            [self showReservationIndentAllView];
            break;
            
        case MapIndentStateGoToPoint://去上车点
            
            [self addGoToPointWithIndent];
            [self showRecevingIndentView];
          
            //显示导航/去目的地按钮
            [self showNavigationBtnAndDetermineBtn];
            
            break;
            
        case MapIndentStateWaitingPassengers://免费or收费等候乘客上车
            //隐藏
            [self hideRouteBetweenSelfAndUser];
            [self addWaitingPassengersWithIndent];
            //显示
            [self showRecevingIndentView];
            if (self.type == 1) {
                [self showRouteBetweenUserAndDetermination];
            }else if(self.type == 2){
                [self showRouteBetweenUserAndDetermination2];
            }
            [self showPassengerGetOnBtn];
            [self showDrivingTipsView];
            
            break;
            
        case MapIndentStateGoToDestination://去目的地
            [self addGoToDestinationWithIndent];
            [self showRecevingIndentView];
            [self showNavigationBtnAndGetToPointBtn];
            [self showDestinationTipsView];
            break;
            
        case MapIndentStateForSettlement://待结算
            [self showDisposingLoadAlertAndFinalSettlement];
            
          //隐藏
            [self hideRecevingIndentView];
            [self hideRouteBetweenSelfAndUser];
            break;
            
        case MapIndentStateForGathering://待收款
            
            break;
            
        default:
            [self hideMapStateChange];
            break;
    }
}

#pragma mark - 去上车点地图状态
-(void)addGoToPointWithIndent{
    
    //接单乘客信息栏
    [_indentController.view addSubview: self.recevingIndentView];
    //上车点按钮确认
    [[self.determinedBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self changeMapStateWithMapIndentState:MapIndentStateWaitingPassengers];
    }];
    [self.indentController.view addSubview:self.determinedBtn];
    
    //标题修改
    self.recevingIndentView.titleLabel.text = @"开始接驾";
    //伸缩栏信息修改
    self.recevingIndentView.scalingView = self.recevingIndentView.tCarView;
    self.recevingIndentView.hidenView = self.recevingIndentView.bCarView;
    self.recevingIndentView.scalingBtn.selected = !self.recevingIndentView.scalingBtn.selected;
    [self.recevingIndentView scalingBtnClick:self.recevingIndentView.scalingBtn];
}

//免费or收费等候乘客上车
-(void)addWaitingPassengersWithIndent{
    
    //等待乘客提示框
    [_indentController.view addSubview: self.drivingTipsView];
    
    [self.drivingTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.recevingIndentView.mas_bottom);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(190) + MATCHSIZE(60));
    }];
    
    //上车按钮
    [[self.passengerGetOn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        __weak typeof(self) weakSelf = self;
        self.passengerGetOnAlert.passengerGetOnAlert.okBtnClick = ^{
            [weakSelf changeMapStateWithMapIndentState:MapIndentStateGoToDestination];
            [weakSelf.passengerGetOnAlert alertViewCloseWithBlock:nil];
        };
        
        self.passengerGetOnAlert.passengerGetOnAlert.cancelBtnClick = ^{
            [weakSelf.passengerGetOnAlert alertViewCloseWithBlock:nil];
        };
        
        [self.passengerGetOnAlert alertViewShow];

    }];
    [_indentController.view addSubview:self.passengerGetOn];
    //标题修改
    self.recevingIndentView.titleLabel.text = @"等待接驾";
}

//去目的地
-(void)addGoToDestinationWithIndent{
    
    [self.getToPoint addTarget:self action:@selector(getToPointClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_indentController.view addSubview:self.getToPoint];
    
    //去目的地提示
    [_indentController.view addSubview: self.destinationTipsView];
    [self.destinationTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.recevingIndentView.mas_bottom);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(190) + MATCHSIZE(60));
    }];
    
    //伸缩乘客信息栏信息修改
    self.recevingIndentView.scalingView = self.recevingIndentView.bCarView;
    self.recevingIndentView.hidenView = self.recevingIndentView.tCarView;
    self.recevingIndentView.scalingBtn.selected = !self.recevingIndentView.scalingBtn.selected;
    [self.recevingIndentView scalingBtnClick:self.recevingIndentView.scalingBtn];
    
    //标题修改
    self.recevingIndentView.titleLabel.text = @"正在服务";
}

- (void)getToPointClick{
   [self changeMapStateWithMapIndentState:MapIndentStateForSettlement];
}

//正在处理加载弹窗
- (void)showDisposingLoadAlertAndFinalSettlement{
    LXQDisposingLoadAlertViewController* LoadAlertViewController = [[LXQDisposingLoadAlertViewController alloc] init];
    LoadAlertViewController.modalPresentationStyle = 2;
    [self.indentController presentViewController:LoadAlertViewController animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LoadAlertViewController dismissViewControllerAnimated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LXQFinalSettlementViewController* FinalSettlementViewController = [[LXQFinalSettlementViewController alloc] init];
            FinalSettlementViewController.model = self.recevingIndentView.model;
            [self.indentController.navigationController pushViewController:FinalSettlementViewController animated:YES];
        });
    });
}

- (void)showSetOutBtn{
    self.setOutBtn.hidden = NO;
}

- (void)hideSetOutBtn{
    self.setOutBtn.hidden = YES;
}

- (void)showRecevingIndentView{
    self.recevingIndentView.hidden = NO;
    [UIView animateWithDuration:0.8 animations:^{
        self.recevingIndentView.y = MATCHSIZE(90);
    }];
}

- (void)hideRecevingIndentView{
    [UIView animateWithDuration:0.8 animations:^{
        self.recevingIndentView.y = 0;
    }completion:^(BOOL finished) {
        self.recevingIndentView.hidden = YES;
    }];
}

- (void)hideMapStateChange{
    [self hideRecevingIndentView];
    [self hideNavigationBtnAndDetermineBtn];
    [self hideRouteBetweenSelfAndUser];
    [self hidePassengerGetOnBtn];
    [self hideDrivingTipsView];
    [self hideNavigationBtnAndGetToPointBtn];
    [self hideSetOutBtn];
    [self hideDestinationTipsView];
}

- (void)hideIndentClassAndMapStateChange{
    [self hideWaitIndentAllView];
    [self hideInstantIndentAllView];
    [self hideReservationIndentAllView];
    [self hideNavigationBtnAndDetermineBtn];
    [self hidePassengerGetOnBtn];
    [self hideSetOutBtn];
    [self hideDrivingTipsView];
    [self hideNavigationBtnAndGetToPointBtn];
    [self hideDestinationTipsView];
}

//显示目的地按钮
- (void)showDestinationTipsView{
    self.destinationTipsView.hidden = NO;
}
//隐藏目的地按钮
- (void)hideDestinationTipsView{
    self.destinationTipsView.hidden = YES;
}
//显示乘客上车按钮
- (void)showPassengerGetOnBtn{
    self.passengerGetOn.hidden = NO;
}
//隐藏乘客上车按钮
- (void)hidePassengerGetOnBtn{
    self.passengerGetOn.hidden = YES;
}

- (void)showNavigationBtnAndDetermineBtn{
    self.startNavigation.hidden = NO;
    self.determinedBtn.hidden = NO;
}

- (void)showNavigationBtnAndGetToPointBtn{
    self.startNavigation.hidden = NO;
    self.getToPoint.hidden = NO;
}

- (void)hideNavigationBtnAndGetToPointBtn{
    self.startNavigation.hidden = YES;
    self.getToPoint.hidden = YES;
}


- (void)hideNavigationBtnAndDetermineBtn{
    self.startNavigation.hidden = YES;
    self.determinedBtn.hidden = YES;
}
//等车弹窗提示显示
- (void)showDrivingTipsView{
    self.drivingTipsView.hidden = NO;
    
}
//等车弹窗提示隐藏
- (void)hideDrivingTipsView{
    self.drivingTipsView.hidden = YES;
}

//从用户位置到用户目的地
- (void)showRouteBetweenUserAndDetermination{
    //测试------------------->
    NetWorkingManage *netManage = [NetWorkingManage shareInstance];
    
    [netManage getInstantIndentWithBlock:^(NSArray *array) {
        IndentData *model = array[0];
        
        //      CLLocationCoordinate2D startCoor = CLLocationCoordinate2DMake([model.startLocationLat doubleValue], [model.startLocationLon doubleValue]);
        
        CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake([model.endLocationLat doubleValue], [model.endLocationLon doubleValue]);
        
        AMPublicTools *tool = [AMPublicTools shareInstance];
        [tool showRouteWithMap:self.indentController.map.mapView StartCoordinate: self.indentController.map.userLocation.coordinate andDestinationCoordinate:endCoor andStrategy:5 block:nil];
        
        self.indentController.destinationPoint = [AMapNaviPoint locationWithLatitude:[model.endLocationLat floatValue] longitude:[model.endLocationLon floatValue]];
    }];
}

//预约单数据
- (void)showRouteBetweenUserAndDetermination2{
    //测试------------------->
    IndentData *model = self.arrayData[0];
    
    //      CLLocationCoordinate2D startCoor = CLLocationCoordinate2DMake([model.startLocationLat doubleValue], [model.startLocationLon doubleValue]);
    
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake([model.endLocationLat doubleValue], [model.endLocationLon doubleValue]);
    
    AMPublicTools *tool = [AMPublicTools shareInstance];
    [tool showRouteWithMap:self.indentController.map.mapView StartCoordinate: self.indentController.map.userLocation.coordinate andDestinationCoordinate:endCoor andStrategy:5 block:nil];
    
    self.indentController.destinationPoint = [AMapNaviPoint locationWithLatitude:[model.endLocationLat floatValue] longitude:[model.endLocationLon floatValue]];
}


//从当前位置到用户位置
- (void)showRouteBetweenSelfAndUser{
    //测试------------------->
    NetWorkingManage *netManage = [NetWorkingManage shareInstance];
    
    [netManage getInstantIndentWithBlock:^(NSArray *array) {
        IndentData *model = array[0];
        
        CLLocationCoordinate2D startCoor = CLLocationCoordinate2DMake([model.startLocationLat doubleValue], [model.startLocationLon doubleValue]);
        
        AMPublicTools *tool = [AMPublicTools shareInstance];
        [tool showRouteWithMap:self.indentController.map.mapView StartCoordinate: self.indentController.map.userLocation.coordinate andDestinationCoordinate:startCoor andStrategy:5 block:nil];
        
        self.indentController.destinationPoint = [AMapNaviPoint locationWithLatitude:[model.endLocationLat floatValue] longitude:[model.endLocationLon floatValue]];
    }];
}

//隐藏路径
- (void)hideRouteBetweenSelfAndUser{
    AMPublicTools *tool = [AMPublicTools shareInstance];
    [tool clearRouteWithBlock:nil];
}

@end
