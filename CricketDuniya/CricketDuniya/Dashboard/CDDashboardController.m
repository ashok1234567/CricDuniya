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
#import "FullLiveScoreController.h"
#import "WhatNextController.h"
@interface CDDashboardController ()<MatchBtnSection>
{
    NSMutableDictionary*objDicLiveMatchData;
    NSArray *objTotalMatchs;
    NSString *urlLiveMatchFullScore;
}
@end

@implementation CDDashboardController

- (void)viewDidLoad {
    
    
    //firt time call notifcation service
    [objNotificationtimer CallWebService];
    
    //Start notification service for every 10 secound 
    [objNotificationtimer StartTimerForNotification];
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0f green:147/255.0f blue:74/255.0f alpha:1.0]};

    urlLiveMatchFullScore=@"";
    
    //hide match button
    self.btnMatch1.hidden=YES;
        self.btnMatch2.hidden=YES;
        self.btnMatch3.hidden=YES;
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callServiceForDashboard) name:@"loadlivescore" object:nil];
    
    //call for live score
    [self callServiceForDashboard];
    
   
}
-(void)viewWillAppear:(BOOL)animated{
  
    if(objSharedData.isComeFromPopUp==YES){
    WhatNextController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"whatnext"];
    self.navigationController.viewControllers = @[secondViewController];//mypage
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}
#pragma mark Custom methods
-(void)callMiniScore :(NSString*)matchId{
    NSMutableString *matchName=[NSMutableString string];
    [matchName appendString:@"livescore/2/"];
    [matchName appendString:[NSString stringWithFormat:@"%@", matchId]];
    [matchName appendString:@"_s.json"];

    [self callServiceForMiniScore:matchName];
}
-(void)calFullScore :(NSString*)matchId{
    NSMutableString *matchName=[NSMutableString string];
    [matchName appendString:@"livescore/2/"];
    [matchName appendString:matchId];
    [matchName appendString:@".json"];

    [self callServiceForMiniScore:matchName];
}
-(void)reloadDataOnScreen {

       NSLog(@"dicResponcelivescore:-%@",objDicLiveMatchData );


NSArray *myArray = [[objDicLiveMatchData objectForKey:@"match_time"] componentsSeparatedByString:@" "];
    
    urlLiveMatchFullScore=[objDicLiveMatchData objectForKey:@"fullscore"];
    
    NSMutableString *matchDate=[NSMutableString string];
    [matchDate appendString:[myArray objectAtIndex:0]];
    [matchDate appendString:@" "];
    [matchDate appendString:[myArray objectAtIndex:1]];
    [matchDate appendString:@" "];
    [matchDate appendString:[myArray objectAtIndex:2]];

    NSMutableString *matchTime=[NSMutableString string];
    [matchTime appendString:[myArray objectAtIndex:3]];
    [matchTime appendString:@" "];
    [matchTime appendString:[myArray objectAtIndex:4]];


    _lblMatchTime.text=matchTime;
    _lblMatchDate.text=matchDate;
    _lblMatchVenue.text=[objDicLiveMatchData objectForKey:@"match_venue"];
    _lblBatingTeamInitial.text=[objDicLiveMatchData objectForKey:@"batting_team_tinitial"];
    _lblBowlingTeamInitial.text=[objDicLiveMatchData objectForKey:@"bowling_teamt_initial"];
    _lblIningDescription.text=[objDicLiveMatchData objectForKey:@"inning_descr"];
    _lblCurrentRate.text=[objDicLiveMatchData objectForKey:@"curr_runrate"];
        //_lblRequiredRate.text=[objDicLiveMatchData objectForKey:@"requird_runrate"];

    _lblTeam2Score.text = [[objDicLiveMatchData valueForKeyPath:@"match_score.inning"] objectAtIndex:0];
    
 NSMutableString *player1=[NSMutableString string];

    if ([[objDicLiveMatchData objectForKey:@"player_1_batting_status"] isEqualToString:@"ONST"])
         {
         [player1 appendString:[objDicLiveMatchData objectForKey:@"player_1_eng"]];
         [player1 appendString:@"*"];
         }
    else
        {
        [player1 appendString:[objDicLiveMatchData objectForKey:@"player_1_eng"]];
        }

    _lblPlayer1.text=player1;

    NSMutableString *player2=[NSMutableString string];
    if ([[objDicLiveMatchData objectForKey:@"player_2_batting_status"] isEqualToString:@"ONST"])
        {
        [player2 appendString:[objDicLiveMatchData objectForKey:@"player_2_eng"]];
        [player2 appendString:@"*"];
        }
    else
        {
        [player2 appendString:[objDicLiveMatchData objectForKey:@"player_2_eng"]];
        }

    _lblPlayer1Runs.text=[objDicLiveMatchData objectForKey:@"player_1_runs"];
    _lblPlayer1Balls.text=[objDicLiveMatchData objectForKey:@"player_1_balls"];
    _lblPlayer14.text=[objDicLiveMatchData objectForKey:@"player_1_4s"];
    _lblPlayer16.text=[objDicLiveMatchData objectForKey:@"player_1_6s"];
    _lblPlayer1SR.text=[objDicLiveMatchData objectForKey:@"player_1_sr"];

    _lblPlayer2.text=player2;
    _lblPlayer2Runs.text=[objDicLiveMatchData objectForKey:@"player_2_runs"];
    _lblPlayer2Balls.text=[objDicLiveMatchData objectForKey:@"player_2_balls"];
    _lblPlayer24.text=[objDicLiveMatchData objectForKey:@"player_2_4s"];
    _lblPlayer26.text=[objDicLiveMatchData objectForKey:@"player_2_6s"];
    _lblPlayer2SR.text=[objDicLiveMatchData objectForKey:@"player_2_sr"];

    _lblBowler.text=[objDicLiveMatchData objectForKey:@"bowler_name_eng"];
    _lblBowlerRuns.text=[objDicLiveMatchData objectForKey:@"bowler_runs"];
    _lblBowlerMaidens.text=[objDicLiveMatchData objectForKey:@"bowler_maidens"];
    _lblBowlerWicket.text=[objDicLiveMatchData objectForKey:@"bowler_wickets"];
    _lblBowlerOvers.text=[objDicLiveMatchData objectForKey:@"bowler_overs"];
    _lblBowlerER.text=[objDicLiveMatchData objectForKey:@"bowler_er"];


    NSMutableDictionary*objcommetry;
    if([[objDicLiveMatchData objectForKey:@"recent_commentry"] count]>0){
    objcommetry=[[objDicLiveMatchData objectForKey:@"recent_commentry"] objectAtIndex:0];
    _lblBallbyCommenntry.text=[objcommetry objectForKey:@"comm_text"];
        [_imgCommenntry setImageWithURL:[NSURL URLWithString:[[objDicLiveMatchData valueForKeyPath:@"recent_commentry.sponsor"] objectAtIndex:0]]];
    }
    
    if([[objDicLiveMatchData valueForKey:@"match_status"] isEqualToString:@"Completed"]){
        _lblRequiredRate.hidden=YES;
        _lblCurrentRate.hidden=YES;
        _tempCR.hidden=YES;
        _tempRR.hidden=YES;
        
        _lblStatus.text=[objDicLiveMatchData valueForKey:@"match_status"];
        _lblResult.text=[objDicLiveMatchData valueForKey:@"match_status_overs_remaining"];
        _lblStatus.hidden=NO;
        _lblResult.hidden=NO;
    }else{
        _lblStatus.hidden=YES;
        _lblResult.hidden=YES;
        _lblRequiredRate.hidden=NO;
        _lblCurrentRate.hidden=NO;
        _tempCR.hidden=NO;
        _tempRR.hidden=NO;
    }

}


- (IBAction)btnMenu:(id)sender {
    
        // Dismiss keyboard (optional)
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];

        // Present the view controller
    self.frostedViewController.backgroundFadeAmount=0.2;
    self.frostedViewController.direction=REFrostedViewControllerDirectionRight;
    [self.frostedViewController presentMenuViewController];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    FullLiveScoreController *objFullLiveScoreController=[segue destinationViewController];
    objFullLiveScoreController.urlForFullScore=[NSString stringWithFormat:@"%@", urlLiveMatchFullScore];
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)callServiceForMiniScore:(NSString*)methodName{
    _selected_service=2;

    NSDictionary* valueDic=[[NSDictionary alloc]init];

        //for ActivityIndicator start
    // [self performSelector:@selector(startActivityIndicator) withObject:nil afterDelay:0.5];
   // [appDelegate startActivityIndicator:self.view withText:Progressing];

    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;

        //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];

}



-(void)callServiceForDashboard
{
    _selected_service=1;

        //  NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:_txtFirstName.text,@"first_last_name",_txtAge.text,@"gender",@"M",@"age",@"",@"profile_img",SocialType,@"user_from",@"0",@"facebook_id",nil];

    NSDictionary* valueDic=[[NSDictionary alloc]init];
    NSString *methodName = LiveScore_Url;

        //for ActivityIndicator start
    [self performSelector:@selector(startActivityIndicator) withObject:nil afterDelay:0.1];
   
     //[appDelegate performSelectorInBackground:@selector(startActivityIndicator) withObject:nil];

    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;

        //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];

}
-(void)startActivityIndicator{
     [appDelegate startActivityIndicator:self.view withText:Progressing];
}

-(void)webServiceHandler:(WebserviceHandler *)webHandler recievedResponse:(NSDictionary *)dicResponce
{

    if (_selected_service==1)
        {
        if([dicResponce valueForKey:@"microscorecard_data_items"])
            {
            NSLog(@"dicResponcelivematch:-%@",[dicResponce valueForKey:@"microscorecard_data_items"]);
               
                objTotalMatchs=[dicResponce valueForKey:@"microscorecard_data_items"];
                if ([[[objTotalMatchs objectAtIndex:0] objectForKey:@"match_status"] isEqualToString:@"No Live Match"] )
                {
                    
                    objSharedData.isCheckTrue=NO;
                    [appDelegate StopTimeForRefresh];
                    
                    ScheduleController *objScheduleController = [self.storyboard instantiateViewControllerWithIdentifier:@"schedule"];
                    self.navigationController.viewControllers = @[objScheduleController];
                }
                else
                {
                
            objDicLiveMatchData=[[dicResponce valueForKey:@"microscorecard_data_items"] objectAtIndex:0];
                
                    
                    objSharedData.Pdelegate=self;
                    //load match buttons
                    UIView *matchBtn=[objSharedData NumberOfMatchButton:[[dicResponce valueForKey:@"microscorecard_data_items"] count]];
                    [self.view addSubview:matchBtn];
                    [objSharedData.arrMatchList removeAllObjects];
                    for(int i=0;i<[objTotalMatchs count];i++){
                        [objSharedData.arrMatchList addObject:[[objTotalMatchs objectAtIndex:0] objectForKey:@"matchid"]];
                    }
                    

                //setup or reload live data
                    
                    objSharedData.strLiveMatchId=[[objTotalMatchs objectAtIndex:0] objectForKey:@"matchid"];
                    [self callMiniScore:[[objTotalMatchs objectAtIndex:0] objectForKey:@"matchid"]];

           

                               }
            }

        }
    else if (_selected_service==2)
        {
            [appDelegate StartTimeForRefresh];
        objDicLiveMatchData=dicResponce;
        [self reloadDataOnScreen];
        [appDelegate stopActivityIndicator];
        }
    


}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{

    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
        //remove it after WS call
}
-(void)selectedMatch:(id)sender{
    
    UIButton *btnSelected=(UIButton*)sender;
    
    objSharedData.strLiveMatchId=[[objTotalMatchs objectAtIndex:btnSelected.tag] objectForKey:@"matchid"];
    [self callMiniScore:[[objTotalMatchs objectAtIndex:btnSelected.tag] objectForKey:@"matchid"]];
}
//- (IBAction)btnActionMatch:(id)sender {
//    
//     [self callMiniScore:[[objTotalMatchs objectAtIndex:0] objectForKey:@"matchid"]];
//    
//}
//- (IBAction)btnActionMatch2:(id)sender {
//     [self callMiniScore:[[objTotalMatchs objectAtIndex:1] objectForKey:@"matchid"]];
//}
//
//- (IBAction)btnActionMatch3:(id)sender {
//     [self callMiniScore:[[objTotalMatchs objectAtIndex:2] objectForKey:@"matchid"]];
//}


- (IBAction)tblActionFullScore:(id)sender {
    }
@end
