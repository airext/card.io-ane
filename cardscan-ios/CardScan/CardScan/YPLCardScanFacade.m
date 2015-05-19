//
//  YPLCardScanFacade.m
//  CardIO
//
//  Created by Max Rozdobudko on 5/8/15.
//  Copyright (c) 2015 yeaply.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FlashRuntimeExtensions.h"
#import "YPLCardScan.h"
#import "YPLCardScanConversionRoutines.h"

FREContext context;

#pragma mark Internal methods

void dispatchEvent(NSString* code, NSString* level)
{
    FREDispatchStatusEventAsync(context, (const uint8_t *) [code UTF8String], (const uint8_t *) [level UTF8String]);
}

#pragma mark API

FREObject YPLCardScanIsSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    FRENewObjectFromBool([YPLCardScan isSupported], &result);
    
    return result;
}

FREObject YPLCardScanLibraryVersion(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    return [YPLCardScanConversionRoutines convertNSStringToFREObject:[YPLCardScan libraryVersion]];
}

FREObject YPLCardScanGetLogoForCardType(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    if (argc > 0)
    {
        CardIOCreditCardType cardType = [YPLCardScanConversionRoutines convertFREObjectToCreditCardType:argv[0]];
        
        UIImage* logo = [YPLCardScan getLogoForCardType: cardType];
        
        return [YPLCardScanConversionRoutines convertUIImageToFREObject:logo];
    }
    else
    {
        return NULL;
    }
}

FREObject YPLCardScanGetDisplayNameForCardType(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    if (argc > 1)
    {
        CardIOCreditCardType cardType = [YPLCardScanConversionRoutines convertFREObjectToCreditCardType:argv[0]];
        NSString* languageOrLocale = [YPLCardScanConversionRoutines convertFREObjectToNSString:argv[1]];
        
        NSString* displayName = [YPLCardScan getDisplayNameForCardType:cardType singLanguageOrLocale:languageOrLocale];
        
        return [YPLCardScanConversionRoutines convertNSStringToFREObject:displayName];
    }
    else
    {
        return NULL;
    }
}

FREObject YPLCardScanScanForPayment(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    NSDictionary* options = nil;
    
    if (argc > 0)
    {
        options = [YPLCardScanConversionRoutines convertCardScanOptionsToNSDictionary:argv[0]];
    }
    
    [[YPLCardScan sharedInstance] scanForPayment:options completion:^(CardIOCreditCardInfo *info, NSError *error)
    {
        NSLog(@"YPLCardScanScanForPayment.callback()");
        
        if (info != nil)
        {
            NSError* serializationError = nil;
            
            NSString* json = [YPLCardScanConversionRoutines convertCreditCardInfoToJSON:info error:&serializationError];

            if (serializationError != nil)
            {
                dispatchEvent(@"CardScan.ScanForPayment.Failed", [serializationError localizedDescription]);
            }
            else
            {
                dispatchEvent(@"CardScan.ScanForPayment.Complete", json);
            }
        }
        else if (error != nil)
        {
            dispatchEvent(@"CardScan.ScanForPayment.Failed", [error localizedDescription]);
        }
        else
        {
            dispatchEvent(@"CardScan.ScanForPayment.Canceled", @"status");
        }
    }];
    
    return NULL;
}

#pragma mark ContextInitialize/ContextFinalizer

void YPLCardScanContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    *numFunctionsToTest = 5;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    
    func[0].name = (const uint8_t*) "isSupported";
    func[0].functionData = NULL;
    func[0].function = &YPLCardScanIsSupported;
    
    func[1].name = (const uint8_t*) "libraryVersion";
    func[1].functionData = NULL;
    func[1].function = &YPLCardScanLibraryVersion;

    func[2].name = (const uint8_t*) "scanForPayment";
    func[2].functionData = NULL;
    func[2].function = &YPLCardScanScanForPayment;
    
    func[3].name = (const uint8_t*) "getLogoForCardType";
    func[3].functionData = NULL;
    func[3].function = &YPLCardScanGetLogoForCardType;
    
    func[4].name = (const uint8_t*) "getDisplayNameForCardType";
    func[4].functionData = NULL;
    func[4].function = &YPLCardScanGetDisplayNameForCardType;
    
    *functionsToSet = func;
    
    context = ctx;
}

void YPLCardScanContextFinalizer(FREContext ctx)
{
    context = NULL;
}

#pragma mark Initializer/Finalizer

void YPLCardScanInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    NSLog(@"YPLCardScanInitializer");
    
    *extDataToSet = NULL;
    
    *ctxInitializerToSet = &YPLCardScanContextInitializer;
    *ctxFinalizerToSet = &YPLCardScanContextFinalizer;
}

void YPLCardScanFinalizer(void* extData)
{
    NSLog(@"YPLCardScanFinalizer");
}