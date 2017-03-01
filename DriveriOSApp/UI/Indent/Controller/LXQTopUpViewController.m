//
//  LXQTopUpViewController.m
//  DriveriOSApp
//
//  Created by mac on 17/3/1.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQTopUpViewController.h"

@interface LXQTopUpViewController ()

@property(nonatomic, weak)UIImageView* nameIMG;

@property(nonatomic, weak)UILabel* nameLabel;

@property(nonatomic, weak)UIView* middleView;

@property(nonatomic, weak)UIView* middleLineView;

@property(nonatomic, weak)UILabel* topUpLabel;

@property(nonatomic, weak)UITextField* topUpTeF;

@property(nonatomic, weak)UIView* downLineView;

@property(nonatomic, weak)UITextField* noteTeF;

@property(nonatomic, weak)UIButton* confirmBtn;

@property(nonatomic, weak)UIView* confirmBtnLineView;

@end

@implementation LXQTopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatNAV];
    
    [self creatUI];
}

- (void)creatUI{
    self.view.backgroundColor = COLOR(245, 245, 245, 1);
    
    UIImageView* nameIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];;
    [nameIMG sd_setImageWithURL:[NSURL URLWithString:_model.headIMG] placeholderImage:[UIImage imageNamed:@"userIMG"]];
    nameIMG.layer.cornerRadius = MATCHSIZE(125) / 2.0;
    nameIMG.layer.masksToBounds = YES;
    [self.view addSubview:nameIMG];
    self.nameIMG = nameIMG;
    
    UILabel* nameLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#8c8c8c") fontSize:MATCHSIZE(32)];
    nameLabel.text = self.model.name;
    [self.view addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UIView* middleView = [[UIView alloc] init];
    middleView.backgroundColor = UIColorFromRGB(@"#ffffff");
    middleView.layer.shadowColor = [UIColorFromRGB(@"#cccccc") CGColor];
    middleView.layer.shadowOffset = CGSizeMake(0, MATCHSIZE(5));
//    middleView.layer.shadowRadius = MATCHSIZE(1);
    middleView.layer.opacity = 1;
    [self.view addSubview:middleView];
    self.middleView = middleView;
    
    UIView* middleLineView = [[UIView alloc] init];
    middleLineView.backgroundColor = UIColorFromRGB(@"#cccccc");
    [self.view addSubview:middleLineView];
    self.middleLineView = middleLineView;
    
    UILabel* topUpLabel = [FactoryClass labelWithTextColor:UIColorFromRGB(@"#b3b3b3") fontSize:MATCHSIZE(28)];
    topUpLabel.text = @"代充值金额";
    [middleView addSubview:topUpLabel];
    self.topUpLabel = topUpLabel;
    
    UITextField* topUpTeF = [FactoryClass textFieldWithFrame:CGRectZero placeholder:@"¥0.00" placeholderColor:UIColorFromRGB(@"#b3b3b3")  textColor:UIColorFromRGB(@"#ff6d00") backgroundColor:nil textAlignment:NSTextAlignmentCenter cornerRadius:0 itemImage:nil keyboardType:0];
    topUpTeF.font = [UIFont systemFontOfSize:MATCHSIZE(40)];
    [middleView addSubview:topUpTeF];
    self.topUpTeF = topUpTeF;
    
    UIView* downLineView = [[UIView alloc] init];
    downLineView.backgroundColor = COLOR(222, 222, 222, 1);
    [middleView addSubview:downLineView];
    self.downLineView = downLineView;
    
    UITextField* noteTeF = [FactoryClass textFieldWithFrame:CGRectZero placeholder:@"添加备注(20字以内)" placeholderColor:UIColorFromRGB(@"#b3b3b3")  textColor:UIColorFromRGB(@"#000000") backgroundColor:nil textAlignment:NSTextAlignmentLeft cornerRadius:0 itemImage:nil keyboardType:0];
    noteTeF.font = [UIFont systemFontOfSize:MATCHSIZE(24)];
    [middleView addSubview:noteTeF];
    self.noteTeF = noteTeF;
    
    UIButton* confirmBtn = [UIButton buttonWithType:0];
    [confirmBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:@"确定" attributes:@{NSForegroundColorAttributeName : UIColorFromRGB(@"#ff6d00"),NSFontAttributeName : [UIFont systemFontOfSize:MATCHSIZE(32)]}] forState:0];
    [confirmBtn setBackgroundColor:[UIColor whiteColor]];
    confirmBtn.layer.cornerRadius = MATCHSIZE(16);
    confirmBtn.layer.shadowOffset = CGSizeMake(0, MATCHSIZE(5));
    confirmBtn.layer.shadowColor = [UIColorFromRGB(@"#e0e0e0") CGColor];
    confirmBtn.layer.opacity = 1;
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    self.confirmBtn = confirmBtn;
    
//    UIView* confirmBtnLineView = [[UIView alloc] init];
//    confirmBtnLineView.backgroundColor = UIColorFromRGB(@"#e0e0e0");
//    [self.view addSubview:confirmBtnLineView];
//    self.confirmBtnLineView = confirmBtnLineView;

}

- (void)setModel:(IndentData *)model{
    
    _model = model;
    
    [self.nameIMG sd_setImageWithURL:[NSURL URLWithString:_model.headIMG] placeholderImage:[UIImage imageNamed:@"userIMG"]];
    
    self.nameLabel.text = _model.name;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

    [self.nameIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(MATCHSIZE(118));
        make.width.offset(MATCHSIZE(125));
        make.height.offset(MATCHSIZE(125));
    }];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameIMG.mas_bottom).offset(MATCHSIZE(30));
        make.centerX.offset(0);
    }];

    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(MATCHSIZE(112));
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(196));
    }];
    
    [self.middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.mas_bottom);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.topUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(26));
        make.top.offset(MATCHSIZE(20));
    }];
    
    [self.topUpTeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topUpLabel.mas_bottom).offset(MATCHSIZE(20));
        make.centerX.offset(0);
        make.width.offset(MATCHSIZE(200));
        make.height.offset(MATCHSIZE(40));
    }];
    
    [self.downLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(132));
        make.left.offset(MATCHSIZE(26));
        make.right.offset(MATCHSIZE(-26));
        make.height.offset(MATCHSIZE(1));
    }];
    
    [self.noteTeF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.downLineView.mas_bottom).offset(MATCHSIZE(10));
        make.left.offset(MATCHSIZE(26));
        make.right.offset(MATCHSIZE(-26));
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(MATCHSIZE(80));
        make.left.offset(MATCHSIZE(26));
        make.right.offset(MATCHSIZE(-26));
        make.bottom.offset(MATCHSIZE(-268));
    }];
    
    [self.confirmBtnLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmBtn.mas_bottom);
        make.left.equalTo(self.confirmBtn.mas_left).offset(MATCHSIZE(16));
        make.right.equalTo(self.confirmBtn.mas_right).offset(MATCHSIZE(-16));
        make.height.offset(MATCHSIZE(2));
    }];
}

- (void)creatNAV{
    self.title = @"代充值";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:0 target:self action:@selector(leftBtnClick)];
}

- (void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)confirmBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
