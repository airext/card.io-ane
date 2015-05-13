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

#pragma mark Callbacks

typedef void (^ANXCardIOScanForPaymentCompletion)(CardIOCreditCardInfo* info, NSError *error);

#pragma mark Interface

@interface ANXCardIO : NSObject <CardIOPaymentViewControllerDelegate>

#pragma mark Shared Instance

+(ANXCardIO*) sharedInstance;

#pragma mark Class Methods

+(BOOL) isSupported;

+(NSString*) libraryVersion;

-(void) scanForPayment: (FREObject) object completion: (ANXCardIOScanForPaymentCompletion) completion;

@end
