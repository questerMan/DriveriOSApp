//
//  LYKLeftMenuMain.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/26.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "LeftMenuMain.h"
#import "LeftMainHeadView.h"
#import "LeftMainItemCell.h"

@interface LeftMenuMain ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayData;
@property (nonatomic, strong) NSMutableArray *arrayItemIMG;


@end

@implementation LeftMenuMain

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(MATCHSIZE(0), MATCHSIZE(0), MATCHSIZE(550), VIEW_H) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = MATCHSIZE(80);
        
        //去掉分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}
-(NSMutableArray *)arrayItemIMG{
    if (!_arrayItemIMG) {
        _arrayItemIMG = [NSMutableArray array];
    }
    return _arrayItemIMG;
}


-(void)viewWillAppear:(BOOL)animated{
    
    
}
-(void)loadData{
    
    [self.arrayData addObjectsFromArray:@[@"我的订单",@"消息通知",@"司机指南",@"离线地图",@"客服热线"]];

    [self.arrayItemIMG addObjectsFromArray:@[@"orders",@"guide",@"map",@"feedback",@"hot-line"]];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadData];
    
    [self creatTableView];
    
    [self versionInfo];
    
    
}
-(void)creatTableView{
        
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.scrollEnabled = NO; //设置tableview 不能滚动

    self.tableView.backgroundColor = UIColorFromRGB(@"#ffffff");
    
    self.tableView.rowHeight = MATCHSIZE(90);
    
    [self.view addSubview:self.tableView];
    
}

-(void)versionInfo{
    
    UILabel *lastVersionInfo = [FactoryClass labelWithText:@"Copyright © 2016-2017 Gaclixin All Rights Reserved" fontSize:MATCHSIZE(18) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    [self.view addSubview:lastVersionInfo];
    [lastVersionInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(self.view).offset(MATCHSIZE(-16));
        make.height.offset(MATCHSIZE(22));
        make.width.offset(self.view.frame.size.width);
    }];
    
    UILabel *secondVersionInfo = [FactoryClass labelWithText:@"广汽丽新 版权所有" fontSize:MATCHSIZE(22) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    [self.view addSubview:secondVersionInfo];
    [secondVersionInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(lastVersionInfo.mas_top).offset(MATCHSIZE(-16));
        make.height.offset(MATCHSIZE(22));
        make.width.offset(self.view.frame.size.width);
    }];
    
    UILabel *firstVersionInfo = [FactoryClass labelWithText:@"丽新专车 APP版本 2.0" fontSize:MATCHSIZE(22) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    [self.view addSubview:firstVersionInfo];
    [firstVersionInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(secondVersionInfo.mas_top).offset(MATCHSIZE(-16));
        make.height.offset(MATCHSIZE(22));
        make.width.offset(self.view.frame.size.width);
    }];}

#pragma mark tableView代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayData.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    
    LeftMainItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//    }
//    
//    cell.selectionStyle =UITableViewCellSelectionStyleNone;
//    
//    cell.textLabel.text = self.arrayData[indexPath.row];
//    
//    cell.textLabel.textColor = UIColorFromRGB(@"#8c8c8c");
//    
//    cell.imageView.image = [UIImage imageNamed:self.arrayItemIMG[indexPath.row]];
    if (!cell) {
        cell = [[LeftMainItemCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.itemIMG.image = [UIImage imageNamed:self.arrayItemIMG[indexPath.row]];
    cell.itemTitle.text = self.arrayData[indexPath.row];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return MATCHSIZE(294);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *cell = @"headCell";
    
    LeftMainHeadView *headCell = [tableView dequeueReusableCellWithIdentifier:cell];
    
    if (headCell == nil) {
        headCell = [[LeftMainHeadView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell];
    }
    
    [headCell getData];
    
    [headCell userIMGWithBlock:^{
        UINavigationController *myMessage = [[UINavigationController alloc] initWithRootViewController:[[MyMessage alloc] init]];
        
        [self presentFromViewController:self andToViewController:myMessage andAnimated:YES];
    }];
    
    
    return headCell;

}
//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UINavigationController *offlineNac = [[UINavigationController alloc] initWithRootViewController:[[OfflineDetailViewController alloc] init]];

    UINavigationController *myIndentNac = [[UINavigationController alloc] initWithRootViewController:[[MyIndent alloc] init]];
    
    UINavigationController *notifyNac = [[UINavigationController alloc] initWithRootViewController:[[Notify alloc] init]];

    UINavigationController *driverGuideNac = [[UINavigationController alloc] initWithRootViewController:[[DriverGuide alloc] init]];

    
    switch (indexPath.row) {
    
        case 0:
            [self presentFromViewController:self andToViewController:myIndentNac andAnimated:YES];
            break;
        case 1:
            [self presentFromViewController:self andToViewController:notifyNac andAnimated:YES];
            break;
            
        case 2:
            [self presentFromViewController:self andToViewController:driverGuideNac andAnimated:YES];
            break;
        case 3:
            [self presentFromViewController:self andToViewController:offlineNac andAnimated:YES];
            break;
        case 4:
            NSLog(@"-------------4");
            
            break;
            
        default:
            break;
    }
    

   //测试**********
    if (indexPath.row == 4) {
        
        AlertView *alert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeInstantIndentCommingAlert];
        [alert alertViewShow];
        
    }
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];

}



@end
