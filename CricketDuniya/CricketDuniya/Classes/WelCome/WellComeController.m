//
//  WellComeController.m
//  CricketDuniya
//
//  Created by ashok on 2/14/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "WellComeController.h"
#import <AVFoundation/AVFoundation.h>
#include <AudioToolbox/AudioToolbox.h>
@interface WellComeController ()<WebServiceHandlerDelegate,AVAudioPlayerDelegate>

@end

@implementation WellComeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self playMusic];
    });
   
   
    
    // Do any additional setup after loading the view.
    [self.btnGoLive.layer setCornerRadius:5.0];
     [self.btnMatchresult.layer setCornerRadius:5.0];
     [self.btnschedule.layer setCornerRadius:5.0];
    
    [self.lblBG.layer setCornerRadius:5.0];
    self.lblBG.clipsToBounds = YES;
    
    [self callServiceForLiveMatch];
}
-(void)viewDidAppear:(BOOL)animated{
   
}
-(void)playMusic{
    //start a background sound
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"publicnoice" ofType: @"mp3"];
     NSError *error;
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath ];
    _myAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
    _myAudioPlayer.delegate=self;
    _myAudioPlayer.volume=8.0;
      [_myAudioPlayer prepareToPlay];
   
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@",
              [error localizedDescription]);
    } else {
    [_myAudioPlayer play];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)startActivityIndicator{
    [appDelegate startActivityIndicator:self.view withText:Progressing];
}

-(void)callServiceForLiveMatch
{
   // _selected_service=1;
    
    //  NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:_txtFirstName.text,@"first_last_name",_txtAge.text,@"gender",@"M",@"age",@"",@"profile_img",SocialType,@"user_from",@"0",@"facebook_id",nil];
    
    NSDictionary* valueDic=[[NSDictionary alloc]init];
    NSString *methodName = LiveScore_Url;
    
    //for ActivityIndicator start
    [self performSelector:@selector(startActivityIndicator) withObject:nil afterDelay:0.3];
    
    //for ActivityIndicator start
    //[appDelegate startActivityIndicator:self.view withText:Progressing];
    
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
    
}
-(void)webServiceHandler:(WebserviceHandler *)webHandler recievedResponse:(NSDictionary *)dicResponce
{

    [appDelegate stopActivityIndicator];
    if([dicResponce valueForKey:@"microscorecard_data_items"])
    {
        NSLog(@"dicResponcelivematch:-%@",[dicResponce valueForKey:@"microscorecard_data_items"]);
        
        if ([[[[dicResponce valueForKey:@"microscorecard_data_items"] objectAtIndex:0] objectForKey:@"match_status"] isEqualToString:@"No Live Match"] )
        {
           //load data on view when no LIve match
            _lblMatchTime.text=@"No live match";
            _btnGoLive.hidden=YES;
            _lblMatchDate.hidden=YES;
            _lblMatchTitle.hidden=YES;
            _lblMatchPlace.hidden=YES;
            _imgsepareteline.hidden=YES;
            _btnMatchresult.hidden=NO;
            _btnschedule.hidden=NO;
           
        }
        else
        {
            NSMutableDictionary *temparr=[[dicResponce valueForKey:@"microscorecard_data_items"] objectAtIndex:0];
            
           _lblMatchDate.text= [self getDateAndTime:[temparr valueForKey:@"match_time"]];
            //live match hare...
            _lblMatchTitle.text=[objSharedData getString15FromString:[temparr valueForKey:@"match_title"]];
            _lblMatchPlace.text=[temparr valueForKey:@"match_venue"];
            _lblMatchTime.text=[temparr valueForKey:@"match_time"];
            
            _lblMatchTitle.text=[_lblMatchTitle.text stringByAppendingString:[NSString stringWithFormat:@"  %@ v/s %@",[temparr  valueForKey:@"batting_team_tinitial"],[temparr  valueForKey:@"bowling_team_tinitial"]]];
            
            
            
            _btnGoLive.hidden=NO;
            _lblMatchDate.hidden=NO;
            _lblMatchTitle.hidden=NO;
            _imgsepareteline.hidden=NO;
            _lblMatchPlace.hidden=NO;
            
            _btnMatchresult.hidden=YES;
            _btnschedule.hidden=YES;
            
        }
    }
    
}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{
    
    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
    //remove it after WS call
}
-(NSString*)getDateAndTime:(NSString*)string{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE MMM dd HH:mm 'IST'"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"IST"];
    NSDate *date=[formatter dateFromString:string];
    
    
    [formatter setDateFormat:@"dd MMM"];
    
    NSString *tempstr=[formatter stringFromDate:date];
    //NSString *stringFromDate = [[formatter stringFromDate:myDate] lowercaseString];
    return tempstr;
    
}

- (IBAction)btnGoLive:(id)sender {
    
    [self performSegueWithIdentifier:@"livescore" sender:nil];
}
- (IBAction)btnSchedule:(id)sender {
    
    objSharedData.isComeFor=@"schedule";
    [self performSegueWithIdentifier:@"livescore" sender:nil];
    
}

- (IBAction)btnMatchresult:(id)sender {
    
     objSharedData.isComeFor=@"matchresule";
     [self performSegueWithIdentifier:@"livescore" sender:nil];
}
@end
