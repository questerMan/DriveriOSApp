//
//  LXQSucceedChangeViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/15.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQSucceedChangeViewController.h"

@interface LXQSucceedChangeViewController ()

@property(nonatomic, weak)UIImageView* titleImg;

@property(nonatomic, weak)UILabel* contentLabel;

@end

@implementation LXQSucceedChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = MATCHSIZE(18);
    self.view.layer.masksToBounds = YES;
    
    [self creatUI];
}

-(void)creatUI{
    UIImageView* titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"achieve"]];
    [self.view addSubview:titleImg];
    self.titleImg = titleImg;
    
    UILabel* contentLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#333333") fontSize:MATCHSIZE(28)];
    contentLabel.text = @"您已成功更换手机号码，下次登录记得使用新号码，一个月只能更换一次!";
    contentLabel.numberOfLines = 0;
    [self.view addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(20));
        make.centerX.offset(0);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImg.mas_bottom).offset(MATCHSIZE(15));
        make.centerX.offset(0);
        make.width.offset(MATCHSIZE(370));
    }];
}

@end
