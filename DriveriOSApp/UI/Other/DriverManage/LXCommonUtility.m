//
//  LXCommonUtility.m
//  DriveriOSApp
//
//  Created by lixin on 16/12/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "LXCommonUtility.h"

@implementation LXCommonUtility

+ (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil) {
        return NULL;
    }
    if (token == nil) {
        token = @",";
    }
    NSString *str = @"";
    if (![token isEqualToString:@","]) {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    else {
        str = [NSString stringWithString:string];
    }
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL) {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++) {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    return coordinates;
}

+ (NSArray *)pathForCoordinateString:(NSString *)coordinateString
{
    if (coordinateString.length == 0)
    {
        return nil;
    }
    
    NSUInteger count = 0;
    
    CLLocationCoordinate2D *coordinates = [LXCommonUtility coordinatesForString:coordinateString
                                                              coordinateCount:&count
                                                                   parseToken:@";"];
    
    NSMutableArray * path = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++)
    {
        CLLocation * loc = [[CLLocation alloc] initWithCoordinate:coordinates[i] altitude:0.0 horizontalAccuracy:0.0 verticalAccuracy:0.0 timestamp:[NSDate date]];
        [path addObject:loc];
    }
    return path;
}
@end
