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
AppDelegate *appDelegate;
SharedData *objSharedData;
CustomPopData *objCustomPop;
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
    
    
    //call charck network part
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
    
    myTime=0;
   timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
}

-(void)countDown:(NSTimer *) aTimer {
   
    myTime=myTime+1;
    NSLog(@"Titmer running=%f",aTimer.timeInterval);

    if(myTime==30.0){
        myTime=0;
        NSLog(@"callwebservies");
    }

}

-(void)StopTimeForRefresh{
    if(timer){
    [timer invalidate];
    timer=nil;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
