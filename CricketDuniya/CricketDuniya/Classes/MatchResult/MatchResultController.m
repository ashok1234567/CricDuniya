//
//  MatchResultController.m
//  CricketDuniya
//
//  Created by ashok on 1/21/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "MatchResultController.h"
#import "SelectionsController.h"
#import "REFrostedViewController.h"
@interface MatchResultController ()<SelectCategory,WebServiceHandlerDelegate>
{
    NSMutableArray *objArrMatchResult;
}

@end

@implementation MatchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    return [objArrMatchResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    UILabel *lblDate=(UILabel*)[cell viewWithTag:5];
//    lblDate.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"mdate"];
//    
//    UILabel *lblDay=(UILabel*)[cell viewWithTag:1];
//    lblDay.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"mdate"];
//    
//    UILabel *lblMatchName=(UILabel*)[cell viewWithTag:2];
//    lblMatchName.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"mname"];
//    
//    UILabel *lblMatchTime=(UILabel*)[cell viewWithTag:3];
//    lblMatchTime.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"mtime"];
//    
//    UILabel *lblMatchVenue=(UILabel*)[cell viewWithTag:4];
//    lblMatchVenue.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"mvenue"];
    
    
    return cell;
    
    
}
-(void)SelectedCategory:(NSString*)Cat{

}
- (IBAction)btnActionSoftByCatgory:(id)sender {
    UIButton *tempbtn=(UIButton*)sender;
    switch (tempbtn.tag) {
        case 1:
            //call service for month data
            
           // [self callServiceForSchedule:LiveScheduleMatch_Url];
            break;
        case 2:
            //call service for series/tuornament data
           
            [self performSegueWithIdentifier:@"tournament" sender:sender];
            
            break;
        case 3:
            //call service for country
            [self performSegueWithIdentifier:@"country" sender:sender];
           
            break;
            
        default:
            break;
    }
}

#pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     SelectionsController *objSelectionsController=[segue destinationViewController];
     UIButton *tempbtn=(UIButton*)sender;
     objSelectionsController.category=tempbtn.tag;
     objSelectionsController.Pdelegate=self;
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
    
    objArrMatchResult =dicResponce ;
    [self.tblMatchResult reloadData];
    [appDelegate stopActivityIndicator];
    
    
}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{
    
    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
    //remove it after WS call
}


@end
