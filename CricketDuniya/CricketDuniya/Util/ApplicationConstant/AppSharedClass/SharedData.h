//
//  RVSharedData.h
//  Renovate
//
//  Created by Vandana Singh on 9/12/13.
//  Copyright (c) 2013 Vandana Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WebserviceHandler.h"
#import <MapKit/MKPlacemark.h>

@interface SharedData : NSObject<WebServiceHandlerDelegate >
@property (nonatomic,strong)  CLLocation *currentLocation;
@property (nonatomic,strong)  NSString* str_DeviceToken;
@property (nonatomic,strong)  NSMutableDictionary* logingUserInfo;
@property (strong, nonatomic) User *objCurrentUser;
@property (nonatomic,assign)  BOOL isLoggedin;
@property (nonatomic,assign)  BOOL isNoLiveMatch;
@property (nonatomic,assign)  BOOL bool_sliderOpen,isCheckTrue;
@property (nonatomic,strong)  id btn_sender;
@property(nonatomic,retain) MKPlacemark *myPlacemark;
@property(nonatomic,retain) NSString *localCountryCode;
@property(nonatomic,retain) NSString *str_SholdSwipeWork,*str_ShouldShowMoreOption;
@property(nonatomic,retain) NSString *strHospitalID;
@property(nonatomic,retain) NSString *strDoctorStatus,*strDoctorDepartment,*strLastTagName;
@property(nonatomic,assign) BOOL isFirsttimeLanch;
//For chat
@property(nonatomic,retain) NSString *strLoginJid;
@property(nonatomic,retain) NSString *UserTypeId;
@property(nonatomic,retain) NSString *strJidPassword;
@property(nonatomic,retain) NSMutableArray *arr_Doctorlist;
@property(nonatomic,retain) NSMutableArray *arrTeamList;
@property(nonatomic,retain) NSString *strloginuserEmail;
@property(nonatomic,retain) NSString *strLoginUserPassword;
@property(nonatomic,retain) NSMutableDictionary *dictOnlineChatuserDetail;
@property(nonatomic,retain) NSString *strPatientId;
@property(nonatomic,retain) NSMutableDictionary *dictPatientInfo;
@property(nonatomic,assign) BOOL isComeFromPatientDashboard;

@property(nonatomic,retain) NSString *strTokenGuid;
@property(nonatomic,retain) NSString *strEncryptionKey;
@property(nonatomic,retain) NSString *strEncryptionIV;

// Method Decleration
+(SharedData *)instance;

#pragma mark - Save/Restore methods
-(void)storeToUserdefaults;
-(void)restoreFromUserdefaults;
-(void)deleteUserInfo;
- (NSString *)getIPAddress;

#pragma mark - Other Class methods
-(NSString *)sha1EncodedFromString:(NSString *)str;
- (NSString *) md5:(NSString *)str;

#pragma mark - convert base64encoded string
- (NSString*)base64forData:(NSData*)theData;

#pragma mark - Button highlighted method
- (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - GetPhoneCountryCode
-(void)GetPhoneCountryCode;

#pragma mark GetShortStringUsingString
-(NSString*)GetShortNameOfString:(NSString*)strGetString;

#pragma mark ImageFrom UIColor
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark anmate text view
-(void)shakeAnimation:(UIView*) view;

#pragma mark SmallWindow
-(void)ShowWhatNextSmallWindow;
@end
