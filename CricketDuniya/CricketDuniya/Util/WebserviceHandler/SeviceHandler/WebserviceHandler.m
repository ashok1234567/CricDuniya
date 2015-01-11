//
//  WebserviceHandler.m
//  MedlinxPatient
//
//  Created by Vandana Singh on 08/5/14.
//  Copyright (c) 2013 Vandana Singh. All rights reserved.
//

#import "WebserviceHandler.h"
#import "AFHTTPRequestOperation.h"

//For encryption
#import "NSData+Base64.h"
#import "StringEncryption.h"
#import "Base64.h"
#define gkey			@"0123456789abcdeffedcba9876543210"
#define gIv             @"fedcba9876543210"

@implementation WebserviceHandler

@synthesize request;
@synthesize responseData;
@synthesize delegate,str;//,operation;

-(id)init {
    if ( self = [super init] ) {
    }
    return self;
}
#pragma mark - GetWebservice
-(void)callWebserviceWithRequest:(NSString *)methodName RequestString:(NSDictionary *)parameters RequestType:(NSString*)reqType{
    
    if(appDelegate.networkStatus)
    {
        
    NSMutableString *postString=[[NSMutableString alloc] init];
    for (int i=0; i<[parameters allKeys].count; i++) {
        if ([parameters allKeys].count-1==i) {
            [postString appendString:[NSString stringWithFormat:@"%@=%@",[[parameters allKeys] objectAtIndex:i],[[parameters allValues] objectAtIndex:i]]];
        }else{
            [postString appendString:[NSString stringWithFormat:@"%@=%@&",[[parameters allKeys] objectAtIndex:i],[[parameters allValues] objectAtIndex:i]]];
        }
    }
        
        NSString* encodedUrl = [postString stringByAddingPercentEscapesUsingEncoding:
                                NSUTF8StringEncoding];
        
        NSString *reqString;
        if([methodName isEqualToString:SignIN_Url]|| [methodName isEqualToString:SignUp_Url] )
    reqString=[NSString stringWithFormat:@"%@%@?%@",URL_DOMAIN,methodName,encodedUrl];
        else{
      reqString=[NSString stringWithFormat:@"%@%@?%@",URL_DOMAIN_USER,methodName,postString];
        }
    NSLog(@"dicttttt +++ %@",reqString);

    NSString *msgLength =[NSString stringWithFormat:@"%lu",(unsigned long)[reqString length]];
    request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:reqString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:RequestTimeOutInterval];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: [postString dataUsingEncoding:NSUTF8StringEncoding]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([delegate respondsToSelector:@selector(webServiceHandler:recievedResponse:)])
            [delegate performSelector:@selector(webServiceHandler:recievedResponse:) withObject:self withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
        ShowAlert(AppName, msgReqFail);
        if([delegate respondsToSelector:@selector(webServiceHandler:requestFailedWithError:)])
            [delegate performSelector:@selector(webServiceHandler:requestFailedWithError:) withObject:self withObject:error];
    }];
    
    [operation start];
    }
        else
        {
            [appDelegate stopActivityIndicator];
            ShowAlert (NetworkReachabilityTitle, NetworkReachabilityAlert)
        }
   
    
    
}
#pragma mark - AFNtworking
// Create request ASynchrinously
// You will pass Method name, Method url name, and tag dictionary in below function
-(void) AFNcallThePassedURLASynchronouslyWithRequest:(NSDictionary*)valueDic withMethod:(NSString *)methodName withUrl:(NSString *)urlStr forKey:(NSString *)key
{
    NSMutableString *requestStr;
    NSString *UrlString;
    NSString *strArray = key;
    NSMutableArray *arrayValues = [[NSMutableArray alloc] init];
    if([key length]!=0)
    {
        NSArray *array=[strArray componentsSeparatedByString:@","];
        arrayValues = [[NSMutableArray alloc] initWithArray:array];
    }
    if(appDelegate.networkStatus)
    {
           //Use below code if you want pass argumants like HTTP function
            //for append tag
            requestStr = [[NSMutableString alloc] init];
            [requestStr appendString:@"{"];
            NSArray *keyArr = [valueDic allKeys];
            for (int i=0; i<[keyArr count]; i++) {
                if(i==[keyArr count]-1)
                {
                    if([arrayValues count]!=0)
                    {
                        BOOL isCheck = FALSE;
                        for (int j=0; j<[arrayValues count]; j++) {
                            if([[keyArr objectAtIndex:i] isEqualToString:[arrayValues objectAtIndex:j]])
                            {
                                [requestStr appendString:[NSString stringWithFormat:@"\"%@\":%@",[keyArr objectAtIndex:i],[valueDic objectForKey:[keyArr objectAtIndex:i]]]];
                                [arrayValues removeObjectAtIndex:j];
                                isCheck = TRUE;
                            }
                        }
                        if(!isCheck)
                        {
                            [requestStr appendString:[NSString stringWithFormat:@"\"%@\":\"%@\"",[keyArr objectAtIndex:i],[valueDic objectForKey:[keyArr objectAtIndex:i]]]];
                        }
                        
                    }
                    else
                    {
                        if([methodName length]>1 && [[keyArr objectAtIndex:i] isEqualToString:methodName])
                        {
                            [requestStr appendString:[NSString stringWithFormat:@"\"%@\":%@",[keyArr objectAtIndex:i],[valueDic objectForKey:[keyArr objectAtIndex:i]]]];
                        }else
                        {
                            [requestStr appendString:[NSString stringWithFormat:@"\"%@\":\"%@\"",[keyArr objectAtIndex:i],[valueDic objectForKey:[keyArr objectAtIndex:i]]]];
                        }
                    }
                }else
                {
                    if([arrayValues count]!=0)
                    {
                        BOOL isCheck = FALSE;
                        for (int j=0; j<[arrayValues count]; j++) {
                            
                            if([[keyArr objectAtIndex:i] isEqualToString:[arrayValues objectAtIndex:j]])
                            {
                                [requestStr appendString:[NSString stringWithFormat:@"\"%@\":%@,",[keyArr objectAtIndex:i],[valueDic objectForKey:[keyArr objectAtIndex:i]]]];
                                [arrayValues removeObjectAtIndex:j];
                                isCheck= TRUE;
                            }
                        }
                        if(!isCheck)
                        {
                            [requestStr appendString:[NSString stringWithFormat:@"\"%@\":\"%@\",",[keyArr objectAtIndex:i],[valueDic objectForKey:[keyArr objectAtIndex:i]]]];
                        }
                        
                    }
                    else
                    {
                        if([methodName length]>1 && [[keyArr objectAtIndex:i] isEqualToString:methodName])
                        {
                            [requestStr appendString:[NSString stringWithFormat:@"\"%@\":%@,",[keyArr objectAtIndex:i],[valueDic objectForKey:[keyArr objectAtIndex:i]]]];
                        }else
                            
                        {
                            [requestStr appendString:[NSString stringWithFormat:@"\"%@\":\"%@\",",[keyArr objectAtIndex:i],[valueDic objectForKey:[keyArr objectAtIndex:i]]]];
                        }
                    }
                    
                }
            }
            [requestStr appendString:@"}"];
            //for append tag
            UrlString = [NSString stringWithFormat:@"%@%@",URL_DOMAIN,urlStr];
                NSString *postString = [requestStr mutableCopy];
        URL_Log(UrlString, postString)
        
        str = postString;
        NSString *msgLength =[NSString stringWithFormat:@"%lu",(unsigned long)[postString length]];
        
        request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:UrlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:RequestTimeOutInterval];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
        [request setHTTPMethod:@"POST"];
        //[request setHTTPBody: [postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        //Add header parameter
//        NSString *authStr = [NSString stringWithFormat:@"admin:123456"];
//        NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
//        NSString *authValue = [NSString stringWithFormat:@"Basic %@", [objSharedData base64forData:authData]];
//        [request setValue:authValue forHTTPHeaderField:@"Authorization"];
//        appDelegate.strUrl = urlStr;
//        if(![urlStr isEqualToString:GenerateToken_url])
//        {
//            NSString *tokenStr = [NSString stringWithFormat:@"%@",objSharedData.strTokenGuid];
//            NSString *tokenValue = tokenStr;
//            [request setValue:tokenValue forHTTPHeaderField:@"ApiKey"];
//            
//            //For Encryption/decryption
//            //For no padding, apply function for getting hole text after decryption.
//            //Start
//            NSMutableString * _secret = [[NSMutableString alloc] initWithString:postString];
//            int size = 16;
//            int x = _secret.length % size;
//            char *digest = " ";
//            NSInteger padLength = size - x;
//            for(int i = 0; i < padLength; i++)
//                [_secret appendString:[NSString stringWithFormat:@"%s",digest]];
//            //End
//            
//            // for encryption, you will have to use IV and key.
//            key = objSharedData.strEncryptionKey;
//            NSString * iv = objSharedData.strEncryptionIV;
//            NSData * encryptedData = [[StringEncryption alloc] encrypt:[_secret dataUsingEncoding:NSUTF8StringEncoding] key:key iv:iv];
//            NSString *strBase = [encryptedData base64EncodedStringWithWrapWidth:0];
//            NSLog(@"encrypted data:: %@", strBase);
//            
//            // Decryption
//            // for decryption, you will have to use the same IV and key which was used for encryption.
//            NSData *basedata = [strBase base64DecodedData];
//            NSData *decryptedData = [[StringEncryption alloc] decrypt:basedata  key:key iv:iv];
//            NSString * decryptedText = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
//            NSLog(@"decrypted data:: %@", decryptedText); //print the decrypted text
//            
//            //For Encryption/decryption
//            
//            [request setHTTPBody:[strBase dataUsingEncoding:NSUTF8StringEncoding]];
//            //NSLog(@"data:-%@",[strBase dataUsingEncoding:NSUTF8StringEncoding]);
//        }else
//        {
        
        NSString *tempstr=@"user_name=ashok&user_password=1234&user_from=app&facebook_id=0";
           // [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
         [request setHTTPBody:[tempstr dataUsingEncoding:NSUTF8StringEncoding]];
        //}

        
        
        //used with new AfNetworking framework
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
             //NSLog(@"response %@",responseObject);
            if([delegate respondsToSelector:@selector(webServiceHandler:recievedResponse:)])
                [delegate performSelector:@selector(webServiceHandler:recievedResponse:) withObject:self withObject:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
            ShowAlert(@"Xplorer", msgReqFail)
            if([delegate respondsToSelector:@selector(webServiceHandler:requestFailedWithError:)])
                [delegate performSelector:@selector(webServiceHandler:requestFailedWithError:) withObject:self withObject:error];
        }];
      [operation start];
    }
    else
    {
        [appDelegate stopActivityIndicator];
        ShowAlert (NetworkReachabilityTitle, NetworkReachabilityAlert)
    }
}
@end
