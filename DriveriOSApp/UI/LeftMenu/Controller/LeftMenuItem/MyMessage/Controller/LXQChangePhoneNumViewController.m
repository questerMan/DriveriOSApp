//
//  LXQChangePhoneNumViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/13.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQChangePhoneNumViewController.h"

@interface LXQChangePhoneNumViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)UIBarButtonItem* nextItem;

@property(nonatomic, weak)UILabel* numberLabel;

@property(nonatomic, weak)UILabel* tipsLabel;

@property(nonatomic, weak)UIView* numBg;

@property(nonatomic, weak)UIView* numBgDownLine;

@property(nonatomic, weak)UITextField* numTeF;

@end

@implementation LXQChangePhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    
    [self creatNAV];
    
    [self creatUI];
}

- (void)creatUI{
    
    UILabel* numberLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#333333") fontSize:MATCHSIZE(32)];
    numberLabel.text = @"您当前的手机号码是 18825072827";
    [self.view addSubview:numberLabel];
    self.numberLabel = numberLabel;
    
    UILabel* tipsLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#cccccc") fontSize:MATCHSIZE(26)];
    tipsLabel.text = @"更换手机，不影响账号内容和数据，下次可以使用新手机登录";
    tipsLabel.numberOfLines = 0;
    [self.view addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
    
    UIView* numBg = [[UIView alloc] init];
    numBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:numBg];
    self.numBg = numBg;
    
    UIView* numBgDownLine = [[UIView alloc] init];
    numBgDownLine.backgroundColor = UIColorFromRGB(@"#cccccc");
    [self.view addSubview:numBgDownLine];
    self.numBgDownLine = numBgDownLine;
    
    UITextField* numTeF = [FactoryClass textFieldWithFrame:CGRectZero placeholder:@"请输入手机号" placeholderColor:UIColorFromRGB(@"#cccccc") textColor:UIColorFromRGB(@"#333333") backgroundColor:nil textAlignment:NSTextAlignmentCenter cornerRadius:0 itemImage:nil keyboardType:UIKeyboardTypeNumberPad];
    numTeF.delegate = self;
    [numBg addSubview:numTeF];
    self.numTeF = numTeF;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(112));
        make.centerX.offset(0);
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberLabel.mas_bottom).offset(MATCHSIZE(44));
        make.centerX.offset(0);
        make.width.offset(MATCHSIZE(540));
    }];
    
    [self.numBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(MATCHSIZE(80));
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(80));
    }];
    
    [self.numBgDownLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numBg.mas_bottom).offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.numTeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.offset(MATCHSIZE(330));
        make.height.offset(MATCHSIZE(45));
    }];
}

- (void)creatNAV{
    
    self.title = @"更换手机号";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(leftBtnClick)];
    self.navigationItem.leftBarButtonItem.tintColor = UIColorFromRGB(@"#333333");
    
    UIBarButtonItem* nextItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:0 target:self action:@selector(nextBtnClick)];
    nextItem.tintColor = UIColorFromRGB(@"#cccccc");
    nextItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = nextItem;
    self.nextItem = nextItem;
}

- (void)nextBtnClick{
    AlertView* alertV = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeConfirmPhoneNumAlert];
    __weak typeof(AlertView*) weakSelf = alertV;
    alertV.confirmPhoneNumViewController.confirmBtnClick = ^{
        [weakSelf alertViewCloseWithBlock:nil];
        AlertView* alertView = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeInputVerificationAlert];
        
        [alertView alertViewShow];
    };
    [alertV alertViewShow];
    [self.numTeF resignFirstResponder];
}

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location == 10) {
        self.nextItem.tintColor = UIColorFromRGB(@"#333333");
        self.nextItem.enabled = YES;
    }else{
        self.nextItem.tintColor = UIColorFromRGB(@"#cccccc");
        self.nextItem.enabled = NO;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    self.nextItem.tintColor = UIColorFromRGB(@"#cccccc");
    self.nextItem.enabled = NO;
 
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.numTeF resignFirstResponder];
}

@end
