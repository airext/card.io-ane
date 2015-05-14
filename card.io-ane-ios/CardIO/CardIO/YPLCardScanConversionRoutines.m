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

@end
