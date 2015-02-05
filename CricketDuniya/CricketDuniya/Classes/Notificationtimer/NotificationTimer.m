//
//  NotificationTimer.m
//  CricketDuniya
//
//  Created by ashok on 2/5/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "NotificationTimer.h"
#import "AS_CustomNavigationController.h"
@implementation NotificationTimer



-(void)StartTimerForNotification{
   
    if(!timerNoti){
        NSLog(@"Titmer Start");
        timerNoti=[NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    }
}

-(void)countDown:(NSTimer *) aTimer {
    
    NSLog(@"Titmer running=%f",aTimer.timeInterval);
    
    //call server for live core
    [self CallWebService];
    
    
    
}
-(void)StopNotificationTime{
    if(timerNoti){
        [timerNoti invalidate];
        timerNoti=nil;
        NSLog(@"Titmer Stop");
    }
}

-(void)CallWebService{

     [self callServiceForSchedule:@"http://api.amarujala.com/crid/profile/1/420_notification.json" ];
}
-(void)callServiceForSchedule :(NSString*)methodName
{
    NSDictionary* valueDic=[[NSDictionary alloc]init];
    //for ActivityIndicator start
  //  [appDelegate startActivityIndicator:appDelegate.window withText:Progressing];
    
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    
    
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
}

-(void)webServiceHandler:(WebserviceHandler *)webHandler recievedResponse:(NSDictionary *)dicResponce
{
    
    
    NSLog(@"Notification service:-%@",[dicResponce valueForKeyPath:@"data.notification"]);
    _objDicNotification=[[NSMutableArray alloc]initWithCapacity:0];
    _objDicNotification=[dicResponce valueForKeyPath:@"data.notification"];
    
    if([_objDicNotification count]>0){
        
         [ objSharedData.badge51 removeFromSuperview];
        objSharedData.badge51=nil;
    objSharedData.badge51 = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d",[_objDicNotification count]]];
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AS_CustomNavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"contentController"];
   
    NSArray *temp=navigationController.navigationBar.subviews;
    
    UIButton *btn=(UIButton*)[temp lastObject];
   
    [ objSharedData.badge51  setFrame:CGRectMake(btn.frame.origin.x-btn.frame.size.width*2, btn.frame.origin.y,35, 35)];
   
    [appDelegate.window addSubview: objSharedData.badge51];
    }else{
        [objSharedData.badge51 removeFromSuperview];
        objSharedData.badge51=nil;
}
  
    
}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{
    
    NSLog(@"dicResponce:-%@",[error description]);
    
    
    [appDelegate stopActivityIndicator];
    //remove it after WS call
}
@end
