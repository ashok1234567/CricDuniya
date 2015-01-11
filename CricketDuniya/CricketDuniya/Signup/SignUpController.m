//
//  SignUpController.m
//  CricketDuniya
//
//  Created by ashok on 1/7/15.
//  Copyright (c) 2015 apmocon. All rights reserved.
//

#import "SignUpController.h"

@interface SignUpController ()

@end

@implementation SignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnActionMale:(id)sender {
    self.btnMaleOutlet.selected=YES;
        self.btnOutletFemale.selected=NO;

    
    
}
- (IBAction)btnActionFemale:(id)sender {
    self.btnMaleOutlet.selected=NO;
    self.btnOutletFemale.selected=YES;
}
- (IBAction)btnActionSignUp:(id)sender {
    
    if([_txtFirstName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length<=0){
        //ShowAlert(AppName, InvalidFirstname);
        [objSharedData shakeAnimation:_txtFirstName];
        
    }else if([_txtAge.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length<=0){
        
       // ShowAlert(AppName, Invalidage);
        
        [objSharedData shakeAnimation:_txtAge];
    }else if (!self.btnMaleOutlet.selected && !self.btnOutletFemale.selected
              ){
       // ShowAlert(AppName, InvalidGender);
        [objSharedData shakeAnimation:_btnMaleOutlet];
                [objSharedData shakeAnimation:_btnOutletFemale];
    }else{
    
        //Call services for singin
        [self callServiceForSignUp];
    }
    
   // [self performSegueWithIdentifier:@"dashboard" sender:nil];
    
}

-(void)callServiceForSignUp
{
    
    NSString *tempGender=@"Male";
    if(self.btnOutletFemale.selected)
        tempGender=@"Female";
    
    NSDictionary* valueDic=[NSDictionary dictionaryWithObjectsAndKeys:_txtFirstName.text,@"first_last_name",tempGender,@"gender",_txtAge.text,@"age",@"",@"profile_img",SocialType,@"user_from",nil];
    
    NSString *methodName = SignUp_Url;
    
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
    if([[dicResponce valueForKey:@"message"] isEqualToString:@"Update Sucessfully"]){
         objSharedData.logingUserInfo=[dicResponce valueForKey:@"data"];
        [self performSegueWithIdentifier:@"dashboard" sender:nil];
    }else{
        ShowAlert(AppName, @"please try again");
    }
    
}
-(void) webServiceHandler:(WebserviceHandler *)webHandler requestFailedWithError:(NSError *)error
{
    
    NSLog(@"dicResponce:-%@",[error description]);
    [appDelegate stopActivityIndicator];
    //remove it after WS call
}

@end
