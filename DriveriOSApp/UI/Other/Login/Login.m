//
//  Login.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/15.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "Login.h"

@interface Login ()
/** logo图 */
@property (nonatomic, strong) UIImageView *logoIMG;
/** 用户名 */
@property (nonatomic, strong) UITextField *usersF;
/** 密  码 */
@property (nonatomic, strong) UITextField *passWordF;
/** 验证码 */
@property (nonatomic, strong) UITextField *codeF;
/** 发送验证码按钮 */
@property (nonatomic, strong) UIButton *sendCodeBtn;
/** 忘记密码 */
@property (nonatomic, strong) UIButton *lookPassWordBtn;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UIButton *eyeBtn;

@end

@implementation Login

-(UIImageView *)logoIMG{
    if (!_logoIMG) {
        _logoIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    }
    return _logoIMG;
}

-(UITextField *)usersF{
    if (!_usersF) {
        _usersF = [FactoryClass textFieldWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(80), SCREEN_W - MATCHSIZE(340), MATCHSIZE(40)) placeholder:@"  " placeholderColor:[UIColor grayColor] textColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter cornerRadius:0 itemImage:[UIImage imageNamed:@""] keyboardType:UIKeyboardTypeNumberPad];
        _usersF.tag = 1000;
    }
    return _usersF;
}

-(UITextField *)passWordF{
    if (!_passWordF) {
        _passWordF = [FactoryClass textFieldWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(183), SCREEN_W - MATCHSIZE(340), MATCHSIZE(40)) placeholder:@"  " placeholderColor:[UIColor grayColor] textColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter cornerRadius:0 itemImage:[UIImage imageNamed:@""] keyboardType:UIKeyboardTypeNumberPad];
        _passWordF.secureTextEntry = YES;
        _passWordF.tag = 1001;
    }
    return _passWordF;
}

-(UITextField *)codeF{
    if (!_codeF) {
        _codeF = [FactoryClass textFieldWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(284), MATCHSIZE(180), MATCHSIZE(40)) placeholder:@"  " placeholderColor:[UIColor grayColor] textColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter cornerRadius:0 itemImage:[UIImage imageNamed:@""] keyboardType:UIKeyboardTypeNumberPad];
        _codeF.tag = 1002;
    }
    return _codeF;
}

-(UIButton *)sendCodeBtn{
    if (!_sendCodeBtn) {
        _sendCodeBtn = [FactoryClass buttonWithFrame:CGRectMake(SCREEN_W - MATCHSIZE(340) - MATCHSIZE(120) , MATCHSIZE(254), MATCHSIZE(180), MATCHSIZE(70)) Title:@"获取验证码" backGround:[UIColor clearColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(0)];
        [_sendCodeBtn setTitleColor:UIColorFromRGB(@"#ff772b") forState:UIControlStateNormal];
        _sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:MATCHSIZE(26)];
        _sendCodeBtn.layer.borderWidth = MATCHSIZE(1.5);
        _sendCodeBtn.layer.borderColor = UIColorFromRGB(@"#e0e0e0").CGColor;
    }
    return _sendCodeBtn;
}


-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [FactoryClass buttonWithFrame:CGRectMake((SCREEN_W - MATCHSIZE(220) - MATCHSIZE(100))/2, MATCHSIZE(384), MATCHSIZE(100), MATCHSIZE(40)) Title:@"登录" backGround:[UIColor clearColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(0)];
        [_loginBtn setTitleColor:UIColorFromRGB(@"#ff772b") forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:MATCHSIZE(26)];
    }
    return _loginBtn;
}

-(UIButton *)eyeBtn{
    if (!_eyeBtn) {
        _eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeBtn setImage:[UIImage imageNamed:@"eyes"] forState:UIControlStateNormal];
    }
    return _eyeBtn;
}

-(UIButton *)lookPassWordBtn{
    if (!_lookPassWordBtn) {
        CGFloat lenght = [PublicTool lengthofStr:@"忘记密码？" AndSystemFontOfSize:MATCHSIZE(30)];
        _lookPassWordBtn = [FactoryClass buttonWithFrame:CGRectMake(MATCHSIZE(100), MATCHSIZE(1080), lenght, MATCHSIZE(60)) Title:@"忘记密码?" backGround:[UIColor clearColor] tintColor:[UIColor blackColor] cornerRadius:MATCHSIZE(0)];
        [_lookPassWordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _lookPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:MATCHSIZE(30)];
        _lookPassWordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _lookPassWordBtn;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
}



-(void)creatUI{

    self.view.backgroundColor = [UIColor grayColor];
    //背景图
    UIImageView *bgIMG = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bgIMG.image = [UIImage imageNamed:@"baseboard"];
    [self.view addSubview:bgIMG];
    
    //logo图
    [self.view addSubview:self.logoIMG];
    [self.logoIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(MATCHSIZE(308));
        make.top.equalTo(self.view).offset(MATCHSIZE(124));
        make.right.equalTo(self.view).offset(MATCHSIZE(-308));
        make.height.offset(MATCHSIZE(180));
    }];

    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = MATCHSIZE(10);
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoIMG.mas_bottom).offset(MATCHSIZE(105));
        make.left.equalTo(self.view).offset(MATCHSIZE(74));
        make.right.equalTo(self.view).offset(MATCHSIZE(-74));
        make.height.offset(MATCHSIZE(466));
    }];
    
    UIImageView *userImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone"]];
    [bgView addSubview:userImg];
    [userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(MATCHSIZE(36));
        make.left.equalTo(bgView).offset(MATCHSIZE(40));
        make.width.offset(MATCHSIZE(30));
        make.height.offset(MATCHSIZE(30));
    }];
    
    UILabel *userNameLab = [FactoryClass labelWithText:@"手机号" fontSize:MATCHSIZE(32) textColor:UIColorFromRGB(@"#ff772b") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [bgView addSubview:userNameLab];
    [userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(MATCHSIZE(36));
        make.left.equalTo(userImg.mas_right).offset(MATCHSIZE(20));
        make.width.offset(MATCHSIZE(100));
        make.height.offset(MATCHSIZE(30));
    }];
    
    //手机文本框
    [bgView addSubview:self.usersF];
    [self.usersF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userImg.mas_bottom).offset(MATCHSIZE(0));
        make.left.equalTo(bgView).offset(MATCHSIZE(80));
        make.right.equalTo(bgView).offset(MATCHSIZE(-80));
        make.height.offset(MATCHSIZE(70));
    }];
    
    UILabel *line = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:UIColorFromRGB(@"#e0e0e0")];
    [bgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userImg.mas_bottom).offset(MATCHSIZE(70));
        make.left.equalTo(bgView).offset(MATCHSIZE(40));
        make.right.equalTo(bgView).offset(MATCHSIZE(-40));
        make.height.offset(MATCHSIZE(1.5));
    }];
   
    //锁头图片
    UIImageView *pwdImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    [bgView addSubview:pwdImg];
    [pwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(MATCHSIZE(30));
        make.left.equalTo(bgView).offset(MATCHSIZE(40));
        make.width.offset(MATCHSIZE(30));
        make.height.offset(MATCHSIZE(30));
    }];
    
    UILabel *userPassLab = [FactoryClass labelWithText:@"密码" fontSize:MATCHSIZE(30) textColor:UIColorFromRGB(@"#ff772b") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [bgView addSubview:userPassLab];
    [userPassLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(MATCHSIZE(30));
        make.left.equalTo(pwdImg.mas_right).offset(MATCHSIZE(20));
        make.width.offset(MATCHSIZE(100));
        make.height.offset(MATCHSIZE(30));
    }];
    
    //密码文本框
    [bgView addSubview:self.passWordF];
    [self.passWordF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdImg.mas_bottom).offset(MATCHSIZE(0));
        make.left.equalTo(bgView).offset(MATCHSIZE(80));
        make.right.equalTo(bgView).offset(MATCHSIZE(-80));
        make.height.offset(MATCHSIZE(70));
    }];
    
    UILabel *line2 = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:UIColorFromRGB(@"#e0e0e0")];
    [bgView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pwdImg.mas_bottom).offset(MATCHSIZE(70));
        make.left.equalTo(bgView).offset(MATCHSIZE(40));
        make.right.equalTo(bgView).offset(MATCHSIZE(-40));
        make.height.offset(MATCHSIZE(1.5));
    }];
    
   
    //验证码文本框
    [bgView addSubview:self.codeF];
    [self.codeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(MATCHSIZE(20));
        make.left.equalTo(bgView).offset(MATCHSIZE(40));
        make.width.offset(MATCHSIZE(170));
        make.height.offset(MATCHSIZE(56));
    }];
    
    UILabel *line3 = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:UIColorFromRGB(@"#e0e0e0")];
    [bgView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(MATCHSIZE(76));
        make.left.equalTo(bgView).offset(MATCHSIZE(40));
        make.width.offset(MATCHSIZE(170));
        make.height.offset(MATCHSIZE(1.5));
    }];
    
    //发送验证码
    [bgView addSubview:self.sendCodeBtn];
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(MATCHSIZE(20));
        make.left.equalTo(line3.mas_right).offset(MATCHSIZE(58));
        make.width.offset(MATCHSIZE(154));
        make.height.offset(MATCHSIZE(58));
    }];
    
    //发送验证码按钮点击事件
    [[self.sendCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        UIButton *btn = (UIButton *)x;
        [btn countDownFromTime:60 title:@"获取验证码" unitTitle:@"s后重新获取" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
        
    }];
    
    
    //登录
    [bgView addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView.mas_bottom).offset(MATCHSIZE(-36));
        make.height.offset(MATCHSIZE(40));
        make.width.offset(MATCHSIZE(200));
        make.centerX.offset(0);
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //跳到主页面，移除当前登录页面
        [self.view removeFromSuperview];
        
    }];
    
    //忘记密码
    [self.view addSubview:self.lookPassWordBtn];
    [[self.lookPassWordBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self showHint:@"忘记密码"];
        
    }];
    
    [bgView addSubview:self.eyeBtn];
    [self.eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line2.mas_top).offset(MATCHSIZE(-30));
        make.right.equalTo(bgView).offset(MATCHSIZE(-40));
        make.width.offset(MATCHSIZE(20));
        make.height.offset(MATCHSIZE(10));
    }];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.usersF resignFirstResponder];
    [self.passWordF resignFirstResponder];
    [self.codeF resignFirstResponder];
}


@end
