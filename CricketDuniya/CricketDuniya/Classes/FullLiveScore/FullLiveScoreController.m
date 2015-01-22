//
//  FullLiveScoreController.m
//  CricketDuniya
//
//  Created by ashok on 1/22/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "FullLiveScoreController.h"
#import "FirstCellView.h"
#import "SecoundCellView.h"
#import "ThirdCellView.h"

//define macros
#define arrBatting @"batting"
#define arrBowling @"bowling"
#define arrMatchInfo @"matchinfo"

@interface FullLiveScoreController ()

{
    NSMutableDictionary *objDicFullScore;
  
}
@end

@implementation FullLiveScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [_tblFullScoreBoard registerNib:[UINib nibWithNibName:@"FirstCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell1"];
     [_tblFullScoreBoard registerNib:[UINib nibWithNibName:@"SecoundCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell2"];
     [_tblFullScoreBoard registerNib:[UINib nibWithNibName:@"ThirdCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell3"];
    
    
   NSMutableArray *objArrBatting=[[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3", nil];
    
     NSMutableArray *objArrBowling=[[NSMutableArray alloc]initWithObjects:@"1",@"2", nil];
     NSMutableArray *objArrMatchInfo=[[NSMutableArray alloc]initWithObjects:@"1", nil];
    objDicFullScore=[[NSMutableDictionary alloc]init];
    [objDicFullScore setValue:objArrBatting forKey:arrBatting];
    [objDicFullScore setValue:objArrBowling forKey:arrBowling];
    [objDicFullScore setValue:objArrMatchInfo forKey:arrMatchInfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableVIew Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
           return  [[objDicFullScore valueForKey:arrBatting] count];
            break;
        case 1:
           return  [[objDicFullScore valueForKey:arrBowling] count];
            break;
        case 2:
          return [[objDicFullScore valueForKey:arrMatchInfo] count];
            break;
            
        default:
            return 0;
            break;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"Cell1";
        
        FirstCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        cell.lblPlayerName.text=@"Rohit Sharma";
    return cell;
    }else  if (indexPath.section==1){
        
        static NSString *CellIdentifier = @"Cell2";
        
        SecoundCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        return cell;
    }else {
        static NSString *CellIdentifier = @"Cell3";
        
        ThirdCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        return cell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section)
    {
        case 0:
            return 55.f;
            break;
        case 1:
            return 40.f;
            break;
        case 2:
            return 1109.0f;
            break;
        default: return 0;
            break;
            
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    switch (section)
    {
        case 0:
            return 180.f;
            break;
        case 1:
             return 30.f;
            break;
        case 2:
             return 50.f;
            break;
        default: return 0;
            break;
            
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    switch (section)
    {
        case 0:
            return 100.f;
            break;
        case 1:
            return 0.1f;
            break;
        case 2:
            return 0.1f;
            break;
        default: return 0.1f;
            break;
            
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
     UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0,50,50.0)];
    switch (section)
    {
        case 0:{
            
           UIView *firstHeaderView=[[[NSBundle mainBundle] loadNibNamed:@"FirstHeader" owner:self options:nil] lastObject];
            firstHeaderView.frame=header.frame;
            
            
            UILabel *label=(UILabel*)[firstHeaderView viewWithTag:1];
            label.text = @"INDIA";
            [header addSubview:firstHeaderView];
        }
            break;
        case 1:{
            
           //SecoundHeader
            
            UIView *firstHeaderView=[[[NSBundle mainBundle] loadNibNamed:@"SecoundHeader" owner:self options:nil] lastObject];
            firstHeaderView.frame=header.frame;
            
            
//            UILabel *label=(UILabel*)[firstHeaderView viewWithTag:1];
//            label.text = @"INDIA";
            [header addSubview:firstHeaderView];
        }
            break;
        case 2:{
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0,20,100,30.0)];
            label.backgroundColor= [UIColor clearColor];
            label.textColor= [UIColor blackColor];
            label.font = [UIFont fontWithName:@"Helvetica Neue" size:11.0];
            label.text = @"MATCH INFO";
            [header addSubview:label];
        }
            break;
            
    }

   
    
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0,50,50.0)];
    switch (section)
    {
        case 0:{
            
            UIView *firstHeaderView=[[[NSBundle mainBundle] loadNibNamed:@"FirstFooter" owner:self options:nil] lastObject];
            firstHeaderView.frame=header.frame;
            
            
            UILabel *label=(UILabel*)[firstHeaderView viewWithTag:1];
            label.text = @"18";
            [header addSubview:firstHeaderView];
        }
            break;
        case 1:{
        
        }
            break;
        case 2:{
          
        }
            break;
            
    }
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
#pragma mark Custom Methods

- (IBAction)btnActionCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
