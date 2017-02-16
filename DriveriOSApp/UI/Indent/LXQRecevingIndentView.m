//
//  LXQRecevingIndentView.m
//  DriveriOSApp
//
//  Created by mac on 17/1/18.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "LXQRecevingIndentView.h"

@interface LXQRecevingIndentView()

@property (nonatomic, strong) UIView *bgView;//背景图

@end

@implementation LXQRecevingIndentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    /** 背景 */
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(26), MATCHSIZE(10), SCREEN_W - MATCHSIZE(26) * 2, MATCHSIZE(242))];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = MATCHSIZE(8);
    self.bgView.layer.masksToBounds = YES;
    [self addSubview:self.bgView];
    
    self.titleLabel = [FactoryClass labelWithText:@"开始接驾" fontSize:MATCHSIZE(32) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1];
    [self.bgView addSubview:self.titleLabel];
    
    self.scalingBtn = [UIButton buttonWithType:0];
    [self.scalingBtn setBackgroundImage:[UIImage imageNamed:@"pull-up"] forState:0];
    self.scalingBtn.backgroundColor = [UIColor blackColor];
    [self.bgView addSubview:self.scalingBtn];
    
    /** 头像图标 */
    self.headIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    [self.bgView addSubview:self.headIMG];
    
    /** 名字 */
    self.name = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
//    self.name.frame = CGRectMake(MATCHSIZE(160), MATCHSIZE(20), MATCHSIZE(120), MATCHSIZE(60));
    [self.bgView addSubview:self.name];
    
//    /** 电话 */
//    self.number = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(25) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
//    self.number.frame = CGRectMake(MATCHSIZE(280), MATCHSIZE(25), MATCHSIZE(200), MATCHSIZE(55));
//    [self.bgView addSubview:self.number];
    
    /** 上车图标 */
    self.tCarIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"start"]];
    [self.bgView addSubview:self.tCarIMG];
    
    /** 下车图标 */
    self.bCarIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"end"]];
    [self.bgView addSubview:self.bCarIMG];
    
    /** 上车点 */
    self.tCarLab = [FactoryClass labelWithText:@"出发地:" fontSize:MATCHSIZE(28) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
//    self.tCarLab.frame = CGRectMake(MATCHSIZE(220), MATCHSIZE(100), MATCHSIZE(120), MATCHSIZE(50));
    [self.bgView addSubview:self.tCarLab];
    
    /** 下车点 */
    self.bCarLab = [FactoryClass labelWithText:@"目的地:" fontSize:MATCHSIZE(28) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
//    self.bCarLab.frame = CGRectMake(MATCHSIZE(220), MATCHSIZE(170), MATCHSIZE(120), MATCHSIZE(50));
    [self.bgView addSubview:self.bCarLab];
    
    /** 上车点文本 */
    self.tCarText = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(28) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
//    self.tCarText.frame = CGRectMake(MATCHSIZE(340), MATCHSIZE(100), MATCHSIZE(230), MATCHSIZE(50));
    [self.bgView addSubview:self.tCarText];
    
    /** 下车点文本 */
    self.bCarText = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(28) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
//    self.bCarText.frame = CGRectMake(MATCHSIZE(340), MATCHSIZE(170), MATCHSIZE(230), MATCHSIZE(50));
    [self.bgView addSubview:self.bCarText];
    
    /** 打电话按钮 */
    self.callBtn = [UIButton buttonWithType:0];
    [self.callBtn setImage:[UIImage imageNamed:@"phone"] forState:0];
    
    //打电话
    [[self.callBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.number.text.length > 0 && self.number.text != nil) {
            //拨打电话
            [PublicTool callPhoneWithPhoneNum:self.number.text];
        }
    }];
    [self.bgView addSubview:self.callBtn];
    
    //详情按钮
    self.sendBtn = [UIButton buttonWithType:0];
    [self.sendBtn setImage:[UIImage imageNamed:@"send-order"] forState:0];
    [self.bgView addSubview:self.sendBtn];
}


-(void)setModel:(IndentData *)model{
    
    _model = model;
    
    [self.headIMG sd_setImageWithURL:[NSURL URLWithString:model.headIMG] placeholderImage:[UIImage imageNamed:@"userIMG"]];
    
    self.number.text = model.number;
    
    self.name.text = model.name;
    
  //self.satus.text = model.satus;
    
    self.tCarText.text = model.startName;
    
    self.bCarText.text = model.endName;
    
  //self.timeText.text = model.time;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(20));
        make.left.offset(MATCHSIZE(270));
    }];
    
    [self.scalingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(MATCHSIZE(10));
        make.right.offset(MATCHSIZE(270));
        make.centerY.equalTo(self.titleLabel.mas_centerY);
    }];
    
    
}
@end
