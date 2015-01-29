//
//  WhatNextController.h
//  CricketDuniya
//
//  Created by ashok on 1/5/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
@interface WhatNextController : UIViewController<HeadViewDelegate>
{
NSInteger _currentSection;
NSInteger _currentSectionClosed;
NSInteger _currentRow;
NSInteger _currentRowClosed;
NSInteger _tblTag;
    __weak IBOutlet UIButton *btnANS1;
}

@property (weak, nonatomic) IBOutlet UILabel *lblANS4Point;
@property (weak, nonatomic) IBOutlet UILabel *lblANS3Point;
@property (weak, nonatomic) IBOutlet UILabel *lblANS2Point;
@property (weak, nonatomic) IBOutlet UILabel *lblANS1Point;
@property (weak, nonatomic) IBOutlet UIButton *btnANS4;
@property (weak, nonatomic) IBOutlet UIButton *btnANS3;
@property (weak, nonatomic) IBOutlet UIButton *btnANS2;
@property (weak, nonatomic) IBOutlet UITextView *lblQuestion;
@property(nonatomic, retain) NSMutableArray* headViewArray;
@property(nonatomic, retain) NSMutableArray* headViewClosed;
@property (weak, nonatomic) IBOutlet UITableView *tblLiveContestQue;
@property (weak, nonatomic) IBOutlet UITableView *tblClosedContestQue;
@property (weak, nonatomic) IBOutlet UILabel *lblQueNo;
@property (weak, nonatomic) IBOutlet UIView *viewnotlivecontest;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;

- (IBAction)btnActionAns1:(id)sender;









@property(nonatomic) int selectedMatch;
@end
