//
//  LastOverChancePeyController.h
//  CricketDuniya
//
//  Created by ashok on 2/4/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
@interface LastOverChancePeyController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewsSartUp;
- (IBAction)btnActionBat:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnActionbowl;
@property (weak, nonatomic) IBOutlet UIView *viewSecoundStep;
- (IBAction)btnActionSecondStepBall:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewFinalPlay;
- (IBAction)btnActionAllPlay:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer2Runs;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer2Ball;
- (IBAction)btnActionBowl:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblAskRate;
@property (weak, nonatomic) IBOutlet UILabel *lblpresentRate;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer1;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer2;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer1Runs;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer1Ball;
@property (weak, nonatomic) IBOutlet UILabel *lblrunstowin;
@property (weak, nonatomic) IBOutlet UILabel *lbltarget;

@property (weak, nonatomic) IBOutlet UILabel *lblOverBy;
@property (weak, nonatomic) IBOutlet UITextView *lblBallbyBallCommentary;
@property (nonatomic)int selected_service;
@end
