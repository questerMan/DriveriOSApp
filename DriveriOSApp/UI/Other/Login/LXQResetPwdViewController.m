//
//  LXQResetPwdViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/2/20.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQResetPwdViewController.h"

@interface LXQResetPwdViewController ()<UITextFieldDelegate>

@property(nonatomic, weak)UILabel* tipsLabel;

@property(nonatomic, weak)UIView* phoneNumView;

@property(nonatomic, weak)UIView* pwdNumView;

@property(nonatomic, weak)UIView* confirmPwdNumView;

@property(nonatomic, weak)UILabel* phoneNumLabel;

@property(nonatomic, weak)UIView* phoneNumline;

@property(nonatomic, weak)UITextField* phoneNumTeF;

@property(nonatomic, weak)UILabel* pwdNumLabel;

@property(nonatomic, weak)UIView* pwdNumline;

@property(nonatomic, weak)UIButton* pwdNumEyeBtn;

@property(nonatomic, weak)UITextField* pwdNumTeF;

@property(nonatomic, weak)UILabel* confirmPwdNumLabel;

@property(nonatomic, weak)UIView* confirmPwdNumline;

@property(nonatomic, weak)UIButton* confirmPwdNumEyeBtn;

@property(nonatomic, weak)UITextField* confirmNumTeF;

@property(nonatomic, strong)UIBarButtonItem* finishItem;

@end

@implementation LXQResetPwdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    
    [self creatUI];
    
    [self setupNav];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)creatUI{
    
    UILabel* tipsLabel = [FactoryClass labelWithText:@"提示：重置密码后，下次登录请使用新的密码!" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#cccccc") numberOfLine:0];
    [self.view addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
    
    UIView* phoneNumView = [[UIView alloc] init];
    phoneNumView.backgroundColor = UIColorFromRGB(@"#ffffff");
    [self.view addSubview:phoneNumView];
    self.phoneNumView = phoneNumView;
    
    UILabel* phoneNumLabel = [FactoryClass labelWithText:@"手机号" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#cccccc") numberOfLine:0];
    [self.phoneNumView addSubview:phoneNumLabel];
    self.phoneNumLabel = phoneNumLabel;
    
    UIView* phoneNumline = [[UIView alloc] init];
    phoneNumline.backgroundColor = UIColorFromRGB(@"#c4c4c4");
    [self.phoneNumView addSubview:phoneNumline];
    self.phoneNumline = phoneNumline;
    
    UITextField* phoneNumTeF = [FactoryClass textFieldWithFrame:CGRectZero placeholder:nil placeholderColor:nil textColor:UIColorFromRGB(@"#333333") backgroundColor:nil textAlignment:NSTextAlignmentCenter cornerRadius:0 itemImage:nil keyboardType:UIKeyboardTypeNumberPad];
    phoneNumTeF.delegate = self;
    [self.phoneNumView addSubview:phoneNumTeF];
    self.phoneNumTeF = phoneNumTeF;
    
    UIView* pwdNumView = [[UIView alloc] init];
    pwdNumView.backgroundColor = UIColorFromRGB(@"#ffffff");
    [self.view addSubview:pwdNumView];
    self.pwdNumView = pwdNumView;
    
    UILabel* pwdNumLabel = [FactoryClass labelWithText:@"密码" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#cccccc") numberOfLine:0];
    [self.pwdNumView addSubview:pwdNumLabel];
    self.pwdNumLabel = pwdNumLabel;
    
    UIView* pwdNumline = [[UIView alloc] init];
    pwdNumline.backgroundColor = UIColorFromRGB(@"#c4c4c4");
    [self.pwdNumView addSubview:pwdNumline];
    self.pwdNumline = pwdNumline;
    
    UIButton* pwdNumEyeBtn = [UIButton buttonWithType:0];
    [pwdNumEyeBtn setImage:[UIImage imageNamed:@"eyesReset"] forState:0];
    [pwdNumEyeBtn addTarget:self action:@selector(pwdNumEyeBtnClick) forControlEvents:UIControlEventTouchDown];
    [pwdNumEyeBtn addTarget:self action:@selector(pwdNumEyeBtnUp) forControlEvents:UIControlEventTouchUpInside];
    [self.pwdNumView addSubview:pwdNumEyeBtn];
    self.pwdNumEyeBtn = pwdNumEyeBtn;
    
    UITextField* pwdNumTeF = [FactoryClass textFieldWithFrame:CGRectZero placeholder:nil placeholderColor:nil textColor:UIColorFromRGB(@"#333333") backgroundColor:nil textAlignment:NSTextAlignmentCenter cornerRadius:0 itemImage:nil keyboardType:UIKeyboardTypeNumberPad];
    pwdNumTeF.secureTextEntry = YES;
    pwdNumTeF.delegate = self;
    [self.pwdNumView addSubview:pwdNumTeF];
    self.pwdNumTeF = pwdNumTeF;
    
    UIView* confirmPwdNumView = [[UIView alloc] init];
    confirmPwdNumView.backgroundColor = UIColorFromRGB(@"#ffffff");
    [self.view addSubview:confirmPwdNumView];
    self.confirmPwdNumView = confirmPwdNumView;
    
    UILabel* confirmPwdNumLabel = [FactoryClass labelWithText:@"确认密码" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#cccccc") numberOfLine:0];
    [self.confirmPwdNumView addSubview:confirmPwdNumLabel];
    self.confirmPwdNumLabel = confirmPwdNumLabel;
    
    UIButton* confirmPwdNumEyeBtn = [UIButton buttonWithType:0];
    [confirmPwdNumEyeBtn setImage:[UIImage imageNamed:@"eyesReset"] forState:0];
    [confirmPwdNumEyeBtn addTarget:self action:@selector(confirmPwdNumEyeBtnClick) forControlEvents:UIControlEventTouchDown];
    [confirmPwdNumEyeBtn addTarget:self action:@selector(confirmPwdNumEyeBtnUp) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmPwdNumView addSubview:confirmPwdNumEyeBtn];
    self.confirmPwdNumEyeBtn = confirmPwdNumEyeBtn;
    
    UITextField* confirmNumTeF = [FactoryClass textFieldWithFrame:CGRectZero placeholder:nil placeholderColor:nil textColor:UIColorFromRGB(@"#333333") backgroundColor:nil textAlignment:NSTextAlignmentCenter cornerRadius:0 itemImage:nil keyboardType:UIKeyboardTypeNumberPad];
    confirmNumTeF.secureTextEntry = YES;
    confirmNumTeF.delegate = self;
    [self.confirmPwdNumView addSubview:confirmNumTeF];
    self.confirmNumTeF = confirmNumTeF;
}

-(void)pwdNumEyeBtnClick{
    self.pwdNumTeF.secureTextEntry = NO;
}

-(void)pwdNumEyeBtnUp{
    self.pwdNumTeF.secureTextEntry = YES;
}

-(void)confirmPwdNumEyeBtnClick{
    self.confirmNumTeF.secureTextEntry = NO;
}

-(void)confirmPwdNumEyeBtnUp{
    self.confirmNumTeF.secureTextEntry = YES;
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(76) + MATCHSIZE(88));
        make.left.offset(MATCHSIZE(110));
    }];
    
    [self.phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(88) + MATCHSIZE(174));
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(80));
    }];
    
    [self.phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(28));
        make.left.offset(MATCHSIZE(26));
        make.bottom.offset(MATCHSIZE(-28));
    }];
    
    [self.phoneNumline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(28));
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.phoneNumTeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(20));
        make.bottom.offset(MATCHSIZE(-20));
        make.left.offset(MATCHSIZE(200));
        make.right.offset(MATCHSIZE(-200));
    }];
    
    [self.pwdNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumView.mas_bottom);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(80));
    }];
    
    [self.pwdNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(28));
        make.left.offset(MATCHSIZE(26));
        make.bottom.offset(MATCHSIZE(-28));
    }];
    
    [self.pwdNumline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(28));
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.pwdNumEyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(MATCHSIZE(-26));
        make.centerY.offset(0);
    }];
    
    [self.pwdNumTeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(20));
        make.bottom.offset(MATCHSIZE(-20));
        make.left.offset(MATCHSIZE(200));
        make.right.offset(MATCHSIZE(-200));
    }];
    
    [self.confirmPwdNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdNumView.mas_bottom);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(80));
    }];
    
    [self.confirmPwdNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(28));
        make.left.offset(MATCHSIZE(26));
        make.bottom.offset(MATCHSIZE(-28));
    }];
    
    [self.confirmPwdNumEyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(MATCHSIZE(-26));
        make.centerY.offset(0);
    }];
    
    [self.confirmNumTeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(20));
        make.bottom.offset(MATCHSIZE(-20));
        make.left.offset(MATCHSIZE(200));
        make.right.offset(MATCHSIZE(-200));
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (![self.phoneNumTeF.text isEqualToString:@""] && ![self.pwdNumTeF.text isEqualToString:@""] && ![self.confirmNumTeF.text isEqualToString:@""]) {
        self.finishItem.tintColor = UIColorFromRGB(@"#333333");
        self.finishItem.enabled = YES;
    }else{
        self.finishItem.tintColor = UIColorFromRGB(@"#cccccc");
        self.finishItem.enabled = NO;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    if (![self.phoneNumTeF.text isEqualToString:@""] && ![self.pwdNumTeF.text isEqualToString:@""] && ![self.confirmNumTeF.text isEqualToString:@""]) {
        self.finishItem.tintColor = UIColorFromRGB(@"#333333");
        self.finishItem.enabled = YES;
    }else{
        self.finishItem.tintColor = UIColorFromRGB(@"#cccccc");
        self.finishItem.enabled = NO;
    }
    return YES;
}

- (void)setupNav{
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(40)],NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00")};
    self.navigationItem.title = @"重置密码";
    
    UIBarButtonItem* cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(cancelBtnClick)];
    cancelItem.tintColor = UIColorFromRGB(@"#333333");
    
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    UIBarButtonItem* finishItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:0 target:self action:@selector(finishBtnClick)];
    finishItem.tintColor = UIColorFromRGB(@"#cccccc");
    finishItem.enabled = NO;
    
    self.navigationItem.rightBarButtonItem = finishItem;
    
    self.finishItem = finishItem;
}

- (void)cancelBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)finishBtnClick{
    
    //测试加载弹窗
    AlertView* alertV = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeLoadingAlert];
    [alertV alertViewShow];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertV alertViewCloseWithBlock:nil];
    });
}

@end
