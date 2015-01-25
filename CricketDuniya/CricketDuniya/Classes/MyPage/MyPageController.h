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
@property(nonatomic, retain) NSMutableArray* headViewArray;
@property(nonatomic, retain) NSMutableArray* headViewClosed;
@property (weak, nonatomic) IBOutlet UITableView *tblLiveContestQue;
@property (weak, nonatomic) IBOutlet UITableView *tblClosedContestQue;

@end
