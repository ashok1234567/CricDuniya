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

    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0f green:147/255.0f blue:74/255.0f alpha:1.0]};
    
    objArrMatchResult=[[NSMutableArray alloc]initWithCapacity:0];
    [self callMonthSchedule];
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

    NSArray *myArray = [[[objArrMatchResult objectAtIndex:indexPath.row] valueForKey:@"mdate"] componentsSeparatedByString:@", "];
    NSMutableString *matchDate=[NSMutableString string];
    [matchDate appendString:[[myArray objectAtIndex:1] substringFromIndex:3]];
    [matchDate appendString:@"\n"];
    [matchDate appendString:[myArray objectAtIndex:0]];

 

    NSMutableString *matchMonth=[NSMutableString string];

    [matchMonth appendString:[[myArray objectAtIndex:1] substringToIndex:3]];
    [matchMonth appendString:@","];
    [matchMonth appendString:[myArray objectAtIndex:2]];

    UILabel *lblDate=(UILabel*)[cell viewWithTag:5];
    lblDate.text=matchMonth;

    UILabel *lblDay=(UILabel*)[cell viewWithTag:1];
    lblDay.text=matchDate;

    UILabel *lblMatchName=(UILabel*)[cell viewWithTag:2];
    lblMatchName.text=[[objArrMatchResult objectAtIndex:indexPath.row] valueForKey:@"mname"];

    UILabel *lblMatchTime=(UILabel*)[cell viewWithTag:3];
    lblMatchTime.text=[[objArrMatchResult objectAtIndex:indexPath.row] valueForKey:@"mtime"];

    UILabel *lblMatchVenue=(UILabel*)[cell viewWithTag:4];

    if (![[[objArrMatchResult objectAtIndex:indexPath.row] valueForKey:@"match_results"] isEqual:[NSNull null]])
        {

    lblMatchVenue.text=[[objArrMatchResult objectAtIndex:indexPath.row] valueForKey:@"match_results"];
        }
    
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell  forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [objSharedData AnimationWithCell:indexPath.row :cell];
}

-(void)SelectedCategory:(NSString*)Cat{
    NSDictionary* selectedValue=[[NSDictionary alloc]init];
    NSLog(@"Avinash Mahajan @%d",_selected_category);
    selectedValue= Cat;

    if (_selected_category==2)
        {
        NSLog(@"tournamentid=%@",[selectedValue valueForKey:@"tournamentid"]);
        NSMutableString *methodName=[NSMutableString string];
        [methodName appendString:@"livescore/results/"];
        [methodName appendString:[selectedValue valueForKey:@"tournamentid"]];
        [methodName appendString:@"_match_list.json"];

        [self callServiceForSchedule:methodName];

        }
    else if (_selected_category==3)
        {
        NSLog(@"team_a=%@",[selectedValue valueForKey:@"team_a"]);
        NSMutableString *methodName=[NSMutableString string];
        [methodName appendString:@"livescore/results/"];
        [methodName appendString:[[[selectedValue valueForKey:@"team_a"] stringByReplacingOccurrencesOfString:@" " withString:@"_"] lowercaseString]];
        [methodName appendString:@".json"];

        [self callServiceForSchedule:methodName];
        }

}

-(void)callMonthSchedule
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];

    int year = [components year];
    int month = [components month];
        //int day = [components day];


    NSString * dateString = [NSString stringWithFormat: @"%d", month];

    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSDate* myDate = [dateFormatter dateFromString:dateString];


    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM"];
    NSString *stringFromDate = [[formatter stringFromDate:myDate] lowercaseString];

        // NSString *stringFromDate =[self monthNameFromDate:[NSDate date]];

    NSMutableString *methodName=[NSMutableString string];
    [methodName appendString:@"livescore/results/"];
    [methodName appendString:stringFromDate];
    [methodName appendString:@"-"];
    [methodName appendString: [NSString stringWithFormat:@"%d",year]];
    [methodName appendString: @".json"];

    //call web services for get schedule from server and open new controller
    [self callServiceForSchedule:methodName];
}


- (IBAction)btnActionSoftByCatgory:(id)sender {
    UIButton *tempbtn=(UIButton*)sender;
    switch (tempbtn.tag) {
        case 1:
            //call service for month data
            
           [self callMonthSchedule];
            break;
        case 2:
            //call service for series/tuornament data
           _selected_category=2;
            [self performSegueWithIdentifier:@"tournament" sender:sender];
            
            break;
        case 3:
            //call service for country
            _selected_category=3;
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
    NSLog(@"MatchResults:-%@",dicResponce);
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
