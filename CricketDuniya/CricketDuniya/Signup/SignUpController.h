//
//  SignUpController.h
//  CricketDuniya
//
//  Created by ashok on 1/7/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnSignuOutlet;
- (IBAction)btnSignupAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@property (weak, nonatomic) IBOutlet UIButton *btnMaleOutlet;
- (IBAction)btnActionMale:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnOutletFemale;
- (IBAction)btnActionFemale:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnoutletSignUp;
- (IBAction)btnActionSignUp:(id)sender;

@end
