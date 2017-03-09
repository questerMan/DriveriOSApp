//
//  LXQReservationSetOutFailedAlertViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/9.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQReservationSetOutFailedAlertViewController.h"

@interface LXQReservationSetOutFailedAlertViewController ()

@property(nonatomic, weak)UILabel* contentLabel;

@end

@implementation LXQReservationSetOutFailedAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}

- (void)creatUI{
    self.view.backgroundColor = UIColorFromRGB(@"#f0f0f0");
    self.view.layer.cornerRadius = MATCHSIZE(18);
    self.view.layer.masksToBounds = YES;
    
    UILabel* contentLabel = [FactoryClass labelWithTextColor:[UIColor blackColor] fontSize:MATCHSIZE(32)];
    contentLabel.text = @"无法开始出发，您还有个更早的预约单，赶紧去看看";
    contentLabel.numberOfLines = 0;
    [self.view addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(20));
        make.right.offset(MATCHSIZE(-20));
        make.top.offset(MATCHSIZE(40));
    }];
}

@end
