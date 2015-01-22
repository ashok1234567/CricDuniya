//
//  MatchResultController.h
//  CricketDuniya
//
//  Created by ashok on 1/21/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchResultController : UIViewController
@property (nonatomic)int selected_category;
@property (weak, nonatomic) IBOutlet UITableView *tblMatchResult;

@end
