//
//  ViewController.m
//  CricketDuniya
//
//  Created by ashok on 1/4/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//  Avinash

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //view load
     _viewLoginOutlet.hidden=YES;
    [self preperLayout];
}
-(void)preperLayout{
    
    //setup textfield layout
    UIView *paddingViewUserName = [[UIView alloc] initWithFrame:CGRectMake(0, 0,15, 35)];
    self.txtEmailOrMobileNo.leftView = paddingViewUserName;
    self.txtEmailOrMobileNo.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewPassword = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 35)];
    self.txtPassword.leftView = paddingViewPassword;
    self.txtPassword.leftViewMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  TextField Delegate methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
   
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {

}


#pragma mark Custom methods

- (IBAction)btnEnterAction:(id)sender {
    
    _btnEnterOutlet.hidden=YES;
    _viewLoginOutlet.hidden=NO;
    
    
}

- (IBAction)btnActionSignIn:(id)sender {
  
    if([_txtEmailOrMobileNo.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length<=0){
        //ShowAlert(AppName, InvalidEmailOrMobileno);
        [objSharedData shakeAnimation:_txtEmailOrMobileNo];
        
    }else if([_txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length<=0){
        
        // ShowAlert(AppName, InvalidPassword);
                [objSharedData shakeAnimation:_txtPassword];
    }else{
        
        //Call services for singin
        [self callServiceForSignIn];
    }
    
   // [self performSegueWithIdentifier:@"signup" sender:nil];
}
-(void)callServiceForSignIn
{
  
   NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:_txtEmailOrMobileNo.text,@"user_name",_txtPassword.text,@"user_password",SocialType,@"user_from",@"0",@"facebook_id",nil];
    
    NSString *methodName = SignIN_Url;
    
    //for ActivityIndicator start
    [appDelegate startActivityIndicator:self.view withText:Progressing];
    
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];

}
-(void)webServiceHandler:(WebserviceHandler *)webHandler recievedResponse:(NSDictionary *)dicResponce
{
    NSLog(@"dicResponce:-%@",dicResponce);
    
    [appDelegate stopActivityIndicator];
    if([[dicResponce valueForKey:@"message"] isEqualToString:@"User Login Sucessfully"]){
        
        objSharedData.logingUserInfo=[dicResponce valueForKey:@"data"];
        
        [self performSegueWithIdentifier:@"login" sender:nil];
        
        
    }else if([[dicResponce valueForKey:@"message"] isEqualToString:@"Registred Sucessfully"]){
             [self performSegueWithIdentifier:@"signup" sender:nil];
    }else{
        ShowAlert(AppName,[dicResponce valueForKey:@"message"]);
    }
    
    
}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{
    
     NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
    //remove it after WS call
}

- (IBAction)btnActionLogin:(id)sender {
}
@end
