//
//  MenuController.h
//  CricketDuniya
//
//  Created by ashok on 1/6/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
@interface MenuController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblMenuAndNotification;
@property (weak, nonatomic) IBOutlet UIButton *btnCatOutlet;
@property (weak, nonatomic) IBOutlet UIButton *btnResOutlet;
@property (weak, nonatomic) IBOutlet UIButton *btnNotiOutlet;
- (IBAction)btnAllSliderPanalAction:(id)sender;

@end
