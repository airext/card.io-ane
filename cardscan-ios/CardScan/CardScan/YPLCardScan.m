//
//  CardIO.m
//  CardIO
//
//  Created by Max Rozdobudko on 5/8/15.
//  Copyright (c) 2015 yeaply.com. All rights reserved.
//

#import "YPLCardScan.h"

@implementation YPLCardScan
{
    ANXCardIOScanForPaymentCompletion scanForPaymentCallback;
}

#pragma mark Shared Instance

static YPLCardScan* _sharedInstance = nil;

+(YPLCardScan*) sharedInstance
{
    if (_sharedInstance == nil)
    {
        _sharedInstance = [[super alloc] init];
    }
    
    return _sharedInstance;
}

#pragma mark Class Methods

+(BOOL) isSupported
{
    return YES;
}

+(NSString*) libraryVersion
{
    return [CardIOUtilities libraryVersion];
}

+(UIImage*) getLogoForCardType: (CardIOCreditCardType) cardType
{
    return [CardIOCreditCardInfo logoForCardType:cardType];
}

+(NSString*) getDisplayNameForCardType: (CardIOCreditCardType) cardType singLanguageOrLocale: (NSString*) languageOrLocale
{
    return [CardIOCreditCardInfo displayStringForCardType:cardType usingLanguageOrLocale:languageOrLocale];
}

-(void) scanForPayment: (FREObject) object completion: (ANXCardIOScanForPaymentCompletion) completion
{
    NSLog(@"Start scan for payment.");
    
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    
    scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    UIViewController *currentRootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    [currentRootViewController presentViewController:scanViewController animated:YES completion:nil];
    
    scanForPaymentCallback = completion;
}


#pragma mark - CardIOPaymentViewControllerDelegate

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)paymentViewController
{
    NSLog(@"Scan succeeded with info: %@", info);
    
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
    
    if (scanForPaymentCallback != nil)
    {
        scanForPaymentCallback(info, nil);
        
        scanForPaymentCallback = nil;
    }
}

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController
{
    NSLog(@"User cancelled scan");
    
    [paymentViewController dismissViewControllerAnimated:YES completion:nil];
    
    if (scanForPaymentCallback != nil)
    {
        scanForPaymentCallback(nil, nil);
        
        scanForPaymentCallback = nil;
    }
}


@end
