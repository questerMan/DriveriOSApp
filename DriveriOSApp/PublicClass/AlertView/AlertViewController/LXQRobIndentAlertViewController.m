//
//  LXQRobIndentAlertViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/2.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQRobIndentAlertViewController.h"
#import "LXQRobIndentBtn.h"
#import "UIColor+Hex.h"
#import "wendu_yuan2.h"

@interface LXQRobIndentAlertViewController ()

@property(nonatomic, weak)UIImageView* nameIMG;

@property(nonatomic, weak)UILabel* nameLabel;

@property(nonatomic, weak)UIView* evaluationView;

@property(nonatomic, weak)UIImageView* star0IMG;

@property(nonatomic, weak)UIImageView* star1IMG;

@property(nonatomic, weak)UIImageView* star2IMG;

@property(nonatomic, weak)UIImageView* star3IMG;

@property(nonatomic, weak)UIImageView* star4IMG;

@property(nonatomic, weak)UIView* tCarView;

@property(nonatomic, weak)UIImageView* tCarIMG;

@property(nonatomic, weak)UILabel* tCarLabel;

@property(nonatomic, weak)UIView* bCarView;

@property(nonatomic, weak)UIImageView* bCarIMG;

@property(nonatomic, weak)UILabel* bCarLabel;

@property(nonatomic, weak)UIView* appointmentView;

@property(nonatomic, weak)UIImageView* aCarIMG;

@property(nonatomic, weak)UILabel* aCarLabel;

@property(nonatomic, weak)UIButton* robIndentBtn;

@property(nonatomic, weak)UILabel* secondLabel;

@property (nonatomic,strong) wendu_yuan2 *progressView;

@end

@implementation LXQRobIndentAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
    self.count = 10;
}

- (wendu_yuan2*)progressView
{
    if (_progressView  == nil) {
        _progressView = [[wendu_yuan2 alloc] init];
        _progressView.backgroundColor = [UIColor clearColor];
        ;
    }
    return _progressView;
}


- (NSTimer *)robIndentTimer{

    if (!_robIndentTimer) {
        NSTimer* robIndentTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            _count --;
            self.secondLabel.text = [NSString stringWithFormat:@"%.0fS",_count];
            if (_count <= 0) {
                _count = 10;
                [timer invalidate];
                
                AlertView* alert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeRobIndentAlertFailed];
                [alert alertViewShow];
                
                if (_robIndentTimerEnd) {
                    _robIndentTimerEnd();
                }
            }
        }];
        _robIndentTimer = robIndentTimer;
    }
    return _robIndentTimer;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.robIndentTimer fire];
    
    [self.progressView start];
    
}

- (void)creatUI{
    
    self.view.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    self.view.layer.cornerRadius = MATCHSIZE(18);
    self.view.layer.masksToBounds = YES;
    
    UIImageView* nameIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [nameIMG sd_setImageWithURL:[NSURL URLWithString:_model.headIMG] placeholderImage:[UIImage imageNamed:@"userIMG"]];
    nameIMG.layer.cornerRadius = MATCHSIZE(57);
    nameIMG.layer.masksToBounds = YES;
    [self.view addSubview:nameIMG];
    self.nameIMG = nameIMG;
    
    UILabel* nameLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#8c8c8c") fontSize:MATCHSIZE(28)];
    nameLabel.text = _model.name;
    [self.view addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UIView* evaluationView = [[UIView alloc] init];
    evaluationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:evaluationView];
    self.evaluationView = evaluationView;
    
    UIImageView* star0IMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star-1"]];
    [evaluationView addSubview:star0IMG];
    self.star0IMG = star0IMG;
    
    UIImageView* star1IMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star-1"]];
    [evaluationView addSubview:star1IMG];
    self.star1IMG = star1IMG;
    
    UIImageView* star2IMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star-1"]];
    [evaluationView addSubview:star2IMG];
    self.star2IMG = star2IMG;
    
    UIImageView* star3IMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star-1"]];
    [evaluationView addSubview:star3IMG];
    self.star3IMG = star3IMG;
    
    UIImageView* star4IMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star-1"]];
    [evaluationView addSubview:star4IMG];
    self.star4IMG = star4IMG;
    
    UIView* tCarView = [[UIView alloc] init];
    tCarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tCarView];
    self.tCarView = tCarView;
    
    UIImageView* tCarIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"positioning"]];
    [tCarView addSubview:tCarIMG];
    self.tCarIMG = tCarIMG;
    
    UILabel* tCarLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#8c8c8c") fontSize:MATCHSIZE(28)];
    tCarLabel.text = [NSString stringWithFormat:@"上车点: %@",_model.startName];
    [tCarView addSubview:tCarLabel];
    self.tCarLabel = tCarLabel;
    
    UIView* bCarView = [[UIView alloc] init];
    bCarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bCarView];
    self.bCarView = bCarView;
    
    UIImageView* bCarIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"positioning-1"]];
    [bCarView addSubview:bCarIMG];
    self.bCarIMG = bCarIMG;
    
    UILabel* bCarLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#8c8c8c") fontSize:MATCHSIZE(28)];
    bCarLabel.text = [NSString stringWithFormat:@"下车点: %@",_model.endName];
    [bCarView addSubview:bCarLabel];
    self.bCarLabel = bCarLabel;
    
    UIView* appointmentView = [[UIView alloc] init];
    appointmentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:appointmentView];
    self.appointmentView = appointmentView;
    
    UIImageView* aCarIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time"]];
    [appointmentView addSubview:aCarIMG];
    self.aCarIMG = aCarIMG;
    
    UILabel* aCarLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#8c8c8c") fontSize:MATCHSIZE(28)];
    aCarLabel.text = [NSString stringWithFormat:@"预约时间: %@",_model.time];
    [appointmentView addSubview:aCarLabel];
    self.aCarLabel = aCarLabel;
    

    
    LXQRobIndentBtn* robIndentBtn = [[LXQRobIndentBtn alloc] init];
//    [robIndentBtn setBackgroundImage:[UIImage imageNamed:@"button"] forState:0];
    robIndentBtn.backgroundColor = [UIColor whiteColor];
    robIndentBtn.layer.cornerRadius = MATCHSIZE(100);
    [robIndentBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"抢单" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(40)],NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00")}] forState:0];
    robIndentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, MATCHSIZE(30), 0);
    [robIndentBtn addTarget:self action:@selector(robIndentBtnClick:) forControlEvents: 1<<6];
    [self.view addSubview:robIndentBtn];
    self.robIndentBtn = robIndentBtn;
    
    wendu_yuan2* progressView = [[wendu_yuan2 alloc] init];
    progressView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progressView];
    progressView.progress = (800.0-300)/(850-300.0);
    progressView.userInteractionEnabled = NO;
    self.progressView = progressView;
    
    UILabel* secondLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#ff6d00") fontSize:MATCHSIZE(28)];
    secondLabel.text = @"10S";
    [robIndentBtn addSubview:secondLabel];
    self.secondLabel = secondLabel;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.nameIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(MATCHSIZE(56));
        make.height.offset(MATCHSIZE(114));
        make.width.offset(MATCHSIZE(114));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameIMG.mas_bottom).offset(MATCHSIZE(20));
        make.centerX.offset(0);
    }];
    
    [self.evaluationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(110));
        make.right.offset(MATCHSIZE(110));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(MATCHSIZE(30));
        make.height.offset(MATCHSIZE(40));
    }];
    
    [self.star0IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
    }];
    
    [self.star1IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.star0IMG.mas_right).offset(MATCHSIZE(45));
        make.top.offset(0);
    }];
    
    [self.star2IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.star1IMG.mas_right).offset(MATCHSIZE(45));
        make.top.offset(0);
    }];
    
    [self.star3IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.star2IMG.mas_right).offset(MATCHSIZE(45));
        make.top.offset(0);
    }];
    
    [self.star4IMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.star3IMG.mas_right).offset(MATCHSIZE(45));
        make.top.offset(0);
    }];
    
    [self.tCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.evaluationView.mas_bottom).offset(MATCHSIZE(40));
        make.left.offset(MATCHSIZE(136));
        make.right.offset(0);
        make.height.offset(MATCHSIZE(28));
    }];
    
    [self.tCarIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
    }];
    
    [self.tCarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tCarIMG.mas_right).offset(MATCHSIZE(10));
        make.top.offset(0);
    }];
    
    [self.bCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(136));
        make.top.equalTo(self.tCarView.mas_bottom).offset(MATCHSIZE(20));
        make.right.offset(0);
        make.height.offset(MATCHSIZE(28));
    }];
    
    [self.bCarIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
    }];
    
    [self.bCarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bCarIMG.mas_right).offset(MATCHSIZE(10));
        make.top.offset(0);
    }];
    
    [self.appointmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(136));
        make.top.equalTo(self.bCarView.mas_bottom).offset(MATCHSIZE(20));
        make.right.offset(0);
        make.height.offset(MATCHSIZE(28));
    }];
    
    [self.aCarIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
    }];
    
    [self.aCarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.aCarIMG.mas_right).offset(MATCHSIZE(10));
        make.top.offset(0);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(CGSizeMake(AUTO_3PX(980), AUTO_3PX(980)));
        make.centerY.equalTo(self.robIndentBtn);
        make.left.offset(MATCHSIZE(170));
        make.right.offset(MATCHSIZE(-170));
        make.height.equalTo(self.progressView.mas_width);
    }];
    
    [self.robIndentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(194));
        make.right.offset(MATCHSIZE(-194));
        make.height.equalTo(self.robIndentBtn.mas_width);
        make.bottom.offset(MATCHSIZE(-74));
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(MATCHSIZE(-50));
        make.centerX.offset(0);
    }];
}

- (void)setModel:(IndentData *)model{
    
    _model = model;
    
    [self.nameIMG sd_setImageWithURL:[NSURL URLWithString:_model.headIMG] placeholderImage:[UIImage imageNamed:@"userIMG"]];
    self.nameLabel.text = _model.name;
    self.tCarLabel.text = [NSString stringWithFormat:@"上车点: %@",_model.startName];
    self.bCarLabel.text = [NSString stringWithFormat:@"下车点: %@",_model.endName];
    self.aCarLabel.text = [NSString stringWithFormat:@"预约时间: %@",_model.time];
}

- (void)robIndentBtnClick:(UIButton*)sender{
    
    [self.robIndentTimer invalidate];
    
    _count = 10;
    
    AlertView* alert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeRobIndentAlertSuccessed];
    [alert alertViewShow];
    
    if (_robIndentBtnClick) {
        _robIndentBtnClick();
    }
}

@end
