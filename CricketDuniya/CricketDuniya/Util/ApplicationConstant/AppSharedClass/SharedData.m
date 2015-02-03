//
//  RVSharedData.m
//  Renovate
//
//  Created by Vandana Singh on 9/12/13.
//  Copyright (c) 2013 Vandana Singh. All rights reserved.
//

#import "SharedData.h"
#import "UIImage+scale_resize.h"
#import <CommonCrypto/CommonDigest.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
static SharedData * objAppSharedData;

@implementation SharedData
@synthesize bool_sliderOpen;
@synthesize isLoggedin=_isLoggedin;
@synthesize currentLocation=_currentLocation;
@synthesize str_DeviceToken = _str_DeviceToken;
@synthesize btn_sender = _btn_sender;
@synthesize myPlacemark=_myPlacemark;
@synthesize localCountryCode=_localCountryCode;
@synthesize str_SholdSwipeWork=_str_SholdSwipeWork;
@synthesize str_ShouldShowMoreOption=_str_ShouldShowMoreOption;
@synthesize strHospitalID=_strHospitalID;
@synthesize strDoctorStatus=_strDoctorStatus;
@synthesize strDoctorDepartment=_strDoctorDepartment;
@synthesize isCheckTrue=_isCheckTruet;
@synthesize Pdelegate=_Pdelegate;
//For chat
@synthesize strLoginJid=_strLoginJid;
@synthesize strJidPassword=_strJidPassword;
@synthesize arr_Doctorlist=_arr_Doctorlist;
@synthesize arrMatchList=_arrMatchList;
@synthesize strloginuserEmail=_strloginuserEmail;
@synthesize strLoginUserPassword=_strLoginUserPassword;
@synthesize dictOnlineChatuserDetail =_dictOnlineChatuserDetail;
@synthesize strLiveMatchId=_strLiveMatchId;
@synthesize dictPatientInfo=_dictPatientInfo;
@synthesize isComeFromPopUp=_isComeFromPopUp;
@synthesize strLastTagName=_strLastTagName;
@synthesize logingUserInfo=_logingUserInfo;
@synthesize isNoLiveMatch=_isNoLiveMatch;


-(id)init
{
    if (objAppSharedData) {
        return objAppSharedData;
    }
    else
    {
        self=[super init];
        objAppSharedData=self;
        self.objCurrentUser=[[User alloc]init];
        
        //For chat
        _arrMatchList=[[NSMutableArray alloc] init];
        _arr_Doctorlist=[[NSMutableArray alloc] init];
        _dictOnlineChatuserDetail=[[NSMutableDictionary alloc] init];
        _isComeFromPopUp=NO;
        _isFirsttimeLanch=YES;
        return self;
    }
}
+(SharedData *)instance
{
    if(objAppSharedData)
    {
        return objAppSharedData;
    }else
    {
        objAppSharedData=[[SharedData alloc]init];
        return objAppSharedData;
    }
}
#pragma mark - Save/Restore methods
-(void)storeToUserdefaults
{
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    
    if(self.isLoggedin)
    {
        if(self.objCurrentUser)
        {
            NSDictionary *dic=[self.objCurrentUser performSelector:@selector(proxyForJson)];
            [userdefaults setObject:dic forKey:@"LoggedinUser"];
            [userdefaults setObject:((self.isLoggedin)?@"YES":@"NO") forKey:@"LoginStatus"];
            [userdefaults setObject:@"1" forKey:@"SAVED_STATE"];
         }
        if([userdefaults synchronize])
        {}
        else
        {}
    }
    else
    {
        [userdefaults setObject:@"0" forKey:@"SAVED_STATE"];
        [userdefaults setObject:((self.isLoggedin)?@"YES":@"NO") forKey:@"LoginStatus"];
    }
}
-(void)restoreFromUserdefaults
{
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    
    if([[userdefaults objectForKey:@"SAVED_STATE"] isEqualToString:@"1"])
    {
        NSDictionary *dicUser=[NSDictionary dictionaryWithDictionary:(NSDictionary *)[userdefaults valueForKey:@"LoggedinUser"]];
        [self.objCurrentUser setValuesForKeysWithDictionary:dicUser];
        self.isLoggedin=[(NSString *)[userdefaults objectForKey:@"LoginStatus"] boolValue];
    }
}
-(void)updateUserProfileImage:(NSString *)strUrl
{
    if(strUrl==nil)return;
    
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic=nil;
    id obj=[userdefaults objectForKey:@"USER_DATA"];
    if(obj)
        dic=[NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)[userdefaults objectForKey:@"USER_DATA"]];
    if(dic)
    {
        NSString *profileImage=[dic objectForKey:@"PROFILE_IMAGE"];
        if ([strUrl isEqualToString:profileImage]) {
        }
        else
        {
            //update url and save image into directory.
            [dic setObject:strUrl forKey:@"PROFILE_IMAGE"];
            [self saveFileWithUrl:strUrl];
        }
    }
    else
    {
        dic=[[NSMutableDictionary alloc]init];
        [dic setObject:strUrl forKey:@"PROFILE_IMAGE"];
        [self saveFileWithUrl:strUrl];
        
    }
    [userdefaults setObject:dic forKey:@"USER_DATA"];
    [userdefaults synchronize];
}
-(void)saveFileWithUrl:(NSString *)strUrl
{
    NSArray* path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString* docPath = [path objectAtIndex:0];
    docPath = [docPath stringByAppendingPathComponent:@"ProfileImage.png"];
    UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]]];
    NSData* imgData = UIImagePNGRepresentation(image);
    [imgData writeToFile:docPath atomically:YES];
}
-(void)deleteUserInfo
{
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    [userdefaults setObject:nil forKey:@"USER_DATA"];
    [userdefaults synchronize];
}
#pragma mark - Button highlighted method
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
#pragma mark - Password encoding methods
-(NSString *)sha1EncodedFromString:(NSString *)str
{
    const char *s = [str cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    // This is the destination
    uint8_t digest[CC_SHA1_DIGEST_LENGTH] = {0};
    // This one function does an unkeyed SHA1 hash of your hash data
    CC_SHA1(keyData.bytes, keyData.length, digest);
    
    // Now convert to NSData structure to make it usable again
    NSData *out = [NSData dataWithBytes:digest length:19];
    // description converts to hex but puts <> around it and spaces every 4 bytes
    NSString *hash = [out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}
- (NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
#pragma mark - convert base64encoded string for images
- (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

#pragma mark - IP Address
- (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success; // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    { // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            { // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
	freeifaddrs(interfaces);
    return address;
    
}


-(void)setCountryCode:(NSString*)CountryCode
{

    _localCountryCode =CountryCode;
    
}
// method for set short name
-(NSString*)GetShortNameOfString:(NSString*)strGetString
{
    NSString *strShort;
    NSArray *arr=[strGetString componentsSeparatedByString:@" "];
    
    if([arr count]!=0)
    {
        for (int i=0; i<[arr count]; i++) {
            
            if ([arr count]==1) {
                if ([[arr objectAtIndex:i] length]<3) {
                    strShort= [[arr objectAtIndex:i] uppercaseString];
                }else
                    strShort = [[[arr objectAtIndex:i] substringToIndex:3] uppercaseString];
                
            }else
            {
                if ([strShort length]==0) {
                    strShort=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:i] substringToIndex:1]];
                }else
                    if(i>=3)
                    {
                        strShort=strShort;
                    }else
                        strShort=[[NSString stringWithFormat:@"%@%@",strShort,[[arr objectAtIndex:i] substringToIndex:1]] uppercaseString];
            }
        }}
    return strShort;
    
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
-(void)shakeAnimation:(UIView*) view {
    const int reset = 5;
    const int maxShakes = 6;
    
    //pass these as variables instead of statics or class variables if shaking two controls simultaneously
    static int shakes = 2;
    static int translate = reset;
    
    
    [view.layer setBorderColor:[UIColor redColor].CGColor];
    [view.layer setBorderWidth:1.0f];
    
    [UIView animateWithDuration:0.09-(shakes*.01) // reduce duration every shake from .09 to .04
                          delay:0.01f//edge wait delay
                        options:(enum UIViewAnimationOptions) UIViewAnimationCurveEaseInOut
                     animations:^{view.transform = CGAffineTransformMakeTranslation(translate, 0);}
                     completion:^(BOOL finished){
                         if(shakes < maxShakes){
                             shakes++;
                             
                             //throttle down movement
                             if (translate>0)
                                 translate--;
                             
                             //change direction
                             translate*=-1;
                             [self shakeAnimation:view];
                         } else {
                             view.transform = CGAffineTransformIdentity;
                             shakes = 0;//ready for next time
                             translate = reset;//ready for next time
                             return;
                         }
                     }];
}


-(UIView*)NumberOfMatchButton :(int)buttonCount{
    
    CGRect windowFrame=appDelegate.window.frame;
    float width=roundf(windowFrame.size.width/buttonCount);
    objMatchButtons=[[UIView alloc]initWithFrame:CGRectMake(0, 65, windowFrame.size.width, 30)];
    [objMatchButtons setBackgroundColor:[UIColor clearColor]];
    
    
    for (int i=0; i<buttonCount; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        if(i==0){
            [btn setSelected:YES];
        btn.frame=CGRectMake((width*i)+10,0, width-20, 30);
        }else{
         btn.frame=CGRectMake((width*i),0, width-10, 30);
        }
        [btn setTitle:[NSString stringWithFormat:@"Match %d",i+1] forState:UIControlStateNormal];
        btn.tag=i;
        [btn addTarget:self action:@selector(selectbtn:) forControlEvents:UIControlEventTouchUpInside];
       // [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica Neue Medium" size:10]];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:12];
        
        //state
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithRed:68/255.0 green:117/255.0 blue:129/255.0 alpha:1.0] forState:UIControlStateNormal];
       
        [btn setBackgroundImage:[UIImage imageNamed:@"1_0040_Layer-2"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"1_0040_Layer-21"] forState:UIControlStateNormal];
       
        
        [objMatchButtons addSubview:btn];
    }
    
    return objMatchButtons;
    
    
}
-(void)selectbtn:(id)sender{
    
    UIButton *selectedbtn=(UIButton*)sender;
    for(UIButton *btn in objMatchButtons.subviews){
        
        if(btn.tag==selectedbtn.tag){
             [_Pdelegate selectedMatch:sender];
            [btn setSelected:YES];
        }else{
            [btn setSelected:NO];
        }
    }
    
   
}
@end