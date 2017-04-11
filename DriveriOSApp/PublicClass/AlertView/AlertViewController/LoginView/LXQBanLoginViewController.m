//
//  LXQBanLoginViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/27.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQBanLoginViewController.h"

@interface LXQBanLoginViewController ()

@property(nonatomic, weak)UIImageView* bgImageV;

@property(nonatomic, weak)UIView* alertView;

@property(nonatomic, weak)UIImageView* titleImageV;

@property(nonatomic, weak)UILabel* titleLabel;

@property(nonatomic, weak)UIButton* closeBtn;

@end

@implementation LXQBanLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

- (void)creatUI{
    UIImageView* bgImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baseboard-1"]];
    [self.view addSubview:bgImageV];
    self.bgImageV = bgImageV;
    
    UIView* alertView = [[UIView alloc] init];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = MATCHSIZE(18);
    alertView.layer.masksToBounds = YES;
    [self.view addSubview:alertView];
    self.alertView = alertView;
    
    UIImageView* titleImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no"]];
    [self.alertView addSubview:titleImageV];
    self.titleImageV = titleImageV;
    
    UILabel* titleLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#1a1a1a") fontSize:MATCHSIZE(32)];
    titleLabel.text = @"对不起，您已被禁止登陆";
    [self.alertView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton* closeBtn = [UIButton buttonWithType:0];
    [closeBtn setBackgroundColor:UIColorFromRGB(@"#ff0000")];
    [closeBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"关闭" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(36)]}] forState:0];
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.layer.cornerRadius = MATCHSIZE(6);
    closeBtn.layer.masksToBounds = YES;
    [self.alertView addSubview:closeBtn];
    self.closeBtn = closeBtn;
}

- (void)viewDidLayoutSubviews{
    [self.bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(106));
        make.right.offset(MATCHSIZE(-106));
        make.top.offset(MATCHSIZE(430));
        make.height.offset(MATCHSIZE(392));
    }];
    
    [self.titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(36));
        make.centerX.offset(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImageV.mas_bottom).offset(MATCHSIZE(58));
        make.centerX.offset(0);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(MATCHSIZE(50));
        make.left.offset(MATCHSIZE(150));
        make.right.offset(MATCHSIZE(-150));
        make.bottom.offset(MATCHSIZE(-40));
    }];
}

- (void)closeBtnClick :(UIButton*)sender{
    if (_closeBtnClick) {
        _closeBtnClick();
    }
}

@end
