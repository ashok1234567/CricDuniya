//
//  SelectionsController.h
//  CricketDuniya
//
//  Created by ashok on 1/15/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectCategory <NSObject>

@required
-(void)SelectedCategory:(NSString*)Cat;

@end
@interface SelectionsController : UIViewController{
    
}
@property (nonatomic)int category;
@property (nonatomic, retain) id <SelectCategory> Pdelegate;;
@property (strong, nonatomic) IBOutlet UITableView *mytbl;

- (IBAction)btnCancel:(id)sender;
@end

