//
//  Indent.h
//  DriveriOSApp
//
//  Created by lixin on 16/11/28.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AMMapView.h"


@interface Indent : UIViewController

@property (nonatomic, strong) AMMapView *map;

@property (nonatomic, strong) AMapNaviPoint *destinationPoint;

@property (nonatomic, strong) AMapNaviPoint *startLocatoin;

-(void)clearRoute;
@end
