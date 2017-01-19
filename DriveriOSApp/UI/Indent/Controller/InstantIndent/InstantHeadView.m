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
    
    
    self.startIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(20), MATCHSIZE(40), MATCHSIZE(40))];
    self.startIMG.image = [UIImage imageNamed:@"start"];
    [self addSubview:self.startIMG];
    
    UILabel *startLable = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(80), MATCHSIZE(20), MATCHSIZE(120), MATCHSIZE(40))];
    startLable.textAlignment = NSTextAlignmentLeft;
    startLable.text = @"出发地:";
    startLable.font = FontDefault;
    startLable.textColor = [UIColor blackColor];
    [self addSubview:startLable];
    
    self.endIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(80), MATCHSIZE(40), MATCHSIZE(40))];
    self.endIMG.image = [UIImage imageNamed:@"end"];
    [self addSubview:self.endIMG];
    
    UILabel *endLable = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(80), MATCHSIZE(80), MATCHSIZE(120), MATCHSIZE(40))];
    endLable.textAlignment = NSTextAlignmentLeft;
    endLable.text = @"目的地:";
    endLable.font = FontDefault;
    endLable.textColor = [UIColor blackColor];
    [self addSubview:endLable];
    
    
    self.startAddress = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(210), MATCHSIZE(20),SELF_W - MATCHSIZE(200), MATCHSIZE(40))];
    self.startAddress.textAlignment = NSTextAlignmentLeft;
    self.startAddress.text = @"";
    self.startAddress.font = FontDefault;
    self.startAddress.textColor = [UIColor blackColor];
    [self addSubview:self.startAddress];
    
    self.endAddress = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(210), MATCHSIZE(80),SELF_W - MATCHSIZE(200), MATCHSIZE(40))];
    self.endAddress.textAlignment = NSTextAlignmentLeft;
    self.endAddress.text = @"";
    self.endAddress.font = FontDefault;
    self.endAddress.textColor = [UIColor blackColor];
    [self addSubview:self.endAddress];
}

-(void)setModel:(IndentData *)model{
    _model = model;
    
    self.startAddress.text = model.startName;
    
    self.endAddress.text = model.endName;
    
    
}
@end
