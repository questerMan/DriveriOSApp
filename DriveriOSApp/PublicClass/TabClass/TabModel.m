//
//  TabModel.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/5.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "TabModel.h"

@implementation TabModel

-(void)setTitle:(NSString *)title{
    _title = title;
    CGFloat witld = [PublicTool lengthofStr:title AndSystemFontOfSize:MATCHSIZE(36)] + MATCHSIZE(10)*3 + MATCHSIZE(30);
    _size = CGSizeMake(witld, MATCHSIZE(80));
}

@end
