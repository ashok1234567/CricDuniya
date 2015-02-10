//
//  ThirdCellView.h
//  CricketDuniya
//
//  Created by ashok on 1/23/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewCommentryBG;
@property (weak, nonatomic) IBOutlet UITextView *lblMatch;
@property (weak, nonatomic) IBOutlet UITextView *lblDate;
@property (weak, nonatomic) IBOutlet UITextView *lblVenue;
@property (weak, nonatomic) IBOutlet UITextView *lblUmpires;
@property (weak, nonatomic) IBOutlet UITextView *lbl3rdUmpire;
@property (weak, nonatomic) IBOutlet UITextView *lblMetchReferee;
@property (weak, nonatomic) IBOutlet UITextView *lblTeam1;
@property (weak, nonatomic) IBOutlet UITextView *lblTeam1Banch;
@property (weak, nonatomic) IBOutlet UITextView *lblTeam2;
@property (weak, nonatomic) IBOutlet UITextView *lblTeam2Banch;
@property (weak, nonatomic) IBOutlet UILabel *lblTeam2squrd;
@property (weak, nonatomic) IBOutlet UILabel *lblTeam1Squard;
@property (weak, nonatomic) IBOutlet UITextView *lblCommentry;
@property (weak, nonatomic) IBOutlet UIImageView *imgAd;

@end
