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

@property(nonatomic, strong)UIBarButtonItem* finishItem;

@end

@implementation LXQResetPwdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    
    [self creatUI];
    
    [self setupNav];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)creatUI{
    
    UILabel* tipsLabel = [FactoryClass labelWithText:@"提示：重置密码后，下次登录请使用新的密码!" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#cccccc") numberOfLine:0];
    [self.view addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
    
//    UIView* phoneNumView = 
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(76) + MATCHSIZE(88));
        make.left.offset(MATCHSIZE(110));
    }];
    
    
}

- (void)setupNav{
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(40)],NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00")};
    self.navigationItem.title = @"重置密码";
    
    UIBarButtonItem* cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(cancelBtnClick)];
    cancelItem.tintColor = UIColorFromRGB(@"#333333");
    
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    UIBarButtonItem* finishItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:0 target:self action:@selector(finishBtnClick)];
    finishItem.tintColor = UIColorFromRGB(@"#cccccc");
    
    self.navigationItem.rightBarButtonItem = finishItem;
    
    self.finishItem = finishItem;
}

- (void)cancelBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)finishBtnClick{
    
}

@end
