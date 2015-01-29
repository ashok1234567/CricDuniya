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
@implementation CustomPopData
{
    NSMutableArray *arrLiveMatchQue;
}
-(void)ShowWhatNextSmallWindow{
    
    
    [self callServiceForWhatNext];
    firstHeaderView=[[[NSBundle mainBundle] loadNibNamed:@"WhatNext" owner:self options:nil] lastObject];
    firstHeaderView.frame=CGRectMake(0,appDelegate.window.frame.origin.y+(appDelegate.window.frame.size.height/2), appDelegate.window.frame.size.width, appDelegate.window.frame.size.height-appDelegate.window.frame.size.height/2);
    UIButton *tempfull=(UIButton*)[firstHeaderView viewWithTag:1];
    [tempfull addTarget:self action:@selector(clickOnFullWindow:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *tempclose=(UIButton*)[firstHeaderView viewWithTag:2];
    [tempclose addTarget:self action:@selector(clickOnClose:) forControlEvents:UIControlEventTouchUpInside];
    
    [appDelegate.window addSubview:firstHeaderView];
    
}
-(void)clickOnFullWindow :(id)sender{
    
    UIButton *tempbtn=(UIButton*)sender;
    NSLog(@"click button tag=%ld",(long)tempbtn.tag);
     [firstHeaderView removeFromSuperview];
   
    
    
}
-(void)clickOnClose :(id)sender{
    
    UIButton *tempbtn=(UIButton*)sender;
    NSLog(@"click button tag=%ld",(long)tempbtn.tag);
    [firstHeaderView removeFromSuperview];
}

-(void)selectedMatch:(id)sender{
    
    UIButton *btnSelected=(UIButton*)sender;
    
    //load data in view
   // [self refreshDataInView:btnSelected.tag];
    
}
-(void)refreshDataInView :(int)index{
    UILabel *lblMatchNo=(UILabel*)[firstHeaderView viewWithTag:15];
    lblMatchNo.text=[NSString stringWithFormat:@"Q. No. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"q_id"]];
    
    UIImageView *imgres=(UIImageView*)[firstHeaderView viewWithTag:16];
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
    
    
    UIButton *btnq2=(UIButton*)[firstHeaderView viewWithTag:6];
    [btnq2 setTitle:[NSString stringWithFormat:@"2. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"b_ans"]] forState:UIControlStateNormal];
    
    
    UIButton *btnq3=(UIButton*)[firstHeaderView viewWithTag:8];
    [btnq3 setTitle:[NSString stringWithFormat:@"3. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"c_ans"]] forState:UIControlStateNormal];
    
    UIButton *btnq4=(UIButton*)[firstHeaderView viewWithTag:10];
    [btnq4 setTitle:[NSString stringWithFormat:@"4. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"d_ans"]] forState:UIControlStateNormal];
    
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
    }
    if([[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"c_ans"] isEqualToString:@""]){
        btnq3.hidden=YES;
                lblMatchpoint3.hidden=YES;
    }
    if([[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"d_ans"] isEqualToString:@""]){
        btnq4.hidden=YES;
            lblMatchpoint4.hidden=YES;
    }
    
}
-(void)callServiceForWhatNext
{
    
    NSDictionary* valueDic=[[NSDictionary alloc]init];
    
    //for ActivityIndicator start
    [appDelegate startActivityIndicator:firstHeaderView withText:Progressing];
    
    
    
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    NSString *methodName=WhatNext_Url;
    
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
    
}

-(void)webServiceHandler:(WebserviceHandler *)webHandler recievedResponse:(NSDictionary *)dicResponce
{
    
    NSLog(@"objArrScheduleData:-%@",dicResponce);
    
    //  ShowAlert(AppName, [dicResponce valueForKey:@"message"]);
    //arrTotalWhatNextQuestion=[dicResponce valueForKey:@"match_id"];
    
    arrLiveMatchQue=[[NSMutableArray alloc]init];
    for(int i=0;i<[[dicResponce valueForKey:@"match_id"] count];i++){
       
        for(int j=0;j<[objSharedData.arrMatchList count];j++){
        if([[[[dicResponce valueForKey:@"match_id"]objectAtIndex:i] valueForKey:@"match_id"] intValue]==[[objSharedData.arrMatchList objectAtIndex:j] intValue]){
            
            if([[[[dicResponce valueForKey:@"match_id"]objectAtIndex:i] valueForKey:@"live_question"] count]>0){
                if([[[[[dicResponce valueForKey:@"match_id"]objectAtIndex:i] valueForKeyPath:@"live_question.force_push"]objectAtIndex:0] intValue]==1){
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
    [self refreshDataInView:0];
        }
        else{
        tempview.hidden=NO;
        }
    
     //load match buttons
    objSharedData.Pdelegate=self;
       UIView *matchBtn=[objSharedData NumberOfMatchButton:[arrLiveMatchQue count]];
    [matchBtn setFrame:CGRectMake(matchBtn.frame.origin.x, matchBtn.frame.origin.y-20, matchBtn.frame.size.width, matchBtn.frame.size.height)];
    [firstHeaderView addSubview:matchBtn];
    
    
    
    [appDelegate stopActivityIndicator];
    
    
}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{
    
    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
    //remove it after WS call
}

@end
