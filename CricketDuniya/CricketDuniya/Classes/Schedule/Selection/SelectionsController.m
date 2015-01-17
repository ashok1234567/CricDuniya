//
//  SelectionsController.m
//  CricketDuniya
//
//  Created by ashok on 1/15/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "SelectionsController.h"

@interface SelectionsController ()<WebServiceHandlerDelegate>
{
    NSMutableArray *objArrScheduleData;
}
@end

@implementation SelectionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //setup  table view edge
    [self.mytbl setContentInset:UIEdgeInsetsMake(-40, 0, 0, 0)];
    
    
    switch (_category) {
        
        case 2:
            //call service for series/tuornament data
            
              [self callServiceForSchedule:Tournament_Url];
            break;
        case 3:
            //call service for country
              [self callServiceForSchedule:Country_Url];
            break;
            
        default:
            break;
    }

        // objArrScheduleData=[[NSMutableArray alloc]initWithObjects:@"test",@"test",@"test",@"test",@"test",@"test", nil];
    
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
    if (_category==2)
        {
    cell.textLabel.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"tournament_name"];
        }
    else if (_category==3)
        {
        cell.textLabel.text=[[objArrScheduleData objectAtIndex:indexPath.row] valueForKey:@"team_a"];

        }

    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_Pdelegate SelectedCategory:[objArrScheduleData objectAtIndex:indexPath.row]];
    [self btnCancel:nil];
}

#pragma mark WebService
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
    NSLog(@"dicResponce:-%@",dicResponce);
    objArrScheduleData =dicResponce ;
    [self.mytbl reloadData];
    [appDelegate stopActivityIndicator];
 
}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{
    
    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
    //remove it after WS call
}


- (IBAction)btnCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
