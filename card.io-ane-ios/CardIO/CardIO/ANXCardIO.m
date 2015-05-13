//
//  CardIO.m
//  CardIO
//
//  Created by Max Rozdobudko on 5/8/15.
//  Copyright (c) 2015 igamebank. All rights reserved.
//

#import "ANXCardIO.h"

@implementation ANXCardIO
{
    ANXCardIOScanForPaymentCompletion scanForPaymentCallback;
}

#pragma mark Shared Instance

static ANXCardIO* _sharedInstance = nil;

+(ANXCardIO*) sharedInstance
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

-(void) scanForPayment: (FREObject) object completion: (ANXCardIOScanForPaymentCompletion) completion
{
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
