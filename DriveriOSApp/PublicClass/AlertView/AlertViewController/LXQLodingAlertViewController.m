//
//  LXQLodingAlertViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/2/22.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQLodingAlertViewController.h"

@interface LXQLodingAlertViewController ()

@property(nonatomic, weak)UIImageView* bufferImg;

@property(nonatomic, weak)UILabel* loadLabel;

@end

@implementation LXQLodingAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = MATCHSIZE(8);
    
    self.view.backgroundColor = UIColorFromRGB(@"#ffffff");
    
    [self creatUI];
}

- (void)creatUI{
    UIImageView* bufferImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buffer-1"]];
    [self.view addSubview:bufferImg];
    self.bufferImg = bufferImg;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation* loadIMGAnimation = [CABasicAnimation animation];
        loadIMGAnimation.keyPath = @"transform.rotation.z";
        loadIMGAnimation.fromValue = @0;
        loadIMGAnimation.toValue = @(M_PI*2);
        loadIMGAnimation.repeatCount = MAXFLOAT;
        loadIMGAnimation.duration = 2.0;
        [self.bufferImg.layer addAnimation:loadIMGAnimation forKey:nil];
    });
    
    UILabel* loadLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#333333") fontSize:MATCHSIZE(32)];
    loadLabel.text = @"正在加载，请稍后";
    [self.view addSubview:loadLabel];
    self.loadLabel = loadLabel;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.bufferImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(100));
        make.centerY.offset(0);
    }];
    
    [self.loadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bufferImg.mas_right).offset(MATCHSIZE(44));
        make.top.offset(MATCHSIZE(24));
        make.centerY.offset(0);
    }];
}

@end
