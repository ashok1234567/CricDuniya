//
//  MyPageController.m
//  CricketDuniya
//
//  Created by ashok on 1/24/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "MyPageController.h"
#import "HeadView.h"
#import "REFrostedViewController.h"
#import "AnwserCellView.h"
#import "ClosedCellView.h"
#import "CustomwinAndLoss.h"
@interface MyPageController ()
{
    NSMutableArray *objArrLiveContest;
    NSMutableArray *objArrCloseContest;
    NSMutableArray *objArrWinLoss;
    NSMutableArray *objComplete;
}
@end

@implementation MyPageController
@synthesize headViewArray,headViewClosed;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0f green:147/255.0f blue:74/255.0f alpha:1.0]};
    
    [_tblLiveContestQue registerNib:[UINib nibWithNibName:@"AnwserCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cellans"];
    
     [_tblClosedContestQue registerNib:[UINib nibWithNibName:@"ClosedCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellclosed"];
    
    [_lblWinLoss registerNib:[UINib nibWithNibName:@"CustomwinAndLoss" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellWinandloss"];

    if([objSharedData.logingUserInfo valueForKey:@"profile_img"]==[NSNull class])
      [_imgMyPage setImageWithURL:[NSURL URLWithString:[objSharedData.logingUserInfo valueForKey:@"profile_img"]]] ;

    _lblWinLoss.hidden=YES;
        //quiz_results
    [self callServiceForSchedule:[objSharedData.logingUserInfo valueForKey:@"quiz_results"] ];
        //for live
        //[self loadModelLive];

        //for closed
        //[self loadModelClosed]
    
    
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
    NSLog(@"LiveContestCount: %d",[objArrLiveContest count] );
    for(int i = 0;i< [objArrLiveContest count] ;i++)
        {
        HeadView* headview = [[HeadView alloc] init];
        headview.delegate = self;
        headview.section = i;
        headview.backBtn.tag=1;
        [headview.backBtn setTitle:[[objArrLiveContest  valueForKey:@"question"] objectAtIndex:i] forState:UIControlStateNormal];
        NSMutableString *questionId=[NSMutableString string];
        [questionId appendString:@"Q. no"];
        [questionId appendString:[[objArrLiveContest  valueForKey:@"question_id"] objectAtIndex:i]];
        headview.lblMatchTitle.text=questionId;
        headview.lblMatchTitle2.text=@"Match 1";
        [self.headViewArray addObject:headview];

        }
    [self.tblLiveContestQue reloadData];
}
- (void)loadModelClosed{
    _currentRow = -1;
    headViewClosed = [[NSMutableArray alloc]init ];
    for(int i = 0;i< [objArrCloseContest count] ;i++)
        {
        HeadView* headview = [[HeadView alloc] init];
        headview.delegate = self;
        headview.section = i;
        headview.backBtn.tag=2;
        [headview.backBtn setTitle:[[objArrCloseContest  valueForKey:@"question"] objectAtIndex:i] forState:UIControlStateNormal];
        NSMutableString *questionId=[NSMutableString string];
        [questionId appendString:@"Q. no"];
        [questionId appendString:[[objArrCloseContest  valueForKey:@"question_id"] objectAtIndex:i]];
        headview.lblMatchTitle.text=questionId;
        headview.lblMatchTitle2.text=@"Match 1";
        [self.headViewClosed addObject:headview];

        }
    [self.tblClosedContestQue reloadData];
}




#pragma mark - TableViewdelegate&&TableViewdataSource

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag==1){
    HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
    
    return headView.open?27:0;
    }else  if(tableView.tag==2){
        HeadView* headView = [self.headViewClosed objectAtIndex:indexPath.section];
        
        return headView.open?27:0;
    }else{
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView.tag==3){
        return 0.01;
    }else{
    return 50.0;    
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView.tag==1)
    return [self.headViewArray objectAtIndex:section];
    else if(tableView.tag==2) return [self.headViewClosed objectAtIndex:section];
    else return  nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView.tag==1){
    HeadView* headView = [self.headViewArray objectAtIndex:section];
    return headView.open?1:0;
    }else if(tableView.tag==2){
        HeadView* headView = [self.headViewClosed objectAtIndex:section];
        return headView.open?1:0;
    }else return [objArrWinLoss count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView.tag==1){
        return [self.headViewArray count];
    }else  if(tableView.tag==2){
      return [self.headViewClosed count];
    }else return 1;
   
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(tableView.tag==1){
        static NSString *CellIdentifier = @"Cellans";

        AnwserCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            //cell.lblAns.text=[NSString stringWithFormat:@"Ans_%d",indexPath.row+1];
        cell.lblAns.text=[[objArrLiveContest  valueForKey:@"ans_status"] objectAtIndex:indexPath.section];
            //[[objArrLiveContest  valueForKey:@"correct_ans"] objectAtIndex:i]]
        [cell.imgBG.layer setCornerRadius:2.0];
        cell.lblpoints.hidden=YES;
        return cell;
    }else if(tableView.tag==2){

        static NSString *CellIdentifier = @"cellclosed";
        ClosedCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.lblAns.text=[[objArrCloseContest  valueForKey:@"correct_ans"] objectAtIndex:indexPath.section];
        [cell.imgBG.layer setCornerRadius:2.0];
        cell.lblpoints.hidden=YES;
        return cell;
    }else{

        static NSString *CellIdentifier = @"cellWinandloss";
        CustomwinAndLoss*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        NSMutableString *questionId=[NSMutableString string];
        [questionId appendString:@"Q. no "];
        [questionId appendString:[[objArrWinLoss  valueForKey:@"question_id"] objectAtIndex:indexPath.row]];
        cell.lblpoints.text=questionId;
        cell.lblquestion.text=[[objArrWinLoss  valueForKey:@"question"] objectAtIndex:indexPath.row];
        cell.lblMatch.text=@"MATCH1";
        cell.lblAns.text=[[objArrWinLoss objectAtIndex:indexPath.row] valueForKey:@"message"];
            // [cell.imgBG.layer setCornerRadius:2.0];

        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _tblTag=tableView.tag;
    if(tableView.tag==1){
        
    _currentRow = indexPath.row;
    [_tblLiveContestQue reloadData];
    }else if(tableView.tag==2){
        _currentRowClosed = indexPath.row;
        [_tblClosedContestQue reloadData];
    }else{
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnActionAll:(id)sender {
    
    UIButton *tempbtn=(UIButton*)sender;
    
    _tblClosedContestQue.hidden=YES;
    _tblLiveContestQue.hidden=YES;
    _lblWinLoss.hidden=YES;
    _lblsepline.hidden=YES;
    _lbltitle1.hidden=YES;
    _lbltitle2.hidden=YES;

    switch (tempbtn.tag) {
        case 1:
            _tblClosedContestQue.hidden=NO;
            _tblLiveContestQue.hidden=NO;
            _lblsepline.hidden=NO;
            _lbltitle1.hidden=NO;
            _lbltitle2.hidden=NO;
            break;
        case 2:
            _lblWinLoss.hidden=NO;
            break;
        case 3:
           _lblWinLoss.hidden=NO;
            objArrWinLoss=[objComplete valueForKey:@"win"] ;
            [self.lblWinLoss reloadData];
            break;
        case 4:
           _lblWinLoss.hidden=NO;
            objArrWinLoss=[objComplete valueForKey:@"loss"] ;
            [self.lblWinLoss reloadData];
            break;
            
        default:
            break;
    }
}
#pragma marg WebService

-(void)callServiceForSchedule :(NSString*)methodName
{
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

          objComplete =dicResponce ;
     NSLog(@"total_points:-%@",[objComplete valueForKey:@"total_points"]  );

    NSMutableString *totalPoints=[NSMutableString string];
    [totalPoints appendString:[NSString stringWithFormat:@"%@", [objComplete valueForKey:@"total_points"]]];
    [totalPoints appendString:@" Points"];

    NSMutableString *totalWins=[NSMutableString string];
    [totalWins appendString:[NSString stringWithFormat:@"%@", [objComplete valueForKey:@"total_wins"]]];
    [totalWins appendString:@" WINS"];

    NSMutableString *totalLoss=[NSMutableString string];
    [totalLoss appendString:[NSString stringWithFormat:@"%@", [objComplete valueForKey:@"total_loss"]]];
    [totalLoss appendString:@" LOSS"];


    _lblPoints.text=totalPoints;
    _lblwins.text=totalWins;
    _lblLoss.text=totalLoss;
    objArrLiveContest =[dicResponce valueForKey:@"pending"] ;
    objArrCloseContest=[dicResponce valueForKey:@"closed"] ;
    objArrWinLoss=[objComplete valueForKey:@"win"] ;
    [self loadModelLive];
    [self loadModelClosed];


    [appDelegate stopActivityIndicator];

}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{

    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
        //remove it after WS call
}
@end
