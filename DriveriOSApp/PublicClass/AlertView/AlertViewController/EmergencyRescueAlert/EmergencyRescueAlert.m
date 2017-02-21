//
//  EmergencyRescueAlert.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/23.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "EmergencyRescueAlert.h"

static NSTimeInterval count = 5;

@interface EmergencyRescueAlert ()

@property(nonatomic ,weak)UIView* upView;

@property(nonatomic ,weak)UIView* downView;

@property(nonatomic ,weak)UILabel* tipsLabel;

@property(nonatomic ,weak)UILabel* phoneLabel;

@property(nonatomic ,weak)UILabel* secondLabel;

@property(nonatomic ,weak)UIButton* scalingBtn;

@property(nonatomic ,weak)UIButton* phoneBtn;

@property(nonatomic ,weak)UIButton* cancelBtn;

@property(nonatomic ,weak)NSTimer* countTimer;

@end

@implementation EmergencyRescueAlert

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}

- (void)creatUI{
    UIView* downView = [[UIView alloc] init];
    downView.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    downView.layer.cornerRadius = MATCHSIZE(18);
    downView.layer.masksToBounds = YES;
    [self.view addSubview:downView];
    self.downView = downView;
    
    UIView* upView = [[UIView alloc] init];
    upView.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    upView.layer.cornerRadius = MATCHSIZE(18);
    upView.layer.masksToBounds = YES;
    [self.view addSubview:upView];
    self.upView = upView;
    
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"      提示：已自动发出紧急救援信号，如果取消，请在5秒内点击取消按钮。如方便接电话，请打开“方便接电话”。"];
    [str addAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(@"#8c8c8c"),
                         NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(32)]} range:NSMakeRange(0,56)];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(2,2)];
    [str addAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00"),
                         NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(32)]} range:NSMakeRange(28,1)];
    [str addAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00"),
                         NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(32)]} range:NSMakeRange(49,5)];
    
    UILabel* tipsLabel = [[UILabel alloc] init];
    tipsLabel.attributedText = str;
    tipsLabel.numberOfLines = 0;
    [self.upView addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
    
    UILabel* phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"方便接电话";
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.font = [UIFont systemFontOfSize:MATCHSIZE(32)];
    phoneLabel.textColor = UIColorFromRGB(@"#333333");
    [self.upView addSubview:phoneLabel];
    self.phoneLabel = phoneLabel;
    
    UILabel* secondLabel = [[UILabel alloc] init];
    secondLabel.font = [UIFont systemFontOfSize:MATCHSIZE(32)];
    secondLabel.textColor = UIColorFromRGB(@"#8c8c8c");
    [self.upView addSubview:secondLabel];
    self.secondLabel = secondLabel;
    
    UIButton* scalingBtn = [UIButton buttonWithType:0];
    [scalingBtn setImage:[UIImage imageNamed:@"choose"] forState:0];
    [scalingBtn addTarget:self action:@selector(scalingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.upView addSubview:scalingBtn];
    self.scalingBtn = scalingBtn;
    
    UIButton* phoneBtn = [UIButton buttonWithType:0];
    [phoneBtn setImage:[UIImage imageNamed:@"rescuePhone"] forState:0];
    [self.downView addSubview:phoneBtn];
    self.phoneBtn = phoneBtn;
    
    UIButton* cancelBtn = [UIButton buttonWithType:0];
    [cancelBtn setImage:[UIImage imageNamed:@"cancel"] forState:0];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.downView addSubview:cancelBtn];
    self.cancelBtn = cancelBtn;
}

- (void)scalingBtnClick:(UIButton *)sender{
    self.downView.hidden = !self.downView.hidden;
    sender.transform = CGAffineTransformRotate(sender.transform, M_PI);
}

- (void)cancelBtnClick:(UIButton *)sender{
    if (_closeAlert) {
        _closeAlert();
    }
    [self.countTimer invalidate];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.countTimer fire];
}

- (NSTimer *)countTimer{
    if (!_countTimer) {
        NSTimer* countTimer= [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            count --;
            self.secondLabel.text = [NSString stringWithFormat:@"%.0fS",count];
            if (count <= 0) {
                count = 5;
                [timer invalidate];
            }
        }];
        _countTimer = countTimer;
    }
    return _countTimer;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(293));
    }];
    
    [self.downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.bottom.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(143));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(30));
        make.top.offset(MATCHSIZE(30));
        make.right.offset(MATCHSIZE(-30));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipsLabel.mas_left);
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(MATCHSIZE(10));
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.phoneLabel.mas_centerX);
        make.top.equalTo(self.phoneLabel.mas_bottom).offset(MATCHSIZE(10));
    }];
    
    [self.scalingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tipsLabel.mas_right);
        make.top.equalTo(self.phoneLabel.mas_top);
    }];
    
    [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(115));
        make.centerY.equalTo(self.downView.mas_centerY);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(MATCHSIZE(-115));
        make.centerY.equalTo(self.downView.mas_centerY);
    }];
}

@end
