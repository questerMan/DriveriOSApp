//
//  LXQFinalSettlementViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/2/14.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQFinalSettlementViewController.h"

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

- (void)creatUI{
    UIView* navBar = [[UIView alloc] init];
    navBar.backgroundColor = COLOR(224,224,224,1);
    [self.view addSubview:navBar];
    self.navBar = navBar;
    
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"吴先生车费";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = UIColorFromRGB(@"333333");
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"共计¥25.16元"];
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(@"#ff6d00") range:NSMakeRange(3,5)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(3, 5)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 3)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(8, 1)];
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(@"#333333") range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(@"#333333") range:NSMakeRange(8,1)];
    UILabel* finalFare = [[UILabel alloc] init];
    finalFare.attributedText = str;
    [self.view addSubview:finalFare];
    self.finalFare = finalFare;
    
    UILabel* StartPrice = [[UILabel alloc] init];
    StartPrice.text = @"起步价 : 10.00元";
    [self.view addSubview:StartPrice];
    self.StartPrice = StartPrice;
    
    UILabel* mileageFee = [[UILabel alloc] init];
    mileageFee.text = @"里程费 ：1公里/1.00元";
    [self.view addSubview:mileageFee];
    self.StartPrice = mileageFee;
    
    UILabel* lowCost = [[UILabel alloc] init];
    lowCost.text = @"低速费 ：1公里/1.00元";
    [self.view addSubview:lowCost];
    self.StartPrice = lowCost;
    
    UILabel* longFee = [[UILabel alloc] init];
    longFee.text = @"远途费 ：1公里/1.00元";
    [self.view addSubview:longFee];
    self.StartPrice = longFee;
    
    UILabel* nightFee = [[UILabel alloc] init];
    nightFee.text = @"夜间费 ：1公里/1.00元";
    [self.view addSubview:nightFee];
    self.StartPrice = nightFee;
    
    
    UILabel* cancelFee = [[UILabel alloc] init];
    cancelFee.text = @"取消费 : 05.00元";
    [self.view addSubview:cancelFee];
    self.StartPrice = cancelFee;
    
    UILabel* tollFee = [[UILabel alloc] init];
    tollFee.text = @"路桥费 : 00.10元";
    [self.view addSubview:tollFee];
    self.StartPrice = tollFee;
    
    UILabel* parkingFee = [[UILabel alloc] init];
    parkingFee.text = @"停车费 : 00.10元";
    [self.view addSubview:parkingFee];
    self.StartPrice = parkingFee;
    
    UILabel* preferentialFee = [[UILabel alloc] init];
    preferentialFee.text = @"可用优惠额 : 00.10元";
    [self.view addSubview:preferentialFee];
    self.StartPrice = preferentialFee;
    
    UILabel* settlementFee = [[UILabel alloc] init];
    settlementFee.text = @"可用余额  : 00.00元";
    [self.view addSubview:settlementFee];
    self.StartPrice = settlementFee;
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
    
    
}

@end
