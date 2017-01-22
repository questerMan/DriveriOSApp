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
#import "LXQRecevingIndentView.h"
static NSTimeInterval acceptIndentCount;

@interface IndentPublicViewTools()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NetWorkingManage *netWorkingManage;

@property (nonatomic, weak) NSTimer* acceptIndentTimer;

@property (nonatomic, weak) UIButton* determinedBtn;

@property (nonatomic, weak) LXQRecevingIndentView* recevingIndentView;

@end

//标志Yes已经点击接单按钮在此过程中保持接单倒计时定时器不会中断而重启  yes定时器启动 NO定时器关闭
//static BOOL timeFlag = NO;

@implementation IndentPublicViewTools

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(MATCHSIZE(0), MATCHSIZE(80),SCREEN_W, SCREEN_H - MATCHSIZE(90+44)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = YES;
        _tableView.backgroundColor = [UIColor clearColor];

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
        _startNavigation = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(40),SCREEN_H - MATCHSIZE(60) - MATCHSIZE(20) - StatusBar_H -MATCHSIZE(100), (SCREEN_W - MATCHSIZE(40)*3)/2, MATCHSIZE(60)) Title:@"开始导航" backGround:[UIColor grayColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(8)];
        _startNavigation.hidden = YES;
    }
    return _startNavigation;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(40)*2 + (SCREEN_W - MATCHSIZE(40)*3)/2,SCREEN_H - MATCHSIZE(60) - MATCHSIZE(20) - StatusBar_H -MATCHSIZE(100), (SCREEN_W - MATCHSIZE(40)*3)/2, MATCHSIZE(60)) Title:@"取消" backGround:[UIColor grayColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(8)];
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

- (LXQRecevingIndentView *)recevingIndentView
{
    if (!_recevingIndentView) {
        LXQRecevingIndentView* recevingView = [[LXQRecevingIndentView alloc] initWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(90), SCREEN_W - MATCHSIZE(40), MATCHSIZE(240))];
        recevingView.layer.cornerRadius = MATCHSIZE(8);
        recevingView.layer.masksToBounds = YES;
        recevingView.hidden = YES;
        [self.indentController.view addSubview:recevingView];
        _recevingIndentView = recevingView;
    }
    return _recevingIndentView;
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

#pragma mark - 等单
-(void)addWaitIndentWithIndent:(UIViewController *)indent{
    
    [indent.view addSubview:self.seachTextF];
    
    //创建导航按钮
    [indent.view addSubview:self.startNavigation];
    
    //创建取消按钮
    [indent.view addSubview:self.cancelBtn];
    
    [self buttonOfIndent];
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
    
    [self.acceptIndentTimer fire];
    
    [[self.acceptIndentBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self presentOrderReceiving];
        //按钮状态显示“接单”
        [self.acceptIndentBtn setTitle:@"接单" forState:UIControlStateNormal];
        //取消定时器
        [self.acceptIndentTimer invalidate];
        self.acceptIndentTimer = nil;
    }];
    
    [self.acceptIndentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(indent.view).offset(0);
        make.bottom.equalTo(indent.view).offset(MATCHSIZE(-75));
        make.width.offset(MATCHSIZE(600));
        make.height.offset(MATCHSIZE(80));
    }];
    //获取即时单数据
    [self getstantIndentData];
    
}

- (void)presentOrderReceiving{
    AlertView *alert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeCenterAlertInfo];
    [alert alertViewShowTitle:@"接单成功!正在拨打乘客的电话，请检查车上服务用品，尽快前往上车点。" textColor:[UIColor blackColor]];

    [self.acceptIndentTimer invalidate];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert alertViewCloseWithBlock:nil];
        [self changeMapStateWithMapIndentState:MapIndentStateHaveIndent];
    });
}

- (void)showRouteBetweenSelfAndUser{
    
}

- (void)presentRefuseIndent
{
    AlertView* alertV = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeDeleteIndentAlert];
    [alertV alertViewShow];
    
    [self.acceptIndentTimer invalidate];
    self.acceptIndentTimer = nil;
}

//获取当前可视控制器
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
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
    

    //获取预约单table数据
    [self getReservationData];
    
    [self.tableView reloadData];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = MATCHSIZE(310);
    [indent.view addSubview:self.tableView];
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
    
    [self showHint:@"页面未搭建完成"];
//    IndentData* data = self.arrayData[indexPath.row];
//    [self.arrayData removeAllObjects];
//    [self.arrayData addObject:data];
//    [tableView reloadData];
}

#pragma mark - 隐藏预约单页面的view
-(void)hideReservationIndentAllView{
    
    [UIView animateWithDuration:0.8 animations:^{
        self.tableView.y = -(SCREEN_H - MATCHSIZE(90+44));
        
    } completion:^(BOOL finished) {
        self.tableView.hidden = YES;

    }];
}

#pragma mark - 显示预约单页面的view
-(void)showReservationIndentAllView{

    self.tableView.hidden = NO;
    
    [UIView animateWithDuration:0.8 animations:^{
        self.tableView.y = MATCHSIZE(90);

    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - tab点击显示相应的View
-(void)implementAllMethodWithIndent:(int)type andIndent:(UIViewController *)indent{
    
    [self hideMapStateChange];
    // 点击取消第一响应
    [self.seachTextF resignFirstResponder];
    
    switch (type) {
        case 0:
            //显示
            [self addWaitIndentWithIndent:indent];//已经加载
            [self showWaitIndentAllView];
            //隐藏
            [self hideReservationIndentAllView];
            [self hideInstantIndentAllView];
            break;
        case 1:
            //显示
            [self addInstantIndentWithIndent:indent];
            [self showInstantIndentAllView];
            //非正确监听位置
            self.indentController.map.MapIndentState = MapIndentStateWaitingList;
            //隐藏
            [self hideReservationIndentAllView];
            [self hideWaitIndentAllView];
            break;
        case 2:
            //显示
            [self addReservationIndentWithIndent:indent];
            [self showReservationIndentAllView];
            //隐藏
            [self hideWaitIndentAllView];
            [self hideInstantIndentAllView];
            break;
            
        default:
            [self hideIndentClass];
            break;
    }
}

//获取预约单table数据
-(void)getReservationData{
    [self.netWorkingManage getReservationIndentWithBlock:^(NSArray *array) {
        [self.arrayData removeAllObjects];
        [self.arrayData addObjectsFromArray:array];
    }];
}

//获取即时单数据
-(void)getstantIndentData{
    [self.netWorkingManage getInstantIndentWithBlock:^(NSArray *array) {
        self.instantHeadView.model = array[0];
//        [self.arrayData addObject:array[0]];
        self.recevingIndentView.model = array[0];
    }];
}

- (void)changeMapStateWithMapIndentState: (MapIndentState)mapIndentState{
    
    [self hideIndentClass];
    
    switch (mapIndentState) {
        case MapIndentStateWait:
            [self hideRecevingIndentView];
            break;
        case MapIndentStateWaitNavigation:
            [self hideRecevingIndentView];
            break;
        case MapIndentStateWaitingList:
            [self hideRecevingIndentView];
            break;
            //已接单
        case MapIndentStateHaveIndent:
            [self showRecevingIndentView];
            break;
        default:
            [self hideMapStateChange];
            break;
    }
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
}

- (void)hideIndentClass{
    [self hideWaitIndentAllView];
    [self hideInstantIndentAllView];
    [self hideReservationIndentAllView];
}

- (void)setNavigationBtnAndDetermineBtn{
    
}

@end
