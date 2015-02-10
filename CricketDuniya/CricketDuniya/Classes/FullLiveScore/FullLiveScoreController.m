//
//  FullLiveScoreController.m
//  CricketDuniya
//
//  Created by ashok on 1/22/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "FullLiveScoreController.h"
#import "FirstCellView.h"
#import "SecoundCellView.h"
#import "ThirdCellView.h"

//define macros
#define arrBatting @"batting"
#define arrBowling @"bowling"
#define arrMatchInfo @"matchinfo"

#define arrBattingTeam @"battingTeam"
#define arrBowlingTeam @"bowlingTeam"
#define arrBattingTeamPlayer @"battingTeamPlayer"
#define arrBowlingTeamPlayer @"bowlingTeamPlayer"

@interface FullLiveScoreController ()<WebServiceHandlerDelegate>

{
    NSMutableDictionary *objDicFullScore;

    NSMutableArray *objArrBattingTeam;
    NSMutableArray *objArtBowlingTeam;
    NSMutableArray *objArrBattingPlayer;
    NSMutableArray *objArrBowlingPlayer;

    NSMutableDictionary *objDicFullScoreInning2;
    NSMutableArray *objArrBattingTeam2;
    NSMutableArray *objArtBowlingTeam2;




    NSMutableArray *objArrMatch;
    
    NSString *battingTeam,*bowlingTeam;
  
}
@end

@implementation FullLiveScoreController
@synthesize urlForFullScore;
- (void)viewDidLoad {
    [super viewDidLoad];
    _selected_ining=0;
    // Do any additional setup after loading the view.
    objArrBattingPlayer=[[NSMutableArray alloc]initWithCapacity:0];
     [_tblFullScoreBoard registerNib:[UINib nibWithNibName:@"FirstCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell1"];
     [_tblFullScoreBoard registerNib:[UINib nibWithNibName:@"SecoundCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell2"];
     [_tblFullScoreBoard registerNib:[UINib nibWithNibName:@"ThirdCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell3"];
    
    
   NSMutableArray *objArrBatting=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3", nil];
    
     NSMutableArray *objArrBowling=[[NSMutableArray alloc]initWithObjects:@"1",@"2", nil];
     NSMutableArray *objArrMatchInfo=[[NSMutableArray alloc]initWithObjects:@"1", nil];
    objDicFullScore=[[NSMutableDictionary alloc]init];


    
}
-(void)viewWillAppear:(BOOL)animated{
    
    //cal web services for fullscore 
    [self calFullScore];
}

-(void)calFullScore {
//    NSMutableString *matchName=[NSMutableString string];
//    [matchName appendString:@"livescore/2/"];
//    [matchName appendString:@"1430"];
//    [matchName appendString:@".json"];

    [self callServiceForSchedule:urlForFullScore];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableVIew Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
           // NSLog(@"objArrBowlingPlayerCount:-%d",[[objDicFullScore valueForKey:arrBattingTeamPlayer] count]);
           return  [objArrBattingPlayer count];
            break;
        case 1:
           return  [objArrBowlingPlayer count];
            break;
        case 2:
          return 1;
            break;
            
        default:
            return 0;
            break;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"Cell1";
        
        FirstCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        cell.lblPlayerName.text=[[objArrBattingPlayer objectAtIndex:indexPath.row] valueForKey:@"player_name"];
        cell.lblRun.text=[[objArrBattingPlayer objectAtIndex:indexPath.row] valueForKey:@"player_runs"];
        cell.lblBall.text=[[objArrBattingPlayer objectAtIndex:indexPath.row] valueForKey:@"player_balls"];
        cell.lbl4s.text=[[objArrBattingPlayer objectAtIndex:indexPath.row] valueForKey:@"player_4s"];
        cell.lbl6s.text=[[objArrBattingPlayer objectAtIndex:indexPath.row] valueForKey:@"player_6s"];
        cell.lblSR.text=[[objArrBattingPlayer objectAtIndex:indexPath.row] valueForKey:@"player_sr"];
        cell.lblPlayerStatus.text=[[objArrBattingPlayer objectAtIndex:indexPath.row] valueForKey:@"wicketline"];


    return cell;
    }else  if (indexPath.section==1){
        
        static NSString *CellIdentifier = @"Cell2";
        
        SecoundCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.lblBowler.text=[[objArrBowlingPlayer objectAtIndex:indexPath.row] valueForKey:@"bowler_name_eng"];
        cell.lblOver.text=[[objArrBowlingPlayer objectAtIndex:indexPath.row] valueForKey:@"bowler_overs"];
        cell.lblMaiden.text=[[objArrBowlingPlayer objectAtIndex:indexPath.row] valueForKey:@"bowler_maidens"];
        cell.lblRuns.text=[[objArrBowlingPlayer objectAtIndex:indexPath.row] valueForKey:@"bowler_runs"];
        cell.lblWicket.text=[[objArrBowlingPlayer objectAtIndex:indexPath.row] valueForKey:@"bowler_wickets"];
        cell.lblEr.text=[[objArrBowlingPlayer objectAtIndex:indexPath.row] valueForKey:@"bowler_er"];


        return cell;
    }else {
        static NSString *CellIdentifier = @"Cell3";
        
        ThirdCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.lblMatch.text=[objArrMatch valueForKey:@"match_title"];
        cell.lblDate.text=[objArrMatch  valueForKey:@"match_time"];
        cell.lblVenue.text=[objArrMatch  valueForKey:@"match_venue"];
        cell.lblUmpires.text=[objArrMatch  valueForKey:@"umpires_1"];
        cell.lbl3rdUmpire.text=[objArrMatch  valueForKey:@"umpires_tv"];
        cell.lblMetchReferee.text=[objArrMatch  valueForKey:@"match_referees"];
        if([[objArrMatch valueForKey:@"recent_commentry"] count]>0)
        cell.lblCommentry.text=[[[objArrMatch valueForKey:@"recent_commentry"] objectAtIndex:0] valueForKey:@"comm_text"];
        cell.lblTeam1Squard.text=[NSString stringWithFormat:@"%@ Squard", [objArrMatch valueForKey:@"batting_team_tname"]];
        cell.lblTeam2squrd.text=[NSString stringWithFormat:@"%@ Squard", [objArrMatch valueForKey:@"bowling_team_tname"]];
        cell.lblTeam1.text=battingTeam;
        cell.lblTeam2.text=bowlingTeam;
         if([[objArrMatch valueForKey:@"match_status"] isEqualToString:@"Completed"]){
             cell.viewCommentryBG.hidden=YES;
         }else{
             cell.viewCommentryBG.hidden=NO;
         }
        
        return cell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section)
    {
        case 0:
            return 55.f;
            break;
        case 1:
            return 40.f;
            break;
        case 2:
            if([[objArrMatch valueForKey:@"match_status"] isEqualToString:@"Completed"]){
                 return 868.0f;
            }else{
                 return 1068.0f;
            }

           
            break;
        default: return 0;
            break;
            
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    switch (section)
    {
        case 0:
            return 180.f;
            break;
        case 1:
             return 30.f;
            break;
        case 2:
             return 50.f;
            break;
        default: return 0;
            break;
            
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    switch (section)
    {
        case 0:
            return 100.f;
            break;
        case 1:
            return 0.1f;
            break;
        case 2:
            return 0.1f;
            break;
        default: return 0.1f;
            break;
            
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
     UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0,50,50.0)];
    switch (section)
    {
        case 0:{
            
           UIView *firstHeaderView=[[[NSBundle mainBundle] loadNibNamed:@"FirstHeader" owner:self options:nil] lastObject];
            firstHeaderView.frame=header.frame;
            if(objArrMatch!=nil){

                UIButton *btn1st =(UIButton*) [firstHeaderView viewWithTag:20];
                [btn1st addTarget:self action:@selector(myIning1:) forControlEvents:UIControlEventTouchUpInside];

                UIButton *btn2st =(UIButton*) [firstHeaderView viewWithTag:21];
                [btn2st addTarget:self action:@selector(myIning2:) forControlEvents:UIControlEventTouchUpInside];

            UILabel *labelteam1=(UILabel*)[firstHeaderView viewWithTag:1];
            labelteam1.text = [objArrMatch valueForKey:@"batting_team_tinitial"];
            
            UILabel *labelteam2=(UILabel*)[firstHeaderView viewWithTag:2];
            labelteam2.text = [objArrMatch valueForKey:@"bowling_teamt_initial"];
            
            UILabel *labelteam1time=(UILabel*)[firstHeaderView viewWithTag:3];
            NSArray *myArray = [[objArrMatch valueForKey:@"match_time"] componentsSeparatedByString:@" "];
            
           
            
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
            
            
           
           
            labelteam1time.text = matchTime;
            
            UILabel *labelteam1score=(UILabel*)[firstHeaderView viewWithTag:4];
            labelteam1score.text = [objArrMatch valueForKey:@"inning_descr"];
            UILabel *labelvanue=(UILabel*)[firstHeaderView viewWithTag:5];
            labelvanue.text = [objArrMatch valueForKey:@"match_venue"];
            
            
          
            
            UILabel *labelteam1CRR=(UILabel*)[firstHeaderView viewWithTag:6];
            labelteam1CRR.text = [objArrMatch valueForKey:@"curr_runrate"];
            
            UILabel *labelteam1RRR=(UILabel*)[firstHeaderView viewWithTag:7];
            labelteam1RRR.text = [objArrMatch valueForKey:@"batting_team_tinitial"];
            UILabel *labelteam2Score=(UILabel*)[firstHeaderView viewWithTag:8];
            labelteam2Score.text = [[objArrMatch valueForKeyPath:@"match_score.inning"] objectAtIndex:0];
          
            UILabel *labelMatchDay=(UILabel*)[firstHeaderView viewWithTag:9];
            labelMatchDay.text = matchDate;
            
                
                UILabel *labelMatchStatus=(UILabel*)[firstHeaderView viewWithTag:10];
              labelMatchStatus.text= [objArrMatch valueForKey:@"match_status"];
                
                UILabel *labelMatchResult=(UILabel*)[firstHeaderView viewWithTag:11];
                 labelMatchResult.text= [objArrMatch valueForKey:@"match_status_overs_remaining"];
                
                 UILabel *labelRR1=(UILabel*)[firstHeaderView viewWithTag:100];
                 UILabel *labelRR2=(UILabel*)[firstHeaderView viewWithTag:101];
                if([[objArrMatch valueForKey:@"match_status"] isEqualToString:@"Completed"]){
                    labelteam1CRR.hidden=YES;
                    labelteam1RRR.hidden=YES;
                    labelRR1.hidden=YES;
                    labelRR2.hidden=YES;
                    labelMatchStatus.hidden=NO;
                    labelMatchResult.hidden=NO;
                }else{
                    labelMatchStatus.hidden=YES;
                    labelMatchResult.hidden=YES;
                }
            }
            
            [header addSubview:firstHeaderView];
        }
            break;
        case 1:{
            
           //SecoundHeader
            
            UIView *firstHeaderView=[[[NSBundle mainBundle] loadNibNamed:@"SecoundHeader" owner:self options:nil] lastObject];
            firstHeaderView.frame=header.frame;
            
            
//            UILabel *label=(UILabel*)[firstHeaderView viewWithTag:1];
//            label.text = @"INDIA";
            [header addSubview:firstHeaderView];
        }
            break;
        case 2:{
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0,20,100,30.0)];
            label.backgroundColor= [UIColor clearColor];
            label.textColor= [UIColor blackColor];
            label.font = [UIFont fontWithName:@"Helvetica Neue" size:11.0];
            label.text = @"MATCH INFO";
            [header addSubview:label];
        }
            break;
            
    }

   
    
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0,50,50.0)];
    switch (section)
    {
        case 0:{
            
            UIView *firstHeaderView=[[[NSBundle mainBundle] loadNibNamed:@"FirstFooter" owner:self options:nil] lastObject];
            firstHeaderView.frame=header.frame;
            
            if(objArrMatch!=nil){
            UILabel *label=(UILabel*)[firstHeaderView viewWithTag:1];
                if([[objArrMatch valueForKeyPath:@"inning.inning_items"] count]>0)
            label.text = [[[objArrMatch valueForKeyPath:@"inning.inning_items"] objectAtIndex:_selected_ining] valueForKeyPath:@"extras"];//extras
            
            UILabel *labeltotal=(UILabel*)[firstHeaderView viewWithTag:3];
            labeltotal.text = [[objArrMatch valueForKeyPath:@"match_score.inning"] objectAtIndex:_selected_ining];
            }
            [header addSubview:firstHeaderView];
        }
            break;
        case 1:{
        
        }
            break;
        case 2:{
          
        }
            break;
            
    }
    return header;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark Custom Methods

- (IBAction)btnActionCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)myIning1:(id)sender{

    objArrBattingPlayer =[[objArrMatch valueForKeyPath:@"inning.inning_items.batting_team"]objectAtIndex:0] ;


    objArrBowlingPlayer =[[objArrMatch valueForKeyPath:@"inning.inning_items.bowlers_team"]objectAtIndex:0] ;
    _selected_ining=0;
    [self.tblFullScoreBoard reloadData];
    

    NSLog(@"button was clicked");
}

- (void)myIning2:(id)sender{
    objArrBattingPlayer =[[objArrMatch valueForKeyPath:@"inning.inning_items.batting_team"]objectAtIndex:1] ;


    objArrBowlingPlayer =[[objArrMatch valueForKeyPath:@"inning.inning_items.bowlers_team"]objectAtIndex:1] ;
    _selected_ining=1;
    [self.tblFullScoreBoard reloadData];

    NSLog(@"button was clicked");
}

#pragma marg WebService

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
        //objArrLeaders =[dicResponce valueForKey:@"leaderboard"] ;

        NSLog(@"Fullscore:-%@",dicResponce);
          objArrMatch =dicResponce ;
    battingTeam=@"";
    bowlingTeam=@"";
    
    for (int i=0; i<[[objArrMatch  valueForKey:@"batting_team"] count]; i++) {
        battingTeam=[battingTeam stringByAppendingString:[[objArrMatch  valueForKey:@"batting_team"] objectAtIndex:i]];
        battingTeam=[battingTeam stringByAppendingString:@", "];
        
    }
    for (int i=0; i<[[objArrMatch  valueForKey:@"bowling_team"] count]; i++) {
       
        
        bowlingTeam=[bowlingTeam stringByAppendingString:[[objArrMatch  valueForKey:@"bowling_team"] objectAtIndex:i]];
        bowlingTeam=[bowlingTeam stringByAppendingString:@", "];
        
        
    }
    
    objArrBattingTeam =[dicResponce valueForKey:@"batting_team"] ;
    objArtBowlingTeam =[dicResponce valueForKey:@"bowling_team"] ;

         objArrBattingPlayer =[[dicResponce valueForKeyPath:@"inning.inning_items.batting_team"]objectAtIndex:0] ;


         objArrBowlingPlayer =[[dicResponce valueForKeyPath:@"inning.inning_items.bowlers_team"]objectAtIndex:0] ;

    objDicFullScoreInning2=[[dicResponce valueForKeyPath:@"inning.inning_items"]objectAtIndex:1];


        NSLog(@"inning2 %@",[[dicResponce valueForKeyPath:@"inning.inning_items"]objectAtIndex:1] );


    [objDicFullScore setValue:objArrBattingTeam forKey:arrBattingTeam];
    [objDicFullScore setValue:objArtBowlingTeam forKey:arrBowlingTeam];
    [objDicFullScore setValue:objArrBattingPlayer forKey:arrBattingTeamPlayer];
    [objDicFullScore setValue:objArrBowlingPlayer forKey:arrBowlingTeamPlayer];
    [objDicFullScore setValue:objArrMatch forKey:arrMatchInfo];

        [self.tblFullScoreBoard reloadData];
    [appDelegate stopActivityIndicator];


}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{

    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
        //remove it after WS call
}

@end
