//
//  LXQRobIndentAlertFailedViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/3.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQRobIndentAlertFailedViewController.h"

@interface LXQRobIndentAlertFailedViewController ()

@property(nonatomic, weak)UIImageView* titleIMG;

@property(nonatomic, weak)UILabel* titleLabel;

@end

@implementation LXQRobIndentAlertFailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}

- (void)creatUI{
    
    self.view.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    self.view.layer.cornerRadius = MATCHSIZE(18);
    self.view.layer.masksToBounds = YES;
    
    UIImageView* titleIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sad"]];
    [self.view addSubview:titleIMG];
    self.titleIMG = titleIMG;
    
    UILabel* titleLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#8c8c8c") fontSize:MATCHSIZE(28)];
    titleLabel.text = @"已使用洪荒之力,但没抢成功,\n感觉错失了几个亿...";
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.titleIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(40));
        make.centerX.offset(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleIMG.mas_bottom).offset(MATCHSIZE(36));
        make.width.offset(MATCHSIZE(360));
        make.centerX.offset(0);
    }];
}

@end
