//
//  FullLiveScoreController.h
//  CricketDuniya
//
//  Created by ashok on 1/22/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullLiveScoreController : UIViewController

- (IBAction)btnActionCancel:(id)sender;
@property (retain, nonatomic)NSString *urlForFullScore;
@property (weak, nonatomic) IBOutlet UITableView *tblFullScoreBoard;
@end
