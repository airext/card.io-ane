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

+(NSString*) convertCreditCardInfoToJSON: (CardIOCreditCardInfo*) info error: (NSError**) error;

+(NSString*) convertCreditCardTypeToNSString: (CardIOCreditCardType) type;
+(CardIOCreditCardType) convertFREObjectToCreditCardType: (FREObject) object;

+(FREObject) convertUIImageToFREObject: (UIImage*) image;

@end
