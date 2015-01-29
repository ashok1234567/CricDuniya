//
//  AppDelegate.h
//  CricketDuniya
//
//  Created by ashok on 1/4/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CustomPopData.h"
@class AppDelegate;
extern AppDelegate *appDelegate;
@class SharedData;
@class Reachability;
extern AppDelegate *appDelegate;
extern SharedData *objSharedData;
@class CustomPopData;
extern CustomPopData *objCustomPop;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    //use for all type of Reachability
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
    //use for all type of Reachability

}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL networkStatus;
@property (nonatomic, assign) BOOL bool_isIOS7BtnSpace;
@property (nonatomic, assign) BOOL isIphone5, isIOS8;

-(void)StartTimeForRefresh;
-(void)StopTimeForRefresh;


//Methods
-(void)startActivityIndicator:(UIView *)view withText:(NSString *)text;
-(void)stopActivityIndicator;

@end

