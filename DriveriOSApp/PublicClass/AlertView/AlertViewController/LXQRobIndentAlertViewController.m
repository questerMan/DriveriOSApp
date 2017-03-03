//
//  LXQRobIndentAlertViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/2.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//
static NSTimeInterval count = 10;

#import "LXQRobIndentAlertViewController.h"

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

@property(nonatomic, weak)NSTimer* robIndentTimer;

@property(nonatomic, weak)UILabel* secondLabel;

@end

@implementation LXQRobIndentAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
}

- (NSTimer *)robIndentTimer{
    if (!_robIndentTimer) {
        NSTimer* robIndentTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            count --;
            self.secondLabel.text = [NSString stringWithFormat:@"%.0fS",count];
            if (count <= 0) {
                count = 10;
                [timer invalidate];
            }
        }];
        _robIndentTimer = robIndentTimer;
    }
    return _robIndentTimer;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.robIndentTimer fire];
}

- (void)creatUI{
    
    UIImageView* nameIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [nameIMG sd_setImageWithURL:[NSURL URLWithString:_model.headIMG] placeholderImage:[UIImage imageNamed:@"userIMG"]];
    [self.view addSubview:nameIMG];
    self.nameIMG = nameIMG;
    
    UILabel* nameLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#8c8c8c") fontSize:MATCHSIZE(28)];
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
    
    UIImageView* aCarIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"positioning-1"]];
    [appointmentView addSubview:aCarIMG];
    self.aCarIMG = aCarIMG;
    
    UILabel* aCarLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#8c8c8c") fontSize:MATCHSIZE(28)];
    aCarLabel.text = [NSString stringWithFormat:@"预约时间: %@",_model.time];
    [appointmentView addSubview:aCarLabel];
    self.aCarLabel = aCarLabel;
    
    UIButton* robIndentBtn = [UIButton buttonWithType:0];
    [robIndentBtn setBackgroundImage:[UIImage imageNamed:@"button"] forState:0];
    [robIndentBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"抢单" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(40)],NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00")}] forState:0];
    robIndentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, MATCHSIZE(30), 0);
    [self.view addSubview:robIndentBtn];
    self.robIndentBtn = robIndentBtn;
    
    UILabel* secondLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#ff6d00") fontSize:MATCHSIZE(28)];
    secondLabel.text = @"10S";
    [robIndentBtn addSubview:secondLabel];
    self.secondLabel = secondLabel;
}

- (void)setModel:(IndentData *)model{
    _model = model;
    
    self.tCarLabel.text = [NSString stringWithFormat:@"上车点: %@",_model.startName];
    self.bCarLabel.text = [NSString stringWithFormat:@"下车点: %@",_model.endName];
    self.aCarLabel.text = [NSString stringWithFormat:@"预约时间: %@",_model.time];
}

- (void)robIndentBtnClick{
    
    [self.robIndentTimer invalidate];
    
    count = 10;
}

@end
