//
//  ANXCardIOConversionRoutines.m
//  CardIO
//
//  Created by Max Rozdobudko on 5/8/15.
//  Copyright (c) 2015 igamebank. All rights reserved.
//

#import "ANXCardIOConversionRoutines.h"

@implementation ANXCardIOConversionRoutines

#pragma mark Conversion methods

+(FREObject) convertNSStringToFREObject:(NSString*) string
{
    if (string == nil) return NULL;
    
    const char* utf8String = string.UTF8String;
    
    unsigned long length = strlen( utf8String );
    
    FREObject converted;
    FREResult result = FRENewObjectFromUTF8((uint32_t) length + 1, (const uint8_t*) utf8String, &converted);
    
    if (result != FRE_OK)
        return NULL;
    
    return converted;
}

+(NSString*) convertFREObjectToNSString: (FREObject) string
{
    FREResult result;
    
    uint32_t length = 0;
    const uint8_t* tempValue = NULL;
    
    result = FREGetObjectAsUTF8(string, &length, &tempValue);
    
    if (result != FRE_OK)
        return nil;
    
    return [NSString stringWithUTF8String: (char*) tempValue];
}

+(FREObject) convertNSUIntegerToFREObject:(NSUInteger) integer
{
    FREResult result;
    
    FREObject value;
    
    result = FRENewObjectFromUint32((uint32_t) integer, &value);
    
    if (result != FRE_OK)
        return NULL;
    
    return value;
}

+(NSString*) convertCreditCardInfoToJSON: (CardIOCreditCardInfo*) info error: (NSError**) error
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setValue:info.cardNumber forKey:@"cardNumber"];
    [dictionary setValue:info.cardNumber forKey:@"cardNumber"];
    [dictionary setValue:info.redactedCardNumber forKey:@"redactedCardNumber"];
    [dictionary setValue:[NSNumber numberWithInteger:info.expiryMonth] forKey:@"expiryMonth"];
    [dictionary setValue:[NSNumber numberWithInteger:info.expiryYear] forKey:@"expiryYear"];
    
    NSData* json = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:error];
    
    if (*error != nil)
    {
        return nil;
    }
    
    return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
}

@end
