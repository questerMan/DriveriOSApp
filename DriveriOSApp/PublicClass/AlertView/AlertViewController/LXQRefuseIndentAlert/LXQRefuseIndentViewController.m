//
//  LXQRefuseIndentViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/1/13.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQRefuseIndentViewController.h"
#import "LXQRefuseIndentItem.h"
#import "LXQTableViewCell.h"
static NSString* ID = @"refuseIndent";
@interface LXQRefuseIndentViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView* tableView;

@property (nonatomic, strong) NSArray* refuseReasonItemArr;

@property (nonatomic, weak) UILabel* titleLabel;

@property (nonatomic, weak) UIImageView* titleImageV;

@end

@implementation LXQRefuseIndentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableView];
    
    [self setTitleLabel];
    
    [self setTitleImageV];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.view.frame = CGRectMake(MATCHSIZE(0), MATCHSIZE(0), SCREEN_W - MATCHSIZE(40),SCREEN_H - MATCHSIZE(90));
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(55));
        make.right.offset(-MATCHSIZE(55));
        make.bottom.equalTo(self.view.mas_bottom).offset(- MATCHSIZE(30));
        make.top.equalTo(self.view.mas_top).offset(MATCHSIZE(220));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(self.tableView.mas_top).offset(-MATCHSIZE(30));
    }];
    
    [self.titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(MATCHSIZE(75));
        make.height.offset(MATCHSIZE(75));
        make.centerX.offset(0);
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-MATCHSIZE(20));
    }];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    self.view.frame = CGRectMake(MATCHSIZE(20), MATCHSIZE(30), SCREEN_W - MATCHSIZE(40), SCREEN_H - MATCHSIZE(50));
}

- (NSArray *)refuseReasonItemArr
{
    NSArray* refuseReasonArr = @[@"正在吃饭",@"客户取消订单",@"车辆加油",@"平台派单太远",@"道路拥挤",@"车辆故障或事故",@"其它原因"];
    NSMutableArray* temp = [NSMutableArray array];
    for (NSString* string in refuseReasonArr) {
        [temp addObject:[LXQRefuseIndentItem LXQRefuseIndentItemWithTitle:string]];
    }
    self.refuseReasonItemArr = temp;
    return _refuseReasonItemArr;
}

- (void)setTitleLabel{
    UILabel* title = [[UILabel alloc] init];
    [self.view addSubview:title];
    title.text = @"为什么不接单";
    [title sizeToFit];
//    CGRect frame = title.frame;
//    frame.origin = CGPointMake(MATCHSIZE(220), MATCHSIZE(150));
//    title.frame = frame;
    self.titleLabel = title;
}

- (void)setTitleImageV{
    UIImageView* imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"why"]];
    [self.view addSubview:imageV];
//    imageV.frame = CGRectMake(MATCHSIZE(300), MATCHSIZE(30), MATCHSIZE(75), MATCHSIZE(75));
    self.titleImageV = imageV;
}

- (void)setTableView{
    UITableView* tableView = [[UITableView alloc] init];

    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[LXQTableViewCell class] forCellReuseIdentifier:ID];
    tableView.rowHeight = MATCHSIZE(100);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.scrollEnabled = NO;
//    tableView.frame = CGRectMake(MATCHSIZE(50), MATCHSIZE(215), self.view.frame.size.width - MATCHSIZE(100), MATCHSIZE(950));
    tableView.tableFooterView = [self tableFootView];
    self.tableView = tableView;
}

- (UIView *)tableFootView{
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, 0, MATCHSIZE(210));
    UIButton* tableFootViewBtn = [UIButton buttonWithType:0];
    [tableFootViewBtn setTitle:@"提交" forState:UIControlStateNormal];
    tableFootViewBtn.backgroundColor = [UIColor lightGrayColor];
    [tableFootViewBtn addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:tableFootViewBtn];
    [tableFootViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(0);
        make.width.offset(200);
    }];
    return view;
}

- (void)submitClick{
    
    self.closeAlert();
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.refuseReasonItemArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXQTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    LXQRefuseIndentItem* item = self.refuseReasonItemArr[indexPath.row];
    cell.item = item;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
