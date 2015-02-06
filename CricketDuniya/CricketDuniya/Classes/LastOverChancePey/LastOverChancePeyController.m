//
//  LastOverChancePeyController.m
//  CricketDuniya
//
//  Created by ashok on 2/4/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "LastOverChancePeyController.h"

@interface LastOverChancePeyController ()<WebServiceHandlerDelegate>
{
    NSMutableDictionary *objArrLastOverChance;
        NSMutableDictionary *objDicCommenatary;
        NSMutableDictionary *objDicRuns;
    
    int ballClickCount;
    BOOL *isAlreadyPlayed;
}

@end

@implementation LastOverChancePeyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0f green:147/255.0f blue:74/255.0f alpha:1.0]};
    
    //setup view according to play
     _viewSecoundStep.alpha = 1.0;
     _viewSecoundStep.alpha = 0.0;
     _viewSecoundStep.alpha = 0.0;
    _viewsSartUp.hidden=NO;
    _viewSecoundStep.hidden=YES;
    _viewFinalPlay.hidden=YES;
    
    
    
    [self CallWebService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnMenu:(id)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    self.frostedViewController.backgroundFadeAmount=0.5 ;
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
#pragma mark GameSteps
-(void)stepOne{
        _viewsSartUp.hidden=YES;
        _viewSecoundStep.hidden=NO;
        _viewFinalPlay.hidden=YES;
        [UIView animateWithDuration:0.5 animations:^() {
            _viewSecoundStep.alpha = 1.0;
            _viewFinalPlay.alpha = 0.0;
             _viewsSartUp.alpha =0.0;
            
        }];
}
-(void)stepTwo{
    
    _viewsSartUp.hidden=YES;
    _viewSecoundStep.hidden=YES;
    _viewFinalPlay.hidden=NO;
    [UIView animateWithDuration:0.5 animations:^() {
        _viewSecoundStep.alpha = 0.0;
        _viewFinalPlay.alpha = 1.0;
        _viewsSartUp.alpha =0.0;
        
    }];
}

- (IBAction)btnActionBat:(id)sender {
   
    [self callServiceForSaveLastChance:@"bat"];
    [objSharedData bounce:sender];
    [self performSelector:@selector(stepOne) withObject:nil afterDelay:0.4];
    
}
- (IBAction)btnActionBowl:(id)sender {
    
    [self callServiceForSaveLastChance:@"bowl"];
    [objSharedData bounce:sender];
    [self performSelector:@selector(stepOne) withObject:nil afterDelay:0.4];
}
- (IBAction)btnActionSecondStepBall:(id)sender {
    [objSharedData bounce:sender];
    [self performSelector:@selector(stepTwo) withObject:nil afterDelay:0.4];
  
}
- (IBAction)btnActionAllPlay:(id)sender {
    
    [objSharedData bounce:sender];
    
    if(ballClickCount<[objDicCommenatary count]){
        
        NSMutableDictionary *temp=[objDicCommenatary valueForKey:[NSString stringWithFormat:@"%d",ballClickCount+1]];
         NSMutableDictionary *temprun=[objDicRuns valueForKey:[NSString stringWithFormat:@"%d",ballClickCount+1]];
        
        _lblBallbyBallCommentary.text=[NSString stringWithFormat:@"%@",[temp valueForKey:@"comment"]];
        
        _lblPlayer1Runs.text=[NSString stringWithFormat:@"%@",[temprun valueForKey:@"player1_run"]];
                _lblPlayer1Ball.text=[NSString stringWithFormat:@"%@",[temprun valueForKey:@"player1_balls"]];
        
        
         _lblPlayer2Runs.text=[NSString stringWithFormat:@"%@",[temprun valueForKey:@"player2_run"]];
        _lblPlayer2Ball.text=[NSString stringWithFormat:@"%@",[temprun valueForKey:@"player1_balls"]];
         ballClickCount=ballClickCount+1;
        
    }else{
        
        if(!isAlreadyPlayed){
         //Done game
        _lblBallbyBallCommentary.text=[objArrLastOverChance valueForKey:@"match_result"];
        
        //call service for set final result
        [self callServiceForSaveResultAfterPlay];
        }else {
            ShowAlert(AppName, @"You have already played");
        }
    }
   
    
    
   
}
-(void)reloadDataOnScreen {
    
    _lblAskRate.text=[objArrLastOverChance objectForKey:@"batting_requird_runrate"];
    _lblpresentRate.text=[objArrLastOverChance objectForKey:@"batting_runrate"];
    _lblPlayer1.text=[objArrLastOverChance objectForKey:@"player_1_eng"];
    _lblPlayer1Runs.text=[objArrLastOverChance objectForKey:@"player_1_runs"];
    _lblPlayer1Ball.text=[objArrLastOverChance objectForKey:@"player_1_balls"];
    _lblPlayer2.text=[objArrLastOverChance objectForKey:@"player_2_eng"];
    _lblPlayer2Runs.text=[objArrLastOverChance objectForKey:@"player_2_runs"];
    _lblPlayer2Ball.text=[objArrLastOverChance objectForKey:@"player_2_balls"];
    _lblOverBy.text=[objArrLastOverChance objectForKey:@"bowler_name_eng"];
    _lbltarget.text=[objArrLastOverChance objectForKey:@"batting_target"];
    _lblrunstowin.text=[objArrLastOverChance objectForKey:@"batting_target_text"];

}
#pragma marg WebService

-(void)CallWebService{
   
    //get first step
    [self callServiceForLastChange:LastOverChangePey_Url];
}
-(void)callServiceForSaveLastChance:(NSString*)playerType
{

    NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:[objArrLastOverChance objectForKey:@"last_over_id"],@"last_over",[objSharedData.logingUserInfo valueForKey:@"user_id"],@"user_id",playerType,@"player_action",nil];

    NSString *methodName = SaveLastOverChance_Url;

        //for ActivityIndicator start
    [appDelegate startActivityIndicator:self.view withText:Progressing];

     _selected_service=2;
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;

        //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
    
}
-(void)callServiceForSaveResultAfterPlay
{
    
    NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:[objArrLastOverChance objectForKey:@"last_over_id"],@"last_over",[objSharedData.logingUserInfo valueForKey:@"user_id"],@"user_id",[objArrLastOverChance valueForKey:@"result_flag"],@"result_flag",@"win",@"match_result",nil];
    
    NSString *methodName = SaveResultAfterPlay_Url;
    
    //for ActivityIndicator start
    [appDelegate startActivityIndicator:self.view withText:Progressing];
    
    _selected_service=3;
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
    
}


-(void)callServiceForLastChange :(NSString*)methodName
{

        //  NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:_txtFirstName.text,@"first_last_name",_txtAge.text,@"gender",@"M",@"age",@"",@"profile_img",SocialType,@"user_from",@"0",@"facebook_id",nil];

    NSDictionary* valueDic=[[NSDictionary alloc]init];


        //for ActivityIndicator start
    [appDelegate startActivityIndicator:self.view withText:Progressing];

    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;

     _selected_service=1;
        //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];

}

-(void)webServiceHandler:(WebserviceHandler *)webHandler recievedResponse:(NSDictionary *)dicResponce
{
    if (_selected_service==1)
        {
        //last_over_pey_chance
    objArrLastOverChance=[[NSMutableDictionary alloc]initWithDictionary:[[dicResponce valueForKey:@"last_over_pey_chance"] objectAtIndex:0]];
    NSLog(@"objArrLastOverChance:-%@",[[dicResponce valueForKey:@"last_over_pey_chance"] objectAtIndex:0]);
        
            isAlreadyPlayed=NO;
    [self reloadDataOnScreen];
   
    }
    else if (_selected_service==2)
        {
        NSLog(@"LastOverChance:-%@",dicResponce );
            ballClickCount=0;
            
            [objArrLastOverChance setObject:[dicResponce valueForKey:@"match_result"] forKey:@"match_result"];
            [objArrLastOverChance setObject:[dicResponce valueForKey:@"result_flag"] forKey:@"result_flag"];
            
            
            objDicCommenatary=[dicResponce valueForKey:@"commentry"];
            objDicRuns=[dicResponce valueForKey:@"runs"];
            
        }
    else if (_selected_service==3)
    {
        isAlreadyPlayed=YES;
        _lblBallbyBallCommentary.text=[dicResponce valueForKey:@"message"];
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
