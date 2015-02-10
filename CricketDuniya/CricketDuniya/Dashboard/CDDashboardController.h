//
//  CDDashboardController.h
//  CricketDuniya
//
//  Created by ashok on 1/5/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDDashboardController : UIViewController<WebServiceHandlerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblTeam2Score;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *tempRR;
@property (weak, nonatomic) IBOutlet UILabel *tempCR;
@property (weak, nonatomic) IBOutlet UIView *viewcomnnentryBG;
@property (weak, nonatomic) IBOutlet UIButton *btnOutletMatch1;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentryBG;
- (IBAction)btnActionMatch2:(id)sender;
- (IBAction)btnActionMatch3:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchDate;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchTime;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchVenue;
@property (weak, nonatomic) IBOutlet UILabel *lblBatingTeamInitial;
@property (weak, nonatomic) IBOutlet UILabel *lblBowlingTeamInitial;
@property (weak, nonatomic) IBOutlet UILabel *lblIningDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblCurrentRate;
@property (weak, nonatomic) IBOutlet UILabel *lblRequiredRate;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer1;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer1Runs;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer1Balls;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer14;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer16;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer1SR;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer2;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer2Runs;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer2Balls;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer24;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer26;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer2SR;
@property (weak, nonatomic) IBOutlet UILabel *lblBowler;
@property (weak, nonatomic) IBOutlet UILabel *lblBowlerOvers;
@property (weak, nonatomic) IBOutlet UILabel *lblBowlerMaidens;
@property (weak, nonatomic) IBOutlet UILabel *lblBowlerRuns;
@property (weak, nonatomic) IBOutlet UILabel *lblBowlerWicket;
@property (weak, nonatomic) IBOutlet UIButton *btnMatch3;
@property (weak, nonatomic) IBOutlet UILabel *lblBowlerER;
- (IBAction)btnActionMatch:(id)sender;
-(void)callServiceForDashboard;
@property (weak, nonatomic) IBOutlet UIScrollView *scrContainer;
- (IBAction)tblActionFullScore:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnActionReloadCommenntry;
@property (weak, nonatomic) IBOutlet UITextView *lblBallbyCommenntry;
@property (weak, nonatomic) IBOutlet UIImageView *imgCommenntry;
@property (weak, nonatomic) IBOutlet UIButton *btnMatch2;
@property (nonatomic)int selected_service;
@property (weak, nonatomic) IBOutlet UIButton *btnMatch1;

-(void)loadWhatNext:(int )index;
@end
