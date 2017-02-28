//
//  LXQConfirmCollectionAlertViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/2/28.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQConfirmCollectionAlertViewController.h"

@interface LXQConfirmCollectionAlertViewController ()

@property (nonatomic, strong) AMMapView *map;

@property (nonatomic, weak) UIView* confirmCollectionView;

@property (nonatomic, weak) UIView* titleView;

@property (nonatomic, weak) UILabel* titleLabel;

@property (nonatomic, weak) UIView* leftLineView;

@property (nonatomic, weak) UIView* rightLineView;

@property (nonatomic, weak) UIView* downLineView;

@property (nonatomic, weak) UILabel* receivableLabel;

@property (nonatomic, weak) UILabel* paidLabel;

@property (nonatomic, weak) UIButton* insteadTopUpBtn;

@property (nonatomic, weak) UILabel* tipsLabel;

@property (nonatomic, weak) UIView* finishLineView;

@property (nonatomic, weak) UIButton* finishBtn;

@end

@implementation LXQConfirmCollectionAlertViewController

-(AMMapView *)map{
    if (!_map) {
        _map = [[AMMapView alloc] initWithFrame:self.view.bounds];
    }
    return _map;
}

-(void)creatAMMap{
    
    [self.view addSubview:self.map];
    
    [self.map mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(MATCHSIZE(0));
    }];
}

- (void)creatNav{
    self.title = @"服务结束";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:0 target:self action:@selector(leftBtnClick)];
}

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)creatTitleView{
    UIView* confirmCollectionView = [[UIView alloc] init];
    confirmCollectionView.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    [self.view addSubview:confirmCollectionView];
    self.confirmCollectionView = confirmCollectionView;
    
    UIView* titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor whiteColor];
    [confirmCollectionView addSubview:titleView];
    self.titleView = titleView;
    
    UILabel* titleLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#333333") fontSize:MATCHSIZE(36)];
    titleLabel.text = @"确认收款";
    [titleView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIView* leftLineView = [[UIView alloc] init];
    leftLineView.backgroundColor = UIColorFromRGB(@"#cccccc");
    [titleView addSubview:leftLineView];
    self.leftLineView = leftLineView;
    
    UIView* rightLineView = [[UIView alloc] init];
    rightLineView.backgroundColor = UIColorFromRGB(@"#cccccc");
    [titleView addSubview:rightLineView];
    self.rightLineView = rightLineView;
    
    UIView* downLineView = [[UIView alloc] init];
    downLineView.backgroundColor = UIColorFromRGB(@"#cccccc");
    [confirmCollectionView addSubview:downLineView];
    self.downLineView = downLineView;
    
    UILabel* receivableLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#8c8c8c") fontSize:MATCHSIZE(30)];
    receivableLabel.text = @"应收现金： 25.10元";
    [confirmCollectionView addSubview:receivableLabel];
    self.receivableLabel = receivableLabel;
    
    UILabel* paidLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#8c8c8c") fontSize:MATCHSIZE(30)];
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:@"应收现金： 25.10元" attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(@"#8c8c8c"),NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(30)]}];
    [str addAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00"),NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(30)]} range:NSMakeRange(0, 5)];
    paidLabel.attributedText = str;
    [confirmCollectionView addSubview:paidLabel];
    self.paidLabel = paidLabel;
    
    UIButton* insteadTopUpBtn = [UIButton buttonWithType:0];
    [insteadTopUpBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"立即代充值 >>" attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(@"#cccccc"),NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(28)]}] forState:0];
    [confirmCollectionView addSubview:insteadTopUpBtn];
    self.insteadTopUpBtn = insteadTopUpBtn;
    
    UILabel* tipsLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#b2b2b2") fontSize:MATCHSIZE(24)];
    tipsLabel.text = @"提示：请提醒乘客在线支付余款，或者收取乘客现金后，通过代充值功能收取余款";
    tipsLabel.numberOfLines = 0;
    [confirmCollectionView addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
    
    UIView* finishLineView = [[UIView alloc] init];
    finishLineView.backgroundColor = UIColorFromRGB(@"#cccccc");
    [confirmCollectionView addSubview:finishLineView];
    self.finishLineView = finishLineView;
    
    UIButton* finishBtn = [UIButton buttonWithType:0];
    [finishBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"完成" attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(@"#333333"),NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(36)]}] forState:0];
    [finishBtn setBackgroundColor:UIColorFromRGB(@"#d9d9d9")];
    [confirmCollectionView addSubview:finishBtn];
    self.finishBtn = finishBtn;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.confirmCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(MATCHSIZE(678));
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.top.offset(0);
        make.height.offset(MATCHSIZE(80));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
//        make.left.equalTo(self.leftLineView.mas_right).offset(MATCHSIZE(30));
        make.centerY.offset(0);
    }];
    
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(26));
        make.width.offset(MATCHSIZE(250));
        make.centerY.offset(0);
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(-26));
        make.right.equalTo(self.titleLabel.mas_right).offset(MATCHSIZE(30));
        make.centerY.offset(0);
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.downLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.receivableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).offset(MATCHSIZE(98));
        make.centerX.offset(0);
    }];
    
    [self.paidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.receivableLabel.mas_bottom).offset(MATCHSIZE(30));
        make.centerX.offset(0);
    }];
    
    [self.insteadTopUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.paidLabel.mas_bottom).offset(MATCHSIZE(70));
        make.centerX.offset(0);
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.insteadTopUpBtn.mas_bottom).offset(MATCHSIZE(70));
        make.width.offset(MATCHSIZE(570));
        make.centerX.offset(0);
    }];
    
    [self.finishLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.finishBtn.mas_top).offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(98));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatAMMap];
    
    [self creatNav];
    
    [self creatTitleView];
}



@end
