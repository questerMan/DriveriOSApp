//
//  DeleteIndentAlert.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/13.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "DeleteIndentAlert.h"
#import "DeleteIndentCell.h"

@interface DeleteIndentAlert ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *headIMG;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayData;
@end

@implementation DeleteIndentAlert

/* 懒加载 */
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(MATCHSIZE(50), MATCHSIZE(220), VIEW_W - MATCHSIZE(136), VIEW_H - MATCHSIZE(360)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = MATCHSIZE(100);
        //去掉分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.layer.cornerRadius = MATCHSIZE(10);
        _tableView.layer.masksToBounds = YES;
        
    }
    return _tableView;
}

-(NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}

#pragma mark - tableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    DeleteIndentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[DeleteIndentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.titleLab.text = self.arrayData[indexPath.row];
    
    return cell;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(215, 215, 215, 1);
    
    //获取列表数据
    [self getDataArray];
    //创建UI界面
    [self creatUI];
    
    
}
//获取表格列表数据
-(void)getDataArray{
    [self.arrayData addObjectsFromArray:@[@"正在吃饭",@"客户取消订单",@"车辆加油",@"平台派单太远了",@"道路拥挤",@"车辆的故障或事故",@"其它原因"]];
}

-(void)creatUI{
    //页面顶部图像
    self.headIMG = [FactoryClass imageViewWithFrame:CGRectMake(MATCHSIZE(300), MATCHSIZE(40), VIEW_W - MATCHSIZE(620), MATCHSIZE(80)) Image:[UIImage imageNamed:@"item"]];
    [self.view addSubview:self.headIMG];
    
    [self.headIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(MATCHSIZE(40));
        make.width.offset(MATCHSIZE(78));
        make.height.offset(MATCHSIZE(78));
    }];
    
    //页面头部大标题
    UILabel *titleLab = [FactoryClass labelWithText:@"为什么改派单" fontSize:MATCHSIZE(40) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    titleLab.font = [UIFont boldSystemFontOfSize:MATCHSIZE(40)];
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(0);
        make.top.equalTo(self.headIMG.mas_bottom).offset(MATCHSIZE(35));
        make.width.offset(VIEW_W);
        make.height.offset(MATCHSIZE(45));
    }];

    //创建表格视图
    [self creatTableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(MATCHSIZE(50));
        make.right.equalTo(self.view).offset(MATCHSIZE(-50));
        make.bottom.equalTo(self.view).offset(MATCHSIZE(-38));
        make.top.equalTo(titleLab.mas_bottom).offset(MATCHSIZE(25));
    }];
    
    //创建提交按钮
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setBackgroundColor:[UIColor lightGrayColor]];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = MATCHSIZE(8);
    submitBtn.layer.masksToBounds = YES;
    [self.tableView addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.tableView).offset(MATCHSIZE(850));
        make.width.offset(MATCHSIZE(300));
        make.height.offset(MATCHSIZE(80));
    }];
    //提交按钮的点击事件
    [[submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self showHint:@"提交完成"];
        
        if ([_delegate respondsToSelector:@selector(closeAlertView)]) {
            [_delegate closeAlertView];
        }
        
    }];
    
    
    
}
#pragma mark -  创建表格视图
-(void)creatTableView{
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

@end
