//
//  LYKMyMessage.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/28.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "MyMessage.h"

@interface MyMessage ()<UITableViewDelegate,UITableViewDataSource>
/** 头像 */
@property (nonatomic, strong) UIButton *headIMGBtn;

@property (nonatomic, strong) PublicTool *tool;

@property (nonatomic, strong) UIButton *exitBtn;

@end

@implementation MyMessage

- (PublicTool *)tool{
    if (!_tool) {
        _tool = [PublicTool shareInstance];
    }
    return _tool;
}

-(UIButton *)headIMGBtn{
    if (!_headIMGBtn) {
        _headIMGBtn = [FactoryClass buttonWithFrame:CGRectZero image:[UIImage imageNamed:@""]];
        _headIMGBtn.backgroundColor = [UIColor whiteColor];
    }
    return _headIMGBtn;
}

-(void)viewWillAppear:(BOOL)animated{
    
    //导航栏的状态
    [self changeNavigation];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_"] style:0 target:self action:@selector(leftBarButtonClick)];
}

- (void)leftBarButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    
    [self creatUI];
}

-(void)initData{
    
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"我的";
}

-(void)creatUI{
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, MATCHSIZE(80), SCREEN_W, SCREEN_H - MATCHSIZE(80)) style:0];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    UIButton* exitBtn = [UIButton buttonWithType:0];
    [exitBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"退出登录" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:36],NSForegroundColorAttributeName :[UIColor whiteColor]}] forState:0];
    [self.view addSubview:exitBtn];
    self.exitBtn = exitBtn;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (void)addHeadIMGBtn{
    //获取头像
    NSData *headData = [CacheClass getAllDataFromYYCacheWithKey:HeadIMG_KEY];
    if (headData != nil) {
        UIImage *image = [UIImage imageWithData:headData];
        [self.headIMGBtn setImage:image forState:UIControlStateNormal];
    }
    
    [self.view addSubview:self.headIMGBtn];
    
    
    @weakify(self);
    
    //头像点击事件
    [[self.headIMGBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        
        UIButton *headBtn = (UIButton *)x;
        
        [self.tool putAlertViewWithViewController:self andPicBlock:^(UIImage *image) {
            [headBtn setImage:image forState:UIControlStateNormal];
            NSData *dataIMG = UIImagePNGRepresentation(image);
            //缓存
            [CacheClass cacheFromYYCacheWithValue:dataIMG AndKey:HeadIMG_KEY];
            
            //发送通知修改头像（在leftMian头部view接收该通知） 测试*************************
            [[NSNotificationCenter defaultCenter] postNotificationName:@"headIMG" object:nil userInfo:@{@"headIMG":dataIMG}];
        }];
    }];
}

@end
