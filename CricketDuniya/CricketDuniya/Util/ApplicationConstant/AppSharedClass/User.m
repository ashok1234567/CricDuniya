//
//  User.m
//  Zaptaview
//
//  Created by Shelesh Rawat on 14/02/13.
//  Copyright (c) 2013 Shelesh Rawat. All rights reserved.
//

#import "User.h"

@implementation User
-(id)init
{
    self=[super init];
    if(self)
    {
        self.accessToken=@"";
        self.faceBookUser=@"";
        self.UserId = @"";
        self.userFaceBookID=@"";
        self.gplusUser = @"";
        self.IsPasswordExist =@"";
        self.lastName=@"";
        self.firstName = @"";
        self.userTypId =@"";
        self.MobileNumber = @"";
        self.CountryCode = @"";
        self.StatusId = @"";
        self.MobileNumberStatus = @"";
        self.userPic = @"";
        self.userLat = @"";
        self.userLog = @"";
        self.userDepartment = @"";
        self.userStatus = @"";
        self.userDesignation = @"";
        //For chat
        self.strpasswordfield=@"";
        self.arrTotalUserList=[[NSMutableArray alloc] init];
        self.arrTotalTeams=[[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.accessToken forKey:UserAccessTokenKey];
    [encoder encodeObject:self.faceBookUser forKey:UserFBKey];
    [encoder encodeObject:self.userId forKey:UserIdKey];
    [encoder encodeObject:self.userFaceBookID forKey:UserFaceBookIDKey];
    [encoder encodeObject:self.gplusUser forKey:UserGPlusKey];
    [encoder encodeObject:self.IsPasswordExist forKey:UserIsPasswordExistKey];
    [encoder encodeObject:self.firstName forKey:UserFirstNameKey];
    [encoder encodeObject:self.lastName forKey:UserLastNameKey];
    [encoder encodeObject:self.emailId forKey:UserEmailIDKey];
    [encoder encodeObject:self.userTypId forKey:UserUserTypIdKey];
    [encoder encodeObject:self.MobileNumber forKey:UserMobileNumberKey];
    [encoder encodeObject:self.CountryCode forKey:UserCountryCodeKey];
    [encoder encodeObject:self.StatusId forKey:UserStatusIDKey];
    [encoder encodeObject:self.MobileNumberStatus forKey:UserMobileNumberStatusKey];
    [encoder encodeObject:self.userPic forKey:UserPicKey];
    [encoder encodeObject:self.userLat forKey:UserLatKey];
    [encoder encodeObject:self.userLog forKey:UserLogKey];
    [encoder encodeObject:self.userDepartment forKey:userDepartmentKey];
    [encoder encodeObject:self.userStatus forKey:userStatusKey];
    [encoder encodeObject:self.userDesignation forKey:userDesignationKey];
    //For chat
    [encoder encodeObject:self.strpasswordfield forKey:UserpasswordKey];
    [encoder encodeObject:self.arrTotalUserList forKey:UserarrTotalUserList];
    [encoder encodeObject:self.arrTotalTeams forKey:UserarrTotalTeams];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        
        self.accessToken=[decoder decodeObjectForKey:UserAccessTokenKey];
        self.faceBookUser=[decoder decodeObjectForKey:UserFBKey];
        self.userId=[decoder decodeObjectForKey:UserIdKey];
        self.userFaceBookID=[decoder decodeObjectForKey:UserFaceBookIDKey];
        self.gplusUser=[decoder decodeObjectForKey:UserGPlusKey];
        self.IsPasswordExist=[decoder decodeObjectForKey:UserIsPasswordExistKey];
        self.emailId=[decoder decodeObjectForKey:UserEmailIDKey];
        self.firstName=[decoder decodeObjectForKey:UserFaceBookIDKey];
        self.lastName=[decoder decodeObjectForKey:UserGPlusKey];
        self.userTypId=[decoder decodeObjectForKey:UserIsPasswordExistKey];
        self.MobileNumber=[decoder decodeObjectForKey:UserMobileNumberKey];
        self.CountryCode=[decoder decodeObjectForKey:UserCountryCodeKey];
        self.StatusId=[decoder decodeObjectForKey:UserStatusIDKey];
        self.MobileNumberStatus=[decoder decodeObjectForKey:UserMobileNumberStatusKey];
        self.userPic=[decoder decodeObjectForKey:UserPicKey];
        self.userLat=[decoder decodeObjectForKey:UserLatKey];
        self.userLog=[decoder decodeObjectForKey:UserLogKey];
        self.userDepartment=[decoder decodeObjectForKey:userDepartmentKey];
        self.userStatus=[decoder decodeObjectForKey:userStatusKey];
         self.userDesignation=[decoder decodeObjectForKey:userDesignationKey];
        //For chat
        self.strpasswordfield=[decoder decodeObjectForKey:UserpasswordKey];
        self.arrTotalUserList=[decoder decodeObjectForKey:UserarrTotalUserList];
        self.arrTotalTeams=[decoder decodeObjectForKey:UserarrTotalTeams];
    }
    return self;
}
-(void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues
{
    self.accessToken=[keyedValues valueForKey:UserAccessTokenKey];
    self.faceBookUser=[keyedValues valueForKey:UserFBKey];
    self.userId=[keyedValues valueForKey:UserIdKey];
    self.userFaceBookID=[keyedValues valueForKey:UserFaceBookIDKey];
    self.gplusUser=[keyedValues valueForKey:UserGPlusKey];
    self.IsPasswordExist=[keyedValues valueForKey:UserIsPasswordExistKey];
    self.emailId=[keyedValues valueForKey:UserEmailIDKey];
    self.firstName=[keyedValues valueForKey:UserFirstNameKey];
    self.lastName=[keyedValues valueForKey:UserLastNameKey];
    self.userTypId=[keyedValues valueForKey:UserLastNameKey];
    self.MobileNumber=[keyedValues valueForKey:UserMobileNumberKey];
    self.CountryCode=[keyedValues valueForKey:UserCountryCodeKey];
    self.StatusId=[keyedValues valueForKey:UserStatusIDKey];
    self.MobileNumberStatus=[keyedValues valueForKey:UserMobileNumberStatusKey];
    self.userPic=[keyedValues valueForKey:UserPicKey];
    self.userLat=[keyedValues valueForKey:UserLatKey];
    self.userLog=[keyedValues valueForKey:UserLogKey];
    self.userDepartment=[keyedValues valueForKey:userDepartmentKey];
    self.userStatus=[keyedValues valueForKey:userStatusKey];
    self.userDesignation=[keyedValues valueForKey:userDesignationKey];
    //For chat
    self.strpasswordfield=[keyedValues valueForKey:UserpasswordKey];
    self.arrTotalUserList=[keyedValues valueForKey:UserarrTotalUserList];
    self.arrTotalTeams=[keyedValues valueForKey:UserarrTotalTeams];
}
#pragma mark - For SBJSON
-(id)proxyForJson
{
    NSDictionary *d=nil;
    d=[NSDictionary dictionaryWithObjectsAndKeys:
       ((self.arrTotalUserList)?self.arrTotalUserList:nil),UserarrTotalUserList,
       ((self.arrTotalTeams)?self.arrTotalTeams:nil),UserarrTotalTeams,
       ((self.accessToken)?self.accessToken:@""),UserAccessTokenKey,
       ((self.faceBookUser)?self.faceBookUser:@""),UserFBKey,
       ((self.userId)?self.userId:@""),UserIdKey,
       ((self.userFaceBookID)?self.userFaceBookID:@""),UserFaceBookIDKey,
       ((self.gplusUser)?self.gplusUser:@""),UserGPlusKey,
       ((self.IsPasswordExist)?self.gplusUser:@""),UserIsPasswordExistKey,
       ((self.emailId)?self.emailId:@""),UserEmailIDKey,
       ((self.firstName)?self.firstName:@""),UserFirstNameKey,
       ((self.lastName)?self.lastName:@""),UserLastNameKey,
       ((self.userTypId)?self.userTypId:@""),UserUserTypIdKey,
       ((self.MobileNumber)?self.MobileNumber:@""),UserMobileNumberKey,
       ((self.CountryCode)?self.CountryCode:@""),UserCountryCodeKey,
       ((self.StatusId)?self.StatusId:@""),UserMobileNumberKey,
       ((self.MobileNumberStatus)?self.MobileNumberStatus:@""),UserMobileNumberStatusKey,
       ((self.userPic)?self.userPic:@""),UserPicKey,
       ((self.userLat)?self.userLat:@""),UserLatKey,
       ((self.userLog)?self.userLog:@""),UserLogKey,
       ((self.userDepartment)?self.userDepartment:@""),userDepartmentKey,
       ((self.userStatus)?self.userStatus:@""),userStatusKey,
       ((self.userDesignation)?self.userDesignation:@""),userDesignationKey,
       ((self.strpasswordfield)?self.strpasswordfield:@""),UserpasswordKey,
       nil];

    return d;
}
@end
