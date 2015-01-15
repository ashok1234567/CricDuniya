//
//  ScheduleController.m
//  CricketDuniya
//
//  Created by ashok on 1/11/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "ScheduleController.h"
#import "REFrostedViewController.h"
#import "SelectionsController.h"
@interface ScheduleController ()<WebServiceHandlerDelegate,SelectCategory>
{
    NSMutableArray *objArrScheduleData;
}
@end

@implementation ScheduleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    objArrScheduleData=[[NSMutableArray alloc]initWithCapacity:0];
     self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0f green:147/255.0f blue:74/255.0f alpha:1.0]};
    
    
    for (int i=0; i<5; i++) {
        NSMutableDictionary *objTempDicResult=[[NSMutableDictionary alloc]init];
        [objTempDicResult setValue:@"Jan, 2015" forKey:@"data1"];
        [objTempDicResult setValue:@"14 JAN" forKey:@"data2"];
        [objTempDicResult setValue:@"IND v/s PAK,3rd match" forKey:@"data3"];
        [objTempDicResult setValue:@"20.00 IST/ 13.34 GMT" forKey:@"data4"];
        [objTempDicResult setValue:@"New Dehli, India" forKey:@"data5"];
        
        [objArrScheduleData addObject:objTempDicResult];
       
    }

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    SelectionsController *objSelectionsController=[segue destinationViewController];
    UIButton *tempbtn=(UIButton*)sender;
    objSelectionsController.category=tempbtn.tag;
    objSelectionsController.Pdelegate=self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return [objArrScheduleData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel *lblDate=(UILabel*)[cell viewWithTag:5];
    lblDate.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"data1"];
    lblDate.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"data1"];

    UILabel *lblDay=(UILabel*)[cell viewWithTag:1];
    lblDay.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"data2"];
    
    UILabel *lblMatchName=(UILabel*)[cell viewWithTag:2];
    lblMatchName.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"data3"];
    
    UILabel *lblMatchTime=(UILabel*)[cell viewWithTag:3];
    lblMatchTime.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"data4"];
    
    UILabel *lblMatchVenue=(UILabel*)[cell viewWithTag:4];
    lblMatchVenue.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"data5"];
    
        
        return cell;
    
    
}

- (IBAction)btnActionSoftByCatgory:(id)sender {
    UIButton *tempbtn=(UIButton*)sender;
    switch (tempbtn.tag) {
        case 1:
            //call service for month data
            
            [self callServiceForSchedule:LiveScheduleMatch_Url];
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
-(void)SelectedCategory:(NSString*)Cat{
    NSLog(@"cat=%@",Cat);
    ///web server for load data for selected category
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
    NSLog(@"dicResponce:-%@",[dicResponce valueForKey:@"microscorecard_data_items"]);
    [appDelegate stopActivityIndicator];
    
    
    
}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{
    
    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
    //remove it after WS call
}

@end
