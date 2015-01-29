//
//  ViewController.m
//  CricketDuniya
//
//  Created by ashok on 1/4/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//  Avinash

#import "ViewController.h"

@interface ViewController ()
{
    BOOL isLoginWithFB;
    int intServiceResponce;
    NSMutableDictionary *fbLoginUserData;
    //facebook objects
    FBSession *session;
    NSHTTPCookie *cookie;
}
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
- (BOOL) textField: (UITextField *)theTextField shouldChangeCharactersInRange: (NSRange)range replacementString: (NSString *)string {
    
     [theTextField.layer setBorderColor:[UIColor clearColor].CGColor];
    return YES;
}


#pragma mark Custom methods

- (IBAction)btnEnterAction:(id)sender {
    
    _btnEnterOutlet.hidden=YES;
    _viewLoginOutlet.hidden=NO;
    
    
}
- (IBAction)btnActionSignIn:(id)sender {
  
    isLoginWithFB=NO;
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
    

}
- (IBAction)btnActionLogin:(id)sender {
}
- (IBAction)btnActionLoginWithFacebook:(id)sender {
    
    isLoginWithFB=YES;
    [self facebookLogin];
    
}

- (IBAction)TextDidChange:(id)sender {
    
    
}

#pragma mark WEBServices 
-(void)callServiceForSignIn
{
    NSDictionary* valueDic;
    if(!isLoginWithFB){
 valueDic =[NSDictionary dictionaryWithObjectsAndKeys:_txtEmailOrMobileNo.text,@"user_name",_txtPassword.text,@"user_password",SocialType,@"user_from",@"0",@"facebook_id",nil];
    }else{
        valueDic =[NSDictionary dictionaryWithObjectsAndKeys:[fbLoginUserData valueForKey:@"first_name"],@"user_name",[fbLoginUserData valueForKey:@"id"],@"user_password",SocialType,@"user_from",[fbLoginUserData valueForKey:@"id"],@"facebook_id",nil];
    }
    
    NSString *methodName = SignIN_Url;
    
    //service type
     intServiceResponce=1;
    
    //for ActivityIndicator start
    [appDelegate startActivityIndicator:self.view withText:Progressing];
    
    WebserviceHandler *objWebServiceHandler=[[WebserviceHandler alloc]init];
    objWebServiceHandler.delegate = self;
    
    //for AFNetworking request
    [objWebServiceHandler callWebserviceWithRequest:methodName RequestString:valueDic RequestType:@""];

}
-(void)callServiceForSignUp
{
    
    NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:[fbLoginUserData valueForKey:@"name"],@"first_last_name",[fbLoginUserData valueForKey:@"gender"],@"gender",@"",@"age",[fbLoginUserData valueForKey:@"profilepic"],@"profile_img",SocialType,@"user_from",nil];
    
    
    NSString *methodName = SignUp_Url;
    
    //service type
    intServiceResponce=2;
    
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
    
    if(intServiceResponce==1){
    if(!isLoginWithFB){
    if([[dicResponce valueForKey:@"message"] isEqualToString:@"User Login Sucessfully"]){
        
        objSharedData.logingUserInfo=[dicResponce valueForKey:@"data"];
        
        [self performSegueWithIdentifier:@"login" sender:nil];
        
        
    }else if([[dicResponce valueForKey:@"message"] isEqualToString:@"Registred Sucessfully"]){
             [self performSegueWithIdentifier:@"signup" sender:nil];
    }else{
        ShowAlert(AppName,[dicResponce valueForKey:@"message"]);
    }
    }else{
        
        //login with FB
        [self callServiceForSignUp];
        
    }
    }else{
        
        //load live score board
        if([[dicResponce valueForKey:@"message"] isEqualToString:@"Update Sucessfully"]){
            objSharedData.logingUserInfo=[dicResponce valueForKey:@"data"];
            [self performSegueWithIdentifier:@"login" sender:nil];
        }else{
            ShowAlert(AppName, @"please try again");
        }

    }
    
    
}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{
    
     NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
    //remove it after WS call
}


#pragma mark FACEBOOK LOGIN
- (void)facebookLogin
{
    //[appDelegate startActivityIndicator:self.view withText:Progressing];
    if (session.accessTokenData.accessToken) {
        [self getUserDetails];
    }else{//
        //old app id -> 231009703739339 new-> 1482102808708527 //,@"email"
        session = [[FBSession alloc] initWithAppID:fbAppID permissions:[NSArray arrayWithObjects:@"publish_stream",@"read_stream",@"public_profile", nil] urlSchemeSuffix:nil tokenCacheStrategy:nil
                   ];
        
        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (cookie in [storage cookies]) {
            
            [storage deleteCookie:cookie];
            
        }
        [[FBSession activeSession]handleDidBecomeActive];
        [[FBSession activeSession] closeAndClearTokenInformation];
        [FBSession setActiveSession:nil];
        [FBSession setActiveSession:session];
        FBSessionLoginBehavior behviour = FBSessionLoginBehaviorForcingWebView;
        [session openWithBehavior:behviour completionHandler:^(FBSession *session1, FBSessionState status, NSError *error) {
            
            if (error) {
                NSLog(@"error %@",error.localizedDescription);
                //[appDelegate stopActivityIndicator];
                
            }
            if (session1.accessTokenData.accessToken) {
                
                [self getUserDetails];
            }
        }];
    }
}
-(void)getUserDetails
{
    //appDelegate.facebookAccessToken=session.accessTokenData.accessToken;
    FBRequestConnection *connection=[[FBRequestConnection alloc]init];
    FBRequest *request=[[FBRequest alloc] initWithSession:FBSession.activeSession graphPath:@"me"];
    
    [connection addRequest:request completionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
        if (!error) {
            fbLoginUserData = [[NSMutableDictionary alloc] initWithDictionary:user];
            NSLog(@"Facebook %@",fbLoginUserData);
            
            //call login service by fblogin
            [self callServiceForSignIn];
        }
        else
        {
        }
    }];
    
    FBRequest *requestforPic=[[FBRequest alloc] initWithSession:FBSession.activeSession graphPath:@"me?fields=picture&width=140&height=140"];
    
    [connection addRequest:requestforPic completionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
        if (!error) {
            NSDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:user];
            NSLog(@"Facebook DPPPP %@",dic);
            
            [fbLoginUserData setValue:[[[dic objectForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"] forKey:@"profilepic"];
            
        }
        else
        {
            NSLog(@"errrr %@",error.localizedDescription);
        }
    }];
    
    
    [connection start];
    
}



@end
