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
    self.backgroundColor = [UIColor grayColor];
    //用户头像
    self.userIMG = [FactoryClass buttonWithTitle:@"" backGroundIMG:[UIImage imageNamed:@"userIMG"] textColor:[UIColor blueColor] cornerRadius:MATCHSIZE(60)];
    [self addSubview:self.userIMG];
    
    [self.userIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MATCHSIZE(15));
        make.top.equalTo(self).offset(MATCHSIZE(35));
        make.width.offset(MATCHSIZE(120));
        make.height.offset(MATCHSIZE(120));
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

    
    self.userName = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor whiteColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self addSubview:self.userName];
    
    self.starsIMG = [[UIImageView alloc] init];
    [self addSubview:self.starsIMG];

    self.starsCount = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor whiteColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self addSubview:self.starsCount];
    
    self.carType = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor whiteColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self addSubview:self.carType];
    
    self.carNumber = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(30) textColor:[UIColor whiteColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    [self addSubview:self.carNumber];
    
    
}

-(void)userIMGWithBlock:(LeftMainHeadViewBlock)block{
    _block = block;
}

-(void)getData{
    self.userName.text = @"姓名";
   CGFloat lenght = [PublicTool lengthofStr:self.userName.text AndSystemFontOfSize:MATCHSIZE(30)]+MATCHSIZE(2);
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIMG.mas_right).offset(MATCHSIZE(10));
        make.top.equalTo(self).offset(MATCHSIZE(35));
        make.width.offset(lenght);
        make.height.offset(MATCHSIZE(30));
    }];
    
    self.starsIMG.image = [UIImage imageNamed:@"starsVCount"];
    [self.starsIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName.mas_right).offset(MATCHSIZE(30));
        make.top.equalTo(self).offset(MATCHSIZE(35));
        make.width.offset(MATCHSIZE(30));
        make.height.offset(MATCHSIZE(30));
    }];
    
    self.starsCount.text = @"4.5";
    CGFloat lenght_S = [PublicTool lengthofStr:self.starsCount.text AndSystemFontOfSize:MATCHSIZE(30)]+MATCHSIZE(2);
    [self.starsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.starsIMG.mas_right).offset(MATCHSIZE(2));
        make.top.equalTo(self).offset(MATCHSIZE(35));
        make.width.offset(lenght_S);
        make.height.offset(MATCHSIZE(30));
    }];
    
    self.carType.text = @"品牌＋车型";
    CGFloat lenght_T = [PublicTool lengthofStr:self.carType.text AndSystemFontOfSize:MATCHSIZE(30)]+MATCHSIZE(2);
    [self.carType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIMG.mas_right).offset(MATCHSIZE(10));
        make.top.equalTo(self.userName.mas_bottom).offset(MATCHSIZE(25));
        make.width.offset(lenght_T);
        make.height.offset(MATCHSIZE(30));
    }];
    
    self.carNumber.text = @"车牌";
    CGFloat lenght_N = [PublicTool lengthofStr:self.carNumber.text AndSystemFontOfSize:MATCHSIZE(30)]+MATCHSIZE(2);
    [self.carNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIMG.mas_right).offset(MATCHSIZE(10));
        make.top.equalTo(self.carType.mas_bottom).offset(MATCHSIZE(25));
        make.width.offset(lenght_N);
        make.height.offset(MATCHSIZE(30));
    }];
}
@end
