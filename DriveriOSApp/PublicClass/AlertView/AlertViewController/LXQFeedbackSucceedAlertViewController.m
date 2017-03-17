//
//  LXQFeedbackSucceedAlertViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/17.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQFeedbackSucceedAlertViewController.h"

@interface LXQFeedbackSucceedAlertViewController ()

@property(nonatomic, weak)UIImageView* titleImg;

@property(nonatomic, weak)UILabel* contentLabel;

@end

@implementation LXQFeedbackSucceedAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.cornerRadius = MATCHSIZE(18);
    self.view.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
}

- (void)creatUI{
    
    UIImageView* titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"finish"]];
    [self.view addSubview:titleImg];
    self.titleImg = titleImg;
    
    UILabel* contentLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#333333") fontSize:MATCHSIZE(28)];
    contentLabel.text = @"非常感谢您在闲余时间提出宝贵意见，我们会及时反馈做出调整，感谢您的谅解与配合";
    contentLabel.numberOfLines = 0;
    [self.view addSubview: contentLabel];
    self.contentLabel = contentLabel;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(42));
        make.centerX.offset(0);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImg.mas_bottom).offset(MATCHSIZE(25));
        make.left.offset(MATCHSIZE(28));
        make.right.offset(MATCHSIZE(-28));
    }];
}

@end
