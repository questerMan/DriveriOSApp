//
//  LXQResetPwdViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/2/20.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQResetPwdViewController.h"

@interface LXQResetPwdViewController ()

@property(nonatomic, weak)UILabel* tipsLabel;

@property(nonatomic, weak)UIView* phoneNumView;

@property(nonatomic, weak)UIView* pwdNumView;

@property(nonatomic, weak)UIView* confirmPwdNumView;

@property(nonatomic, weak)UILabel* phoneNumLabel;

@property(nonatomic, weak)UIView* phoneNumline;

@property(nonatomic, weak)UILabel* pwdNumLabel;

@property(nonatomic, weak)UIView* pwdNumline;

@property(nonatomic, weak)UILabel* confirmPwdNumLabel;

@end

@implementation LXQResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
    [self setupNav];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupNav{
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(40)],NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00")};
    self.title = @"重置密码";
    
    UIBarButtonItem* cancelItem = [[UIBarButtonItem alloc] init];
    
    self.navigationItem.backBarButtonItem = cancelItem;
}

- (void)cancelBtnClick{
    
}

- (void)creatUI{
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
}

@end
