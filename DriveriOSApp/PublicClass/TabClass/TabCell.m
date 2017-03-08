//
//  TabCell.m
//  DriveriOSApp
//
//  Created by lixin on 16/11/29.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "TabCell.h"

@implementation TabCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    self.lable = [[UILabel alloc] init];
    self.lable.frame = CGRectMake(0, MATCHSIZE(0), SELF_W, SELF_H);
    self.lable.textAlignment = NSTextAlignmentCenter;
    self.lable.font = [UIFont systemFontOfSize:MATCHSIZE(36)];
    self.lable.textColor = TAB_NOTSELECT_TEXTCOLOR;
    [self addSubview:self.lable];
    
    self.lable.layer.cornerRadius = self.lable.frame.size.height/2;
    self.lable.layer.masksToBounds = YES;
    self.isSelectItem = NO;
    
    self.countLabel = [FactoryClass labelWithText:@"" fontSize:MATCHSIZE(20) textColor:[UIColor whiteColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor grayColor]];
    self.countLabel.layer.cornerRadius = MATCHSIZE(10);
    self.countLabel.layer.masksToBounds = YES;
    self.countLabel.hidden = YES;
    [self addSubview:self.countLabel];
    
    
    self.indentStateIMG = [[UIImageView alloc] init];
    self.indentStateIMG.image = [UIImage imageNamed:@"up"];
    self.indentStateIMG.hidden = YES;
    [self addSubview:self.indentStateIMG];
    
    
}


-(void)setModel:(TabModel *)model{
    _model = model;
    
    [self.lable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(MATCHSIZE(40));
        make.top.equalTo(self.contentView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
        make.width.offset(model.witld+MATCHSIZE(1));
    }];
    
    [self.countLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(model.witld+MATCHSIZE(40));
        make.top.equalTo(self.contentView).offset(8);
        make.width.offset(MATCHSIZE(20));
        make.height.offset(MATCHSIZE(20));
    }];
    
    [self.indentStateIMG mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(MATCHSIZE(-40));
        make.centerY.offset(0);
        make.width.offset(MATCHSIZE(20));
        make.height.offset(MATCHSIZE(10));
    }];
    self.lable.text = model.title;
    
    if (self.isSelectItem == YES) {
    
        self.countLabel.backgroundColor = TAB_SELECT_TEXTCOLOR;
    
        self.lable.textColor = TAB_SELECT_TEXTCOLOR;

    }
    //在预约单、接机单、送机单有状态标注
    if(model.indentCount != nil){
        if ([model.indentCount intValue] > 0) {
            
            if ([model.type intValue] == 2 || [model.type intValue] == 3 || [model.type intValue] == 4) {
                self.countLabel.text = model.indentCount;
                self.countLabel.hidden = NO;
                self.indentStateIMG.hidden = NO;
                
                if(model.indentState.intValue == 0){
                    self.indentStateIMG.image = [UIImage imageNamed:@"up"];
                }else{
                    self.indentStateIMG.image = [UIImage imageNamed:@"pull-down"];
                }
            }
            
        }else{
            self.countLabel.hidden = YES;
            self.indentStateIMG.hidden = YES;
        }
    }
}


@end
