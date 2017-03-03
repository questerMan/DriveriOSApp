//
//  DeleteIndentAlert.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/13.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "DeleteIndentAlert.h"

@interface DeleteIndentAlert ()

@property (nonatomic, strong) UIImageView *headIMG;


@property (nonatomic, strong) NSMutableArray *arrayData;
@end

@implementation DeleteIndentAlert



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


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    
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
    self.headIMG = [FactoryClass imageViewWithFrame:CGRectMake(MATCHSIZE(300), MATCHSIZE(40), VIEW_W - MATCHSIZE(620), MATCHSIZE(80)) Image:[UIImage imageNamed:@"sad_"]];
    [self.view addSubview:self.headIMG];
    
    [self.headIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(MATCHSIZE(34));
        make.width.offset(MATCHSIZE(80));
        make.height.offset(MATCHSIZE(80));
    }];
    
    //页面头部大标题
    UILabel *titleLab = [FactoryClass labelWithText:@"拒接单理由" fontSize:MATCHSIZE(40) textColor:UIColorFromRGB(@"#333333") numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    titleLab.font = [UIFont boldSystemFontOfSize:MATCHSIZE(40)];
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(0);
        make.top.equalTo(self.headIMG.mas_bottom).offset(MATCHSIZE(30));
        make.width.offset(VIEW_W);
        make.height.offset(MATCHSIZE(33));
    }];
    
    //创建理由按钮项
    for (int i = 0 ; i < 7; i++) {
        UIButton *btn = [FactoryClass buttonWithTitle:self.arrayData[i] backGroundIMG:nil textColor:UIColorFromRGB(@"#808080") cornerRadius:MATCHSIZE(14)];
        btn.backgroundColor = UIColorFromRGB(@"#ffffff");
        [self.view addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).offset(MATCHSIZE(36+i*96));
            make.centerX.equalTo(self.view).offset(0);
            make.height.offset(MATCHSIZE(60));
            make.width.offset(MATCHSIZE(543));
        }];
    }
    
    //创建提交按钮
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setBackgroundColor:UIColorFromRGB(@"#ffffff")];
    [submitBtn setTitleColor:UIColorFromRGB(@"#ff6d00") forState:UIControlStateNormal];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.layer.cornerRadius = MATCHSIZE(40);
    submitBtn.layer.masksToBounds = YES;
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(self.view).offset(MATCHSIZE(-64));
        make.width.offset(MATCHSIZE(294));
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

@end
