//
//  IndentData.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/12.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "IndentData.h"

@implementation IndentData
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

//重写
-(void)setValue:(id)value forKey:(NSString *)key{
    
    if ([value isKindOfClass:[NSNull class]]) {
        // NSNull处理
        [self setValue:@"" forKey:key];
    }
    else {
        [super setValue:value forKey:key];
    }
    
    
}
@end
