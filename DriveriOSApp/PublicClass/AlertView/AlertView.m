//
//  AlertView.m
//  AlertViewDemo
//
//  Created by lixin on 16/10/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "AlertView.h"
#import "CenterAlertInfo.h"
#import "PhoneAlert.h"
#import "CodeAlert.h"
#import "LoadAlert.h"
#import "IndentAlert.h"
#import "LoginView.h"
#import "DeleteIndentAlert.h"
#import "LimitLoginAlert.h"
#import "InstantIndentCommingAlert.h"
#import "IndentSucceedAlert.h"
#import "EmergencyRescueAlert.h"
#import "LXQLodingAlertViewController.h"
#import "LXQSquareLodingAlertViewController.h"
#import "LXQRobIndentAlertSuccessedViewController.h"
#import "LXQRobIndentAlertFailedViewController.h"
#import "LXQReservationSetOutFailedAlertViewController.h"
#import "LXQSucceedChangeViewController.h"
#import "LXQFeedbackSucceedAlertViewController.h"
#import "LXQBanLoginViewController.h"
@interface AlertView()<PhoneAlertDelegate,IndentAlertDelegate,DeleteIndentAlertDelegate,LimitLoginAlertDelegate>

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIView *alertView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) CenterAlertInfo *centerAlertInfo;

@property (nonatomic, strong) PhoneAlert *phoneAlert;

@property (nonatomic, strong) CodeAlert *codeAlert;

@property (nonatomic, strong) LoadAlert *loadAlert;

@property (nonatomic, strong) IndentAlert *indentAlert;

@property (nonatomic, strong) LoginView *loginAlert;

@property (nonatomic, strong) DeleteIndentAlert *deleteIndentAlert;

@property (nonatomic, strong) LimitLoginAlert *limitLoginAlert;

@property (nonatomic, strong) InstantIndentCommingAlert *instantIndentCommingAlert;

@property (nonatomic, strong) IndentSucceedAlert *indentSucceedAlert;

@property (nonatomic, strong) EmergencyRescueAlert *emergencyRescueAlert;

@property (nonatomic, strong) LXQLodingAlertViewController *lodingAlertViewController;

@property (nonatomic, strong) LXQSquareLodingAlertViewController *squareLodingAlertViewController;

@property (nonatomic, strong) LXQRobIndentAlertSuccessedViewController *robIndentAlertSuccessedViewController;

@property (nonatomic, strong) UIButton *robIndentCancelAlertBtn;

@property (nonatomic, strong) LXQRobIndentAlertFailedViewController *robIndentAlertFailedViewController;

@property (nonatomic, strong) LXQReservationSetOutFailedAlertViewController *setOutFailedAlertViewController;

@property (nonatomic, strong) LXQSucceedChangeViewController *succeedChangeViewController;

@property (nonatomic, strong) LXQFeedbackSucceedAlertViewController *feedbackSucceedAlertViewController;

@property (nonatomic, strong) UIButton *feedbackViewAlertBtn;

@property (nonatomic, strong) LXQBanLoginViewController *banLoginViewController;

@end

@implementation AlertView

/** 懒加载 */
-(CenterAlertInfo *)centerAlertInfo{
    if (!_centerAlertInfo) {
        _centerAlertInfo = [[CenterAlertInfo alloc] init];
    }
    return _centerAlertInfo;
}

-(PhoneAlert *)phoneAlert{
    if (!_phoneAlert) {
        _phoneAlert = [[PhoneAlert alloc] init];
        _phoneAlert.delegate = self;
    }
    return _phoneAlert;
}

-(CodeAlert *)codeAlert{
    if (!_codeAlert) {
        _codeAlert = [[CodeAlert alloc] init];
    }
    return _codeAlert;
}

-(LoadAlert *)loadAlert{
    if (!_loadAlert) {
        _loadAlert = [[LoadAlert alloc] init];
    }
    return _loadAlert;
}

-(IndentAlert *)indentAlert{
    if (!_indentAlert) {
        _indentAlert = [[IndentAlert alloc] init];
        _indentAlert.delegate = self;
    }
    return _indentAlert;
}

-(LoginView *)loginAlert{
    if (!_loginAlert) {
        _loginAlert = [[LoginView alloc] init];
    }
    return _loginAlert;
}

-(DeleteIndentAlert *)deleteIndentAlert{
    if(!_deleteIndentAlert){
        _deleteIndentAlert = [[DeleteIndentAlert alloc] init];
        _deleteIndentAlert.delegate = self;
    }
    return _deleteIndentAlert;
}

-(LimitLoginAlert *)limitLoginAlert{
    if (!_limitLoginAlert) {
        _limitLoginAlert = [[LimitLoginAlert alloc] init];
        _limitLoginAlert.delegate = self;
    }
    return _limitLoginAlert;
}

-(InstantIndentCommingAlert *)instantIndentCommingAlert{
    if (!_instantIndentCommingAlert) {
        _instantIndentCommingAlert = [[InstantIndentCommingAlert alloc] init];
    }
    return _instantIndentCommingAlert;
}

-(IndentSucceedAlert *)indentSucceedAlert{
    if (!_indentSucceedAlert) {
        _indentSucceedAlert = [[IndentSucceedAlert alloc] init];
    }
    return _indentSucceedAlert;
}

- (EmergencyRescueAlert *)emergencyRescueAlert{
    if (!_emergencyRescueAlert) {
        _emergencyRescueAlert = [[EmergencyRescueAlert alloc] init];
    }
    return _emergencyRescueAlert;
}

-(LXQLodingAlertViewController *)lodingAlertViewController{
    if (!_lodingAlertViewController) {
        _lodingAlertViewController = [[LXQLodingAlertViewController alloc] init];
    }
    return _lodingAlertViewController;
}

- (LXQPassengerGetOnAlertViewController *)passengerGetOnAlert{
    if (!_passengerGetOnAlert) {
        _passengerGetOnAlert = [[LXQPassengerGetOnAlertViewController alloc] init];
    }
    return _passengerGetOnAlert;
}

- (LXQreassignmentIndentAlertViewController *)reassignmentIndentAlertViewController{
    if (!_reassignmentIndentAlertViewController) {
        _reassignmentIndentAlertViewController = [[LXQreassignmentIndentAlertViewController alloc] init];
    }
    return _reassignmentIndentAlertViewController;
}

- (LXQSquareLodingAlertViewController *)squareLodingAlertViewController{
    if (!_squareLodingAlertViewController) {
        _squareLodingAlertViewController = [[LXQSquareLodingAlertViewController alloc] init];
    }
    return _squareLodingAlertViewController;
}

- (LXQRobIndentAlertViewController *)robIndentAlertViewController{
    if (!_robIndentAlertViewController) {
        _robIndentAlertViewController = [[LXQRobIndentAlertViewController alloc] init];
    }
    return _robIndentAlertViewController;
}

- (UIButton *)robIndentCancelAlertBtn{
    if (!_robIndentCancelAlertBtn) {
        _robIndentCancelAlertBtn = [UIButton buttonWithType:0];
        [_robIndentCancelAlertBtn setImage:[UIImage imageNamed:@"cancel"] forState:0];
        [_robIndentCancelAlertBtn addTarget:self action:@selector(robIndentCancelAlertBtnClick) forControlEvents:1<<6];
    }
    return _robIndentCancelAlertBtn;
}

- (LXQRobIndentAlertSuccessedViewController *)robIndentAlertSuccessedViewController{
    if (!_robIndentAlertSuccessedViewController) {
        _robIndentAlertSuccessedViewController = [[LXQRobIndentAlertSuccessedViewController alloc] init];
    }
    return _robIndentAlertSuccessedViewController;
}

- (LXQRobIndentAlertFailedViewController *)robIndentAlertFailedViewController{
    if (!_robIndentAlertFailedViewController) {
        _robIndentAlertFailedViewController = [[LXQRobIndentAlertFailedViewController alloc] init];
    }
    return _robIndentAlertFailedViewController;
}

- (LXQReservationSetOutFailedAlertViewController *)setOutFailedAlertViewController{
    if (!_setOutFailedAlertViewController) {
        _setOutFailedAlertViewController = [[LXQReservationSetOutFailedAlertViewController alloc] init];
    }
    return _setOutFailedAlertViewController;
}

- (LXQConfirmPhoneNumViewController *)confirmPhoneNumViewController{
    if (!_confirmPhoneNumViewController) {
        _confirmPhoneNumViewController = [[LXQConfirmPhoneNumViewController alloc] init];
    }
    return _confirmPhoneNumViewController;
}

- (LXQInputVerificationViewController *)inputVerificationViewController{
    if (!_inputVerificationViewController) {
        _inputVerificationViewController = [[LXQInputVerificationViewController alloc] init];
    }
    return _inputVerificationViewController;
}

- (LXQSucceedChangeViewController *)succeedChangeViewController{
    if (!_succeedChangeViewController) {
        _succeedChangeViewController = [[LXQSucceedChangeViewController alloc] init];
    }
    return _succeedChangeViewController;
}

- (LXQFeedbackSucceedAlertViewController *)feedbackSucceedAlertViewController{
    if (!_feedbackSucceedAlertViewController) {
        _feedbackSucceedAlertViewController = [[LXQFeedbackSucceedAlertViewController alloc] init];
    }
    return _feedbackSucceedAlertViewController;
}

- (UIButton *)feedbackViewAlertBtn{
    if (!_feedbackViewAlertBtn) {
        _feedbackViewAlertBtn = [UIButton buttonWithType:0];
        [_feedbackViewAlertBtn setImage:[UIImage imageNamed:@"call-off"] forState:0];
        [_feedbackViewAlertBtn addTarget:self action:@selector(feedbackViewAlertClick) forControlEvents:1<<6];
    }
    return _feedbackViewAlertBtn;
}

- (LXQBanLoginViewController *)banLoginViewController{
    if (!_banLoginViewController) {
        _banLoginViewController = [[LXQBanLoginViewController alloc] init];
    }
    return _banLoginViewController;
}

//直接调用该方法一般用于固定 view 的展示
-(instancetype)initWithFrame:(CGRect)frame AndAddAlertViewType:(AlertViewType)alertViewType{
    
    _addAlertViewType = alertViewType;

    if (self = [super initWithFrame:frame]) {
        
        switch (alertViewType) {
            case AlertViewTypeCenterAlertInfo:
                
                [self isCloseWithTap:NO];
                [self isCreatTimerWithTimeInterval:3];//测试
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
                
                break;
                
            case AlertViewTypePhoneAlert:
                
                [self isCloseWithTap:NO];
                
                break;
                
            case AlertViewTypeCodeAlert:
                
                [self isCloseWithTap:YES];
                
                break;
                
            case AlertViewTypeLoadAlert:
                
                [self isCloseWithTap:YES];
                
                break;
                
            case AlertViewTypeIndentAlert:
                
                [self isCloseWithTap:NO];
                
                break;
            case AlertViewTypeLoginAlert:
                
                [self isCloseWithTap:YES];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
                
                break;
            case AlertViewTypeDeleteIndentAlert:
                
                [self isCloseWithTap:NO];
                
                break;
            case AlertViewTypeLimitLoginAlert:
                
                [self isCloseWithTap:NO];
                
                break;
            case AlertViewTypeInstantIndentCommingAlert:
                
                [self isCloseWithTap:NO];
                [self isCreatTimerWithTimeInterval:1.5];
                
                break;
                
            case AlertViewTypeIndentSucceedAlert:
                
                [self isCloseWithTap:NO];
                [self isCreatTimerWithTimeInterval:1.5];
                
                break;
            case AlertViewTypeEmergencyRescueAlert:
                [self isCloseWithTap:NO];
                
                break;
            case AlertViewTypeLoadingAlert:
                [self isCloseWithTap:NO];
                [self isCreatTimerWithTimeInterval:1.5];
                break;
            case AlertViewTypePassengerGetOnAlert:
                [self isCloseWithTap:NO];
                
                break;
            case AlertViewTypeReassignmentIndentAlert:
                [self isCloseWithTap:NO];
                
                break;
            case AlertViewTypeSquareLodingAlert:
                [self isCloseWithTap:NO];
                
                break;
            case AlertViewTypeRobIndentAlert:
                [self isCloseWithTap:NO];
                
                break;
            case AlertViewTypeRobIndentAlertSuccessed:
                [self isCloseWithTap:NO];
                [self isCreatTimerWithTimeInterval:1.5];
                break;
            case AlertViewTypeRobIndentAlertFailed:
                [self isCloseWithTap:NO];
                [self isCreatTimerWithTimeInterval:1.5];
                break;
            case AlertViewTypeReservationSetOutFailedAlert:
                [self isCloseWithTap:NO];
                [self isCreatTimerWithTimeInterval:1.5];
                break;
            case AlertViewTypeConfirmPhoneNumAlert:
                [self isCloseWithTap:NO];
                break;
            case AlertViewTypeInputVerificationAlert:
                [self isCloseWithTap:NO];
                break;
            case AlertViewTypeSucceedChangeAlert:
                [self isCloseWithTap:NO];
                [self isCreatTimerWithTimeInterval:3];
                break;
            case AlertViewTypeFeedbackSucceedAlert:
                [self isCloseWithTap:NO];
                
                break;
            default:
                break;
        }
        
    }
    
    return self;
}

#pragma mark - 添加背景膜层，是否需要点击模糊层关闭弹出框:YES为可以点击模糊层关闭alertView
-(void)isCloseWithTap:(BOOL)isClose{
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.5;
    
    [self addSubview:self.bgView];
    
    if (isClose == YES) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        self.bgView.userInteractionEnabled = YES;
        [self.bgView addGestureRecognizer:tap];
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    [self alertViewClose];
    
}

-(void)isCreatTimerWithTimeInterval:(NSTimeInterval)timeInterval{
    //不重复，只调用一次。timer运行一次就会自动停止运行
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(scrollTimer) userInfo:nil repeats:NO];
}

-(void)scrollTimer{
    [self alertViewClose];
    //关闭定时器
    [self.timer setFireDate:[NSDate distantFuture]];
}

#pragma mark - 初始化alertView
-(void)initAlertViewWithViewController:(UIViewController *)controller{
    if (self.alertView) return;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(100), SCREEN_H/2-MATCHSIZE(150), SCREEN_W-MATCHSIZE(200), MATCHSIZE(300))];
    self.alertView.layer.cornerRadius = MATCHSIZE(10);
    self.alertView.layer.masksToBounds = YES;
    self.alertView.alpha = 0;
    self.alertView.userInteractionEnabled = YES;
    
    [self.alertView addSubview:controller.view];
    
    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.bottom.offset(0);
        make.left.offset(0);
        make.right.offset(0);
    }];
    
    [self addSubview:self.alertView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.alpha = 1;
    }];
    
    [window addSubview:self];
}

#pragma mark - 显示alertView
-(void)alertViewShow{
    if (_addAlertViewType == AlertViewTypePhoneAlert){
        
        [self initAlertViewWithViewController:self.phoneAlert];
        __weak typeof(self) weakSelf = self;
        
        //下拉框回调
        [self.phoneAlert showInsetAlertViewHeightWithBlock:^(int lenght) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            if (lenght == 6) {
                [UIView animateWithDuration:0.3 animations:^{
                    strongSelf.alertView.frame = CGRectMake(MATCHSIZE(100), SCREEN_H/2-MATCHSIZE(150), SCREEN_W-MATCHSIZE(200), MATCHSIZE(360));
                }];
            }else if (lenght == 100) {
                [UIView animateWithDuration:0.3 animations:^{
                    strongSelf.alertView.frame = CGRectMake(MATCHSIZE(100), SCREEN_H/2-MATCHSIZE(150), SCREEN_W-MATCHSIZE(200), MATCHSIZE(200));
                }];
                //2s后自动关闭弹出框
                double delayInSeconds = 2.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [strongSelf alertViewClose];
                });
            } else{
                [UIView animateWithDuration:0.3 animations:^{
                    strongSelf.alertView.frame = CGRectMake(MATCHSIZE(100), SCREEN_H/2-MATCHSIZE(150), SCREEN_W-MATCHSIZE(200), MATCHSIZE(300));
                }];
            }
        }];
        
    }else if (_addAlertViewType == AlertViewTypeCodeAlert){
        
        [self initAlertViewWithViewController:self.codeAlert];
        
    }else if (_addAlertViewType == AlertViewTypeLoadAlert){
        
        [self initAlertViewWithViewController:self.loadAlert];
        
    }else if (_addAlertViewType == AlertViewTypeIndentAlert){
        
        [self initAlertViewWithViewController:self.indentAlert];
        self.alertView.frame = CGRectMake(MATCHSIZE(50), MATCHSIZE(150), SCREEN_W - MATCHSIZE(100),SCREEN_H - MATCHSIZE(300));
        
    }else if (_addAlertViewType == AlertViewTypeLoginAlert){
        [self initAlertViewWithViewController:self.loginAlert];
        self.alertView.frame = CGRectMake(MATCHSIZE(110), MATCHSIZE(600), SCREEN_W - MATCHSIZE(220), MATCHSIZE(530));
        
    }else if (_addAlertViewType == AlertViewTypeDeleteIndentAlert){
        [self initAlertViewWithViewController:self.deleteIndentAlert];
        self.alertView.layer.cornerRadius = MATCHSIZE(18);
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(MATCHSIZE(26));
            make.top.equalTo(self).offset(MATCHSIZE(74));
            make.right.equalTo(self).offset(-MATCHSIZE(26));
            make.bottom.equalTo(self).offset(-MATCHSIZE(74));
        }];
    }else if (_addAlertViewType == AlertViewTypeLimitLoginAlert){
        [self initAlertViewWithViewController:self.limitLoginAlert];
        self.alertView.frame = CGRectMake(MATCHSIZE(130), MATCHSIZE(400), SCREEN_W - MATCHSIZE(260), MATCHSIZE(370));
    }else if (_addAlertViewType == AlertViewTypeInstantIndentCommingAlert){
        [self initAlertViewWithViewController:self.instantIndentCommingAlert];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(MATCHSIZE(200));
            make.right.equalTo(self).offset(MATCHSIZE(-200));
            make.centerY.offset(0);
            make.height.offset(MATCHSIZE(250));
        }];
    }else if (_addAlertViewType == AlertViewTypeIndentSucceedAlert){
        [self initAlertViewWithViewController:self.indentSucceedAlert];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(MATCHSIZE(174));
            make.right.equalTo(self).offset(MATCHSIZE(-174));
            make.centerY.offset(0);
            make.height.offset(MATCHSIZE(300));
        }];
    }else if (_addAlertViewType == AlertViewTypeEmergencyRescueAlert){
        [self initAlertViewWithViewController:self.emergencyRescueAlert];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(MATCHSIZE(104));
            make.right.equalTo(self).offset(MATCHSIZE(-104));
            make.top.offset(MATCHSIZE(466));
            make.height.offset(MATCHSIZE(400));
        }];
        __weak typeof(self) weakSelf = self;
        self.emergencyRescueAlert.closeAlert = ^{
            [weakSelf alertViewClose];
        };
    }else if (_addAlertViewType == AlertViewTypeLoadingAlert){
        [self initAlertViewWithViewController:self.lodingAlertViewController];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(MATCHSIZE(94));
            make.right.equalTo(self).offset(MATCHSIZE(-94));
            make.top.offset(MATCHSIZE(527));
            make.height.offset(MATCHSIZE(80));
        }];
    }else if (_addAlertViewType == AlertViewTypePassengerGetOnAlert){
        [self initAlertViewWithViewController:self.passengerGetOnAlert];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(MATCHSIZE(174));
            make.right.equalTo(self).offset(MATCHSIZE(-174));
            make.centerY.offset(0);
            make.height.offset(MATCHSIZE(300));
        }];
    }else if (_addAlertViewType == AlertViewTypeReassignmentIndentAlert){
        [self initAlertViewWithViewController:self.reassignmentIndentAlertViewController];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(MATCHSIZE(174));
            make.right.equalTo(self).offset(MATCHSIZE(-174));
            make.centerY.offset(0);
            make.height.offset(MATCHSIZE(300));
        }];
    }else if (_addAlertViewType == AlertViewTypeSquareLodingAlert){
        
        [self initAlertViewWithViewController:self.squareLodingAlertViewController];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(0);
            make.width.offset(MATCHSIZE(400));
            make.height.offset(MATCHSIZE(300));
        }];
    }else if (_addAlertViewType == AlertViewTypeRobIndentAlert){
        [self initAlertViewWithViewController:self.robIndentAlertViewController];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(0);
            make.width.offset(MATCHSIZE(588));
            make.height.offset(MATCHSIZE(870));
        }];
        
        [self addSubview:self.robIndentCancelAlertBtn];
        [self.robIndentCancelAlertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(self.alertView.mas_bottom).offset(MATCHSIZE(30));
        }];
    }else if (_addAlertViewType == AlertViewTypeRobIndentAlertSuccessed){
        [self initAlertViewWithViewController:self.robIndentAlertSuccessedViewController];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(0);
            make.width.offset(MATCHSIZE(400));
            make.height.offset(MATCHSIZE(300));
        }];
    }else if (_addAlertViewType == AlertViewTypeRobIndentAlertFailed){
        [self initAlertViewWithViewController:self.robIndentAlertFailedViewController];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(0);
            make.width.offset(MATCHSIZE(400));
            make.height.offset(MATCHSIZE(300));
        }];
    }else if (_addAlertViewType == AlertViewTypeReservationSetOutFailedAlert){
        
        [self initAlertViewWithViewController:self.setOutFailedAlertViewController];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(0);
            make.width.offset(MATCHSIZE(350));
            make.height.offset(MATCHSIZE(200));
        }];
        
    }else if (_addAlertViewType == AlertViewTypeConfirmPhoneNumAlert){
        
        [self initAlertViewWithViewController:self.confirmPhoneNumViewController];
        __weak typeof(self) weakSelf = self;
        self.confirmPhoneNumViewController.cancelBtnClick = ^{[weakSelf alertViewCloseWithBlock:nil];};
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(MATCHSIZE(350));
            make.width.offset(MATCHSIZE(447));
            make.height.offset(MATCHSIZE(316));
        }];
        
    }else if (_addAlertViewType == AlertViewTypeInputVerificationAlert){
        
        [self initAlertViewWithViewController:self.inputVerificationViewController];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(MATCHSIZE(350));
            make.width.offset(MATCHSIZE(398));
            make.height.offset(MATCHSIZE(280));
        }];
        
    }else if (_addAlertViewType == AlertViewTypeSucceedChangeAlert){
        
        [self initAlertViewWithViewController:self.succeedChangeViewController];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.offset(MATCHSIZE(400));
            make.width.offset(MATCHSIZE(400));
            make.height.offset(MATCHSIZE(246));
        }];
    }else if (_addAlertViewType == AlertViewTypeFeedbackSucceedAlert){
        
        [self addSubview:self.feedbackViewAlertBtn];
        [self.feedbackViewAlertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(MATCHSIZE(472));
            make.right.offset(MATCHSIZE(-152));
        }];
        
        [self initAlertViewWithViewController:self.feedbackSucceedAlertViewController];
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(MATCHSIZE(164));
            make.top.equalTo(self.feedbackViewAlertBtn.mas_bottom).offset(MATCHSIZE(5));
            make.width.offset(MATCHSIZE(400));
            make.height.offset(MATCHSIZE(300));
        }];
    }else if (_addAlertViewType == AlertViewTypeBanLoginAlert){
        
        [self initAlertViewWithViewController:self.banLoginViewController];
        __weak typeof(self) weakSelf = self;
        self.banLoginViewController.closeBtnClick = ^{
            [weakSelf alertViewClose];
        };
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.top.offset(0);
            make.bottom.offset(0);
        }];
    }
}

#pragma mark - 只显示文字
-(void)alertViewShowTitle:(NSString *)title
                textColor:(UIColor *)textColor{
    if (_addAlertViewType == AlertViewTypeCenterAlertInfo) {
        
        [self initAlertViewWithViewController:self.centerAlertInfo];
        
        [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(MATCHSIZE(120));
            make.top.equalTo(self).offset(MATCHSIZE(445));
            make.right.equalTo(self).offset(-MATCHSIZE(120));
            make.height.offset(MATCHSIZE(340));
        }];
        
        //计算文字高度
        self.centerAlertInfo.contentLabel.text = title;
        self.centerAlertInfo.contentLabel.textColor = textColor;
    }
}

- (void)robIndentCancelAlertBtnClick{
    [self closeAlertView];
    [self.robIndentAlertViewController.robIndentTimer invalidate];
    self.robIndentAlertViewController.count = 10;
}

- (void)feedbackViewAlertClick{
    
    [self closeAlertView];
}

#pragma mark - phoneAlert/IndentAlertDelegate/DeleteIndentAlert代理
-(void)closeAlertView{
    [self alertViewClose];
}

-(void)alertViewCloseWithBlock:(void (^) ())block{
    [self alertViewClose];
}

-(void)alertViewClose{
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        if (_timer) {
            //关闭定时器
            [_timer setFireDate:[NSDate distantFuture]];
            _timer = nil;
        }
        [self.alertView removeFromSuperview];
        self.alertView = nil;
        [self removeFromSuperview];
    }];
}

-(void)keyboardWillChange:(NSNotification  *)notification
{
    // 1.获取键盘的Y值
    NSDictionary *dict  = notification.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    // 获取动画执行时间
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    // 2.计算需要移动的距离
    CGFloat selfY = keyboardY - self.height;
    
    [UIView animateWithDuration:duration delay:0.0 options:7 << 16 animations:^{
        // 需要执行动画的代码
        self.y = selfY;
        //self.bgView.alpha = 0.5;
    } completion:^(BOOL finished) {
        // 动画执行完毕执行的代码
        if (_alertView == nil) {
            //  [self.textField resignFirstResponder];
            [self removeFromSuperview];
        }
    }];
}

@end
