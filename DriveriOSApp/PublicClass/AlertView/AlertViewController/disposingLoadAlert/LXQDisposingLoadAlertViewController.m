//
//  LXQDisposingLoadAlertViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/2/13.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQDisposingLoadAlertViewController.h"

@interface LXQDisposingLoadAlertViewController ()

@property(nonatomic, weak)UILabel* textLabel;

@property(nonatomic, weak)UIImageView* loadIMG;

@end

@implementation LXQDisposingLoadAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(245, 245, 245, 1);
    
    [self creatUI];
}

- (void)creatUI{
    UILabel* textLabel = [[UILabel alloc] init];
    textLabel.text = @"正在处理，请稍后";
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:32];
    textLabel.textColor = COLOR(114, 114, 114, 1);
    [self.view addSubview:textLabel];
    self.textLabel = textLabel;
    
    UIImageView* loadIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buffer"]];
    [self.view addSubview:loadIMG];
    self.loadIMG = loadIMG;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CABasicAnimation* loadIMGAnimation = [CABasicAnimation animation];
        loadIMGAnimation.keyPath = @"transform.rotation.z";
        loadIMGAnimation.fromValue = @0;
        loadIMGAnimation.toValue = @(M_PI*2);
        loadIMGAnimation.repeatCount = MAXFLOAT;
        loadIMGAnimation.duration = 2.0;
        [self.loadIMG.layer addAnimation:loadIMGAnimation forKey:nil];
    });
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.loadIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(515));
        make.left.offset(MATCHSIZE(275));
        make.right.offset(MATCHSIZE(-275));
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.loadIMG.mas_bottom).offset(MATCHSIZE(77));
        make.width.equalTo(self.textLabel.mas_height);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
