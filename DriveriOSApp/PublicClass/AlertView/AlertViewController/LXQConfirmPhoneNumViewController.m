//
//  LXQConfirmPhoneNumViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/14.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQConfirmPhoneNumViewController.h"

@interface LXQConfirmPhoneNumViewController ()

@property(nonatomic, weak)UILabel* titleLabel;

@property(nonatomic, weak)UILabel* contentLabel;

@property(nonatomic, weak)UILabel* phoneNumLabel;

@property(nonatomic, weak)UIButton* confirmBtn;

@property(nonatomic, weak)UIButton* cancelBtn;

@property(nonatomic, weak)UIView* upLine;

@property(nonatomic, weak)UIView* middleLine;

@end

@implementation LXQConfirmPhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = MATCHSIZE(18);
    self.view.layer.masksToBounds = YES;
    
    [self creatUI];
}

- (void)creatUI{
    UILabel* titleLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#ff6d00") fontSize:MATCHSIZE(32)];
    titleLabel.text = @"确认手机号码";
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel* contentLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#333333") fontSize:MATCHSIZE(28)];
    contentLabel.text = @"请确认手机号码，我们将以短信方式发送验证码到这个号码:";
    contentLabel.numberOfLines = 0;
    [self.view addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    UILabel* phoneNumLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#333333") fontSize:MATCHSIZE(28)];
    phoneNumLabel.text = @"18825072827";
    [self.view addSubview:phoneNumLabel];
    self.phoneNumLabel = phoneNumLabel;
    
    UIButton* confirmBtn = [UIButton buttonWithType:0];
    [confirmBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"确定" attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00"),NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(32)]}] forState:0];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    self.confirmBtn = confirmBtn;
    
    UIButton* cancelBtn = [UIButton buttonWithType:0];
    [cancelBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"取消" attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(@"#cccccc"),NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(32)]}] forState:0];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:1<<6];
    [self.view addSubview:cancelBtn];
    self.cancelBtn = cancelBtn;
    
    UIView* upLine = [[UIView alloc] init];
    upLine.backgroundColor = UIColorFromRGB(@"#cccccc");
    [self.view addSubview:upLine];
    self.upLine = upLine;
    
    UIView* middleLine = [[UIView alloc] init];
    middleLine.backgroundColor = UIColorFromRGB(@"#cccccc");
    [self.view addSubview:middleLine];
    self.middleLine = middleLine;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(30));
        make.centerX.offset(0);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(MATCHSIZE(30));
        make.centerX.offset(0);
        make.width.offset(MATCHSIZE(400));
    }];
    
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(MATCHSIZE(20));
        make.centerX.offset(0);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.bottom.offset(0);
        make.width.offset(MATCHSIZE(223));
        make.height.offset(MATCHSIZE(72));
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.bottom.offset(0);
        make.width.offset(MATCHSIZE(223));
        make.height.offset(MATCHSIZE(72));
    }];
    
    [self.upLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.equalTo(self.confirmBtn.mas_top);
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.confirmBtn.mas_right);
        make.right.equalTo(self.cancelBtn.mas_left);
        make.top.equalTo(self.upLine.mas_bottom);
        make.bottom.offset(0);
    }];
}

- (void)cancelBtnClick:(UIButton*)sender{
    if (self.cancelBtnClick) {
        self.cancelBtnClick();
    }
}

- (void)confirmBtnClick:(UIButton*)sender{
    if (self.confirmBtnClick) {
        self.confirmBtnClick();
    }
}
@end
