//
//  MyIndentCell.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/11.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//


#import "MyIndentCell.h"

@interface MyIndentCell()
    
@property (nonatomic, strong) UIImageView *bgView;

@end

@implementation MyIndentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
        
    }
    return self;
}

-(void)creatUI{
    //选中无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //背景
    self.backgroundColor = UIColorFromRGB(@"#f5f5f5");
    
    self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(26), MATCHSIZE(0), (SCREEN_W - MATCHSIZE(52)), MATCHSIZE(235))];
    self.bgView.image = [UIImage imageNamed:@"myindentCell"];
    [self.contentView addSubview:self.bgView];
    
    self.typeLabel = [FactoryClass labelWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(20), MATCHSIZE(300), MATCHSIZE(30)) TextColor:UIColorFromRGB(@"#333333") fontBoldSize:MATCHSIZE(32)];
    self.typeLabel.font = [UIFont systemFontOfSize:MATCHSIZE(32)];
    self.typeLabel.numberOfLines = 1;
    self.typeLabel.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:self.typeLabel];
    
    UIImageView *stateIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"return-1"]];
    [self.bgView addSubview:stateIMG];
    [stateIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(MATCHSIZE(-20));
        make.top.offset(MATCHSIZE(20));
        make.width.offset(MATCHSIZE(15));
        make.height.offset(MATCHSIZE(30));
    }];
    
    //
    self.stateLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(32) textColor:UIColorFromRGB(@"#cccccc") numberOfLine:1 textAlignment:NSTextAlignmentRight backGroundColor:[UIColor clearColor]];
    [self.bgView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(stateIMG.mas_left).offset(MATCHSIZE(-10));
        make.top.offset(MATCHSIZE(20));
        make.width.offset(MATCHSIZE(200));
        make.height.offset(MATCHSIZE(30));
    }];
    
    UIImageView *timeIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(80), MATCHSIZE(25), MATCHSIZE(25))];
    timeIMG.image = [UIImage imageNamed:@"time"];
    [self.bgView addSubview:timeIMG];
    
    self.timeLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(28) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.timeLabel.frame = CGRectMake(MATCHSIZE(55), MATCHSIZE(80), MATCHSIZE(500), MATCHSIZE(25));
    [self.bgView addSubview:self.timeLabel];
    
    
    UIImageView *startIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(135), MATCHSIZE(22), MATCHSIZE(25))];
    startIMG.image = [UIImage imageNamed:@"position"];
    [self.bgView addSubview:startIMG];
    
    self.startPalceLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.startPalceLabel.frame = CGRectMake(MATCHSIZE(55), MATCHSIZE(135), MATCHSIZE(500), MATCHSIZE(25));
    [self.bgView addSubview:self.startPalceLabel];
    
    UIImageView *endIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(20), MATCHSIZE(190), MATCHSIZE(22), MATCHSIZE(25))];
    endIMG.image = [UIImage imageNamed:@"location-1"];
    [self.bgView addSubview:endIMG];
    
    self.endPalceLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(26) textColor:UIColorFromRGB(@"#8c8c8c") numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor clearColor]];
    self.endPalceLabel.frame = CGRectMake(MATCHSIZE(55), MATCHSIZE(190), MATCHSIZE(500), MATCHSIZE(25));
    [self.bgView addSubview:self.endPalceLabel];

}



-(void)setModel:(MyIndentModel *)model{
    _model = model;

    self.typeLabel.text = model.type;
    
    self.timeLabel.text = model.timeData;
    
    self.startPalceLabel.text = model.startPlace;
    
    self.endPalceLabel.text = model.endPlace;
    
    self.stateLabel.text = model.state;
 
}

@end
