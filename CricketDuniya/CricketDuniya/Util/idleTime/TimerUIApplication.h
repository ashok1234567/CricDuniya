//
//  TimerUIApplication.h
//  Medlinx
//
//  Created by Vandana Chouhan on 9/9/14.
//  Copyright (c) 2014 Vandana Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
//the length of time before your application "times out". This number actually represents seconds, so we'll have to multiple it by 60 in the .m file
#define kApplicationTimeoutInMinutes 20

//the notification your AppDelegate needs to watch for in order to know that it has indeed "timed out"
#define kApplicationDidTimeoutNotification @"AppTimeOut"

@interface TimerUIApplication : UIApplication
{
    NSTimer *myidleTimer;
}
-(void)resetIdleTimer;
@end
