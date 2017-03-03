//
//  LXQRobIndentAlertSuccessedViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/3.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQRobIndentAlertSuccessedViewController.h"

@interface LXQRobIndentAlertSuccessedViewController ()

@property(nonatomic, weak)UIImageView* titleIMG;

@property(nonatomic, weak)UILabel* titleLabel;

@property(nonatomic, weak)UILabel* contentLabel;

@end

@implementation LXQRobIndentAlertSuccessedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
}

- (void)creatUI{
    self.view.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    self.view.layer.cornerRadius = MATCHSIZE(18);
    self.view.layer.masksToBounds = YES;
    
    UIImageView* titleIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smile"]];
    [self.view addSubview:titleIMG];
    self.titleIMG = titleIMG;
    
    UILabel* titleLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#8c8c8c") fontSize:MATCHSIZE(28)];
    titleLabel.text = @"恭喜你，抢单成功!";
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel* contentLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#8c8c8c") fontSize:MATCHSIZE(28)];
    contentLabel.text = @"请赶紧与客户联系，确认信息";
    [self.view addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.titleIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(MATCHSIZE(40));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleIMG.mas_bottom).offset(MATCHSIZE(40));
        make.centerX.offset(0);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(MATCHSIZE(20));
        make.centerX.offset(0);
    }];
}

@end
