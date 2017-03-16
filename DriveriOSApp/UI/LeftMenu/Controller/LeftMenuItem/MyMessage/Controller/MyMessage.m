//
//  LYKMyMessage.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/28.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "MyMessage.h"
#import "LXQMyMessageItem.h"
#import "LXQMyMessageGroupItem.h"
#import "LXQMyMessageTableViewCell.h"
#import "LXQHeadImgTableViewCell.h"
#import "LXQAccountSafeViewController.h"
static NSString* headImg = @"HeadImg";
static NSString* myMessage = @"myMessage";
@interface MyMessage ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *myMessageItemArr;

@property (nonatomic, strong) UIButton *exitBtn;


@property (nonatomic, weak) UITableView* tableView;

@property (nonatomic, strong) PublicTool *tool;

@end

@implementation MyMessage
- (PublicTool *)tool{
    if (!_tool) {
        _tool = [PublicTool shareInstance];
    }
    return _tool;
}

- (NSMutableArray *)myMessageItemArr{
    if (!_myMessageItemArr) {
        _myMessageItemArr = [NSMutableArray array];
    }
    return _myMessageItemArr;
}

- (void)setMessageItemArr{
    [self setGroup0];
    [self setGroup1];
    [self setGroup2];
}

- (void)setGroup0{
    LXQMyMessageGroupItem* groupItem0 = [[LXQMyMessageGroupItem alloc] init];
    LXQMyMessageItem* item0 = [LXQMyMessageItem myMessageItemWithtitleLabel:@"头像" contentLabel:nil :nil];
    groupItem0.groupItemArr = @[item0];
    groupItem0.cellHeight = MATCHSIZE(20);
    [self.myMessageItemArr addObject:groupItem0];
}

- (void)setGroup1{
    LXQMyMessageGroupItem* groupItem1 = [[LXQMyMessageGroupItem alloc] init];
    LXQMyMessageItem* item0 = [LXQMyMessageItem myMessageItemWithtitleLabel:@"我的车辆" contentLabel:@"广汽丰田雷凌双擎" :nil];
    item0.isLastCell = NO;
    LXQMyMessageItem* item1 = [LXQMyMessageItem myMessageItemWithtitleLabel:@"账号安全" contentLabel:nil :^{[self.navigationController pushViewController:[[LXQAccountSafeViewController alloc] init] animated:YES];}];
    item1.isLastCell = YES;
    groupItem1.groupItemArr = @[item0,item1];
    groupItem1.cellHeight = MATCHSIZE(20);
    [self.myMessageItemArr addObject:groupItem1];
}

- (void)setGroup2{
    LXQMyMessageGroupItem* groupItem2 = [[LXQMyMessageGroupItem alloc] init];
    LXQMyMessageItem* item0 = [LXQMyMessageItem myMessageItemWithtitleLabel:@"给丽新好评" contentLabel:nil :nil];
    item0.isLastCell = NO;
    LXQMyMessageItem* item1 = [LXQMyMessageItem myMessageItemWithtitleLabel:@"关于丽新" contentLabel:nil :nil];
    item1.isLastCell = YES;
    groupItem2.groupItemArr = @[item0,item1];
    groupItem2.cellHeight = MATCHSIZE(20);
    [self.myMessageItemArr addObject:groupItem2];
}

-(void)viewWillAppear:(BOOL)animated{
    
    //导航栏的状态
    [self changeNavigation];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_"] style:0 target:self action:@selector(leftBarButtonClick)];
    self.navigationItem.leftBarButtonItem.tintColor = COLOR(154, 151, 151, 1);
}

- (void)leftBarButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    
    [self creatUI];
    
    [self setMessageItemArr];
    
    [self.tableView registerClass:[LXQMyMessageTableViewCell class] forCellReuseIdentifier:myMessage];
    [self.tableView registerClass:[LXQHeadImgTableViewCell class] forCellReuseIdentifier:headImg];
}

-(void)initData{
    
    self.view.backgroundColor = [UIColor blackColor];
    
}

-(void)creatUI{
    
    UITableView* tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    tableView.separatorStyle = 0;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIButton* exitBtn = [UIButton buttonWithType:0];
    [exitBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"退出登录" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(36)],NSForegroundColorAttributeName :[UIColor whiteColor]}] forState:0];
    exitBtn.backgroundColor = UIColorFromRGB(@"#ff6d00");
    [self.view addSubview:exitBtn];
    self.exitBtn = exitBtn;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
    
    [self.exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(MATCHSIZE(98));
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(MATCHSIZE(-50));
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
    if (indexPath.section == 0) {
        LXQHeadImgTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:headImg forIndexPath:indexPath];
        LXQMyMessageGroupItem* groupItem = self.myMessageItemArr[indexPath.section];
        LXQMyMessageItem* messageItem = groupItem.groupItemArr[indexPath.row];
        cell.item = messageItem;
        return cell;
    }
    
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
    if (indexPath.section == 0) {
        return MATCHSIZE(120);
    }
    return MATCHSIZE(80);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        [self.tool putAlertViewWithViewController:self andPicBlock:^(UIImage *image) {
            NSData *dataIMG = UIImagePNGRepresentation(image);
            //缓存
            [CacheClass cacheFromYYCacheWithValue:dataIMG AndKey:HeadIMG_KEY];
            
            //发送通知修改头像（在leftMian头部view接收该通知） 测试*************************
            [[NSNotificationCenter defaultCenter] postNotificationName:@"headIMG" object:nil userInfo:@{@"headIMG":dataIMG}];
            [[NSNotificationCenter defaultCenter] postNotificationName:headImg object:nil];
        }];
        
    }else{
        
        LXQMyMessageTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.arrowBtnClick) {
            cell.arrowBtnClick();
        }
    }
}

@end
