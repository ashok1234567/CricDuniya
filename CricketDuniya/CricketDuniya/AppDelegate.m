//
//  AppDelegate.m
//  CricketDuniya
//
//  Created by ashok on 1/4/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "AlertDialogProgressView.h"
#import "ViewController.h"
#import "CDDashboardController.h"

#define kTimeForRefresher 60.0
AppDelegate *appDelegate;
SharedData *objSharedData;
CustomPopData *objCustomPop;
NotificationTimer *objNotificationtimer;

@interface AppDelegate ()
{
    AppLoader *objLoader;
      AlertDialogProgressView *_alertDialogProgressView;
    NSTimer *timer;
    float myTime;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    

    
    
    // Override point for customization after application launch.
     appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   
    objSharedData=[SharedData instance];
    objCustomPop=[[CustomPopData alloc]init];
     objNotificationtimer=[[NotificationTimer alloc]init];
   
   
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //call check network part
     [self callNetwork];
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"8" options:NSNumericSearch] != NSOrderedAscending)
        self.isIOS8=TRUE;
    else
        self.isIOS8=FALSE;
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, self.window.frame.size.height-4,self.window.frame.size.width,4)];
    view.backgroundColor=[UIColor redColor];
    [self.window.rootViewController.view addSubview:view];


    return YES;
}

#pragma mark - Reachability notification method

- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        self.networkStatus = FALSE;
        //No internet
    }
    else if (status == ReachableViaWiFi)
    { self.networkStatus = TRUE;
        //WiFi
    }
    else if (status == ReachableViaWWAN)
    {
        self.networkStatus = TRUE;
        //3G
    }
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}
-(void)callNetwork
{
    //use for all type of Reachability
    // Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
    // method "reachabilityChanged" will be called.
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    //Change the host name here to change the server your monitoring
    hostReach = [Reachability reachabilityWithHostName: @"www.apple.com"];
    [hostReach startNotifier];
    [self updateInterfaceWithReachability: hostReach];
    
    internetReach = [Reachability reachabilityForInternetConnection];
    [internetReach startNotifier];
    [self updateInterfaceWithReachability: internetReach];
    
    wifiReach = [Reachability reachabilityForLocalWiFi];
    [wifiReach startNotifier];
    [self updateInterfaceWithReachability: wifiReach];
    //use for all type of Reachability
}
#pragma mark - Loader methods implementation

#pragma mark - AlertDialogProgressViewDelegate methods implementation
-(void)startActivityIndicator{
    [self startActivityIndicator:nil withText:@"Data Uploading..."];
}
-(void)startActivityIndicator:(UIView *)view withText:(NSString *)text{
    
    if(_alertDialogProgressView == nil){
        _alertDialogProgressView = [[AlertDialogProgressView alloc] initWithView:appDelegate.window];
    }
    [appDelegate.window addSubview:_alertDialogProgressView];
    _alertDialogProgressView.delegate = self;
    _alertDialogProgressView.detailsLabelText = text;
    _alertDialogProgressView.taskInProgress = YES;
    [_alertDialogProgressView show:YES];
}

-(void)stopActivityIndicator{
    if (_alertDialogProgressView.taskInProgress == YES) {
        [_alertDialogProgressView hide:YES];
    }
}
-(void)StartTimeForRefresh{
    
   
    if(!timer){
          NSLog(@"Titmer Start");
   timer=[NSTimer scheduledTimerWithTimeInterval:kTimeForRefresher target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    }
}

-(void)countDown:(NSTimer *) aTimer {
   
    NSLog(@"Titmer running=%f",aTimer.timeInterval);
   
    //call server for live core
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadlivescore" object:nil];
    
    //load comman popup
    [objCustomPop callServiceForCommanPopup];
    
    //load WHAT Next popup
    [objCustomPop ShowWhatNextSmallWindow];
    
   
}
-(void)StopTimeForRefresh{
    if(timer){
    [timer invalidate];
    timer=nil;
         NSLog(@"Titmer Stop");
    }
}


@end
