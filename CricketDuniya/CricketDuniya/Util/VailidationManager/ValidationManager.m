

#import "ValidationManager.h"
#include <regex.h>
#import "RegexKitLite.h"

@implementation ValidationManager

// Validate email id URL's
+(BOOL) validateEmailID:(NSString *)emailId
{
    
    return [emailId isMatchedByRegex:@"^\\w+([-+.']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"];
//	return [emailId isMatchedByRegex:@"^([a-zA-Z0-9_\\-\\.+-]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4})(\\]?)$"];
}

// Validate Name Strings
+(BOOL) validateNameStrings:(NSString *)nameString {
	return [nameString isMatchedByRegex:@"^([A-Za-z](\\.)?+(\\s)?[A-Za-z|\\'|\\.]*){1,7}$"];
}

// Validate Phone Number Strings
+(BOOL) validatePhoneNumber:(NSString *)phoneNumber {
	return [phoneNumber isMatchedByRegex:@"^(1\\s*[-\\/\\.]?)?(\\((\\d{3})\\)|(\\d{3}))\\s*[-\\/\\.]?\\s*(\\d{3})\\s*[-\\/\\.]?\\s*(\\d{4})\\s*(([xX]|[eE][xX][tT])\\.?\\s*(\\d+))*$"];
}

// Validate Note Strings
+(BOOL) validateNoteStrings:(NSString *)noteString {
	return [noteString isMatchedByRegex:@"^[A-Za-z0-9|\\'|\\.|\\,]*"];
}

// Validate ZIP Strings
+(BOOL) validateZipCode:(NSString *)zipCode {
	//return [zipCode isMatchedByRegex:@"(^\\d{4}-\\d{4}|\\d{4}|[A-Z]\\d[A-Z] \\d[A-Z]|\\D{1}\\d{1}\\D{1}\\-?\\d{1}\\D{1}\\d$)"];
   // NSLog(@"^(\\d|[a-zA-Z])*\\s?(\\d|[a-zA-Z])*$");
    return [zipCode isMatchedByRegex:@"^(\\d|[a-zA-Z])*\\s?(\\d|[a-zA-Z])*$"];
}

// Validate Number Strings
+(BOOL) validateNumber:(NSString *)numString {
	//return [numString isMatchedByRegex:@"^([1-9]|[0-9][0-9])$"];
	return [numString isMatchedByRegex:@"^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"];
}
 

// Validate password Strings
+(BOOL) validatePassword:(NSString *)password {
	return [password isMatchedByRegex:@"^([a-zA-Z0-9@*#+;.?&%!~_]{4,15})$"];
    // required more:-!@#$%^*&;?.+_
    
}

// Validate username Strings
+(BOOL) validateUsername:(NSString *)username {
	return [username isMatchedByRegex:@"^([a-zA-Z0-9@*#+;:<>_-]{1,15})$"];
}

// Validate US SSN Number Strings
+ (BOOL) validateSSNNumber:(NSString *)ssnNumberString {
	return [ssnNumberString isMatchedByRegex:@"^\\d{3}-\\d{2}-\\d{4}$"];
}

// Validate Web URL text
+ (BOOL) validateWebURL:(NSString *)webURL{
	return [webURL isMatchedByRegex:@"^(https?://)(([0-9]{1,3}\\.){3}[0-9]{1,3}|([0-9A-Za-z_!~*'()-]+\\.)*([0-9A-Za-z][0-9A-Za-z-]{0,61})?[0-9A-Za-z]\\.[A-Za-z]{2,6})((/?)|(/[0-9A-Za-z_!~*'().;?:@&=+$,%#-]+)+/?)$"];
}

+(BOOL)validateDateOfBirth:(NSString*)StrDate
{

    return [StrDate isMatchedByRegex:@"^(?:(?:31(\\/|-|.)(?:0?[13578]|1[02]))\\1|(?:(?:29|30)(\\/|-|\\\\.)(?:0?[1,3-9]|1[0-2])\\2))(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$|^(?:29(\\/|-|\\.)0?2\\3(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\\d|2[0-8])(\\/|-|\\.)(?:(?:0?[1-9])|(?:1[0-2]))\\4(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$"];
}

// Validate Credit card numbers
+ (BOOL) validateCreditCardNumberString:(NSString *)creditCardNumber{
	return [creditCardNumber isMatchedByRegex:@"^((4\\d{3})|(5[1-5]\\d{2}))[ -]?(\\d{4}[ -]?){3}$|^(3[4,7]\\d{2})[ -]?\\d{6}[ -]?\\d{5}$"];
}
// Validate for country code
+(BOOL)validateCountryCode:(NSString*)Code
{
    return [Code isMatchedByRegex:@"^[+-]?(\\d+\\.?\\d*|\\.\\d+)"];
    
}
@end
