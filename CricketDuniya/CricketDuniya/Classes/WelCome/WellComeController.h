//
//  WellComeController.h
//  CricketDuniya
//
//  Created by ashok on 2/14/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WellComeController : UIViewController
- (IBAction)btnSchedule:(id)sender;
- (IBAction)btnMatchresult:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMatchresult;
@property (weak, nonatomic) IBOutlet UIButton *btnschedule;
@property (weak, nonatomic) IBOutlet UIButton *btnGoLive;
@property (weak, nonatomic) IBOutlet UIImageView *imgsepareteline;
- (IBAction)btnGoLive:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblBG;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchDate;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchTime;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchPlace;

@end
