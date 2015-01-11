//
//  ApplicationAlertMessages.h
//  MedlinxPatient
//
//  Created by Vandana Singh on 08/5/14.
//  Copyright (c) 2013 Vandana Singh. All rights reserved.
//

#pragma mark - All Alerts..

#pragma mark - Custom Alert Methods

#define ShowAlert(title, msg)  [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
#define ShowAlertWithTarAndSel(title, msg, tar, sel) {[appDelegate displayAlertView:title withErrorMsg:msg target:tar selector:sel];}
#define ShowConfirmationAlert(title, msg, tar, btnTitle1, btnTitle2) {[appDelegate displayAlertView:title withErrorMsg:msg target:tar title1:btnTitle1 title2:btnTitle2];}
#define ShowAlertNative(title, msg)  {UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];[alert setTag:105];[alert show];}
#define ShowAlertNativeWithTar(title, msg, tar, tag)  {UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:msg delegate:tar cancelButtonTitle:nil otherButtonTitles:@"OK",nil];[alert setTag:tag];[alert show];}

#define ShowAlertNativewithTag(title, msg,tag)  {UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];[alert setTag:tag];[alert show];}


#pragma mark - Method to check dictionary object or any NULL object
#define ValidString(X) (X==[NSNull null])?@"":X


#pragma mark - Network Activity title
#define Progressing              @"Processing Please Wait.."
#define msgReqFail               @"There is an error in network connection.\n Please try after some time."
#define NetworkReachabilityTitle @"No network connection"
#define NetworkReachabilityAlert @"Sorry, we can't currently refresh the app. Please check your internet connection."
#define ForgetSuccess            @"Please check your email for the procedure to change your password."
#define Fetching                 @"Processing Please Wait.."
#define UploadImage              @"Profile image uploading..."
#define UploadVideo              @"Video uploading..."

#pragma mark - Field validation

#define ValidEntrie         @"Please enter valid Entrie"
#define BlankUsername       @"Please enter Username."
#define InvalidUsername     @"Please enter valid Username."
#define BlankPassword       @"Please enter your Password."
#define LengthPassword      @"Minimum length 5 characters."
//#define LengthFirst         @"Maximum length 30 characters."
//#define LengthLast          @"Maximum length 30 characters."
#define LengthFirst         @"Only 30 characters."
#define LengthLast          @"Only 30 characters."

#define MismatchPassword    @"Confirm Password should be same as Password."
#define InvalidPassword     @"Please enter valid password."
#define ConfirmPassword     @"Password dose not match."
//#define InvalidFirstname    @"Please enter valid firstname."
//#define InvalidLastname     @"Please enter valid lastname."
#define InvalidFirstname    @"Invalid firstname."
#define InvalidLastname     @"Invalid lastname."
#define InvalidEmailOrMobileno @"Please enter your email or mobile no."
#define InvalidEmail        @"Please enter valid Email."
#define InvalidMobile       @"Please enter valid Mobile."
#define InvalidDateOfBirth  @"Please enter valid Date of Birth"
#define InvalidEmailId      @"Please enter valid Email ID."
#define SamePassword        @"New Password should not be same as Temporary Password."
#define SameFirstname       @"Password should not contain Fullname."
#define SameLastname        @"Password should not contain Lastname."
#define InvalidWard         @"Please enter valid ward"
#define Invalidage         @"Please enter your age"
#define InvalidGender         @"Please select gender opation"

#define InvalidDesignation  @"Please enter valid Designation"
#define InvalidPrimaryDx    @"Please enter valid PrimaryDX"
#define InvalidSpeciality   @"Please enter valid Speciality"
#define InvalidSubSpeciality @"Please enter valid SubSpeciality"
#define InvalidBoardCertificate @"Please enter valid Certificte"
#define InvaildAdress       @"Please enter valid Adress"
#define InvalidCountry      @"Please Select Valid Country name"
//#define invalidteam         @"Please Enter Valid Team Name"
#pragma mark - Application color
#define BlueColor       [UIColor colorWithRed:74.0f/255.0f green:105.0f/255.0f blue:170.0f/255.0f alpha:1.0f]
#define BlueSelectColor [UIColor colorWithRed:0.0f/255.0f green:90.0f/255.0f blue:170.0f/255.0f alpha:1.0f]
//#define RedColor        [UIColor colorWithRed:255.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f]
//#define GrayColor       [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f]
#define LightPink       [UIColor colorWithRed:244.0f/255.0f green:231.0f/255.0f blue:214.0f/255.0f alpha:1.0f]

//#define TextColor       [UIColor colorWithRed:33.0f/255.0f green:33.0f/255.0f blue:33.0f/255.0f alpha:1.0f]  
#define TextColor       [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f]

#define ButtonBorderColor       [UIColor colorWithRed:213.0f/255.0f green:213.0f/255.0f blue:213.0f/255.0f alpha:1.0f]
//#define GreenColor      [UIColor colorWithRed:75.0f/255.0f green:154.0f/255.0f blue:21.0f/255.0f alpha:1.0f]
#define BadgeColor      [UIColor colorWithRed:225.0f/255.0f green:213.0f/255.0f blue:197.0f/255.0f alpha:1.0f]
#define BottomBarSelected      [UIColor colorWithRed:226.0f/255.0f green:72.0f/255.0f blue:70.0f/255.0f alpha:1.0f]
#define Greycolor      [UIColor colorWithRed:237.0f/255.0f green:237.0f/255.0f blue:237.0f/255.0f alpha:1.0f]


//PopRx Color
#define OrangeColor     [UIColor colorWithRed:248.0f/255.0f green:79.0f/255.0f blue:77.0f/255.0f alpha:1.0f]
//#define DarkGreycolor      [UIColor colorWithRed:31.0f/255.0f green:31.0f/255.0f blue:31.0f/255.0f alpha:1.0f]
#define Greencolor      [UIColor colorWithRed:13.0f/255.0f green:172.0f/255.0f blue:89.0f/255.0f alpha:1.0f]
//#define LightGraycolor [UIColor colorWithRed:128.0f/255.0f green:135.0f/255.0f blue:140.0f/255.0f alpha:1.0f]
#define HeadertitleColor [UIColor colorWithRed:248.0f/255.0f green:79.0f/255.0f blue:77.0f/255.0f alpha:1.0f]
#define InnerHeaderColor [UIColor colorWithRed:248.0f/255.0f green:57.0f/255.0f blue:43.0f/255.0f alpha:1.0f]
#define RedColor [UIColor colorWithRed:247.0f/255.0f green:74.0f/255.0f blue:70.0f/255.0f alpha:1.0f]
#define ScrollDarkGraycolor     [UIColor colorWithRed:85.0f/255.0f green:91.0f/255.0f blue:95.0f/255.0f alpha:1.0f]


//Andrews Colors
#define DarkGreycolor   [UIColor colorWithRed:39.0f/255.0f green:39.0f/255.0f blue:39.0f/255.0f alpha:1.0f]
#define LightGraycolor  [UIColor colorWithRed:166.0f/255.0f green:162.0f/255.0f blue:159.0f/255.0f alpha:1.0f]
#define ButtonBluecolor [UIColor colorWithRed:46.0f/255.0f green:105.0f/255.0f blue:156.0f/255.0f alpha:1.0f]
#define ButtonBlueHovercolor [UIColor colorWithRed:33.0f/255.0f green:76.0f/255.0f blue:114.0f/255.0f alpha:1.0f]
#define TableViewBackgroundcolor [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]
#define TableCellImagecolor [UIColor colorWithRed:191.0f/255.0f green:175.0f/255.0f blue:214.0f/255.0f alpha:1.0f]
#define NavigationBarcolor [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]
#define Purplecolor [UIColor colorWithRed:191.0f/255.0f green:175.0f/255.0f blue:214.0f/255.0f alpha:1.0f]
#define ViewBackgroundcolor [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]
#define GreyDividerline [UIColor colorWithRed:205.0f/255.0f green:205.0f/255.0f blue:205.0f/255.0f alpha:1.0f]
#define NavigationBarItemcolor [UIColor colorWithRed:115/255.0f green:85.0/255.0f blue:161.0/255.0f alpha:1.0]
#define ButtonWhitecolor [UIColor whiteColor]

#pragma mark - Application Font
#define HeaderFont 24.0f
#define ExtraLargeFont 30.0f
#define LargeFont 20.0f
#define MediumFont 18.0f
#define Medium16Font 16.0f
#define SmallFont  14.0f
#define VarySmallFont  8.0f

#define BtnFont    20.0f
#pragma mark - Appliction Font Type
#define RalewayLight            @"Raleway-Light"
#define RalewayMedium           @"Raleway-Medium"
#define RalewayRegular          @"Raleway-Regular"
#define RalewaySemiBold         @"Raleway-SemiBold"
#define QuickDeathRegular       @"QuickDeath"



#define HelveticaLight      @"HelveticaNeue-Light"
#define Helvetica           @"Helvetica"
#define HelveticaNeueMedium @"HelveticaNeue-Medium"
#define HelveticaNeueRoman  @"HelveticaNeue-Roman"


#define FONT_CHAMPAGNE_LIMOUSINES_BOLD      RalewaySemiBold
#define FONT_CHAMPAGNE_LIMOUSINES           RalewayMedium


#pragma mark - Google Place API
#define DISTANCE 500
#define GOOGLE_KEY @"AIzaSyAxkOLi9kRqCIZ4jVVbz-0QSGI_Q33wsUg"
#define SEARCH_CHAR @"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=(cities)&location=%@,%@&radius=%d&sensor=true&key=%@"
#define SEARCH_CHAR_LOCTION @"https://maps.googleapis.com/maps/api/place/details/json?reference=%@&sensor=true&key=%@"
#define SEARCH_LOCTION_NAME @"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true"
#define NEAR_BY_LIST @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%d&sensor=true&key=%@"
//#define COUNTRY_BY_LIST @"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=false"
#define COUNTRY_BY_LIST @"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=(cities)&key=%@"

#pragma mark - Chat
//#define CHAT_SERVER_DOMAIN @"162.244.228.34"
//#define CHAT_SERVER_URL @"162.244.228.34"
//#define SampleChat_ApplicationConstant_h
//
//#define kXMPPmyJID @"myjabberID"
//#define kXMPPmyJPASSWORD @"myjabberPass"

#define CHAT_SERVER_DOMAIN @"162.244.228.34"
#define CHAT_SERVER_URL @"162.244.228.34"
#define SampleChat_ApplicationConstant_h
#define kXMPPmyJID @"myjabberID"
#define kXMPPmyJPASSWORD @"myjabberPass"

//Import files"

