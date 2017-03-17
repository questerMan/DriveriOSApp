//
//  LXQCustomerServiceViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/17.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQCustomerServiceViewController.h"

@interface LXQCustomerServiceViewController ()

@property(nonatomic, weak)UIImageView* titleImg;

@property(nonatomic, weak)UILabel* contentLabel;

@end

@implementation LXQCustomerServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"客服热线";
    self.view.backgroundColor = UIColorFromRGB(@"#f0f0f0");
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_"] style:0 target:self action:@selector(leftBtnClick)];
    self.navigationItem.leftBarButtonItem.tintColor = COLOR(154, 151, 151, 1);
    
    [self changeNavigation];
    
    [self creatUI];
}

- (void)leftBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)creatUI{
    UIImageView* titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"service"]];
    [self.view addSubview:titleImg];
    self.titleImg = titleImg;
    
    UILabel* contentLabel = [[UILabel alloc] init];
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"         如果您有任何问题，可以随时拨打我们的服务热线 020-88888888，我们会及时帮你解决的，感谢您的合作与谅解！" attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(@"333333"),NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(28)]}];
    [str addAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00"),NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(28)]} range:NSMakeRange(32, 12)];
    contentLabel.attributedText = str;
    contentLabel.numberOfLines = 0;
    [self.view addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(MATCHSIZE(300));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImg.mas_bottom).offset(MATCHSIZE(95));
        make.centerX.offset(0);
        make.width.offset(MATCHSIZE(560));
    }];
}

@end
