//
//  DeleteIndentCell.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/13.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "DeleteIndentCell.h"

@implementation DeleteIndentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
        
    }
    return self;
}

-(void)creatUI{
    
    UILabel *line = [FactoryClass labelWithText:nil fontSize:MATCHSIZE(10) textColor:[UIColor grayColor] numberOfLine:1 textAlignment:NSTextAlignmentLeft backGroundColor:[UIColor lightGrayColor]];
    line.frame = CGRectMake(MATCHSIZE(0), MATCHSIZE(98), SELF_W, MATCHSIZE(2));
    [self addSubview:line];
    
    self.titleLab = [FactoryClass labelWithText:nil fontSize:MATCHSIZE(35) textColor:[UIColor blackColor] numberOfLine:1 textAlignment:NSTextAlignmentCenter backGroundColor:[UIColor clearColor]];
    self.textLabel.textColor = [UIColor blackColor];
    self.titleLab.frame = CGRectMake(MATCHSIZE(0), MATCHSIZE(0), SCREEN_W - MATCHSIZE(136), MATCHSIZE(98));
    [self addSubview:self.titleLab];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}


@end
