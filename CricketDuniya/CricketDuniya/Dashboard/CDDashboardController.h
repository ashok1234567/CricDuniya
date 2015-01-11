//
//  CDDashboardController.h
//  CricketDuniya
//
//  Created by ashok on 1/5/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDDashboardController : UIViewController<WebServiceHandlerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnOutletMatch1;
- (IBAction)btnActionMatch2:(id)sender;
- (IBAction)btnActionMatch3:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnActionMatch1;
@property (weak, nonatomic) IBOutlet UILabel *lblTeamName1;
@property (weak, nonatomic) IBOutlet UILabel *lblTeamName2;
@property (weak, nonatomic) IBOutlet UILabel *lblScoreTarget1;
@property (weak, nonatomic) IBOutlet UILabel *lblScoreTarget2;
@property (weak, nonatomic) IBOutlet UILabel *lblScoreTargetTeam2;
@property (weak, nonatomic) IBOutlet UILabel *lblAskingRunRate;
@property (weak, nonatomic) IBOutlet UILabel *lblPresentRunRate;
@property (weak, nonatomic) IBOutlet UILabel *lblThisOver;
@property (weak, nonatomic) IBOutlet UILabel *lblBatingMember1;
@property (weak, nonatomic) IBOutlet UILabel *lblBatingMember2;
@property (weak, nonatomic) IBOutlet UILabel *lblmeMember1;
@property (weak, nonatomic) IBOutlet UILabel *lblRunmember2;

@property (weak, nonatomic) IBOutlet UILabel *lblBallMember1;
@property (weak, nonatomic) IBOutlet UILabel *lblBallMember2;
- (IBAction)tblActionFullScore:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnActionReloadCommenntry;
@property (weak, nonatomic) IBOutlet UITextView *lblBallbyCommenntry;
@property (weak, nonatomic) IBOutlet UIImageView *imgCommenntry;
@end
