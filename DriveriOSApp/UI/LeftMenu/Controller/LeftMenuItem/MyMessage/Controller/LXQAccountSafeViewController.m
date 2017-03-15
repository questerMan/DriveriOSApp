//
//  LXQAccountSafeViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/13.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQAccountSafeViewController.h"
#import "LXQMyMessageItem.h"
#import "LXQMyMessageGroupItem.h"
#import "LXQMyMessageTableViewCell.h"
#import "LXQChangePhoneNumViewController.h"
static NSString* myMessage = @"myMessage";
@interface LXQAccountSafeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, weak)UITableView* tableView;

@property (nonatomic, strong) NSMutableArray *myMessageItemArr;

@end

@implementation LXQAccountSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    [self setGroup0];
    
    [self creatNAV];
    
    [self creatUI];
}

- (NSMutableArray *)myMessageItemArr{
    if (!_myMessageItemArr) {
        _myMessageItemArr = [NSMutableArray array];
    }
    return _myMessageItemArr;
}

- (void)setGroup0{
    LXQMyMessageGroupItem* groupItem1 = [[LXQMyMessageGroupItem alloc] init];
    LXQMyMessageItem* item0 = [LXQMyMessageItem myMessageItemWithtitleLabel:@"手机号" contentLabel:nil :^{[self.navigationController pushViewController:[[LXQChangePhoneNumViewController alloc] init] animated:YES];}];
    item0.isLastCell = NO;
    LXQMyMessageItem* item1 = [LXQMyMessageItem myMessageItemWithtitleLabel:@"密码" contentLabel:nil :nil];
    item1.isLastCell = YES;
    groupItem1.groupItemArr = @[item0,item1];
    groupItem1.cellHeight = MATCHSIZE(20);
    [self.myMessageItemArr addObject:groupItem1];
}

- (void)creatNAV{
    
    self.title = @"账号安全";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_"] style:0 target:self action:@selector(leftBtnClick)];
}

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatUI{
    UITableView* tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    tableView.separatorStyle = 0;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView registerClass:[LXQMyMessageTableViewCell class] forCellReuseIdentifier:myMessage];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.top.offset(0);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.myMessageItemArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    LXQMyMessageGroupItem* item = self.myMessageItemArr[section];
    return item.groupItemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXQMyMessageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:myMessage forIndexPath:indexPath];
    LXQMyMessageGroupItem* groupItem = self.myMessageItemArr[indexPath.section];
    LXQMyMessageItem* messageItem = groupItem.groupItemArr[indexPath.row];
    cell.item = messageItem;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    LXQMyMessageGroupItem* item = self.myMessageItemArr[section];
    return item.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return MATCHSIZE(80);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXQMyMessageTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.arrowBtnClick) {
        cell.arrowBtnClick();
    }
}


@end
