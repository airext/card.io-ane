//
//  ANXCardIOConversionRoutines.h
//  CardIO
//
//  Created by Max Rozdobudko on 5/8/15.
//  Copyright (c) 2015 igamebank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CardIO/CardIO.h>

#import "FlashRuntimeExtensions.h"

@interface ANXCardIOConversionRoutines : NSObject

#pragma mark Conversion methods

+(FREObject) convertNSStringToFREObject:(NSString*) string;
+(NSString*) convertFREObjectToNSString: (FREObject) string;

+(FREObject) convertNSUIntegerToFREObject:(NSUInteger) integer;

+(NSString*) convertCreditCardInfoToJSON: (CardIOCreditCardInfo*) info error: (NSError**) error;

@end