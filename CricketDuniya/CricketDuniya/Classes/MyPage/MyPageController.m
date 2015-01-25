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
@interface MyPageController ()

@end

@implementation MyPageController
@synthesize headViewArray,headViewClosed;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:58/255.0f green:147/255.0f blue:74/255.0f alpha:1.0]};
    
    
    [_tblLiveContestQue registerNib:[UINib nibWithNibName:@"AnwserCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cellans"];
     [_tblClosedContestQue registerNib:[UINib nibWithNibName:@"ClosedCellView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellclosed"];
    
    //for live
    [self loadModelLive];
    
    //for closed
    [self loadModelClosed];
    
    
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
    for(int i = 0;i< 3 ;i++)
    {
        HeadView* headview = [[HeadView alloc] init];
        headview.delegate = self;
        headview.section = i;
        headview.backBtn.tag=1;
        [headview.backBtn setTitle:[NSString stringWithFormat:@"What will happen in next ball ?=%d",i] forState:UIControlStateNormal];
        headview.lblMatchTitle.text=@"Match 1 Q. no 54";
        [self.headViewArray addObject:headview];
        
    }
}
- (void)loadModelClosed{
    _currentRow = -1;
    headViewClosed = [[NSMutableArray alloc]init ];
    for(int i = 0;i< 2 ;i++)
    {
        HeadView* headview = [[HeadView alloc] init];
        headview.delegate = self;
        headview.section = i;
        headview.backBtn.tag=2;
        [headview.backBtn setTitle:[NSString stringWithFormat:@"What will happen in next ball ?=%d",i] forState:UIControlStateNormal];
        headview.lblMatchTitle.text=@"Match 1 Q. no 54";
        [self.headViewClosed addObject:headview];
        
    }
}



#pragma mark - TableViewdelegate&&TableViewdataSource

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag==1){
    HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
    
    return headView.open?35:0;
    }else {
        HeadView* headView = [self.headViewClosed objectAtIndex:indexPath.section];
        
        return headView.open?35:0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
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
        return headView.open?4:0;
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
        cell.lblAns.text=[NSString stringWithFormat:@"Ans_%d",indexPath.row+1];
        [cell.imgBG.layer setCornerRadius:2.0];
        return cell;
    }else if(tableView.tag==2){
        
        static NSString *CellIdentifier = @"cellclosed";
        ClosedCellView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.lblAns.text=[NSString stringWithFormat:@"Ans_%d",indexPath.row+1];
        [cell.imgBG.layer setCornerRadius:2.0];
        return cell;
    }else{
   
    return nil;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _tblTag=tableView.tag;
    if(tableView.tag==1){
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
