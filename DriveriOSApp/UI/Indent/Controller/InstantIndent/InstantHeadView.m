//
//  InstantHeadView.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/28.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//
//=======默认字体=======
#define FontDefault [UIFont systemFontOfSize:MATCHSIZE(28)]

#import "InstantHeadView.h"
@interface InstantHeadView()

@property (nonatomic, strong) UIView *startBG;

@property (nonatomic, strong) UIView *endBG;

@property (nonatomic, strong) UILabel *startLable;

@property (nonatomic, strong) UILabel *endLable;
@end

@implementation InstantHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    self.backgroundColor = UIColorFromRGB(@"#ffffff");
    self.layer.borderWidth = MATCHSIZE(1.5);
    self.layer.borderColor = UIColorFromRGB(@"#cccccc").CGColor;
    
    
    self.startBG = [[UIView alloc] init];
    [self addSubview:self.startBG];
    
    self.startIMG = [[UIImageView alloc] init];
    self.startIMG.image = [UIImage imageNamed:@"startLcoation"];
    [self.startBG addSubview:self.startIMG];
    
    self.startLable = [[UILabel alloc] init];
    self.startLable.textAlignment = NSTextAlignmentLeft;
    self.startLable.text = @"出发地:";
    self.startLable.font = FontDefault;
    self.startLable.numberOfLines = 1;
    self.startLable.textColor = [UIColor blackColor];
    [self.startBG addSubview:self.startLable];
    
    self.startAddress = [[UILabel alloc] init];
    self.startAddress.textAlignment = NSTextAlignmentLeft;
    self.startAddress.text = @"";
    self.startAddress.font = FontDefault;
    self.startAddress.numberOfLines = 1;
    self.startAddress.textColor = [UIColor blackColor];
    [self.startBG addSubview:self.startAddress];
    
    self.endBG = [[UIView alloc] init];
    [self addSubview:self.endBG];
    
    self.endIMG = [[UIImageView alloc] init];
    self.endIMG.image = [UIImage imageNamed:@"endLcoation"];
    [self.endBG addSubview:self.endIMG];
    
    self.endLable = [[UILabel alloc] init];
    self.endLable.textAlignment = NSTextAlignmentLeft;
    self.endLable.text = @"目的地:";
    self.endLable.font = FontDefault;
    self.endLable.numberOfLines = 1;
    self.endLable.textColor = [UIColor blackColor];
    [self.endBG addSubview:self.endLable];
    
    self.endAddress = [[UILabel alloc] init];
    self.endAddress.textAlignment = NSTextAlignmentLeft;
    self.endAddress.text = @"";
    self.endAddress.numberOfLines = 1;
    self.endAddress.font = FontDefault;
    self.endAddress.textColor = [UIColor blackColor];
    [self.endBG addSubview:self.endAddress];
}

-(void)setModel:(IndentData *)model{
    _model = model;
    
    CGFloat witld = [PublicTool lengthofStr:@"目的地:" AndSystemFontOfSize:MATCHSIZE(28)] + MATCHSIZE(71);
    
    CGFloat startWitld = [PublicTool lengthofStr:model.startName AndSystemFontOfSize:MATCHSIZE(28)] + MATCHSIZE(2);
    CGFloat endWitld = [PublicTool lengthofStr:model.endName AndSystemFontOfSize:MATCHSIZE(28)] + MATCHSIZE(2);

    if (startWitld >= endWitld) {
        [self.startBG mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(self).offset(MATCHSIZE(20));
            make.height.offset(MATCHSIZE(33));
            make.width.offset(witld + startWitld);
        }];
        [self.endBG mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset((SELF_W - witld - startWitld)/2);
            make.bottom.equalTo(self).offset(MATCHSIZE(-20));
            make.height.offset(MATCHSIZE(33));
            make.width.offset(witld + endWitld);
        }];

    }else{
        [self.endBG mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.equalTo(self).offset(MATCHSIZE(-20));
            make.height.offset(MATCHSIZE(33));
            make.width.offset(witld + endWitld);
        }];
        
        [self.startBG mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset((SELF_W - witld - endWitld)/2);
            make.top.equalTo(self).offset(MATCHSIZE(20));
            make.height.offset(MATCHSIZE(33));
            make.width.offset(witld + startWitld);
        }];
    }

    [self.startIMG mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startBG).offset(0);
        make.top.equalTo(self.startBG).offset(MATCHSIZE(0));
        make.bottom.equalTo(self.startBG).offset(MATCHSIZE(0));
        make.width.offset(MATCHSIZE(25));
    }];

    [self.startLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startBG).offset(MATCHSIZE(50));
        make.top.equalTo(self.startBG).offset(MATCHSIZE(0));
        make.bottom.equalTo(self.startBG).offset(MATCHSIZE(0));
        make.width.offset(witld - MATCHSIZE(69));
    }];
    
    [self.startAddress mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startLable.mas_right).offset(MATCHSIZE(20));
        make.top.equalTo(self.startBG).offset(MATCHSIZE(0));
        make.bottom.equalTo(self.startBG).offset(MATCHSIZE(0));
        make.right.equalTo(self.startBG).offset(MATCHSIZE(0));
    }];
    
    [self.endIMG mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.endBG).offset(0);
        make.top.equalTo(self.endBG).offset(MATCHSIZE(0));
        make.bottom.equalTo(self.endBG).offset(MATCHSIZE(0));
        make.width.offset(MATCHSIZE(25));
    }];
    
    [self.endLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.endBG).offset(MATCHSIZE(50));
        make.top.equalTo(self.endBG).offset(MATCHSIZE(0));
        make.bottom.equalTo(self.endBG).offset(MATCHSIZE(0));
        make.width.offset(witld - MATCHSIZE(69));
    }];
    
    [self.endAddress mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.endLable.mas_right).offset(MATCHSIZE(20));
        make.top.equalTo(self.endBG).offset(MATCHSIZE(0));
        make.bottom.equalTo(self.endBG).offset(MATCHSIZE(0));
        make.right.equalTo(self.endBG).offset(MATCHSIZE(0));
    }];
    
    self.startAddress.text = model.startName;
    
    self.endAddress.text = model.endName;
    
    
}
@end
