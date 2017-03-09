//
//  LYKLeftMainHeadView.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/27.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "LeftMainHeadView.h"

@implementation LeftMainHeadView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    //背景颜色
    self.backgroundColor = UIColorFromRGB(@"#ffffff");
    //用户头像
    self.userIMG = [FactoryClass buttonWithTitle:@"" backGroundIMG:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://wx.qlogo.cn/mmhead/ver_1/VZwibrUAlMxJ4yfCOcBrhBfz5ib5l9IBEPpfEWRLHLnlxPbBDdUhjVmQDrZIrHOz1E8VnooevXhibpVto2ibfhX2YcMY7L780ic9cSjsDw0ndsOo/0"]]] textColor:[UIColor blueColor] cornerRadius:MATCHSIZE(57)];
    [self addSubview:self.userIMG];
    
    [self.userIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MATCHSIZE(146));
        make.top.equalTo(self).offset(MATCHSIZE(100));
        make.width.offset(MATCHSIZE(114));
        make.height.offset(MATCHSIZE(114));
    }];
    
    [[self.userIMG rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        if (_block) {
            _block();
        }

    }];
    

    //获取头像
    NSData *headData = [CacheClass getAllDataFromYYCacheWithKey:HeadIMG_KEY];
    if (headData != nil) {
        UIImage *image = [UIImage imageWithData:headData];
        [self.userIMG setBackgroundImage:image forState:UIControlStateNormal];
    }
    //接收到修改头像信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"headIMG" object:nil] subscribeNext:^(NSNotification *x) {
        UIImage *image = [UIImage imageWithData:x.userInfo[@"headIMG"]];
        [self.userIMG setBackgroundImage:image forState:UIControlStateNormal];
    }];

    
    self.userName = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(20) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self addSubview:self.userName];
    
    self.starsIMG = [[UIImageView alloc] init];
    [self addSubview:self.starsIMG];

    self.starsCount = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(20) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self addSubview:self.starsCount];
    
    self.carType = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(20) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self addSubview:self.carType];
    
    self.carModel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(20) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self addSubview:self.carModel];
    
    self.carNumber = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(20) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self addSubview:self.carNumber];
    
    
}

-(void)userIMGWithBlock:(LeftMainHeadViewBlock)block{
    _block = block;
}

-(void)getData{
    self.userName.text = @"李师傅";
    CGFloat lenght = [PublicTool lengthofStr:self.userName.text AndSystemFontOfSize:MATCHSIZE(20)]+MATCHSIZE(2);
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIMG.mas_right).offset(MATCHSIZE(10));
        make.top.equalTo(self).offset(MATCHSIZE(100));
        make.width.offset(lenght);
        make.height.offset(MATCHSIZE(20));
    }];
    
    self.starsIMG.image = [UIImage imageNamed:@"star"];
    [self.starsIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName.mas_right).offset(MATCHSIZE(20));
        make.top.equalTo(self).offset(MATCHSIZE(100));
        make.width.offset(MATCHSIZE(20));
        make.height.offset(MATCHSIZE(20));
    }];
    
    self.starsCount.text = @"4.5";
    CGFloat lenght_S = [PublicTool lengthofStr:self.starsCount.text AndSystemFontOfSize:MATCHSIZE(20)]+MATCHSIZE(2);
    [self.starsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.starsIMG.mas_right).offset(MATCHSIZE(10));
        make.top.equalTo(self).offset(MATCHSIZE(100));
        make.width.offset(lenght_S);
        make.height.offset(MATCHSIZE(20));
    }];
    
    self.carType.text = @"广汽丰田";
    CGFloat lenght_T = [PublicTool lengthofStr:self.carType.text AndSystemFontOfSize:MATCHSIZE(20)]+MATCHSIZE(2);
    [self.carType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIMG.mas_right).offset(MATCHSIZE(10));
        make.top.equalTo(self.userName.mas_bottom).offset(MATCHSIZE(20));
        make.width.offset(lenght_T);
        make.height.offset(MATCHSIZE(20));
    }];
    
    self.carModel.text = @"雷凌双擎";
    CGFloat lenght_M = [PublicTool lengthofStr:self.carModel.text AndSystemFontOfSize:MATCHSIZE(20)]+MATCHSIZE(2);
    [self.carModel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.carType.mas_right).offset(MATCHSIZE(10));
        make.top.equalTo(self.userName.mas_bottom).offset(MATCHSIZE(20));
        make.width.offset(lenght_M);
        make.height.offset(MATCHSIZE(20));
    }];
    
    self.carNumber.text = @"粤A 888888";
    CGFloat lenght_N = [PublicTool lengthofStr:self.carNumber.text AndSystemFontOfSize:MATCHSIZE(20)]+MATCHSIZE(2);
    [self.carNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIMG.mas_right).offset(MATCHSIZE(10));
        make.top.equalTo(self.carType.mas_bottom).offset(MATCHSIZE(20));
        make.width.offset(lenght_N);
        make.height.offset(MATCHSIZE(20));
    }];
}
@end
