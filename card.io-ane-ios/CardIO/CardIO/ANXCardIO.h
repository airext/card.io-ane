//
//  CardIO.h
//  CardIO
//
//  Created by Max Rozdobudko on 5/8/15.
//  Copyright (c) 2015 igamebank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CardIO/CardIO.h>

#import "FlashRuntimeExtensions.h"

@interface ANXCardIO : NSObject

#pragma mark Properties

+(FREContext) context;
+(void) setContext: (FREContext) value;

#pragma mark Methods

+(BOOL) isSupported;

+(NSString*) libraryVersion;

@end
