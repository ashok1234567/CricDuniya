//
//  User.h
//  Zaptaview
//
//  Created by Shelesh Rawat on 14/02/13.
//  Copyright (c) 2013 Shelesh Rawat. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserAccessTokenKey @"UserAccessTokenKey"
#define UserEmailIDKey @"UserEmailIDKey"
#define UserFBKey @"UserFaceBook"
#define UserGPlusKey @"Usergplus"
#define UserIdKey @"UserId"
#define UserFaceBookIDKey @"UserFaceBookID"
#define UserPasswordKey @"UserPassword"  //Only contains 'True/False' value. It belongs to property named isPassword.
#define UserIsPasswordExistKey @"IsPasswordExist"
#define UserIdKey @"UserId"
#define UserFirstNameKey @"UserFirstName"
#define UserLastNameKey @"UserLastName"
#define UserUserTypIdKey @"UserUsertypId"
#define UserMobileNumberKey @"MobileNumber"
#define UserCountryCodeKey @"CountryCode"
#define UserStatusIDKey @"StatusID"
#define UserMobileNumberStatusKey @"MobileNumberStatus"
#define UserPicKey @"userPic"
#define UserLatKey @"userLat"
#define UserLogKey @"userLog"
#define userDepartmentKey @"userDepartment"
#define userStatusKey @"userStatus"
#define userDesignationKey @"userDesignation"
//For chat
#define UserpasswordKey @"strpasswordfield"
#define UserarrTotalUserList  @"arrTotalUserListData"
#define UserarrTotalTeams @"arrTotalTeamsData"


@interface User : NSObject<NSCoding>

@property (nonatomic,strong) NSString * accessToken;
@property (nonatomic,strong) NSString * faceBookUser;
@property (nonatomic,strong) NSString * gplusUser;
@property (nonatomic,strong) NSString * userId;
@property (nonatomic,strong) NSString * userFaceBookID;
@property (nonatomic,strong) NSString * IsPasswordExist;
@property (nonatomic,strong) NSString * emailId;
@property (nonatomic,strong) NSString * firstName;
@property (nonatomic,strong) NSString * lastName;
@property (nonatomic,strong) NSString * userTypId;
@property (nonatomic,strong) NSString * MobileNumber;
@property(nonatomic,strong)  NSString  *CountryCode;
@property(nonatomic,strong)  NSString  *StatusId;
@property(nonatomic,strong)  NSString  *MobileNumberStatus;
@property(nonatomic,strong)  NSString  *userPic;
@property(nonatomic,strong)  NSString  *userLat;
@property(nonatomic,strong)  NSString  *userLog;
@property(nonatomic,strong)  NSString  *userDepartment;
@property(nonatomic,strong)  NSString  *userStatus;
@property(nonatomic,strong)  NSString  *userDesignation;
//For chat
@property(nonatomic,strong) NSString *strpasswordfield;
@property(nonatomic,strong) NSMutableArray *arrTotalUserList;
@property(nonatomic,strong) NSMutableArray *arrTotalTeams;
@end
