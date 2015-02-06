//
//  LastOverChancePeyController.m
//  CricketDuniya
//
//  Created by ashok on 2/4/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "LastOverChancePeyController.h"

@interface LastOverChancePeyController ()
{
    NSMutableDictionary *objArrLastOverChance;
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
    _selected_service=2;
    [self callServiceForLastChance];
    [objSharedData bounce:sender];
    [self performSelector:@selector(stepOne) withObject:nil afterDelay:0.4];
    
}
- (IBAction)btnActionBowl:(id)sender {
    
    [objSharedData bounce:sender];
    [self performSelector:@selector(stepOne) withObject:nil afterDelay:0.4];
}
- (IBAction)btnActionSecondStepBall:(id)sender {
    [objSharedData bounce:sender];
    [self performSelector:@selector(stepTwo) withObject:nil afterDelay:0.4];
    
    
    
}
- (IBAction)btnActionAllPlay:(id)sender {
    
    [objSharedData bounce:sender];
    _lblBallbyBallCommentary.text=@"dummy text";
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
    _selected_service=1;
    [self callServiceForSchedule:@"http://api.amarujala.com/crid/last_over/last_over.json" ];
}
-(void)callServiceForLastChance
{



    NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:[objArrLastOverChance objectForKey:@"last_over"],@"last_over",@"299",@"user_id",@"bat",@"player_action",nil];

    NSString *methodName = @"http://cricapi.amarujala.com/getdata/save_last_over_chance";

        //for ActivityIndicator start
    [appDelegate startActivityIndicator:self.view withText:Progressing];

    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;

        //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
    
}

-(void)callServiceForSchedule :(NSString*)methodName
{

        //  NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:_txtFirstName.text,@"first_last_name",_txtAge.text,@"gender",@"M",@"age",@"",@"profile_img",SocialType,@"user_from",@"0",@"facebook_id",nil];

    NSDictionary* valueDic=[[NSDictionary alloc]init];


        //for ActivityIndicator start
    [appDelegate startActivityIndicator:self.view withText:Progressing];

    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;

        //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];

}

-(void)webServiceHandler:(WebserviceHandler *)webHandler recievedResponse:(NSDictionary *)dicResponce
{
    if (_selected_service==1)
        {
        //last_over_pey_chance
    objArrLastOverChance=[[dicResponce valueForKey:@"last_over_pey_chance"] objectAtIndex:0];
    NSLog(@"objArrLastOverChance:-%@",[[dicResponce valueForKey:@"last_over_pey_chance"] objectAtIndex:0]);
        // objArrMatchResult =dicResponce ;
        //[self.tblMatchResult reloadData];
    [self reloadDataOnScreen];
    [appDelegate stopActivityIndicator];
        }
    else if (_selected_service==2)
        {
        NSLog(@"LastOverChance:-%@",dicResponce );
        }


}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{

    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
        //remove it after WS call
}

@end
