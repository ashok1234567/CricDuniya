//
//  FirstCellView.h
//  CricketDuniya
//
//  Created by ashok on 1/22/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblPlayerName;

@property (weak, nonatomic) IBOutlet UILabel *lblPlayerStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblRun;
@property (weak, nonatomic) IBOutlet UILabel *lblBall;
@property (weak, nonatomic) IBOutlet UILabel *lbl4s;
@property (weak, nonatomic) IBOutlet UILabel *lbl6s;
@property (weak, nonatomic) IBOutlet UILabel *lblSR;
@end
