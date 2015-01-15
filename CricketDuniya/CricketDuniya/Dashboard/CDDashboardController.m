//
//  CDDashboardController.m
//  CricketDuniya
//
//  Created by ashok on 1/5/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "CDDashboardController.h"
#import "REFrostedViewController.h"
#import "AS_CustomNavigationController.h"
#import "ScheduleController.h"
@interface CDDashboardController ()
{
    NSMutableDictionary*objDicLiveMatchData;
}
@end

@implementation CDDashboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0f green:147/255.0f blue:74/255.0f alpha:1.0]};
    
//    if(objSharedData.isNoLiveMatch){
//        AS_CustomNavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
//        ScheduleController *objScheduleController = [self.storyboard instantiateViewControllerWithIdentifier:@"schedule"];
//        
//        navigationController.viewControllers = @[objScheduleController];
//    }
    [self callServiceForDashboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Custom methods
-(void)reloadDataOnScreen {
    
    _lblTeamName1.text=[objDicLiveMatchData objectForKey:@"batting_team_tinitial"];
     _lblTeamName2.text=[objDicLiveMatchData objectForKey:@"bowling_team_tinitial"];//
     _lblAskingRunRate.text=[objDicLiveMatchData objectForKey:@"match_status"];
     _lblScoreTarget1.text=[objDicLiveMatchData objectForKey:@"inning_descr_s"];
     _lblScoreTarget2.text=[objDicLiveMatchData objectForKey:@"inning_descr_s"];
    
}
- (IBAction)btnMenu:(id)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    self.frostedViewController.backgroundFadeAmount=0.2;
    self.frostedViewController.direction=REFrostedViewControllerDirectionRight;
    [self.frostedViewController presentMenuViewController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)callServiceForDashboard
{
    
  //  NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:_txtFirstName.text,@"first_last_name",_txtAge.text,@"gender",@"M",@"age",@"",@"profile_img",SocialType,@"user_from",@"0",@"facebook_id",nil];
    
    NSDictionary* valueDic=[[NSDictionary alloc]init];
    NSString *methodName = LiveScore_Url;
    
    //for ActivityIndicator start
    [appDelegate startActivityIndicator:self.view withText:Progressing];
    
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
    
}

-(void)webServiceHandler:(WebserviceHandler *)webHandler recievedResponse:(NSDictionary *)dicResponce
{
    NSLog(@"dicResponce:-%@",[dicResponce valueForKey:@"microscorecard_data_items"]);
     [appDelegate stopActivityIndicator];
    
    if([dicResponce valueForKey:@"microscorecard_data_items"]){
        objDicLiveMatchData=[[dicResponce valueForKey:@"microscorecard_data_items"] objectAtIndex:0];
        //setup or reload live data
        
        [self reloadDataOnScreen];
    }
    
    ScheduleController *objScheduleController = [self.storyboard instantiateViewControllerWithIdentifier:@"schedule"];
    self.navigationController.viewControllers = @[objScheduleController];
    
   
    
    
    
}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{
    
    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
    //remove it after WS call
}

- (IBAction)btnActionMatch2:(id)sender {
}

- (IBAction)btnActionMatch3:(id)sender {
}
- (IBAction)tblActionFullScore:(id)sender {
}
@end
