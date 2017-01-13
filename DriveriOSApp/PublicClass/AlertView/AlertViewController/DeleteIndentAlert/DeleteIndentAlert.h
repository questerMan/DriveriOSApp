//
//  DeleteIndentAlert.h
//  DriveriOSApp
//
//  Created by lixin on 17/1/13.
//  Copyright © 2017年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeleteIndentAlertDelegate <NSObject>

@optional
/** 关闭alertView */
-(void)closeAlertView;
@end

@interface DeleteIndentAlert : UIViewController

@property (nonatomic, weak) id <DeleteIndentAlertDelegate> delegate;

@end
