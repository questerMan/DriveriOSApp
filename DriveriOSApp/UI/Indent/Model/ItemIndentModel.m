//
//  ItemIndentModel.m
//  DriveriOSApp
//
//  Created by lixin on 17/1/16.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import "ItemIndentModel.h"

@implementation ItemIndentModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
//重写
-(void)setValue:(id)value forKey:(NSString *)key{
    
    //数组处理（模型嵌套）
    if ([value isKindOfClass:[NSArray class]]) {
        
        for (NSDictionary *dict in value) {
            IndentData *model = [[IndentData alloc] init];
            [model setValuesForKeysWithDictionary:dict];
        }
        
        self.indentArr = value;
        
        
    }else if ([value isKindOfClass:[NSNull class]]) {
        // NSNull处理
        [self setValue:@"" forKey:key];
    }
    else {
        [super setValue:value forKey:key];
    }
    
    
}
@end
