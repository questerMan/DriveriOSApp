//
//  AlertView.h
//  AlertViewDemo
//
//  Created by lixin on 16/10/20.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXQPassengerGetOnAlertViewController.h"
#import "LXQreassignmentIndentAlertViewController.h"
#import "LXQRobIndentAlertViewController.h"
@interface AlertView : UIView

typedef enum {
    AlertViewTypeCenterAlertInfo,
    AlertViewTypePhoneAlert,
    AlertViewTypeCodeAlert,
    AlertViewTypeLoadAlert,
    AlertViewTypeIndentAlert,
    AlertViewTypeLoginAlert,
    AlertViewTypeDeleteIndentAlert,
    AlertViewTypeLimitLoginAlert,
    AlertViewTypeInstantIndentCommingAlert,
    AlertViewTypeIndentSucceedAlert,
    AlertViewTypeEmergencyRescueAlert,
    AlertViewTypeLoadingAlert,
    AlertViewTypePassengerGetOnAlert,
    AlertViewTypeReassignmentIndentAlert,
    AlertViewTypeSquareLodingAlert,
    AlertViewTypeRobIndentAlert,
    AlertViewTypeRobIndentAlertSuccessed
}AlertViewType;

@property (nonatomic, assign) AlertViewType addAlertViewType;

@property (nonatomic, strong)LXQPassengerGetOnAlertViewController*  passengerGetOnAlert;

@property (nonatomic, strong) LXQreassignmentIndentAlertViewController *reassignmentIndentAlertViewController;

@property (nonatomic, strong) LXQRobIndentAlertViewController *robIndentAlertViewController;

-(instancetype)initWithFrame:(CGRect)frame AndAddAlertViewType:(AlertViewType)alertViewType;

-(void)alertViewShow;

-(void)alertViewCloseWithBlock:(void (^) ())block;

/** 只显示文字 */
-(void)alertViewShowTitle:(NSString *)title
                textColor:(UIColor *)textColor;

@end
