//
//  CardIO.m
//  CardIO
//
//  Created by Max Rozdobudko on 5/8/15.
//  Copyright (c) 2015 igamebank. All rights reserved.
//

#import "ANXCardIO.h"

@implementation ANXCardIO

#pragma mark Properties

static FREContext context;

+(FREContext) context
{ @synchronized(self) { return context; } }
+(void) setContext:(FREContext)val
{ @synchronized(self) { context = val; } }

#pragma mark Methods

+(BOOL) isSupported
{
    return YES;
}

+(NSString*) libraryVersion
{
    return [CardIOUtilities libraryVersion];
}

@end
