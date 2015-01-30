//
//  ViewController.h
//  CricketDuniya
//
//  Created by ashok on 1/4/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "WebserviceHandler.h"
@interface ViewController : UIViewController<WebServiceHandlerDelegate>


@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *viewLoginOutlet;
@property (weak, nonatomic) IBOutlet UIButton *btnEnterOutlet;
- (IBAction)btnEnterAction:(id)sender;
- (IBAction)btnActionSignIn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailOrMobileNo;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLoginOutlet;
- (IBAction)btnActionLogin:(id)sender;
- (IBAction)btnActionLoginWithFacebook:(id)sender;
- (IBAction)TextDidChange:(id)sender;
-(void)callServiceForSignIn;
@end

