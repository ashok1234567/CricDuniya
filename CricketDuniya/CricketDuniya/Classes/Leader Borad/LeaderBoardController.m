    //
    //  LeaderBoardController.m
    //  CricketDuniya
    //
    //  Created by ashok on 1/21/15.
    //  Copyright (c) 2015 apmocon. All rights reserved.
    //

#import "LeaderBoardController.h"
#import "UIImageView+AFNetworking.h"
#import "REFrostedViewController.h"
@interface LeaderBoardController ()<WebServiceHandlerDelegate>
{
    NSMutableArray *objArrLeaders;
    NSString *selectedCat;
}
@end

@implementation LeaderBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.

        //set navagition title color
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0f green:147/255.0f blue:74/255.0f alpha:1.0]};


    objArrLeaders=[[NSMutableArray alloc]initWithCapacity:0];

    selectedCat=@"OVERALL";
        //call web services for get learder from server and open new controller
    [self callServiceForSchedule:LeaderboardComplete_Url];


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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [objArrLeaders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    UIImageView *imgLeader=(UIImageView*)[cell viewWithTag:1];


    if (![[[objArrLeaders objectAtIndex:indexPath.row] valueForKey:@"user_img"] isEqual:[NSNull null]])
        {
       [imgLeader setImageWithURL:[NSURL URLWithString:[[objArrLeaders objectAtIndex:indexPath.row] valueForKey:@"user_img"]] placeholderImage:nil];
        }


    UILabel *lblLeaderName=(UILabel*)[cell viewWithTag:2];
    if ([[[objArrLeaders objectAtIndex:indexPath.row] valueForKey:@"user_Fname"] isEqual:[NSNull null]])
        {
        lblLeaderName.text=@"";
        }
    else{
        lblLeaderName.text=[[[objArrLeaders objectAtIndex:indexPath.row] valueForKey:@"user_Fname"] capitalizedString];
    }



    UILabel *lblLeaderPoints=(UILabel*)[cell viewWithTag:3];
    lblLeaderPoints.text=[[[objArrLeaders objectAtIndex:indexPath.row] valueForKey:@"user_points"] capitalizedString];


    return cell;


}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
        sectionName =@"OVER ALL";
        break;
        case 1:
        sectionName = @"WHAT NEXT";
        break;

    }
    return sectionName;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(15.0,0,_tblLeaderBoard.frame.size.width,15.0)];
    UILabel *label = [[UILabel alloc] initWithFrame:header.frame];
    label.backgroundColor= [UIColor colorWithRed:42/255.0f green:97/255.0f blue:41/255.0f alpha:1.0];
    label.textColor= [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:11.0];
    label.text = selectedCat;
    [header addSubview:label];
    return header;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell  forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [objSharedData AnimationWithCell:indexPath.row :cell];
}


/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)btnActionDay:(id)sender {
    
    selectedCat=@"DAY";
    [self callServiceForSchedule:LeaderboardDaily_Url];
}

- (IBAction)btnActionWeek:(id)sender {
    
    selectedCat=@"WEEK";
    [self callServiceForSchedule:LeaderboardWeekly_Url];
}

- (IBAction)btnActionMonth:(id)sender {
    
    selectedCat=@"MONTH";
    [self callServiceForSchedule:LeaderboardMonthly_Url];
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
    NSLog(@"leaderboard:-%@",[dicResponce valueForKey:@"leaderboard"]);
    objArrLeaders =[dicResponce valueForKey:@"leaderboard"] ;
    if([objArrLeaders count]>0){
        _lblNorecordfound.hidden=YES;
    }else{
        _lblNorecordfound.hidden=NO;
    }
    [self.myTbl reloadData];
    [appDelegate stopActivityIndicator];

}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{
    
    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
        //remove it after WS call
}
- (IBAction)btnActionOverll:(id)sender {
    
    //Get overall leader record from server
     [self callServiceForSchedule:LeaderboardComplete_Url];
}
@end
