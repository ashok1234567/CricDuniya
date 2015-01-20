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
@interface LeaderBoardController ()
{
    NSMutableArray *objArrLeaders;
}
@end

@implementation LeaderBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set navagition title color
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0f green:147/255.0f blue:74/255.0f alpha:1.0]};
    
    
    objArrLeaders=[[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i=0; i<5; i++) {
        NSMutableDictionary *objTempDicResult=[[NSMutableDictionary alloc]init];
        [objTempDicResult setValue:@"http://url.com/sf" forKey:@"data1"];
        [objTempDicResult setValue:@"Full Name" forKey:@"data2"];
        [objTempDicResult setValue:@"434 Point" forKey:@"data3"];
        
        [objArrLeaders addObject:objTempDicResult];
        
    }
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [objArrLeaders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UIImageView *imgLeader=(UIImageView*)[cell viewWithTag:1];
  
    [imgLeader setImageWithURL:[NSURL URLWithString:[[objArrLeaders objectAtIndex:indexPath.row] valueForKey:@"data1"]] placeholderImage:nil];
    
    UILabel *lblLeaderName=(UILabel*)[cell viewWithTag:2];
    lblLeaderName.text=[[[objArrLeaders objectAtIndex:indexPath.row] valueForKey:@"data2"] capitalizedString];
    
    UILabel *lblLeaderPoints=(UILabel*)[cell viewWithTag:3];
    lblLeaderPoints.text=[[[objArrLeaders objectAtIndex:indexPath.row] valueForKey:@"data3"] capitalizedString];
    
    
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
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(15.0, 5, 100,15.0)];
    UILabel *label = [[UILabel alloc] initWithFrame:header.frame];
    label.backgroundColor= [UIColor clearColor];
   label.textColor= [UIColor blackColor];
    label.font = [UIFont fontWithName:@"Helvetica Neue Medium" size:11.0];
    label.text = @"OVER ALL";
    [header addSubview:label];
    return header;
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
}

- (IBAction)btnActionWeek:(id)sender {
}

- (IBAction)btnActionMonth:(id)sender {
}
@end
