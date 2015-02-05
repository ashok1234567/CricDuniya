//
//  NotificationTimer.h
//  CricketDuniya
//
//  Created by ashok on 2/5/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationTimer : NSObject
{
    NSTimer *timerNoti;
}
@property(nonatomic,retain)NSMutableArray *objDicNotification;
-(void)StartTimerForNotification;
-(void)StopNotificationTime;
-(void)CallWebService;
@end
