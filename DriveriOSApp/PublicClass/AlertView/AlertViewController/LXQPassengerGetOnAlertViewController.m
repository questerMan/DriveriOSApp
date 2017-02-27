//
//  LXQPassengerGetOnAlertViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/2/24.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQPassengerGetOnAlertViewController.h"

@interface LXQPassengerGetOnAlertViewController ()

@property(nonatomic, weak)UILabel* titleLabel;

@property(nonatomic, weak)UIButton* okBtn;

@property(nonatomic, weak)UIButton* cancelBtn;

@end

@implementation LXQPassengerGetOnAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}

- (void)creatUI{
    
    self.view.backgroundColor = UIColorFromRGB(@"#f0f0f0");
    self.view.layer.cornerRadius = MATCHSIZE(18);
    
    UILabel* titleLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#333333") fontSize:MATCHSIZE(32)];
    titleLabel.text = @"请确认乘客上车，乘客会投诉未上车就开始计费的行为！";
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton* okBtn = [UIButton buttonWithType:0];
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"确定" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(32)], NSForegroundColorAttributeName : UIColorFromRGB(@"ffffff")}];
    [okBtn setAttributedTitle:str forState:0];
    [okBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    okBtn.backgroundColor = UIColorFromRGB(@"#ff6d00");
    okBtn.layer.cornerRadius = MATCHSIZE(6);
    [self.view addSubview:okBtn];
    self.okBtn = okBtn;
    
    UIButton* cancelBtn = [UIButton buttonWithType:0];
    NSMutableAttributedString* str2 = [[NSMutableAttributedString alloc] initWithString:@"取消" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(32)], NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00")}];
    [cancelBtn setAttributedTitle:str2 forState:0];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.backgroundColor = UIColorFromRGB(@"#ffffff");
    cancelBtn.layer.cornerRadius = MATCHSIZE(6);
    [self.view addSubview:cancelBtn];
    self.cancelBtn = cancelBtn;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(25));
        make.right.offset(MATCHSIZE(-25));
        make.top.offset(MATCHSIZE(40));
    }];
    
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(20));
        make.bottom.offset(MATCHSIZE(-30));
        make.width.offset(MATCHSIZE(165));
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(MATCHSIZE(-20));
        make.bottom.offset(MATCHSIZE(-30));
        make.width.offset(MATCHSIZE(165));
    }];
}

- (void)okBtnClick:(UIButton *)sender{
    if (_okBtnClick) {
        _okBtnClick();
    }
}

- (void)cancelBtnClick:(UIButton *)sender{
    if (_cancelBtnClick) {
        _cancelBtnClick();
    }
}

@end
