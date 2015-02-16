//
//  WhatNextController.m
//  CricketDuniya
//
//  Created by ashok on 1/5/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "WhatNextController.h"
#import "REFrostedViewController.h"
#import "HeadView.h"
#import "AnwserCellView.h"
#import "ClosedCellView.h"
@interface WhatNextController ()<WebServiceHandlerDelegate,MatchBtnSection>
{
    NSMutableArray *arrLiveQuestion;
    NSMutableArray *arrClosedQuestion;
        NSMutableArray *arrTotalWhatNextQuestion;
    NSArray *ansOpation;
    int serviceCall;
    NSMutableArray *arrLiveMatchQue;

}
@end

@implementation WhatNextController

@synthesize headViewArray,headViewClosed;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0f green:147/255.0f blue:74/255.0f alpha:1.0]};
    
    //setup ans button border
    [btnANS1.layer setCornerRadius:2.0];
        [_btnANS2.layer setCornerRadius:2.0];
        [_btnANS3.layer setCornerRadius:2.0];
        [_btnANS4.layer setCornerRadius:2.0];
    
    [_tblLiveContestQue registerNib:[UINib nibWithNibName:@"AnwserCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cellans"];
    [_tblClosedContestQue registerNib:[UINib nibWithNibName:@"ClosedCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellclosed"];
    
    ansOpation=[[NSArray alloc]initWithObjects:@"a",@"b",@"c",@"d", nil];
   
    //_viewnotlivecontest.hidden=YES;
    
    //callweb services for WhatNext
    [self callServiceForWhatNext];
    
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadModelLive{
    _currentRow = -1;
    headViewArray = [[NSMutableArray alloc]init ];
    for(int i = 0;i<[arrLiveQuestion count] ;i++)
    {
        HeadView* headview = [[HeadView alloc] init];
        headview.delegate = self;
        headview.section = i;
        headview.backBtn.tag=1;
        [headview.backBtn setTitle:[NSString stringWithFormat:@"%@",[[arrLiveQuestion objectAtIndex:i] valueForKey:@"question"]] forState:UIControlStateNormal];
        headview.lblMatchTitle2.text=@"Match";
        
        headview.lblMatchTitle.text=[NSString stringWithFormat:@"Q. no %@",[[arrLiveQuestion objectAtIndex:i] valueForKey:@"q_id"]];//@"Match 1 Q. no 54";
        [headview.lblMatchTitle setTextColor:[UIColor lightGrayColor]];
        [headview.lblMatchTitle2 setTextColor:[UIColor blackColor]];
        [self.headViewArray addObject:headview];
        
    }
    [_tblLiveContestQue reloadData];
}
- (void)loadModelClosed{
    _currentRow = -1;
    headViewClosed = [[NSMutableArray alloc]init ];
    for(int i = 0;i<[arrClosedQuestion count] ;i++)
    {
        HeadView* headview = [[HeadView alloc] init];
        headview.delegate = self;
        headview.section = i;
        headview.backBtn.tag=2;
        [headview.backBtn setTitle:[NSString stringWithFormat:@"%@",[[arrClosedQuestion objectAtIndex:i] valueForKey:@"question"]] forState:UIControlStateNormal];
        
        headview.lblMatchTitle2.text=@"Match 1";
        [headview.lblMatchTitle2 setTextColor:[UIColor blackColor]];
        headview.lblMatchTitle.text=[NSString stringWithFormat:@"Q. no %@",[[arrClosedQuestion objectAtIndex:i] valueForKey:@"q_id"]];//@"Match 1 Q. no
         [headview.lblMatchTitle setTextColor:[UIColor lightGrayColor]];
        [self.headViewClosed addObject:headview];
        
    }
     [_tblClosedContestQue reloadData];
}



#pragma mark - TableViewdelegate&&TableViewdataSource

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag==1){
        HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
        
        return headView.open?27:0;
    }else {
        HeadView* headView = [self.headViewClosed objectAtIndex:indexPath.section];
        
        return headView.open?27:0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView.tag==1)
        return [self.headViewArray objectAtIndex:section];
    else return [self.headViewClosed objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView.tag==1){
        HeadView* headView = [self.headViewArray objectAtIndex:section];
        return headView.open?4:0;
    }else{
        HeadView* headView = [self.headViewClosed objectAtIndex:section];
        return headView.open?1:0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView.tag==1){
        return [self.headViewArray count];
    }else{
        return [self.headViewClosed count];
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag==1){
        static NSString *CellIdentifier = @"Cellans";
        
        AnwserCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.lblAns.text=[NSString stringWithFormat:@"%@",[[arrLiveQuestion objectAtIndex:indexPath.section] valueForKey:[NSString stringWithFormat:@"%@_ans",[ansOpation objectAtIndex:indexPath.row]]]];
        if([cell.lblAns.text isEqualToString:@""])
            cell.hidden=YES;
        else
            cell.hidden=NO;
        
         cell.lblpoints.text=[NSString stringWithFormat:@"%@ points",[[arrLiveQuestion objectAtIndex:indexPath.section] valueForKey:[NSString stringWithFormat:@"%@_points",[ansOpation objectAtIndex:indexPath.row]]]];
        
        [cell.imgBG.layer setCornerRadius:2.0];
        return cell;
    }else if(tableView.tag==2){
        
        static NSString *CellIdentifier = @"cellclosed";
        ClosedCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       cell.lblAns.text=[NSString stringWithFormat:@"%@",[[arrClosedQuestion objectAtIndex:indexPath.section] valueForKey:@"ans"]];
        cell.lblpoints.text=[NSString stringWithFormat:@"%@ points",[[arrClosedQuestion objectAtIndex:indexPath.section] valueForKey:@"ans_points"]];
        [cell.imgBG.layer setCornerRadius:2.0];
        return cell;
    }else{
        
        return nil;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _tblTag=tableView.tag;
    if(tableView.tag==1){
        
        //call web sservice for set Answer
        
        NSLog(@"selected and=%@",[arrLiveQuestion objectAtIndex:indexPath.section]);
        
        NSLog(@"selected and=%@",[NSString stringWithFormat:@"%@_ans",[ansOpation objectAtIndex:indexPath.row]]);
        
        NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:[[arrTotalWhatNextQuestion objectAtIndex:indexPath.section] valueForKeyPath:@"match_id"],@"match_id",[objSharedData.logingUserInfo valueForKey:@"user_id"],@"user_id",[[arrLiveQuestion objectAtIndex:indexPath.section] valueForKey:@"q_id"],@"question_id",[NSString stringWithFormat:@"%@_ans",[ansOpation objectAtIndex:indexPath.row]],@"question_user_ans",nil];
        
        [self callServiceForWAnwser:valueDic];
        
        _currentRow = indexPath.row;
        [_tblLiveContestQue reloadData];
    }else{
        _currentRowClosed = indexPath.row;
        [_tblClosedContestQue reloadData];
    }
}


#pragma mark - HeadViewdelegate
-(void)selectedWith:(HeadView *)view{
    _tblTag=view.backBtn.tag;
    if(_tblTag==1){
        _currentRow = -1;
        if (view.open) {
            for(int i = 0;i<[headViewArray count];i++)
            {
                HeadView *head = [headViewArray objectAtIndex:i];
                head.open = NO;
                [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
            }
            [_tblLiveContestQue reloadData];
            return;
        }
        _currentSection = view.section;
        [self reset];
    }else{
        _currentRowClosed = -1;
        if (view.open) {
            for(int i = 0;i<[headViewClosed count];i++)
            {
                HeadView *head = [headViewClosed objectAtIndex:i];
                head.open = NO;
                [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
            }
            [_tblClosedContestQue reloadData];
            return;
        }
        _currentSectionClosed = view.section;
        [self reset];
    }
}


- (void)reset
{
    if(_tblTag==1){
        for(int i = 0;i<[headViewArray count];i++)
        {
            HeadView *head = [headViewArray objectAtIndex:i];
            
            if(head.section == _currentSection)
            {
                head.open = YES;
                [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_nomal"] forState:UIControlStateNormal];
                
            }else {
                [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
                
                head.open = NO;
            }
            
        }
        [_tblLiveContestQue reloadData];
    }else{
        for(int i = 0;i<[headViewClosed count];i++)
        {
            HeadView *head = [headViewClosed objectAtIndex:i];
            
            if(head.section == _currentSectionClosed)
            {
                head.open = YES;
                [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_nomal"] forState:UIControlStateNormal];
                
            }else {
                [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
                
                head.open = NO;
            }
            
        }
        [_tblClosedContestQue reloadData];
    }
}

-(void)selectedMatch:(id)sender{

    UIButton *tempbtn=(UIButton*)sender;

    _selectedMatch=tempbtn.tag;
    arrClosedQuestion=[[arrTotalWhatNextQuestion objectAtIndex:tempbtn.tag] valueForKeyPath:@"expired_question"];
    arrLiveQuestion=[[arrTotalWhatNextQuestion objectAtIndex:tempbtn.tag] valueForKeyPath:@"live_question"];
    //for live
    [self loadModelLive];
    
    //for closed
    [self loadModelClosed];
}
-(void)refreshDataInView :(int)index{
    
   
    _lblQueNo.text=[NSString stringWithFormat:@"Q. No. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"q_id"]];
    
  //  UIImageView *imgres=(UIImageView*)[firstHeaderView viewWithTag:16];
    //  [imgres setImageWithURL:[NSURL URLWithString:[[arrLiveMatchQue objectAtIndex:0] valueForKey:@"q_id"]]];
    
  
    _lblQuestion.text=[NSString stringWithFormat:@"%@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"question"]];
    
  
    _lblANS1Point.text=[NSString stringWithFormat:@"%@ points",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"a_points"]];
    
    
    _lblANS2Point.text=[NSString stringWithFormat:@"%@ points",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"b_points"]];
    
   
    _lblANS3Point.text=[NSString stringWithFormat:@"%@ points",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"c_points"]];
    
   
    _lblANS4Point.text=[NSString stringWithFormat:@"%@ points",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"d_points"]];
    
   
    [btnANS1 setTitle:[NSString stringWithFormat:@"1. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"a_ans"]] forState:UIControlStateNormal];
    
    
  
    [_btnANS2 setTitle:[NSString stringWithFormat:@"2. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"b_ans"]] forState:UIControlStateNormal];
    
    
   
    [_btnANS3 setTitle:[NSString stringWithFormat:@"3. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"c_ans"]] forState:UIControlStateNormal];
    
   
    [_btnANS4 setTitle:[NSString stringWithFormat:@"4. %@",[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"d_ans"]] forState:UIControlStateNormal];
    
    if([[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"a_ans"] isEqualToString:@""]){
        btnANS1.hidden=YES;
        _lblANS1Point.hidden=YES;
        _img1.hidden=YES;
    }else{
        btnANS1.hidden=NO;
        _lblANS1Point.hidden=NO;
    }
    if([[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"b_ans"] isEqualToString:@""]){
        _btnANS2.hidden=YES;
        _lblANS2Point.hidden=YES;
        _img2.hidden=YES;
    }
    if([[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"c_ans"] isEqualToString:@""]){
        _btnANS3.hidden=YES;
        _lblANS3Point.hidden=YES;
        _img3.hidden=YES;
    }
    if([[[arrLiveMatchQue objectAtIndex:index] valueForKey:@"d_ans"] isEqualToString:@""]){
        _btnANS4.hidden=YES;
        _lblANS4Point.hidden=YES;
        _img4.hidden=YES;
    }
    
}
#pragma marg WebService

-(void)callServiceForWAnwser :(NSDictionary*)valueDic
{
    
   
    
    //for ActivityIndicator start
    [appDelegate startActivityIndicator:self.view withText:Progressing];
    
    
    serviceCall=2;
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
    [appDelegate startActivityIndicator:self.view withText:Progressing];
    
    
    serviceCall=1;
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    NSString *methodName=WhatNext_Url;
    
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];
    
}

-(void)webServiceHandler:(WebserviceHandler *)webHandler recievedResponse:(NSDictionary *)dicResponce
{
   
    NSLog(@"objArrScheduleData:-%@",dicResponce);
    if(serviceCall==1){
    if([dicResponce valueForKey:@"match_id"]){
        
        @try {
            //For forcepush count 1
            arrLiveMatchQue=[[NSMutableArray alloc]init];
            for(int i=0;i<[[dicResponce valueForKey:@"match_id"] count];i++){
                
                for(int j=0;j<[objSharedData.arrMatchList count];j++){
                    if([[[[dicResponce valueForKey:@"match_id"] objectAtIndex:i] valueForKey:@"match_id"] intValue]==[[objSharedData.arrMatchList objectAtIndex:j] intValue]){
                        
                        if([[[[dicResponce valueForKey:@"match_id"]objectAtIndex:i] valueForKey:@"live_question"] count]>0){
                            if([[[[[dicResponce valueForKey:@"match_id"] objectAtIndex:i] valueForKeyPath:@"live_question.force_push"]objectAtIndex:0] intValue]==1){
                                [arrLiveMatchQue addObjectsFromArray: [[[dicResponce valueForKey:@"match_id"]objectAtIndex:i] valueForKeyPath:@"live_question"]];
                            }
                        }
                        
                    }
                    
                }
            }
            
            if([arrLiveMatchQue count]>0){
                _viewnotlivecontest.hidden=YES;
                
                [self refreshDataInView:0];
            }
            else
                _viewnotlivecontest.hidden=NO;
            
            arrTotalWhatNextQuestion=[dicResponce valueForKey:@"match_id"];
            
            arrClosedQuestion=[[NSMutableArray alloc]init];
            arrLiveQuestion=[[NSMutableArray alloc]init];
            
            for(int i=0;i<[arrTotalWhatNextQuestion count];i++){
                
                [arrClosedQuestion addObjectsFromArray:[[[dicResponce valueForKey:@"match_id"] objectAtIndex:i] valueForKeyPath:@"expired_question"]];
                [arrLiveQuestion addObjectsFromArray:[[[dicResponce valueForKey:@"match_id"] objectAtIndex:i] valueForKeyPath:@"live_question"] ];
                
            }
            _selectedMatch=0;
            
            //for live
            [self loadModelLive];
            
            //for closed
            [self loadModelClosed];
        }
        @catch (NSException *exception) {
            
        }
       
    }
    } else if(serviceCall==2){
        
        ShowAlert(AppName, [dicResponce valueForKey:@"message"]);
    }
    
    [appDelegate stopActivityIndicator];
    
    
}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{
    
    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
    //remove it after WS call
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnActionAns1:(id)sender {

    UIButton *temp=(UIButton*)sender;
    //call web sservice for set Answer
    
    NSLog(@"selected and=%@",[arrLiveMatchQue objectAtIndex:0]);
    
  
    
    NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:[[arrTotalWhatNextQuestion objectAtIndex:0] valueForKeyPath:@"match_id"],@"match_id",[objSharedData.logingUserInfo valueForKey:@"user_id"],@"user_id",[[arrLiveQuestion objectAtIndex:0] valueForKey:@"q_id"],@"question_id",[NSString stringWithFormat:@"%@_ans",[ansOpation objectAtIndex:temp.tag-1]],@"question_user_ans",nil];
    
    [self callServiceForWAnwser:valueDic];

}
@end
