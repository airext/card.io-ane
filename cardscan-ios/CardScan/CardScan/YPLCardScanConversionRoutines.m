//
//  ANXCardIOConversionRoutines.m
//  CardIO
//
//  Created by Max Rozdobudko on 5/8/15.
//  Copyright (c) 2015 yeaply.com. All rights reserved.
//

#import "YPLCardScanConversionRoutines.h"

@implementation YPLCardScanConversionRoutines

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

+(NSInteger) convertFREObjectToNSInteger:(FREObject) object
{
    int32_t value;
    FREResult result = FREGetObjectAsInt32(object, &value);
    
    if (result != FRE_OK)
        return 0;
    
    return value;
}

+(BOOL) convertFREObjectToBOOL: (FREObject) object
{
    uint32_t value;
    
    FREResult result = FREGetObjectAsBool(object, &value);
    
    NSLog(@"-> %u", result);
    
    if (result != FRE_OK)
        return NO;
    
    return value;
}

+(FREObject) convertBOOLToFREObject: (BOOL) boolean
{
    FREObject value;
    
    FREResult result = FRENewObjectFromBool((uint32_t) boolean, &value);
    
    if (result != FRE_OK)
        return NULL;
    
    return value;
}

#pragma mark Read properties from object

+(NSString*) getStringFrom: (FREObject) object forProperty: (NSString*) property
{
    FREObject propertyValue;
    FREResult result = FREGetObjectProperty(object, (const uint8_t*) [property UTF8String], &propertyValue, NULL);
    
    if (result != FRE_OK)
        return nil;
    
    FREObjectType propertyType;
    result = FREGetObjectType(propertyValue, &propertyType);
    
    if (result != FRE_OK || propertyType == FRE_TYPE_NULL)
        return nil;
    
    return [self convertFREObjectToNSString:propertyValue];
}

+(NSNumber*) getBooleanFrom: (FREObject) object forProperty: (NSString*) property
{
    FREObject propertyValue;
    FREResult result = FREGetObjectProperty(object, (const uint8_t*) [property UTF8String], &propertyValue, NULL);
    
    if (result != FRE_OK)
        return nil;
    
    FREObjectType propertyType;
    result = FREGetObjectType(propertyValue, &propertyType);
    
    if (result != FRE_OK || propertyType == FRE_TYPE_NULL)
        return nil;
    
    return [NSNumber numberWithBool:[self convertFREObjectToBOOL:propertyValue]];
}

+(UIColor*) getColorFrom: (FREObject) object forProperty: (NSString*) property
{
    FREObject propertyValue;
    FREResult result = FREGetObjectProperty(object, (const uint8_t*) [property UTF8String], &propertyValue, NULL);
    
    if (result != FRE_OK)
        return nil;
    
    FREObjectType propertyType;
    result = FREGetObjectType(propertyValue, &propertyType);
    
    if (result != FRE_OK || propertyType == FRE_TYPE_NULL)
        return nil;
    
    uint32_t rgb;
    result  = FREGetObjectAsUint32(propertyValue, &rgb);
    
    if (result != FRE_OK)
        return nil;
    
    CGFloat r = ((rgb & 0xFF0000) >> 16) / 255.0;
    CGFloat g = ((rgb & 0xFF00) >> 8) / 255.0;
    CGFloat b = (rgb & 0xFF) / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

+(NSNumber*) getIntegerFrom: (FREObject) object forProperty: (NSString*) property
{
    FREObject propertyValue;
    FREResult result = FREGetObjectProperty(object, (const uint8_t*) [property UTF8String], &propertyValue, NULL);
    
    if (result != FRE_OK)
        return nil;
    
    FREObjectType propertyType;
    result = FREGetObjectType(propertyValue, &propertyType);
    
    if (result != FRE_OK || propertyType == FRE_TYPE_NULL)
        return nil;
    
    return [NSNumber numberWithInteger:[self convertFREObjectToNSInteger:propertyValue]];
}

#pragma mark Convert types


+(NSString*) convertCreditCardInfoToJSON: (CardIOCreditCardInfo*) info error: (NSError**) error
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setValue:info.cardNumber forKey:@"cardNumber"];
    [dictionary setValue:info.redactedCardNumber forKey:@"redactedCardNumber"];
    [dictionary setValue:info.cvv forKey:@"cvv"];
    [dictionary setValue:info.postalCode forKey:@"postalCode"];
    [dictionary setValue:[NSNumber numberWithBool:info.scanned] forKey:@"scanned"];
    [dictionary setValue:[self convertCreditCardTypeToNSString:info.cardType] forKey:@"cardType"];
    [dictionary setValue:[NSNumber numberWithInteger:info.expiryMonth] forKey:@"expiryMonth"];
    [dictionary setValue:[NSNumber numberWithInteger:info.expiryYear] forKey:@"expiryYear"];
    
    NSData* json = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:error];
    
    if (*error != nil)
    {
        return nil;
    }
    
    return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
}

+(NSString*) convertCreditCardTypeToNSString: (CardIOCreditCardType) type
{
    switch (type)
    {
        case CardIOCreditCardTypeAmex :
            return @"AmEx";
            break;
            
        case CardIOCreditCardTypeDiscover :
            return @"Discover";
            break;
            
        case CardIOCreditCardTypeJCB :
            return @"JCB";
            break;
            
        case CardIOCreditCardTypeMastercard :
            return @"MasterCard";
            break;
            
        case CardIOCreditCardTypeVisa :
            return @"Visa";
            break;
            
        case CardIOCreditCardTypeAmbiguous :
            return @"Ambiguous";
            break;
            
        case CardIOCreditCardTypeUnrecognized :            
        default :
            return @"Unknown";
            break;
    }
}

+(CardIOCreditCardType) convertFREObjectToCreditCardType: (FREObject) object
{
    NSString* name = [self convertFREObjectToNSString:object];
    
    if ([name isEqualToString:@"AmEx"])
    {
        return CardIOCreditCardTypeAmex;
    }
    else if ([name isEqualToString:@"Discover"])
    {
        return CardIOCreditCardTypeDiscover;
    }
    else if ([name isEqualToString:@"JCB"])
    {
        return CardIOCreditCardTypeJCB;
    }
    else if ([name isEqualToString:@"MasterCard"])
    {
        return CardIOCreditCardTypeMastercard;
    }
    else if ([name isEqualToString:@"Visa"])
    {
        return CardIOCreditCardTypeVisa;
    }
    else if ([name isEqualToString:@"Ambiguous"])
    {
        return CardIOCreditCardTypeAmbiguous;
    }
    else
    {
        return CardIOCreditCardTypeUnrecognized;
    }
}

+(FREObject) convertUIImageToFREObject: (UIImage*) image
{
    // drawing UIImage to BitmapData http://tyleregeto.com/article/drawing-ios-uiviews-to-as3-bitmapdata-via-air
    
    // Now we'll pull the raw pixels values out of the image data
    
    CGImageRef imageRef = [image CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Pixel color values will be written here
    
    unsigned char *rawData = malloc(height * width * 4);
    
    NSUInteger bytesPerPixel = 4;
    
    NSUInteger bytesPerRow = bytesPerPixel * width;
    
    NSUInteger bitsPerComponent = 8;
    
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    CGContextRelease(context);
    
    // Pixels are now in rawData in the format RGBA8888
    // We'll now loop over each pixel write them into the AS3 bitmapData memory
    
    FREObject bmdWidth;
    FRENewObjectFromUint32((uint32_t) width, &bmdWidth);
    
    FREObject bmdHeight;
    FRENewObjectFromUint32((uint32_t) height, &bmdHeight);
    
    FREObject arguments[] = {bmdWidth, bmdHeight};
    
    FREObject bitmapDataInstance;
    FRENewObject((const uint8_t*) "flash.display.BitmapData", 2, arguments, &bitmapDataInstance, NULL);
    
    FREBitmapData bmd;
    FREAcquireBitmapData(bitmapDataInstance, &bmd);
    
    int x, y;
    
    // There may be extra pixels in each row due to the value of
    // bmd.lineStride32, we'll skip over those as needed
    
    int offset = bmd.lineStride32 - bmd.width;
    
    unsigned long offset2 = bytesPerRow - bmd.width*4;
    
    int byteIndex = 0;
    
    uint32_t *bmdPixels = bmd.bits32;
    
    for(y=0; y<bmd.height; y++)
    {
        for(x=0; x<bmd.width; x++, bmdPixels ++, byteIndex += 4)
        {
            // Values are currently in RGBA8888, so each colour
            
            // value is currently a separate number
            
            int red   = (rawData[byteIndex]);
            int green = (rawData[byteIndex + 1]);
            int blue  = (rawData[byteIndex + 2]);
            int alpha = (rawData[byteIndex + 3]);
            
            // Combine values into ARGB32
            
            * bmdPixels = (alpha << 24) | (red << 16) | (green << 8) | blue;
        }
        
        bmdPixels += offset;
        byteIndex += offset2;
    }
    
    free(rawData);
    
    FREInvalidateBitmapDataRect(bitmapDataInstance, 0, 0, bmd.width, bmd.height);
    
    FREReleaseBitmapData(bitmapDataInstance);
    
    // free the the memory we allocated
    
    return bitmapDataInstance;
}

+(NSDictionary*) convertCardScanOptionsToNSDictionary: (FREObject) object
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    if (object)
    {
        // guideColor
        
        UIColor *guideColor = [self getColorFrom:object forProperty:@"guideColor"];
        
        if (guideColor)
        {
            [dictionary setValue:guideColor forKey:@"guideColor"];
        }
        
        // languageOrLocale
        
        NSString* languageOrLocale = [self getStringFrom:object forProperty:@"languageOrLocale"];
        
        if (languageOrLocale)
        {
            [dictionary setValue:languageOrLocale forKey:@"languageOrLocale"];
        }
        
        // suppressScanConfirmation
        
        NSNumber *suppressScanConfirmation = [self getBooleanFrom:object forProperty:@"suppressScanConfirmation"];
        
        if (suppressScanConfirmation)
        {
            [dictionary setValue:suppressScanConfirmation forKey:@"suppressScanConfirmation"];
        }
        
        // scanInstructions
        
        NSString *scanInstructions = [self getStringFrom:object forProperty:@"scanInstructions"];
        
        if (scanInstructions)
        {
            [dictionary setValue:scanInstructions forKey:@"scanInstructions"];
        }
        
        // hideLogo
        
        NSNumber* hideLogo = [self getBooleanFrom:object forProperty:@"hideLogo"];
        
        if (hideLogo)
        {
            [dictionary setValue:hideLogo forKey:@"hideLogo"];
        }
        
        // requireExpiry
        
        NSNumber *requireExpiry = [self getBooleanFrom:object forProperty:@"requireExpiry"];
        
        if (requireExpiry)
        {
            [dictionary setValue:requireExpiry forKey:@"requireExpiry"];
        }
        
        // requireCVV
        
        NSNumber *requireCVV = [self getBooleanFrom:object forProperty:@"requireCVV"];
        
        if (requireCVV)
        {
            [dictionary setValue:requireCVV forKey:@"requireCVV"];
        }
        
        // requirePostalCode
        
        NSNumber* requirePostalCode = [self getBooleanFrom:object forProperty:@"requirePostalCode"];
        
        if (requirePostalCode)
        {
            [dictionary setValue:requirePostalCode forKey:@"requirePostalCode"];
        }
        
        // scanExpiry
        
        NSNumber *scanExpiry = [self getBooleanFrom:object forProperty:@"scanExpiry"];
        
        if (scanExpiry)
        {
            [dictionary setValue:scanExpiry forKey:@"scanExpiry"];
        }
        
        // useCardIOLogo
        
        NSNumber *useCardIOLogo = [self getBooleanFrom:object forProperty:@"useCardIOLogo"];
        
        if (useCardIOLogo)
        {
            [dictionary setValue:useCardIOLogo forKey:@"useCardIOLogo"];
        }
        
        // suppressManualEntry
        
        NSNumber *suppressManualEntry = [self getBooleanFrom:object forProperty:@"suppressManualEntry"];
        
        if (suppressManualEntry)
        {
            [dictionary setValue:suppressManualEntry forKey:@"suppressManualEntry"];
        }
        
        // detectionMode
        
        NSNumber *detectionMode = [self getIntegerFrom:object forProperty:@"detectionMode"];
        
        if (detectionMode)
        {
            [dictionary setValue:detectionMode forKey:@"detectionMode"];
        }
        
        // extra
        
        // keepStatusBarStyle
        
        NSNumber *keepStatusBarStyle = [self getIntegerFrom:object forProperty:@"keepStatusBarStyle"];
        
        if (keepStatusBarStyle)
        {
            [dictionary setValue:keepStatusBarStyle forKey:@"keepStatusBarStyle"];
        }
        
        // navigationBarTintColor
        
        UIColor *navigationBarTintColor = [self getColorFrom:object forProperty:@"navigationBarTintColor"];
        
        if (navigationBarTintColor)
        {
            [dictionary setValue:navigationBarTintColor forKey:@"navigationBarTintColor"];
        }
        
        // disableBlurWhenBackgrounding
        
        NSNumber *disableBlurWhenBackgrounding = [self getBooleanFrom:object forProperty:@"disableBlurWhenBackgrounding"];
        
        if (disableBlurWhenBackgrounding)
        {
            [dictionary setValue:disableBlurWhenBackgrounding forKey:@"disableBlurWhenBackgrounding"];
        }
        
        // suppressScannedCardImage
        
        NSNumber *suppressScannedCardImage = [self getBooleanFrom:object forProperty:@"suppressScannedCardImage"];
        
        if (suppressScannedCardImage)
        {
            [dictionary setValue:suppressScannedCardImage forKey:@"suppressScannedCardImage"];
        }
        
        // maskManualEntryDigits
        
        NSNumber *maskManualEntryDigits = [self getBooleanFrom:object forProperty:@"maskManualEntryDigits"];
        
        if (maskManualEntryDigits)
        {
            [dictionary setValue:maskManualEntryDigits forKey:@"maskManualEntryDigits"];
        }
        
        // allowFreelyRotatingCardGuide
        
        NSNumber *allowFreelyRotatingCardGuide = [self getBooleanFrom:object forProperty:@"allowFreelyRotatingCardGuide"];
        
        NSLog(@"allowFreelyRotatingCardGuide: %@", allowFreelyRotatingCardGuide);
        
        if (allowFreelyRotatingCardGuide)
        {
            [dictionary setValue:allowFreelyRotatingCardGuide forKey:@"allowFreelyRotatingCardGuide"];
        }
    }
    
    return dictionary;
}

@end
