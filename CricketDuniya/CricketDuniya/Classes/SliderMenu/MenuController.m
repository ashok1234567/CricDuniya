//
//  MenuController.m
//  CricketDuniya
//
//  Created by ashok on 1/6/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "MenuController.h"
#import "UIViewController+REFrostedViewController.h"
#import "AS_CustomNavigationController.h"
#import "CDDashboardController.h"
#import "WhatNextController.h"
#import "CategoryCustomCell.h"
#import "ResultAndNotificationCustomCell.h"
#import "ScheduleController.h"
#import "LeaderBoardController.h"
#import "MatchResultController.h"
#import "MyPageController.h"
#import "UIImageView+AFNetworking.h"
#import "LastOverChancePeyController.h"
#import <MessageUI/MessageUI.h>
@interface MenuController ()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,WebServiceHandlerDelegate>
{
    NSArray *titles;
    NSMutableArray *objDicResult;
    AS_CustomNavigationController *navigationController;
    int serviceType;
}
@end

@implementation MenuController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //test code
    self.btnCatOutlet.selected=YES;
    
    //allocation of arraes

    //objDicNotification=[[NSMutableArray alloc]initWithCapacity:0];

    objDicResult=[[NSMutableArray alloc]initWithCapacity:0];
   
    [self callServiceForSchedule:[objSharedData.logingUserInfo valueForKey:@"quiz_results"] ];
   
//    for (int i=0; i<5; i++) {
//        NSMutableDictionary *objTempDicResult=[[NSMutableDictionary alloc]init];
//        [objTempDicResult setValue:@"Match 1 Q. 5" forKey:@"date1"];
//        [objTempDicResult setValue:@"you won 30 points" forKey:@"date2"];
//        [objTempDicResult setValue:@"What will happen in this Ball" forKey:@"date3"];
//        
//            // [objDicResult addObject:objTempDicResult];
//        [objDicNotification addObject:objTempDicResult];
//    }
    
    titles = @[@"LIVE SCORE", @"WHAT NEXT", @"MY PAGE",@"LAST OVER CHANGE PEY",@"SCHEDULE",@"LEADER BOARD",@"MATCH RESULT",@"INVITE FRIENDS",@"LOG OUT"];


     [self.tblMenuAndNotification registerNib:[UINib nibWithNibName:@"CategoryCustomCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
     [self.tblMenuAndNotification registerNib:[UINib nibWithNibName:@"ResultAndNotificationCustomCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell1"];
    
    self.tblMenuAndNotification.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 0, 45.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-3, 10, 35, 35)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        if([objSharedData.logingUserInfo valueForKey:@"profile_img"]!=[NSNull null])
        [imageView setImageWithURL:[NSURL URLWithString:[objSharedData.logingUserInfo valueForKey:@"profile_img"]]] ;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 17.5;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 0.5f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 0, 24)];
        NSArray *temparr=[[objSharedData.logingUserInfo valueForKey:@"userName"] componentsSeparatedByString:@"@"];
        
        label.text =  [temparr objectAtIndex:0];
        label.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
}
-(void)viewWillAppear:(BOOL)animated{
    objSharedData.isComeFromPopUp=NO;
    objSharedData.badge51.hidden=YES;
    
}
-(void)viewDidDisappear:(BOOL)animated{
    objSharedData.badge51.hidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.btnCatOutlet.selected)
        return 40;
    else if(self.btnNotiOutlet.selected)
        return 50;
     else   return 83;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if(self.btnCatOutlet.selected)
         return [titles count];
    else if(self.btnResOutlet.selected)
        return [objDicResult count];
    else
        return [objNotificationtimer.objDicNotification count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(self.btnCatOutlet.selected){
        //lblTitle.text = titles[indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    
    CategoryCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.lblCategoryTitle.text=titles[indexPath.row];
    return cell;
    }else{
        static NSString *CellIdentifier = @"Cell1";
        
        ResultAndNotificationCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (self.btnResOutlet.selected) {

            NSMutableString *questionId=[NSMutableString string];
            [questionId appendString:@"Q. no "];
            [questionId appendString:[[objDicResult objectAtIndex:indexPath.row] valueForKey:@"question_id"]];
            cell.lblMatchQ.text=questionId;
            cell.lblPointScore.text=[[objDicResult objectAtIndex:indexPath.row] valueForKey:@"question"];
            cell.lblQuestionTitle.text=[[objDicResult objectAtIndex:indexPath.row] valueForKey:@"message"];
            cell.lblMatch.text=@"MATCH1";

            
            
        }else if (self.btnNotiOutlet.selected){
            cell.lblMatchQ.text=[[objNotificationtimer.objDicNotification objectAtIndex:indexPath.row] valueForKey:@"date1"];
            cell.lblPointScore.text=[[objNotificationtimer.objDicNotification objectAtIndex:indexPath.row] valueForKey:@"msg"];
            cell.lblQuestionTitle.text=[[objNotificationtimer.objDicNotification objectAtIndex:indexPath.row] valueForKey:@"date3"];
            
                        cell.lblline.hidden=YES;
        }
       // cell.lblCategoryTitle.text=titles[indexPath.row];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    cell.backgroundColor = [UIColor clearColor];
    //    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    //    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     if(self.btnCatOutlet.selected){
    navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    objSharedData.isCheckTrue=NO;
         
    if (indexPath.row == 0) {
        objSharedData.isCheckTrue=YES;
        CDDashboardController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
        navigationController.viewControllers = @[homeViewController];
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
        
    } else  if (indexPath.row == 1) {
        WhatNextController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"whatnext"];
        navigationController.viewControllers = @[secondViewController];//mypage
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
        
    }else if (indexPath.row == 2) {
        MyPageController *objMyPageController = [self.storyboard instantiateViewControllerWithIdentifier:@"mypage"];
        navigationController.viewControllers = @[objMyPageController];//mypage
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
        
    }else  if (indexPath.row == 4){
        
        ScheduleController *objScheduleController = [self.storyboard instantiateViewControllerWithIdentifier:@"schedule"];
        navigationController.viewControllers = @[objScheduleController];
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
        
    }else if(indexPath.row==5){
        
        LeaderBoardController *objLeaderBoardController = [self.storyboard instantiateViewControllerWithIdentifier:@"leaderboard"];
        navigationController.viewControllers = @[objLeaderBoardController];
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
        
    }else if(indexPath.row==6){
        
        MatchResultController *objMatchResultController = [self.storyboard instantiateViewControllerWithIdentifier:@"metchresult"];
        navigationController.viewControllers = @[objMatchResultController];
        //metchresult
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
        
    }else if(indexPath.row==7){
        
        [self sendInvitation];
        
        
    } else if(indexPath.row==3){
        
        LastOverChancePeyController *objLastOverChancePeyController = [self.storyboard instantiateViewControllerWithIdentifier:@"lastoverchancepey"];
        navigationController.viewControllers = @[objLastOverChancePeyController];
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
        
    } else if (indexPath.row == 8) {
        

        UINavigationController *objUINavigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"logout"];
        appDelegate.window.rootViewController=objUINavigationController;
        
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        FBSession* session = [FBSession activeSession];
        [session closeAndClearTokenInformation];
        [session close];
        [FBSession setActiveSession:nil];
        
        
        //stop timer notification refresh
        [objNotificationtimer StopNotificationTime];
        
        //stop timer for refresh live score
        [appDelegate StopTimeForRefresh];
        return;
    }
     
         //For Timer
         if( objSharedData.isCheckTrue==YES){
            // [appDelegate StartTimeForRefresh];
         }else{
              [appDelegate StopTimeForRefresh];
         }
     }
}

-(void)loadWhatNext:(int )index{
    
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnAllSliderPanalAction:(id)sender {
    
    UIButton *objtempbtn=(UIButton*)sender;
    self.btnCatOutlet.selected=NO;
    self.btnResOutlet.selected=NO;
    self.btnNotiOutlet.selected=NO;
    switch (objtempbtn.tag) {
        case 1:
            self.btnCatOutlet.selected=YES;
            break;
        case 2:
            self.btnResOutlet.selected=YES;
           
            break;
        case 3:
            self.btnNotiOutlet.selected=YES;
            
            [self callServiceForResetNotification];
            break;
            
        default:
            break;
    }
    [self.tblMenuAndNotification reloadData];
}
-(void)sendInvitation{
    
    if ([MFMailComposeViewController canSendMail]) {
    
        [self.frostedViewController hideMenuViewController];

        [objNotificationtimer StopNotificationTime];
        
        [[UINavigationBar appearance] setBackgroundImage:nil forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
        
        [UINavigationBar appearance].tintColor = [UIColor colorWithRed:58/255.0f green:147/255.0f blue:74/255.0f alpha:1.0];
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        NSArray *usersTo = [NSArray arrayWithObject: @"abc@mail.com"];
        [composeViewController setToRecipients:usersTo];
        [composeViewController setSubject:@"From Cricket duniya App"];
        
       
        //self.frostedViewController.contentViewController = navigationController;

        UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
        
        while (topController.presentedViewController) {
            topController = topController.presentedViewController;
        }
        [topController presentViewController:composeViewController animated:YES completion:nil];
        
    }
}
#pragma mark Email delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    [objNotificationtimer StartTimerForNotification];
     UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    //Add an alert in case of failure
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    [topController dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma marg WebService

-(void)callServiceForResetNotification
{
    NSDictionary* valueDic=[[NSDictionary alloc]initWithObjectsAndKeys:[objSharedData.logingUserInfo valueForKey:@"user_id"],@"user_id", nil];
    
    
    //for ActivityIndicator start
    [appDelegate startActivityIndicator:self.view withText:Progressing];
    NSString *methodName=RestNoti_Url
    
    serviceType=2;
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
}

-(void)callServiceForSchedule :(NSString*)methodName
{
    NSDictionary* valueDic=[[NSDictionary alloc]init];
        //for ActivityIndicator start
    [appDelegate startActivityIndicator:self.view withText:Progressing];

    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;

    serviceType=1;
        //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
}

-(void)webServiceHandler:(WebserviceHandler *)webHandler recievedResponse:(NSDictionary *)dicResponce
{

     NSLog(@"total_points:-%@",dicResponce);
    if(serviceType==1){
   
    objDicResult=[dicResponce valueForKey:@"win"] ;

    [self.tblMenuAndNotification reloadData];
        
    }else{
    
    }
    [appDelegate stopActivityIndicator];

}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{

    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
        //remove it after WS call
}
@end
