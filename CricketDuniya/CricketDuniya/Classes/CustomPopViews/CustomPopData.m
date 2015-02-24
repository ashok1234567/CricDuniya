//
//  CustomPopData.m
//  CricketDuniya
//
//  Created by ashok on 1/26/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "CustomPopData.h"
#import "MenuController.h"
#import "CDDashboardController.h"
#import "WhatNextController.h"
#import "AS_CustomNavigationController.h"
#import "BaseControllerController.h"
#import <MediaPlayer/MediaPlayer.h>

#define  kTimeRemovePopup 40.0
#define  kTimeRemoveWhatNextPopup 15.0
@implementation CustomPopData
{
    NSMutableArray *arrLiveMatchQue;
    int serviceType;
    NSString *strUserAns;
    int selectedMatch;
    MPMoviePlayerViewController *moviePlayerController;
}
-(void)ShowWhatNextSmallWindow{
    
    
    [self callServiceForWhatNext];
    
    
    firstHeaderView=[[[NSBundle mainBundle] loadNibNamed:@"WhatNext" owner:self options:nil] lastObject];
    firstHeaderView.frame=CGRectMake(0,appDelegate.window.frame.origin.y+(appDelegate.window.frame.size.height/2)-50, appDelegate.window.frame.size.width, appDelegate.window.frame.size.height-(appDelegate.window.frame.size.height/2)+50);
    UIButton *tempfull=(UIButton*)[firstHeaderView viewWithTag:1];
    [tempfull addTarget:self action:@selector(clickOnFullWindow:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *tempclose=(UIButton*)[firstHeaderView viewWithTag:2];
    [tempclose addTarget:self action:@selector(clickOnClose:) forControlEvents:UIControlEventTouchUpInside];
    
     [self performSelector:@selector(clickOnClose:) withObject:self afterDelay:kTimeRemoveWhatNextPopup];
    [appDelegate.window addSubview:firstHeaderView];
    
}

-(void)callServiceForSchedule :(NSString*)methodName
{
    NSDictionary* valueDic=[[NSDictionary alloc]init];
    //for ActivityIndicator start
    [appDelegate startActivityIndicator:firstHeaderView withText:Progressing];
    
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    serviceType=4;
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
}
-(void)clickOnFullWindow :(id)sender{
    
    UIButton *tempbtn=(UIButton*)sender;
    NSLog(@"click button tag=%ld",(long)tempbtn.tag);
     [firstHeaderView removeFromSuperview];
   
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
     BaseControllerController *objBasecontroller = [storyboard instantiateViewControllerWithIdentifier:@"baseCon"];
    objSharedData.isComeFromPopUp=YES;
    appDelegate.window.rootViewController=objBasecontroller;
}
-(void)clickOnClose :(id)sender{
  
    [firstHeaderView removeFromSuperview];
    
    if(moviePlayerController){
        [moviePlayerController.moviePlayer stop];
        [moviePlayerController removeFromParentViewController];
    }
    [viewCommanPopUp removeFromSuperview];
}

-(void)selectedMatch:(id)sender{
    
    UIButton *btnSelected=(UIButton*)sender;
    
    selectedMatch=btnSelected.tag;
    //load data in view
    [self refreshDataInView:btnSelected.tag];
    
}
-(void)refreshDataInView :(int)index{
    UILabel *lblMatchNo=(UILabel*)[firstHeaderView viewWithTag:15];
    lblMatchNo.text=[NSString stringWithFormat:@"Q. No. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"q_id"]];
    
   // UIImageView *imgres=(UIImageView*)[firstHeaderView viewWithTag:16];
  //  [imgres setImageWithURL:[NSURL URLWithString:[[arrLiveMatchQue objectAtIndex:0] valueForKey:@"q_id"]]];
    
    UITextView *lblQues=(UITextView*)[firstHeaderView viewWithTag:3];
    lblQues.text=[NSString stringWithFormat:@"%@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"question"]];
    
    UILabel *lblMatchpoint1=(UILabel*)[firstHeaderView viewWithTag:5];
    lblMatchpoint1.text=[NSString stringWithFormat:@"%@ points",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"a_points"]];
    
    UILabel *lblMatchpoint2=(UILabel*)[firstHeaderView viewWithTag:7];
    lblMatchpoint2.text=[NSString stringWithFormat:@"%@ points",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"b_points"]];
    
    UILabel *lblMatchpoint3=(UILabel*)[firstHeaderView viewWithTag:9];
    lblMatchpoint3.text=[NSString stringWithFormat:@"%@ points",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"c_points"]];
    
    UILabel *lblMatchpoint4=(UILabel*)[firstHeaderView viewWithTag:11];
    lblMatchpoint4.text=[NSString stringWithFormat:@"%@ points",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"d_points"]];
    
    UIButton *btnq1=(UIButton*)[firstHeaderView viewWithTag:4];
    [btnq1 setTitle:[NSString stringWithFormat:@"1. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"a_ans"]] forState:UIControlStateNormal];
    [btnq1 addTarget:self action:@selector(clickonAns:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnq2=(UIButton*)[firstHeaderView viewWithTag:6];
    [btnq2 setTitle:[NSString stringWithFormat:@"2. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"b_ans"]] forState:UIControlStateNormal];
     [btnq2 addTarget:self action:@selector(clickonAns:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnq3=(UIButton*)[firstHeaderView viewWithTag:8];
    [btnq3 setTitle:[NSString stringWithFormat:@"3. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"c_ans"]] forState:UIControlStateNormal];
     [btnq3 addTarget:self action:@selector(clickonAns:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btnq4=(UIButton*)[firstHeaderView viewWithTag:10];
    [btnq4 setTitle:[NSString stringWithFormat:@"4. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"d_ans"]] forState:UIControlStateNormal];
     [btnq4 addTarget:self action:@selector(clickonAns:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if([[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"a_ans"] isEqualToString:@""]){
        btnq1.hidden=YES;
        lblMatchpoint1.hidden=YES;
    }else{
        btnq1.hidden=NO;
        lblMatchpoint1.hidden=NO;
    }
    if([[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"b_ans"] isEqualToString:@""]){
        btnq2.hidden=YES;
        lblMatchpoint2.hidden=YES;
    }else{
        btnq2.hidden=NO;
        lblMatchpoint2.hidden=NO;
    }
    if([[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"c_ans"] isEqualToString:@""]){
        btnq3.hidden=YES;
                lblMatchpoint3.hidden=YES;
    }else{
        btnq3.hidden=NO;
        lblMatchpoint3.hidden=NO;
    }
    if([[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"d_ans"] isEqualToString:@""]){
        btnq4.hidden=YES;
            lblMatchpoint4.hidden=YES;
    }else{
        btnq4.hidden=NO;
        lblMatchpoint4.hidden=NO;
    }
    
}
-(void)clickonAns:(UIButton*)sender{
    
    switch (sender.tag) {
        case 4:
            strUserAns=@"a_ans";
            break;
        case 6:
            strUserAns=@"b_ans";
            break;
        case 8:
            strUserAns=@"c_ans";
            break;
        case 10:
            strUserAns=@"d_ans";
            break;
            
        default:
            break;
    }
    
    if([objSharedData.arrMatchList count]>selectedMatch){
    NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:[objSharedData.arrMatchList objectAtIndex:selectedMatch],@"match_id",[objSharedData.logingUserInfo valueForKey:@"user_id"],@"user_id",[[arrLiveMatchQue objectAtIndex:selectedMatch] valueForKey:@"q_id"],@"question_id",strUserAns,@"question_user_ans",nil];
    
    [self callServiceForWAnwser:valueDic];
    }
}
-(void)loadPopup{
    
    
    
    viewCommanPopUp=[[[NSBundle mainBundle] loadNibNamed:@"CommanPopUp" owner:self options:nil] lastObject];
    
    viewCommanPopUp.frame=CGRectMake(0,appDelegate.window.frame.origin.y+(appDelegate.window.frame.size.height/2), appDelegate.window.frame.size.width, appDelegate.window.frame.size.height-appDelegate.window.frame.size.height/2);
    
    UIButton *tempclose=(UIButton*)[viewCommanPopUp viewWithTag:2];
    [tempclose addTarget:self action:@selector(clickOnClose:) forControlEvents:UIControlEventTouchUpInside];
    
    [appDelegate.window addSubview:viewCommanPopUp];
    
}

-(void)ShowCommanPopupForFour:(NSString*)text{

    [self loadPopup];
    [self performSelector:@selector(clickOnClose:) withObject:self afterDelay:kTimeRemovePopup];
    
    UILabel *temptext=(UILabel*)[viewCommanPopUp viewWithTag:4];
    temptext.text=text;
    
    UINavigationBar *navBar=(UINavigationBar*)[viewCommanPopUp viewWithTag:100];
    UINavigationItem *title=[navBar.items objectAtIndex:0];
    
    title.title=text;
    [self UpdateView:1];

}

-(void)ShowCommanPopupForImage:(NSString*)url{
    
    [self loadPopup];
    
    [self performSelector:@selector(clickOnClose:) withObject:self afterDelay:kTimeRemovePopup];
    
    UINavigationBar *navBar=(UINavigationBar*)[viewCommanPopUp viewWithTag:100];
    UINavigationItem *title=[navBar.items objectAtIndex:0];
    
    title.title=url;
    
    UIImageView *tempimg1=(UIImageView*)[viewCommanPopUp viewWithTag:5];
    [tempimg1 setImageWithURL:[NSURL URLWithString:url]];
    [self UpdateView:2];
   
}
-(void)ShowWebViewPopup:(NSString*)url{
    [self loadPopup];
    
    
    UINavigationBar *navBar=(UINavigationBar*)[viewCommanPopUp viewWithTag:100];
    UINavigationItem *title=[navBar.items objectAtIndex:0];
    
    title.title=url;
    UIWebView *tempwebview=(UIWebView*)[viewCommanPopUp viewWithTag:6];
    NSURLRequest *tempreq=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [tempwebview loadRequest:tempreq];
    
    [self UpdateView:3];
}
-(void)ShowVideoPopup:(NSString*)url{
    
    [self loadPopup];

    UINavigationBar *navBar=(UINavigationBar*)[viewCommanPopUp viewWithTag:100];
    UINavigationItem *title=[navBar.items objectAtIndex:0];
    
    title.title=@"Video";
    
  moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:url]];
    [moviePlayerController.view setFrame:CGRectMake(0,44,viewCommanPopUp.frame.size.width,viewCommanPopUp.frame.size.height)];
    [viewCommanPopUp addSubview:moviePlayerController.view];
    [moviePlayerController.moviePlayer prepareToPlay];
    moviePlayerController.moviePlayer.shouldAutoplay=YES;
    [moviePlayerController.moviePlayer play];
    
    //add player using url
    [self UpdateView:4];
    
}
-(void)UpdateView:(int)viewtag{
    
    UIImageView *tempimg=(UIImageView*)[viewCommanPopUp viewWithTag:3];
    UILabel *temptext=(UILabel*)[viewCommanPopUp viewWithTag:4];
    UIImageView *tempimg1=(UIImageView*)[viewCommanPopUp viewWithTag:5];
    UIWebView *tempwebview=(UIWebView*)[viewCommanPopUp viewWithTag:6];
    
//    100
   
    
    
    tempimg.hidden=YES;
    temptext.hidden=YES;
    tempimg1.hidden=YES;
    tempwebview.hidden=YES;
    
    switch (viewtag) {
        case 1:
            
           
            tempimg.hidden=NO;
            temptext.hidden=NO;
            break;
        case 2:
            tempimg1.hidden=NO;
            break;
        case 3:
            tempwebview.hidden=NO;
            break;
        default:
            break;
    }
}

#pragma marg WebService

-(void)callServiceForWAnwser :(NSDictionary*)valueDic
{
    
    
    
    //for ActivityIndicator start
    [appDelegate startActivityIndicator:firstHeaderView withText:Progressing];
    
    serviceType=3;
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    NSString *methodName=WhatNextAnwser_Url;
    
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
    
}

-(void)callServiceForWhatNext
{
    
    NSDictionary* valueDic=[[NSDictionary alloc]init];
    
    //for ActivityIndicator start
    [appDelegate startActivityIndicator:firstHeaderView withText:Progressing];
    
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    NSString *methodName=WhatNext_Url;
    
    serviceType=1;
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
    
}
-(void)callServiceForCommanPopup
{
    
    NSDictionary* valueDic=[[NSDictionary alloc]init];
    
    //for ActivityIndicator start
    [appDelegate startActivityIndicator:viewCommanPopUp withText:Progressing];
    
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    NSString *methodName=CommanPopup_Url;
    
    serviceType=2;
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
    
}

-(void)callServiceForScore :(NSString*)methodName
{
    NSDictionary* valueDic=[[NSDictionary alloc]init];
    //for ActivityIndicator start
    //  [appDelegate startActivityIndicator:appDelegate.window withText:Progressing];
    
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    
    serviceType=5;
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
}


-(void)webServiceHandler:(WebserviceHandler *)webHandler recievedResponse:(NSDictionary *)dicResponce
{
    
    NSLog(@"objArrScheduleData:-%@",dicResponce);
    
    //  ShowAlert(AppName, [dicResponce valueForKey:@"message"]);
    //arrTotalWhatNextQuestion=[dicResponce valueForKey:@"match_id"];
    if(serviceType==1){
        
        @try {
            arrLiveMatchQue=[[NSMutableArray alloc]init];
            for(int i=0;i<[[dicResponce valueForKey:@"match_id"] count];i++){
                
                for(int j=0;j<[objSharedData.arrMatchList count];j++){
                    if([[[[dicResponce valueForKey:@"match_id"] objectAtIndex:i] valueForKey:@"match_id"] intValue]==[[objSharedData.arrMatchList objectAtIndex:j] intValue]){
                        
                        if([[[[dicResponce valueForKey:@"match_id"]valueForKey:[NSString stringWithFormat:@"%d",i]] valueForKey:@"live_question"] count]>0){
                            if([[[[[dicResponce valueForKey:@"match_id"] objectAtIndex:i] valueForKeyPath:@"live_question.force_push"]objectAtIndex:0] intValue]==1){
                                [arrLiveMatchQue addObjectsFromArray: [[[dicResponce valueForKey:@"match_id"]objectAtIndex:i] valueForKeyPath:@"live_question"]];
                            }
                        }
                        
                    }
                    
                }
            }
            UIView *tempview=(UIView*)[firstHeaderView viewWithTag:20];
            //load data in view
            if([arrLiveMatchQue count]>0){
                tempview.hidden=YES;
                selectedMatch=0;
                [self refreshDataInView:0];
            }
            else{
                tempview.hidden=NO;
            }
            
            //load match buttons
            objSharedData.Pdelegate=self;
            
            UIView *matchBtn=[objSharedData NumberOfMatchButton:arrLiveMatchQue];
            [matchBtn setFrame:CGRectMake(matchBtn.frame.origin.x, matchBtn.frame.origin.y-20, matchBtn.frame.size.width, matchBtn.frame.size.height)];
            [firstHeaderView addSubview:matchBtn];
            
            
            //Get overall leader record from server
            [self callServiceForSchedule:LeaderboardComplete_Url];

        }
        @catch (NSException *exception) {
            
        }
        
    
        
        
    }else if(serviceType==2){
        
        @try {
            //responce for comman popup
            if([[dicResponce valueForKey:@"flag"] intValue]==1){
                if([[dicResponce valueForKey:@"fixture_id"] isEqualToString:objSharedData.strLiveMatchId] ){
                    
                    //Is for user and check now only type for message
                    if([[dicResponce valueForKey:@"seltype"] isEqualToString:@"seltxt"]){
                        
                        //show all text
                        [self ShowCommanPopupForFour:[dicResponce valueForKey:@"ddval"]];
                    }else if([[dicResponce valueForKey:@"seltype"] isEqualToString:@"selimg"]){
                        if([dicResponce valueForKey:@"ddval_2"]){
                            
                            //show image
                            [self ShowCommanPopupForImage:[dicResponce valueForKey:@"ddval_2"]];
                        }
                    }else if([[dicResponce valueForKey:@"seltype"] isEqualToString:@"selhtml"]){
                        
                        //show html with webview
                        [self ShowWebViewPopup:[dicResponce valueForKey:@"ddval"]];
                    }else if([[dicResponce valueForKey:@"seltype"] isEqualToString:@"selvideo"]){
                        
                        //show view from url
                        [self ShowVideoPopup:[dicResponce valueForKey:@"ddval"]];
                    }
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }else if(serviceType==3){
        
        ShowAlert(AppName, [dicResponce valueForKey:@"message"]);
    }else if(serviceType==4){
        
    
        @try {
           
            
       
      NSMutableArray  *objArrLeaders =[[NSMutableArray alloc] initWithArray:[dicResponce valueForKey:@"leaderboard"]];
        
            for(int i=1;i<=5;i++){
                
                if([[objArrLeaders objectAtIndex:i-1] valueForKey:@"user_img"]!=[NSNull null]){
                UIImageView *L1=(UIImageView*)[firstHeaderView viewWithTag:1000+i];
                 [L1 setImageWithURL:[NSURL URLWithString:[[objArrLeaders objectAtIndex:i-1] valueForKey:@"user_img"]] placeholderImage:nil];
                }
                
                if([[objArrLeaders objectAtIndex:i-1] valueForKey:@"user_points"]!=[NSNull null]){
                    UILabel *lbl1=(UILabel*)[firstHeaderView viewWithTag:2000+i];
                    lbl1.text=[[[objArrLeaders objectAtIndex:i-1] valueForKey:@"user_points"] capitalizedString];
                }
            }
            
            
           [self callServiceForScore:[objSharedData.logingUserInfo valueForKey:@"notification"]];    
        }
        @catch (NSException *exception) {
            
        }
    }else if(serviceType==5){
        @try {
            UILabel *lbl1=(UILabel*)[firstHeaderView viewWithTag:2006];
            int points=[[dicResponce valueForKeyPath:@"data.user_points"] intValue];
            lbl1.text=[NSString stringWithFormat:@"%d",points];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
       
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
