//
//  LXQAfterDrivingTipsView.m
//  DriveriOSApp
//
//  Created by mac on 17/2/5.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQAfterDrivingTipsView.h"

static NSTimeInterval countTime = 300;

@interface LXQAfterDrivingTipsView()

/** 提示图标 */
@property (nonatomic, weak) UIImageView *tipsIMG;

/** 聊天气泡 */
@property (nonatomic, weak) UIImageView *chatAir;

/** 提示文字背景 */
@property (nonatomic, weak) UIView *tipsLabelBg;

/** 提示文字 */
@property (nonatomic, weak) UILabel *tipsLabel;

/** 等待倒计时背景 */
@property (nonatomic, weak) UIView *waitLabelBg;

/** 等待文字 */
@property (nonatomic, weak) UILabel *waitLabel;

/** 倒计时文字 */
@property (nonatomic, weak) UILabel *countLabel;

/** 倒计时定时器 */
@property (nonatomic, weak) NSTimer *countTimer;
//同步锁
@property (nonatomic, strong) id token;

/** 分钟 */
@property (nonatomic, assign) NSTimeInterval minute;

/** 秒 */
@property (nonatomic, assign) NSTimeInterval second;

@property (nonatomic, assign) BOOL isFireTimer;

@end

@implementation LXQAfterDrivingTipsView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
        [self setShowAndHideBlock];
    }
    return self;
}

- (void)setShowAndHideBlock{
    __weak typeof(self)weakSelf = self;
    self.showTipsView = ^{
        @synchronized (weakSelf.token) {
            if (weakSelf.isFireTimer == NO) {
                weakSelf.minute = countTime / 60;
                weakSelf.second = (int)countTime % 60;
                
                [weakSelf.countTimer fire];
                
                weakSelf.isFireTimer = YES;
            }
        }
    };
    
    self.hideTipsView = ^{
        if (weakSelf.isFireTimer == YES) {
            [weakSelf.countTimer invalidate];
            weakSelf.isFireTimer = NO;
        }
    };
}

-(void)creatUI{
    UIImageView* tipsIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reminder"]];
//    tipsIMG.center = CGPointMake(MATCHSIZE(30), MATCHSIZE(35));
//    tipsIMG.bounds = CGRectMake(0, 0, MATCHSIZE(32), MATCHSIZE(32));
    [self addSubview:tipsIMG];
    self.tipsIMG = tipsIMG;
    
//    UIView* tipsLabelBg = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(10), MATCHSIZE(660), MATCHSIZE(65))];
//    tipsLabelBg.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:tipsLabelBg];
//    self.tipsLabelBg = tipsLabelBg;
    UIImageView* chatAir = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prompt-box"]];
    [self addSubview:chatAir];
    self.chatAir = chatAir;
    
    UILabel* tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"乘客即将到达，请及时到路边停车，若5分钟后，乘客未上车，开始计费等候.";
    tipsLabel.textColor = UIColorFromRGB(@"#737373");
    tipsLabel.numberOfLines = 0;
    tipsLabel.font = [UIFont systemFontOfSize:MATCHSIZE(20)];
    [chatAir addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
    
    UIView* waitLabelBg = [[UIView alloc] init];
    waitLabelBg.backgroundColor = [UIColor whiteColor];
    waitLabelBg.layer.cornerRadius = MATCHSIZE(6);
    waitLabelBg.layer.borderColor = [COLOR(204, 204, 204, 1) CGColor];
    waitLabelBg.layer.borderWidth = MATCHSIZE(1);
    [self addSubview:waitLabelBg];
    self.waitLabelBg = waitLabelBg;
    
    UILabel* waitLabel = [[UILabel alloc] init];
    waitLabel.text = @"耐心等待";
    waitLabel.font = [UIFont systemFontOfSize:MATCHSIZE(22)];
    waitLabel.textColor = UIColorFromRGB(@"#8c8c8c");
    [waitLabelBg addSubview:waitLabel];
    self.waitLabel = waitLabel;
    
    UILabel* countLabel = [[UILabel alloc] init];
    countLabel.font = [UIFont systemFontOfSize:14];
    countLabel.font = [UIFont systemFontOfSize:MATCHSIZE(22)];
    countLabel.textColor = UIColorFromRGB(@"#8c8c8c");
    [waitLabelBg addSubview:countLabel];
    self.countLabel = countLabel;
    
    
}

- (NSTimer *)countTimer
{
    if (! _countTimer) {
        [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            // 减一秒
            self.second--;
            // 判断秒数
            if (self.second == -1) {
                self.second = 59;
                self.minute--;
            }

            if (self.minute >= 0 && self.second >= 0) {
                self.countLabel.text = [NSString stringWithFormat:@"0%.0f:%.0f分",self.minute,self.second];
                if (self.second <= 10 && self.minute <= 0) {
                    self.waitLabel.text = @"计费等候";
                    self.waitLabel.textColor = UIColorFromRGB(@"#ff0000");
                    self.countLabel.textColor = UIColorFromRGB(@"#ff0000");
                }
                else{
                    self.waitLabel.text = @"耐心等待";
                    self.waitLabel.textColor = UIColorFromRGB(@"#8c8c8c");
                    self.countLabel.textColor = UIColorFromRGB(@"#8c8c8c");
                }
            }
            else
            {
                [timer invalidate];
            }
            _countTimer = timer;
        }];
    }
    return _countTimer;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.tipsIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(26));
        make.centerY.equalTo(self.chatAir.mas_centerY);
    }];
    
    [self.chatAir mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipsIMG.mas_right).offset(MATCHSIZE(10));
        make.top.offset(MATCHSIZE(5));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(25));
//        make.right.offset(MATCHSIZE(-12));
        make.width.offset(MATCHSIZE(480));
        make.centerY.offset(0);
        make.height.offset(MATCHSIZE(50));
    }];
    
    [self.waitLabelBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(64));
        make.top.equalTo(self.chatAir.mas_bottom).offset(MATCHSIZE(5));
        make.width.offset(MATCHSIZE(120));
        make.height.offset(MATCHSIZE(80));
    }];
    
    [self.waitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(12));
        make.centerX.offset(0);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.waitLabel.mas_bottom).offset(MATCHSIZE(12));
        make.centerX.offset(0);
    }];
}

@end
