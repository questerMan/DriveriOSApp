//
//  LXQInputVerificationViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/14.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQInputVerificationViewController.h"

@interface LXQInputVerificationViewController ()<UITextFieldDelegate>

@property(nonatomic, weak)UILabel* titleLabel;

@property(nonatomic, strong)UITextField* inputTextField;

@property(nonatomic, weak)UIView* firstNumBg;

@property (nonatomic,strong) UIImageView *circleSmallView1;//小圆点

@property(nonatomic, weak)UIView* secondNumBg;

@property (nonatomic,strong) UIImageView *circleSmallView2;//小圆点

@property(nonatomic, weak)UIView* thirdNumBg;

@property (nonatomic,strong) UIImageView *circleSmallView3;//小圆点

@property(nonatomic, weak)UIView* fourthNumBg;

@property (nonatomic,strong) UIImageView *circleSmallView4;//

@end

@implementation LXQInputVerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = MATCHSIZE(18);
    self.view.layer.masksToBounds = YES;
    
    [self creatUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.inputTextField becomeFirstResponder];
}

-(UIImageView *)circleSmallView1{
    
    if (!_circleSmallView1) {
        _circleSmallView1 = [[UIImageView alloc] init];
        _circleSmallView1.image = [UIImage imageNamed:@"pwdIcon"];
        _circleSmallView1.tintColor = UIColorFromRGB(@"#ff6d00");
        _circleSmallView1.hidden = YES;
    }
    return _circleSmallView1;
    
}

-(UIImageView *)circleSmallView2{
    
    if (!_circleSmallView2) {
        _circleSmallView2 = [[UIImageView alloc]init];
        _circleSmallView2.image = [UIImage imageNamed:@"pwdIcon"];
        _circleSmallView2.tintColor = UIColorFromRGB(@"#ff6d00");
        _circleSmallView2.hidden = YES;
    }
    return _circleSmallView2;
    
}

-(UIImageView *)circleSmallView3{
    
    if (!_circleSmallView3) {
        _circleSmallView3 = [[UIImageView alloc]init];
        _circleSmallView3.image = [UIImage imageNamed:@"pwdIcon"];
        _circleSmallView3.tintColor = UIColorFromRGB(@"#ff6d00");
        _circleSmallView3.hidden = YES;
    }
    return _circleSmallView3;
    
}

-(UIImageView *)circleSmallView4{
    
    if (!_circleSmallView4) {
        _circleSmallView4 = [[UIImageView alloc]init];
        _circleSmallView4.image = [UIImage imageNamed:@"pwdIcon"];
        _circleSmallView4.tintColor = UIColorFromRGB(@"#ff6d00");
        _circleSmallView4.hidden = YES;
    }
    return _circleSmallView4;
    
}


-(UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_inputTextField addTarget:self action:@selector(inputTextChanged:) forControlEvents:UIControlEventEditingChanged];
        _inputTextField.tintColor = [UIColor clearColor];
        _inputTextField.textColor = [UIColor clearColor];
        _inputTextField.delegate = self;
    }
    
    return _inputTextField;
}

//密码文字改变
- (void)inputTextChanged:(UITextField *)textField{
    
//    //密码文字回调
//    if (self.passWordText) {
//        self.passWordText(textField.text);
//    }
    
    if (textField.text.length == 1) {
        self.circleSmallView1.hidden = NO;self.circleSmallView2.hidden = YES;
        self.circleSmallView3.hidden = YES;self.circleSmallView4.hidden = YES;
    }else if (textField.text.length == 2){
        self.circleSmallView1.hidden = NO;self.circleSmallView2.hidden = NO;
        self.circleSmallView3.hidden = YES;self.circleSmallView4.hidden = YES;
    }else if (textField.text.length == 3){
        self.circleSmallView1.hidden = NO;self.circleSmallView2.hidden = NO;
        self.circleSmallView3.hidden = NO;self.circleSmallView4.hidden = YES;
    }else if (textField.text.length == 4){
        self.circleSmallView1.hidden = NO;self.circleSmallView2.hidden = NO;
        self.circleSmallView3.hidden = NO;self.circleSmallView4.hidden = NO;
    }else if (textField.text.length == 0){
        self.circleSmallView1.hidden = YES;self.circleSmallView2.hidden = YES;
        self.circleSmallView3.hidden = YES;self.circleSmallView4.hidden = YES;
    }
    
    if (textField.text.length == 4) {
        if (self.fourthNumJump) {
            self.fourthNumJump();
        }
    }
}

- (void)creatUI{
    UILabel* titleLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#ff6d00") fontSize:MATCHSIZE(36)];
    titleLabel.text = @"输入验证码";
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    [self.view addSubview:self.inputTextField];
    
    UIView* firstNumBg = [[UIView alloc] init];
    firstNumBg.layer.borderColor = UIColorFromRGB(@"#cccccc").CGColor;
    firstNumBg.layer.borderWidth = MATCHSIZE(1);
    [self.view addSubview:firstNumBg];
    self.firstNumBg = firstNumBg;
    
    [firstNumBg addSubview:self.circleSmallView1];
    
    UIView* secondNumBg = [[UIView alloc] init];
    secondNumBg.layer.borderColor = UIColorFromRGB(@"#cccccc").CGColor;
    secondNumBg.layer.borderWidth = MATCHSIZE(1);
    [self.view addSubview:secondNumBg];
    self.secondNumBg = secondNumBg;
    
    [secondNumBg addSubview:self.circleSmallView2];
    
    UIView* thirdNumBg = [[UIView alloc] init];
    thirdNumBg.layer.borderColor = UIColorFromRGB(@"#cccccc").CGColor;
    thirdNumBg.layer.borderWidth = MATCHSIZE(1);
    [self.view addSubview:thirdNumBg];
    self.thirdNumBg = thirdNumBg;
    
    [thirdNumBg addSubview:self.circleSmallView3];
    
    UIView* fourthNumBg = [[UIView alloc] init];
    fourthNumBg.layer.borderColor = UIColorFromRGB(@"#cccccc").CGColor;
    fourthNumBg.layer.borderWidth = MATCHSIZE(1);
    [self.view addSubview:fourthNumBg];
    self.fourthNumBg = fourthNumBg;

    [fourthNumBg addSubview:self.circleSmallView4];
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(56));
        make.centerX.offset(0);
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLabel.mas_bottom).offset(MATCHSIZE(60));
        make.left.offset(MATCHSIZE(30));
        make.height.offset(MATCHSIZE(60));
        make.width.offset(MATCHSIZE(340));
        
    }];
    
    [self.firstNumBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(MATCHSIZE(60));
        make.left.offset(MATCHSIZE(30));
        make.width.offset(MATCHSIZE(60));
        make.height.offset(MATCHSIZE(60));
    }];
    
    [self.circleSmallView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.offset(MATCHSIZE(40));
        make.height.offset(MATCHSIZE(40));
    }];
    
    [self.secondNumBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(MATCHSIZE(60));
        make.left.equalTo(self.firstNumBg.mas_right).offset(MATCHSIZE(30));
        make.width.offset(MATCHSIZE(60));
        make.height.offset(MATCHSIZE(60));
    }];
    
    [self.circleSmallView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.offset(MATCHSIZE(40));
        make.height.offset(MATCHSIZE(40));
    }];
    
    [self.thirdNumBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(MATCHSIZE(60));
        make.left.equalTo(self.secondNumBg.mas_right).offset(MATCHSIZE(30));
        make.width.offset(MATCHSIZE(60));
        make.height.offset(MATCHSIZE(60));
    }];
    
    [self.circleSmallView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.offset(MATCHSIZE(40));
        make.height.offset(MATCHSIZE(40));
    }];
    
    [self.fourthNumBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(MATCHSIZE(60));
        make.left.equalTo(self.thirdNumBg.mas_right).offset(MATCHSIZE(30));
        make.width.offset(MATCHSIZE(60));
        make.height.offset(MATCHSIZE(60));
    }];
    
    [self.circleSmallView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(0);
        make.width.offset(MATCHSIZE(40));
        make.height.offset(MATCHSIZE(40));
    }];
}

#pragma mark -textFieldDelegte
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.inputTextField) {
        
        if (range.location >= 6) {
            return NO;
        }
        
        return YES;
    }
    
    return YES;
    
}

@end
