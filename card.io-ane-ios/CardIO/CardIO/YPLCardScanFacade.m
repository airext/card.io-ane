//
//  ANXCardIOFacade.m
//  CardIO
//
//  Created by Max Rozdobudko on 5/8/15.
//  Copyright (c) 2015 igamebank. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FlashRuntimeExtensions.h"
#import "ANXCardIO.h"
#import "ANXCardIOConversionRoutines.h"

FREContext context;

#pragma mark Internal methods

void dispatchEvent(NSString* code, NSString* level)
{
    FREDispatchStatusEventAsync(context, (const uint8_t *) [code UTF8String], (const uint8_t *) [level UTF8String]);
}

#pragma mark API

FREObject ANXCardIOIsSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    FREObject result;
    
    FRENewObjectFromBool([ANXCardIO isSupported], &result);
    
    return result;
}

FREObject ANXCardIOLibraryVersion(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    return [ANXCardIOConversionRoutines convertNSStringToFREObject:[ANXCardIO libraryVersion]];
}

FREObject ANXCardIOGetLogoForCardType(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    if (argc > 0)
    {
        CardIOCreditCardType cardType = [ANXCardIOConversionRoutines convertFREObjectToCreditCardType:argv[0]];
        
        UIImage* logo = [ANXCardIO getLogoForCardType: cardType];
        
        return [ANXCardIOConversionRoutines convertUIImageToFREObject:logo];
    }
    else
    {
        return NULL;
    }
}

FREObject ANXCardIOGetDisplayNameForCardType(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    if (argc > 1)
    {
        CardIOCreditCardType cardType = [ANXCardIOConversionRoutines convertFREObjectToCreditCardType:argv[0]];
        NSString* languageOrLocale = [ANXCardIOConversionRoutines convertFREObjectToNSString:argv[1]];
        
        NSString* displayName = [ANXCardIO getDisplayNameForCardType:cardType singLanguageOrLocale:languageOrLocale];
        
        return [ANXCardIOConversionRoutines convertNSStringToFREObject:displayName];
    }
    else
    {
        return NULL;
    }
}

FREObject ANXCardIOScanForPayment(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
{
    [[ANXCardIO sharedInstance] scanForPayment:NULL completion:^(CardIOCreditCardInfo *info, NSError *error)
    {
        if (info != nil)
        {
            NSError* serializationError = nil;
            
            NSString* json = [ANXCardIOConversionRoutines convertCreditCardInfoToJSON:info error:&serializationError];

            if (serializationError != nil)
            {
                dispatchEvent(@"CardIO.ScanForPayment.Failed", [serializationError localizedDescription]);
            }
            else
            {
                dispatchEvent(@"CardIO.ScanForPayment.Complete", json);
            }
        }
        else if (error != nil)
        {
            dispatchEvent(@"CardIO.ScanForPayment.Failed", [error localizedDescription]);
        }
        else
        {
            dispatchEvent(@"CardIO.ScanForPayment.Canceled", @"status");
        }
    }];
    
    return NULL;
}

#pragma mark ContextInitialize/ContextFinalizer

void ANXCardIOContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    *numFunctionsToTest = 5;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    
    func[0].name = (const uint8_t*) "isSupported";
    func[0].functionData = NULL;
    func[0].function = &ANXCardIOIsSupported;
    
    func[1].name = (const uint8_t*) "libraryVersion";
    func[1].functionData = NULL;
    func[1].function = &ANXCardIOLibraryVersion;

    func[2].name = (const uint8_t*) "scanForPayment";
    func[2].functionData = NULL;
    func[2].function = &ANXCardIOScanForPayment;
    
    func[3].name = (const uint8_t*) "getLogoForCardType";
    func[3].functionData = NULL;
    func[3].function = &ANXCardIOGetLogoForCardType;
    
    func[4].name = (const uint8_t*) "getDisplayNameForCardType";
    func[4].functionData = NULL;
    func[4].function = &ANXCardIOScanForPayment;
    
    *functionsToSet = func;
    
    context = ctx;
}

void ANXCardIOContextFinalizer(FREContext ctx)
{
    context = NULL;
}

#pragma mark Initializer/Finalizer

void ANXCardIOInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    NSLog(@"ANXCardIOInitializer");
    
    *extDataToSet = NULL;
    
    *ctxInitializerToSet = &ANXCardIOContextInitializer;
    *ctxFinalizerToSet = &ANXCardIOContextFinalizer;
}

void ANXCardIOFinalizer(void* extData)
{
    NSLog(@"ANXCardIOFinalizer");
}