//
//  ReservationCell.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/7.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "ReservationCell.h"

@interface ReservationCell ()
@property (nonatomic, strong) UIView *bgView;//背景图

/** 出发地背景 */
@property (nonatomic, weak) UIView *tCarView;
/** 目的地背景 */
@property (nonatomic, weak) UIView *bCarView;
/** 预约时间背景 */
@property (nonatomic, weak) UIView *timeView;

/** 该派单按钮 */
@property (nonatomic, strong) UIButton *sendBtn;

@property (nonatomic, strong) AlertView *sendBtnAlert;//改派单
@end

@implementation ReservationCell

- (AlertView *)sendBtnAlert{
    if (!_sendBtnAlert) {
        _sendBtnAlert = [[AlertView alloc] initWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeReassignmentIndentAlert];
    }
    return _sendBtnAlert;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //选中无色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    /** 背景 */
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.shadowOpacity = 1;
    self.bgView.layer.shadowOffset = CGSizeMake(3, 3);
    self.bgView.layer.shadowColor = UIColorFromRGB(@"#cccccc").CGColor;
    [self addSubview:self.bgView];
    
    /** 头像图标 */
    self.headIMG = [FactoryClass imageViewWithFrame:CGRectZero Image:[UIImage imageNamed:@""] cornerRadius:MATCHSIZE(42)];
    [self.bgView addSubview:self.headIMG];
    
    /** 名字 */
    self.name = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(28) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self.bgView addSubview:self.name];
                 
    /** 电话 */
    self.number = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(32) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self.bgView addSubview:self.number];
    
    /** 出发地背景 */
    UIView* tCarView = [[UIView alloc] init];
    tCarView.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:tCarView];
    self.tCarView = tCarView;
    
    /** 目的地背景 */
    UIView* bCarView = [[UIView alloc] init];
    bCarView.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:bCarView];
    self.bCarView = bCarView;
    
    /** 预约时间背景 */
    UIView* timeView = [[UIView alloc] init];
    timeView.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:timeView];
    self.timeView = timeView;
    
    /** 上车图标 */
    self.tCarIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"positioning"]];
    [tCarView addSubview:self.tCarIMG];
    
    /** 下车图标 */
    self.bCarIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"positioning-1"]];
    [bCarView addSubview:self.bCarIMG];
    
    /** 预约时间图标 */
    self.timeIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"time"]];
    [timeView addSubview:self.timeIMG];
    
    /** 上车点 */
    self.tCarLab = [FactoryClass labelWithText:@"出发点:" fontSize:MATCHSIZE(28) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [tCarView addSubview:self.tCarLab];
    
    /** 下车点 */
    self.bCarLab = [FactoryClass labelWithText:@"目的地:" fontSize:MATCHSIZE(28) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [bCarView addSubview:self.bCarLab];
    
    /** 预约时间 */
    self.timeLab = [FactoryClass labelWithText:@"预约时间:" fontSize:MATCHSIZE(28) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [timeView addSubview:self.timeLab];
    
    /** 上车点文本 */
    self.tCarText = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:0 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [tCarView addSubview:self.tCarText];
    
    /** 下车点文本 */
    self.bCarText = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:0 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [bCarView addSubview:self.bCarText];
    
    /** 预约日期文本 */
    self.dateText = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [timeView addSubview:self.dateText];
    
    /** 预约时间文本 */
    self.timeText = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [timeView addSubview:self.timeText];
    
    /** 打电话按钮 */
    self.callBtn = [FactoryClass buttonWithFrame:CGRectZero image:[UIImage imageNamed:@"phone"]];
    
    //打电话
    [[self.callBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.number.text.length > 0 && self.number.text != nil) {
            //拨打电话
            [PublicTool callPhoneWithPhoneNum:self.number.text];
        }
    }];
    [self.bgView addSubview:self.callBtn];
    
    /** 订单状态标签 */
    self.satus = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    [self.bgView addSubview:self.satus];
    
    //详情按钮
    self.sendBtn = [UIButton buttonWithType:0];
    [self.sendBtn setImage:[UIImage imageNamed:@"send-order"] forState:0];
    [self.sendBtn sizeToFit];
    [self.sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.sendBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(26));
        make.right.offset(MATCHSIZE(-26));
        make.top.offset(MATCHSIZE(10));
        make.height.offset(MATCHSIZE(230));
    }];
    
    [self.headIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(20));
        make.top.offset(MATCHSIZE(20));
        make.height.offset(MATCHSIZE(84));
        make.width.offset(MATCHSIZE(84));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIMG.mas_right).offset(MATCHSIZE(20));
        make.top.offset(MATCHSIZE(20));
    }];
    
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_right).offset(MATCHSIZE(60));
        make.centerY.equalTo(self.name.mas_centerY);
    }];
    
    [self.tCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).offset(MATCHSIZE(30));
        make.left.offset(MATCHSIZE(120));
        make.right.offset(MATCHSIZE(-100));
        make.height.offset(MATCHSIZE(31));
    }];
    
    [self.tCarIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(0));
        make.top.offset(MATCHSIZE(0));
    }];
    
    [self.tCarLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tCarIMG.mas_right).offset(MATCHSIZE(10));
        make.centerY.offset(0);
    }];
    
    [self.tCarText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tCarLab.mas_right).offset(MATCHSIZE(10));
//        make.right.offset(0);
        make.centerY.offset(0);
    }];
    
    [self.bCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tCarView.mas_bottom).offset(MATCHSIZE(20));
        make.left.offset(MATCHSIZE(120));
        make.right.offset(MATCHSIZE(-100));
        make.height.offset(MATCHSIZE(31));
    }];
    
    [self.bCarIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(0));
        make.top.offset(MATCHSIZE(0));
    }];
    
    [self.bCarLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bCarIMG.mas_right).offset(MATCHSIZE(10));
        make.centerY.offset(0);
    }];
    
    [self.bCarText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bCarLab.mas_right).offset(MATCHSIZE(10));
//        make.right.offset(0);
        make.centerY.offset(0);
    }];
    
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bCarView.mas_bottom).offset(MATCHSIZE(20));
        make.left.offset(MATCHSIZE(116));
        make.right.offset(MATCHSIZE(-150));
        make.height.offset(MATCHSIZE(31));
    }];
    
    [self.timeIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(0));
        make.top.offset(MATCHSIZE(0));
//        make.width.offset(MATCHSIZE(29));
//        make.height.offset(MATCHSIZE(28));
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeIMG.mas_right).offset(MATCHSIZE(10));
        make.centerY.offset(0);
    }];
    
    [self.dateText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLab.mas_right).offset(MATCHSIZE(10));
//        make.right.offset(0);
        make.centerY.offset(0);
    }];
    
    [self.timeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateText.mas_right).offset(MATCHSIZE(20));
//        make.right.offset(0);
        make.centerY.offset(0);
    }];
    
    [self.callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(20));
        make.right.offset(MATCHSIZE(-20));
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.callBtn.mas_bottom).offset(MATCHSIZE(20));
        make.right.offset(MATCHSIZE(-20));
    }];
    
    [self.satus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeView.mas_centerY);
        make.right.offset(MATCHSIZE(-20));
    }];
}

- (void)sendBtnClick{
    
    [self.sendBtnAlert alertViewShow];
    
    __weak typeof(self) weakSelf = self;
    self.sendBtnAlert.reassignmentIndentAlertViewController.okBtnClick = ^{
        [weakSelf.sendBtnAlert alertViewCloseWithBlock:nil];
    };
    
    self.sendBtnAlert.reassignmentIndentAlertViewController.cancelBtnClick = ^{
        [weakSelf.sendBtnAlert alertViewCloseWithBlock:nil];
    };
}


-(void)setModel:(IndentData *)model{
    
    _model = model;
    
    [self.headIMG sd_setImageWithURL:[NSURL URLWithString:model.headIMG] placeholderImage:[UIImage imageNamed:@"userIMG"]];

    self.number.text = model.number;
    
    self.name.text = model.name;
    
    self.satus.text = model.satus;
    
    self.tCarText.text = model.startName;
    
    self.bCarText.text = model.endName;
    
    self.dateText.text = model.dateTime;
    
    self.timeText.text = model.time;
}


@end
