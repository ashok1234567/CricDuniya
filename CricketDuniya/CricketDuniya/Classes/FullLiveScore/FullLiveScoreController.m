//
//  FullLiveScoreController.m
//  CricketDuniya
//
//  Created by ashok on 1/22/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "FullLiveScoreController.h"

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
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    switch (section)
    {
        case 0:
            return 100.f;
            break;
        case 1:
             return 15.f;
            break;
        case 2:
             return 15.f;
            break;
        default: return 0;
            break;
            
    }
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
     UIView *header = [[UIView alloc] initWithFrame:CGRectMake(15.0, 0, 150,15.0)];
    switch (section)
    {
        case 0:{
            UILabel *label = [[UILabel alloc] initWithFrame:header.frame];
            label.backgroundColor= [UIColor clearColor];
            label.textColor= [UIColor blackColor];
            label.font = [UIFont fontWithName:@"Helvetica Neue" size:10.0];
            label.text = @"BATTING";
            [header addSubview:label];
        }
            break;
        case 1:{
            UILabel *label = [[UILabel alloc] initWithFrame:header.frame];
            label.backgroundColor= [UIColor clearColor];
            label.textColor= [UIColor blackColor];
            label.font = [UIFont fontWithName:@"Helvetica Neue" size:10.0];
            label.text = @"BOLWER";
            [header addSubview:label];
        }
            break;
        case 2:{
            UILabel *label = [[UILabel alloc] initWithFrame:header.frame];
            label.backgroundColor= [UIColor clearColor];
            label.textColor= [UIColor blackColor];
            label.font = [UIFont fontWithName:@"Helvetica Neue" size:10.0];
            label.text = @"MATCH INFO";
            [header addSubview:label];
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

@end
