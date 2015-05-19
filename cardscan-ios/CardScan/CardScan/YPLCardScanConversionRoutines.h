//
//  ANXCardIOConversionRoutines.h
//  CardIO
//
//  Created by Max Rozdobudko on 5/8/15.
//  Copyright (c) 2015 yeaply.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CardIO/CardIO.h>

#import "FlashRuntimeExtensions.h"

@interface YPLCardScanConversionRoutines : NSObject

#pragma mark Conversion methods

+(FREObject) convertNSStringToFREObject:(NSString*) string;
+(NSString*) convertFREObjectToNSString: (FREObject) string;

+(FREObject) convertNSUIntegerToFREObject:(NSUInteger) integer;

+(NSInteger) convertFREObjectToNSInteger:(FREObject) object;

+(BOOL) convertFREObjectToBOOL: (FREObject) object;

#pragma mark Read properties from object

+(NSString*) getStringFrom: (FREObject) object forProperty: (NSString*) property;

+(NSNumber*) getBooleanFrom: (FREObject) object forProperty: (NSString*) property;

+(UIColor*) getColorFrom: (FREObject) object forProperty: (NSString*) property;

+(NSNumber*) getIntegerFrom: (FREObject) object forProperty: (NSString*) property;

#pragma mark Convert types

+(NSString*) convertCreditCardInfoToJSON: (CardIOCreditCardInfo*) info error: (NSError**) error;

+(NSString*) convertCreditCardTypeToNSString: (CardIOCreditCardType) type;
+(CardIOCreditCardType) convertFREObjectToCreditCardType: (FREObject) object;

+(FREObject) convertUIImageToFREObject: (UIImage*) image;

+(NSDictionary*) convertCardScanOptionsToNSDictionary: (FREObject) object;


@end
