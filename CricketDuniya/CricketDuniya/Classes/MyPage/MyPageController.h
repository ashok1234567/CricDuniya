//
//  MyPageController.h
//  CricketDuniya
//
//  Created by ashok on 1/24/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
@interface MyPageController : UIViewController<HeadViewDelegate>
{
    NSInteger _currentSection;
    NSInteger _currentSectionClosed;
NSInteger _currentRow;
    NSInteger _currentRowClosed;
    NSInteger _tblTag;
    
    
}
@property (weak, nonatomic) IBOutlet UILabel *lbltitle2;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle1;
@property (weak, nonatomic) IBOutlet UILabel *lblsepline;
@property(nonatomic, retain) NSMutableArray* headViewArray;
@property(nonatomic, retain) NSMutableArray* headViewClosed;
@property (weak, nonatomic) IBOutlet UITableView *tblLiveContestQue;
@property (weak, nonatomic) IBOutlet UITableView *tblClosedContestQue;
@property (weak, nonatomic) IBOutlet UITableView *lblWinLoss;
- (IBAction)btnActionAll:(id)sender;

@end
