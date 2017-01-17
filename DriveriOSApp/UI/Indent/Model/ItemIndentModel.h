//
//  ItemIndentModel.h
//  DriveriOSApp
//
//  Created by lixin on 17/1/16.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IndentData.h"

@interface ItemIndentModel : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *indentArr;
@end
