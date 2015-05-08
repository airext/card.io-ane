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

#pragma mark ContextInitialize/ContextFinalizer

void ANXCardIOContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    *numFunctionsToTest = 2;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    
    func[0].name = (const uint8_t*) "isSupported";
    func[0].functionData = NULL;
    func[0].function = &ANXCardIOIsSupported;
    
    func[1].name = (const uint8_t*) "libraryVersion";
    func[1].functionData = NULL;
    func[1].function = &ANXCardIOLibraryVersion;
    
    *functionsToSet = func;
    
    ANXCardIO.context = ctx;
}

void ANXCardIOContextFinalizer(FREContext ctx)
{
    ANXCardIO.context = nil;
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