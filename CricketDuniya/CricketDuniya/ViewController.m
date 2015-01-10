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
#pragma mark Custom methods

- (IBAction)btnEnterAction:(id)sender {
    
    _btnEnterOutlet.hidden=YES;
    _viewLoginOutlet.hidden=NO;
    
    //Call services for singin
    [self callServiceForSignIn];
}

- (IBAction)btnActionSignIn:(id)sender {
   
    
}
-(void)callServiceForSignIn
{
  

   NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:@"ashok",@"user_name",@"1234",@"user_password",SocialType,@"user_from",@"0",@"facebook_id",nil];
    
    NSString *methodName = SignIN_Url;
    
    //for ActivityIndicator start
  //  [appDelegate startActivityIndicator:self.view withText:Progressing];
    
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    //for AFNetworking request
    [objWebServiceHandler AFNcallThePassedURLASynchronouslyWithRequest:valueDic withMethod:methodName withUrl:methodName forKey:@""];
}
-(void)webServiceHandler:(WebserviceHandler *)webHandler recievedResponse:(NSDictionary *)dicResponce
{
    NSLog(@"dicResponce:-%@",dicResponce);
    [appDelegate stopActivityIndicator];
    
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
