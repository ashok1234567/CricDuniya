//
//  LeaderBoardController.h
//  CricketDuniya
//
//  Created by ashok on 1/21/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnDay;
@property (weak, nonatomic) IBOutlet UIButton *btnWeek;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth;
- (IBAction)btnActionDay:(id)sender;
- (IBAction)btnActionWeek:(id)sender;
- (IBAction)btnActionMonth:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblLeaderBoard;
@property (weak, nonatomic) IBOutlet UITableView *myTbl;

@end
