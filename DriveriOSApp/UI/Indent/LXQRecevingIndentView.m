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
//    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(MATCHSIZE(3), MATCHSIZE(3), SCREEN_W - MATCHSIZE(52), MATCHSIZE(242))];
//    self.bgView.backgroundColor = [UIColor whiteColor];
//    self.bgView.layer.cornerRadius = MATCHSIZE(8);
//    self.bgView.layer.masksToBounds = YES;
//    [self addSubview:self.bgView];
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = MATCHSIZE(8);
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [COLOR(204, 204, 204, 1) CGColor];
    self.layer.borderWidth = MATCHSIZE(3);
    
    self.titleLabel = [FactoryClass labelWithText:@"开始接驾" fontSize:MATCHSIZE(32) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1];
    [self addSubview:self.titleLabel];
    
    //伸缩按钮
    UIButton* scalingBtn = [UIButton buttonWithType:0];
    [scalingBtn setImage:[UIImage imageNamed:@"pull-up"] forState:0];
    [scalingBtn sizeToFit];
    [scalingBtn addTarget:self action:@selector(scalingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:scalingBtn];
    self.scalingBtn = scalingBtn;
    
    /** 头像图标 */
    self.headIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    self.headIMG.layer.cornerRadius = MATCHSIZE(51);
    self.headIMG.layer.masksToBounds = YES;
    [self addSubview:self.headIMG];
    
    /** 名字 */
    self.name = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:UIColorFromRGB(@"#4c4c4c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
//    self.name.frame = CGRectMake(MATCHSIZE(160), MATCHSIZE(20), MATCHSIZE(120), MATCHSIZE(60));
    [self addSubview:self.name];
    
    /** 电话 */
    self.number = [[UILabel alloc] init];
//    self.number = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(25) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
//    self.number.frame = CGRectMake(MATCHSIZE(280), MATCHSIZE(25), MATCHSIZE(200), MATCHSIZE(55));
//    [self addSubview:self.number];
    
    /** 上车图标 */
    self.tCarIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"positioning"]];
    [self addSubview:self.tCarIMG];
    
    /** 下车图标 */
    self.bCarIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"positioning-1"]];
    [self addSubview:self.bCarIMG];
    
    /** 上车点 */
    self.tCarLab = [FactoryClass labelWithText:@"出发地:" fontSize:MATCHSIZE(28) textColor:UIColorFromRGB(@"#4c4c4c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
//    self.tCarLab.frame = CGRectMake(MATCHSIZE(220), MATCHSIZE(100), MATCHSIZE(120), MATCHSIZE(50));
    [self addSubview:self.tCarLab];
    
    /** 下车点 */
    self.bCarLab = [FactoryClass labelWithText:@"目的地:" fontSize:MATCHSIZE(28) textColor:UIColorFromRGB(@"#4c4c4c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
//    self.bCarLab.frame = CGRectMake(MATCHSIZE(220), MATCHSIZE(170), MATCHSIZE(120), MATCHSIZE(50));
    [self addSubview:self.bCarLab];
    
    /** 上车点文本 */
    self.tCarText = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#4c4c4c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
//    self.tCarText.frame = CGRectMake(MATCHSIZE(340), MATCHSIZE(100), MATCHSIZE(230), MATCHSIZE(50));
    [self addSubview:self.tCarText];
    
    /** 下车点文本 */
    self.bCarText = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#4c4c4c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
//    self.bCarText.frame = CGRectMake(MATCHSIZE(340), MATCHSIZE(170), MATCHSIZE(230), MATCHSIZE(50));
    [self addSubview:self.bCarText];
    
    /** 打电话按钮 */
    self.callBtn = [UIButton buttonWithType:0];
    [self.callBtn setImage:[UIImage imageNamed:@"phone"] forState:0];
    [self.callBtn sizeToFit];
    
    //打电话
    [[self.callBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.number.text.length > 0 && self.number.text != nil) {
            //拨打电话
            [PublicTool callPhoneWithPhoneNum:self.number.text];
        }
    }];
    [self addSubview:self.callBtn];
    
    //详情按钮
    self.sendBtn = [UIButton buttonWithType:0];
    [self.sendBtn setImage:[UIImage imageNamed:@"send-order"] forState:0];
    [self.sendBtn sizeToFit];
    [self addSubview:self.sendBtn];
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
//      make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.top.offset(MATCHSIZE(20));
    }];
    
    [self.headIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(MATCHSIZE(20));
        make.top.offset(MATCHSIZE(68));
        make.width.offset(MATCHSIZE(102));
        make.height.offset(MATCHSIZE(102));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIMG.mas_right).offset(MATCHSIZE(20));
        make.top.equalTo(self.headIMG.mas_top);
    }];
    
    [self.tCarIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIMG.mas_right).offset(MATCHSIZE(20));
        make.top.equalTo(self.name.mas_bottom).offset(MATCHSIZE(20));
    }];
    
    [self.bCarIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tCarIMG.mas_bottom).offset(MATCHSIZE(30));
        make.left.equalTo(self.tCarIMG.mas_left);
    }];
    
    [self.tCarLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tCarIMG.mas_right).offset(MATCHSIZE(10));
        make.centerY.equalTo(self.tCarIMG.mas_centerY);
    }];
    
    [self.bCarLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bCarIMG.mas_right).offset(MATCHSIZE(10));
        make.centerY.equalTo(self.bCarIMG.mas_centerY);
    }];
    
    [self.tCarText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tCarLab.mas_right).offset(MATCHSIZE(10));
        make.centerY.equalTo(self.tCarLab.mas_centerY);
    }];
    
    [self.bCarText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bCarLab.mas_right).offset(MATCHSIZE(10));
        make.centerY.equalTo(self.bCarLab.mas_centerY);
    }];
    
    [self.callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MATCHSIZE(46));
        make.right.offset(MATCHSIZE(-20));
//        make.bottom.equalTo(self.sendBtn.mas_top).offset(MATCHSIZE(-58));
        make.height.offset(MATCHSIZE(51));
        make.width.offset(MATCHSIZE(50));
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(MATCHSIZE(-34));
        make.right.offset(MATCHSIZE(-20));
    }];
}

-(void)scalingBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"pull-up-1"] forState:0];
        
        self.titleLabel.textColor = UIColorFromRGB(@"#ff6d00");
        
        [self.name mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
            make.width.offset(0);
        }];
        
        [self.headIMG mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
            make.width.offset(0);
        }];
        
        [self.bCarIMG mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
            make.width.offset(0);
        }];
        
        [self.bCarLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
            make.width.offset(0);
        }];
        
        [self.bCarText mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
            make.width.offset(0);
        }];
        
        [self.callBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
            make.width.offset(0);
        }];
        
        [self.sendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
            make.width.offset(0);
        }];

        [self.tCarIMG mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(MATCHSIZE(140));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(MATCHSIZE(20));
        }];
        
        [self.tCarLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tCarIMG.mas_right).offset(MATCHSIZE(10));
            make.top.equalTo(self.tCarIMG.mas_top);
        }];
        
        [self.tCarText mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tCarLab.mas_right).offset(MATCHSIZE(10));
            make.top.equalTo(self.tCarLab.mas_top);
        }];
        
        self.frame = CGRectMake(MATCHSIZE(26), MATCHSIZE(90), SCREEN_W - 2 * MATCHSIZE(26), MATCHSIZE(126));
        
        self.headIMG.hidden = YES;
        self.name.hidden = YES;
        self.number.hidden = YES;
        self.bCarIMG.hidden = YES;
        self.bCarLab.hidden = YES;
        self.bCarText.hidden = YES;
        self.callBtn.hidden = YES;
        self.sendBtn.hidden = YES;
        
    }else{
        
        [sender setImage:[UIImage imageNamed:@"pull-up"] forState:0];
        
        self.titleLabel.textColor = UIColorFromRGB(@"#8c8c8c");
        
        [self.headIMG mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(MATCHSIZE(20));
            make.top.offset(MATCHSIZE(68));
            make.width.offset(MATCHSIZE(102));
            make.height.offset(MATCHSIZE(102));
        }];
        
        [self.name mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headIMG.mas_right).offset(MATCHSIZE(20));
            make.top.equalTo(self.headIMG.mas_top);
        }];
        
        [self.tCarIMG mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headIMG.mas_right).offset(MATCHSIZE(20));
            make.top.equalTo(self.name.mas_bottom).offset(MATCHSIZE(20));
        }];
        
        [self.bCarIMG mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tCarIMG.mas_bottom).offset(MATCHSIZE(30));
            make.left.equalTo(self.tCarIMG.mas_left);
        }];
        
        [self.tCarLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tCarIMG.mas_right).offset(MATCHSIZE(10));
            make.centerY.equalTo(self.tCarIMG.mas_centerY);
        }];
        
        [self.bCarLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bCarIMG.mas_right).offset(MATCHSIZE(10));
            make.centerY.equalTo(self.bCarIMG.mas_centerY);
        }];
        
        [self.tCarText mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tCarLab.mas_right).offset(MATCHSIZE(10));
            make.centerY.equalTo(self.tCarLab.mas_centerY);
        }];
        
        [self.bCarText mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bCarLab.mas_right).offset(MATCHSIZE(10));
            make.centerY.equalTo(self.bCarLab.mas_centerY);
        }];
        
        [self.callBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(MATCHSIZE(46));
            make.right.offset(MATCHSIZE(-20));
            //        make.bottom.equalTo(self.sendBtn.mas_top).offset(MATCHSIZE(-58));
            make.height.offset(MATCHSIZE(51));
            make.width.offset(MATCHSIZE(50));
        }];
        
        [self.sendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(MATCHSIZE(-34));
            make.right.offset(MATCHSIZE(-20));
        }];
        
        self.frame = CGRectMake(MATCHSIZE(26), MATCHSIZE(90), SCREEN_W - 2 * MATCHSIZE(26), MATCHSIZE(242));
        
        self.headIMG.hidden = NO;
        self.name.hidden = NO;
        self.number.hidden = NO;
        self.bCarIMG.hidden = NO;
        self.bCarLab.hidden = NO;
        self.bCarText.hidden = NO;
        self.callBtn.hidden = NO;
        self.sendBtn.hidden = NO;
    }
}

- (void)scalingUp{
    
}
@end
