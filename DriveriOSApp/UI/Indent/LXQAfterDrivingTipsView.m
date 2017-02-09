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

@end

@implementation LXQAfterDrivingTipsView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    UIImageView* tipsIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips"]];
    tipsIMG.center = CGPointMake(MATCHSIZE(30), MATCHSIZE(35));
    tipsIMG.bounds = CGRectMake(0, 0, MATCHSIZE(32), MATCHSIZE(32));
    [self addSubview:tipsIMG];
    self.tipsIMG = tipsIMG;
    
    UIView* tipsLabelBg = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(10), MATCHSIZE(660), MATCHSIZE(65))];
    tipsLabelBg.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:tipsLabelBg];
    self.tipsLabelBg = tipsLabelBg;
    
    UILabel* tipsLabel = [[UILabel alloc] init];
    tipsLabel.text = @"乘客即将到达，请及时到路边停车，若5分钟后，乘客未上车，开始计费等候....";
    tipsLabel.numberOfLines = 0;
    tipsLabel.font = [UIFont systemFontOfSize:14];
    [tipsLabelBg addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
    
    UIView* waitLabelBg = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(60), MATCHSIZE(10)*2 + MATCHSIZE(65), MATCHSIZE(200), MATCHSIZE(90))];
    waitLabelBg.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:waitLabelBg];
    self.waitLabelBg = waitLabelBg;
    
    UILabel* waitLabel = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(10), MATCHSIZE(10), MATCHSIZE(200) - 2 * MATCHSIZE(10), MATCHSIZE(30))];
    waitLabel.text = @"正在耐心等待";
    waitLabel.font = [UIFont systemFontOfSize:14];
    [self.waitLabelBg addSubview:waitLabel];
    self.waitLabel = waitLabel;
    
    UILabel* countLabel = [[UILabel alloc] init];
    countLabel.font = [UIFont systemFontOfSize:14];
    [waitLabelBg addSubview:countLabel];
    self.countLabel = countLabel;
    
    [self.countTimer fire];
}

- (NSTimer *)countTimer
{
    if (! _countTimer) {
        NSTimer* countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            countTime --;
            NSTimeInterval minute = countTime/60;
            NSTimeInterval second = (int)countTime%60;
            
//            NSLog(@"%.0f,%.0f",hour,minute);
            if (minute >= 0 && second >= 0) {
                self.countLabel.text = [NSString stringWithFormat:@"0%.0f:%.0f分",minute,second];
            }
            else
            {
                [timer invalidate];
                countTime = 300;
            }
            _countTimer = timer;
        }];
    }
    return _countTimer;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(20));
        make.top.offset(MATCHSIZE(0));
        make.width.offset(MATCHSIZE(620));
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.waitLabel.mas_centerX);
        make.top.equalTo(self.waitLabel.mas_bottom).offset(MATCHSIZE(10));
        make.width.offset(MATCHSIZE(120));
    }];
}

@end
