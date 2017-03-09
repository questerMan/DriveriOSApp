//
//  LXQFinalSettlementViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/2/14.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQFinalSettlementViewController.h"
#import "LXQConfirmCollectionAlertViewController.h"
#import "LXQDisposingLoadAlertViewController.h"
@interface LXQFinalSettlementViewController ()

@property(nonatomic , weak)UIView* navBar;

@property(nonatomic , weak)UILabel* titleLabel;

@property(nonatomic , weak)UILabel* finalFare;

@property(nonatomic , weak)UILabel* StartPrice;

@property(nonatomic , weak)UILabel* mileageFee;

@property(nonatomic , weak)UILabel* lowCost;

@property(nonatomic , weak)UILabel* longFee;

@property(nonatomic , weak)UILabel* nightFee;

@property(nonatomic , weak)UILabel* cancelFee;

@property(nonatomic , weak)UILabel* tollFee;

@property(nonatomic , weak)UILabel* parkingFee;

@property(nonatomic , weak)UILabel* preferentialFee;

@property(nonatomic , weak)UILabel* balanceFee;

@property(nonatomic , weak)UIButton* settlementFee;

@property(nonatomic , weak)UIButton* tollFeePlus;

@property(nonatomic , weak)UIButton* tollFeeMinute;

@property(nonatomic , weak)UIButton* parkingFeePlus;

@property(nonatomic , weak)UIButton* parkingFeeMinute;

@end

@implementation LXQFinalSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNAV];
    
    [self creatUI];
}

- (void)setupNAV{
    self.title = @"最终结算";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeStatusBarStyleWithFlag:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return 0;
}

- (void)creatUI{
    
    self.view.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    
    UIView* navBar = [[UIView alloc] init];
    navBar.backgroundColor = COLOR(224,224,224,1);
    [self.view addSubview:navBar];
    self.navBar = navBar;
    
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = [NSString stringWithFormat:@"%@车费",_model.name];
    titleLabel.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    titleLabel.textColor = UIColorFromRGB(@"333333");
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"共计¥25.16元"];
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(@"#ff6d00") range:NSMakeRange(3,5)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:MATCHSIZE(40)] range:NSMakeRange(3, 5)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:MATCHSIZE(26)] range:NSMakeRange(0, 3)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:MATCHSIZE(26)] range:NSMakeRange(8, 1)];
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(@"#333333") range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(@"#333333") range:NSMakeRange(8,1)];
    UILabel* finalFare = [[UILabel alloc] init];
    finalFare.attributedText = str;
    [self.view addSubview:finalFare];
    self.finalFare = finalFare;
    
    UILabel* StartPrice = [[UILabel alloc] init];
    StartPrice.text = @"起步价 : 10.00元";
    StartPrice.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    StartPrice.textColor = UIColorFromRGB(@"#808080");
    [self.view addSubview:StartPrice];
    self.StartPrice = StartPrice;
    
    UILabel* mileageFee = [[UILabel alloc] init];
    mileageFee.text = @"里程费 ：1公里/1.00元";
    mileageFee.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    mileageFee.textColor = UIColorFromRGB(@"#808080");
    [self.view addSubview:mileageFee];
    self.mileageFee = mileageFee;
    
    UILabel* lowCost = [[UILabel alloc] init];
    lowCost.text = @"低速费 ：1公里/1.00元";
    lowCost.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    lowCost.textColor = UIColorFromRGB(@"#808080");
    [self.view addSubview:lowCost];
    self.lowCost = lowCost;
    
    UILabel* longFee = [[UILabel alloc] init];
    longFee.text = @"远途费 ：1公里/1.00元";
    longFee.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    longFee.textColor = UIColorFromRGB(@"#808080");
    [self.view addSubview:longFee];
    self.longFee = longFee;
    
    UILabel* nightFee = [[UILabel alloc] init];
    nightFee.text = @"夜间费 ：1公里/1.00元";
    nightFee.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    nightFee.textColor = UIColorFromRGB(@"#808080");
    [self.view addSubview:nightFee];
    self.nightFee = nightFee;
    
    
    UILabel* cancelFee = [[UILabel alloc] init];
    cancelFee.text = @"取消费 : 05.00元";
    cancelFee.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    cancelFee.textColor = UIColorFromRGB(@"#808080");
    [self.view addSubview:cancelFee];
    self.cancelFee = cancelFee;
    
    UILabel* tollFee = [[UILabel alloc] init];
    tollFee.text = @"路桥费 : 00.10元";
    tollFee.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    tollFee.textColor = UIColorFromRGB(@"#808080");
    [self.view addSubview:tollFee];
    self.tollFee = tollFee;
    
    UILabel* parkingFee = [[UILabel alloc] init];
    parkingFee.text = @"停车费 : 00.10元";
    parkingFee.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    parkingFee.textColor = UIColorFromRGB(@"#808080");
    [self.view addSubview:parkingFee];
    self.parkingFee = parkingFee;
    
    UILabel* preferentialFee = [[UILabel alloc] init];
    preferentialFee.text = @"可用优惠额 : 00.10元";
    preferentialFee.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    preferentialFee.textColor = UIColorFromRGB(@"#808080");
    [self.view addSubview:preferentialFee];
    self.preferentialFee = preferentialFee;
    
    UILabel* balanceFee = [[UILabel alloc] init];
    balanceFee.text = @"可用余额    : 00.00元";
//  balanceFee.text = @"可用优惠额 : 00.10元";
    balanceFee.font = [UIFont systemFontOfSize:MATCHSIZE(28)];
    balanceFee.textColor = UIColorFromRGB(@"#808080");
    [self.view addSubview:balanceFee];
    self.balanceFee = balanceFee;
    
    UIButton* settlementFee = [UIButton buttonWithType:0];
    [settlementFee setTitle:@"结算" forState:0];
    [settlementFee setTitleColor:UIColorFromRGB(@"#ffffff") forState:0];
    [settlementFee setBackgroundColor:UIColorFromRGB(@"#ff6d00")];
    settlementFee.layer.cornerRadius = MATCHSIZE(40);
    [settlementFee addTarget:self action:@selector(settlementFeeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settlementFee];
    self.settlementFee = settlementFee;
    
    UIButton* tollFeePlus = [UIButton buttonWithType:0];
    NSMutableAttributedString* str1 = [[NSMutableAttributedString alloc] initWithString:@"＋"];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:MATCHSIZE(20)] range:NSMakeRange(0, 1)];
    [tollFeePlus setAttributedTitle:str1 forState:0];
    [str1 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(@"#f5f5f5") range:NSMakeRange(0, 1)];
    tollFeePlus.layer.cornerRadius = MATCHSIZE(16);
    tollFeePlus.layer.masksToBounds = YES;
    [tollFeePlus setTitleColor:UIColorFromRGB(@"#f5f5f5") forState:0];
    tollFeePlus.backgroundColor = UIColorFromRGB(@"#ff6d00");
    [self.view addSubview:tollFeePlus];
    self.tollFeePlus = tollFeePlus;
    
    UIButton* tollFeeMinute = [UIButton buttonWithType:0];
    NSMutableAttributedString* str2 = [[NSMutableAttributedString alloc] initWithString:@"－"];
    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:MATCHSIZE(20)] range:NSMakeRange(0, 1)];
        [tollFeeMinute setAttributedTitle:str2 forState:0];
    [str2 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(@"#f5f5f5") range:NSMakeRange(0, 1)];
    tollFeeMinute.layer.cornerRadius = MATCHSIZE(16);
    tollFeeMinute.layer.masksToBounds = YES;
    [tollFeeMinute setTitleColor:UIColorFromRGB(@"#f5f5f5") forState:0];
    tollFeeMinute.backgroundColor = UIColorFromRGB(@"#ff6d00");
    [self.view addSubview:tollFeeMinute];
    self.tollFeeMinute = tollFeeMinute;
    
    UIButton* parkingFeePlus = [UIButton buttonWithType:0];
    NSMutableAttributedString* str3 = [[NSMutableAttributedString alloc] initWithString:@"＋"];
    [str3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:MATCHSIZE(20)] range:NSMakeRange(0, 1)];
    [str3 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(@"#f5f5f5") range:NSMakeRange(0, 1)];
    [parkingFeePlus setAttributedTitle:str3 forState:0];
    parkingFeePlus.layer.cornerRadius = MATCHSIZE(16);
    parkingFeePlus.layer.masksToBounds = YES;
    [parkingFeePlus setTitleColor:UIColorFromRGB(@"#f5f5f5") forState:0];
    parkingFeePlus.backgroundColor = UIColorFromRGB(@"#ff6d00");
    [self.view addSubview:parkingFeePlus];
    self.parkingFeePlus = parkingFeePlus;
    
    UIButton* parkingFeeMinute = [UIButton buttonWithType:0];
    NSMutableAttributedString* str4 = [[NSMutableAttributedString alloc] initWithString:@"－"];
    [str4 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:MATCHSIZE(20)] range:NSMakeRange(0, 1)];
    [str4 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(@"#f5f5f5") range:NSMakeRange(0, 1)];
    [parkingFeeMinute setAttributedTitle:str4 forState:0];
    parkingFeeMinute.layer.cornerRadius = MATCHSIZE(16);
    parkingFeeMinute.layer.masksToBounds = YES;
    [parkingFeeMinute setTitleColor:UIColorFromRGB(@"#f5f5f5") forState:0];
    parkingFeeMinute.backgroundColor = UIColorFromRGB(@"#ff6d00");
    [self.view addSubview:parkingFeeMinute];
    self.parkingFeeMinute = parkingFeeMinute;
}

- (void)setModel:(IndentData *)model{
    _model = model;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@车费",_model.name];
}

- (void)settlementFeeClick{
    LXQDisposingLoadAlertViewController* LoadAlertViewController = [[LXQDisposingLoadAlertViewController alloc] init];
    LoadAlertViewController.modalPresentationStyle = 2;
    [self presentViewController:LoadAlertViewController animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LoadAlertViewController dismissViewControllerAnimated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            LXQConfirmCollectionAlertViewController* ConfirmCollectionAlertViewController = [[LXQConfirmCollectionAlertViewController alloc] init];
            ConfirmCollectionAlertViewController.model = self.model;
             [self.navigationController pushViewController:ConfirmCollectionAlertViewController animated:YES];
        });
    });
   
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(1));
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navBar.mas_bottom).offset(MATCHSIZE(40));
        make.centerX.offset(0);
    }];
    
    [self.finalFare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(MATCHSIZE(40));
        make.centerX.offset(0);
    }];
    
    [self.StartPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.finalFare.mas_bottom).offset(MATCHSIZE(90));
        make.centerX.offset(0);
    }];
    
    [self.mileageFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.StartPrice.mas_bottom).offset(MATCHSIZE(50));
        make.centerX.offset(0);
    }];
    
    [self.lowCost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mileageFee.mas_bottom).offset(MATCHSIZE(50));
        make.centerX.offset(0);
    }];
    
    [self.longFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lowCost.mas_bottom).offset(MATCHSIZE(50));
        make.centerX.offset(0);
    }];
    
    [self.nightFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.longFee.mas_bottom).offset(MATCHSIZE(50));
        make.centerX.offset(0);
    }];
    
    [self.cancelFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nightFee.mas_bottom).offset(MATCHSIZE(50));
        make.centerX.offset(0);
        make.width.offset(MATCHSIZE(215));
    }];
    
    [self.tollFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelFee.mas_bottom).offset(MATCHSIZE(50));
        make.centerX.offset(0);
        make.width.offset(MATCHSIZE(215));
    }];
    
    [self.parkingFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tollFee.mas_bottom).offset(MATCHSIZE(50));
        make.centerX.offset(0);
        make.width.offset(MATCHSIZE(215));
    }];
    
    [self.preferentialFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.parkingFee.mas_bottom).offset(MATCHSIZE(50));
        make.centerX.offset(0);
    }];
    
    [self.balanceFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.preferentialFee.mas_bottom).offset(MATCHSIZE(50));
        make.centerX.offset(0);
    }];
    
    [self.settlementFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(MATCHSIZE(-50));
        make.width.offset(MATCHSIZE(600));
        make.height.offset(MATCHSIZE(80));
        make.centerX.offset(0);
    }];
    
    [self.tollFeePlus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(196));
        make.right.equalTo(self.tollFee.mas_left).offset(MATCHSIZE(-38));
        make.centerY.equalTo(self.tollFee.mas_centerY);
        make.height.equalTo(self.tollFeePlus.mas_width);
    }];
    
    [self.tollFeeMinute mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(MATCHSIZE(-196));
        make.left.equalTo(self.tollFee.mas_right).offset(MATCHSIZE(38));
        make.centerY.equalTo(self.tollFee.mas_centerY);
        make.height.equalTo(self.tollFeeMinute.mas_width);
    }];
    
    [self.parkingFeePlus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(196));
        make.right.equalTo(self.parkingFee.mas_left).offset(MATCHSIZE(-38));
        make.centerY.equalTo(self.parkingFee.mas_centerY);
        make.height.equalTo(self.parkingFeePlus.mas_width);
    }];
    
    [self.parkingFeeMinute mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(MATCHSIZE(-196));
        make.left.equalTo(self.parkingFee.mas_right).offset(MATCHSIZE(38));
        make.centerY.equalTo(self.parkingFee.mas_centerY);
        make.height.equalTo(self.parkingFeeMinute.mas_width);
    }];
}

@end
