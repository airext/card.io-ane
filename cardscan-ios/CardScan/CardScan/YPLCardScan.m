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

+(void) preload
{
    [CardIOUtilities preload];
}

+(NSString*) libraryVersion
{
    return [CardIOUtilities libraryVersion];
}

+(BOOL) canReadCardWithCamera
{
    return [CardIOUtilities canReadCardWithCamera];
}

+(UIImage*) blurredScrenImage
{
    UIImageView* imageView = [CardIOUtilities blurredScreenImageView];
    
    if (imageView != nil)
    {
        return imageView.image;
    }
    else
    {
        return nil;
    }
}

+(UIImage*) getLogoForCardType: (CardIOCreditCardType) cardType
{
    return [CardIOCreditCardInfo logoForCardType:cardType];
}

+(NSString*) getDisplayNameForCardType: (CardIOCreditCardType) cardType singLanguageOrLocale: (NSString*) languageOrLocale
{
    return [CardIOCreditCardInfo displayStringForCardType:cardType usingLanguageOrLocale:languageOrLocale];
}

-(void) scanForPayment: (NSDictionary*) options completion: (ANXCardIOScanForPaymentCompletion) completion
{
    NSLog(@"Start scan for payment.");
    
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    
    if ([options objectForKey:@"languageOrLocale"])
    {
        scanViewController.languageOrLocale = [options valueForKey:@"languageOrLocale"];
    }
    
    if ([options objectForKey:@"guideColor"])
    {
        scanViewController.guideColor = [options valueForKey:@"guideColor"];
    }
    
    if ([options objectForKey:@"suppressScanConfirmation"])
    {
        scanViewController.suppressScanConfirmation = [[options valueForKey:@"suppressScanConfirmation"] boolValue];
    }
    
    if ([options objectForKey:@"scanInstructions"])
    {
        scanViewController.scanInstructions = [options valueForKey:@"scanInstructions"];
    }
    
    if ([options objectForKey:@"hideLogo"])
    {
        scanViewController.hideCardIOLogo = [[options valueForKey:@"hideLogo"] boolValue];
    }
    
    if ([options objectForKey:@"requireExpiry"])
    {
        scanViewController.collectExpiry = [[options valueForKey:@"requireExpiry"] boolValue];
    }
    
    if ([options objectForKey:@"requireCVV"])
    {
        scanViewController.collectCVV = [[options valueForKey:@"requireCVV"] boolValue];
    }
    
    if ([options objectForKey:@"requirePostalCode"])
    {
        scanViewController.collectPostalCode = [[options valueForKey:@"requirePostalCode"] boolValue];
    }
    
    if ([options objectForKey:@"scanExpiry"])
    {
        scanViewController.scanExpiry = [[options valueForKey:@"scanExpiry"] boolValue];
    }
    
    if ([options objectForKey:@"useCardIOLogo"])
    {
        scanViewController.useCardIOLogo = [[options valueForKey:@"useCardIOLogo"] boolValue];
    }
    
    if ([options objectForKey:@"suppressManualEntry"])
    {
        scanViewController.disableManualEntryButtons = [[options valueForKey:@"suppressManualEntry"] boolValue];
    }
    
    if ([options objectForKey:@"detectionMode"])
    {
        scanViewController.detectionMode = [[options valueForKey:@"detectionMode"] integerValue];
    }
    
    if ([options objectForKey:@"keepStatusBarStyle"])
    {
        scanViewController.keepStatusBarStyle = [[options valueForKey:@"keepStatusBarStyle"] integerValue];
    }
    
    if ([options objectForKey:@"navigationBarTintColor"])
    {
        scanViewController.navigationBarTintColor = [options valueForKey:@"navigationBarTintColor"];
    }
    
    if ([options objectForKey:@"disableBlurWhenBackgrounding"])
    {
        scanViewController.disableBlurWhenBackgrounding = [[options valueForKey:@"disableBlurWhenBackgrounding"] boolValue];
    }
    
    if ([options objectForKey:@"suppressScannedCardImage"])
    {
        scanViewController.suppressScannedCardImage = [[options valueForKey:@"suppressScannedCardImage"] boolValue];
    }
    
    if ([options objectForKey:@"maskManualEntryDigits"])
    {
        scanViewController.maskManualEntryDigits = [[options valueForKey:@"maskManualEntryDigits"] boolValue];
    }
    
    if ([options objectForKey:@"allowFreelyRotatingCardGuide"])
    {
        scanViewController.allowFreelyRotatingCardGuide = [[options valueForKey:@"allowFreelyRotatingCardGuide"] boolValue];
    }
    
    NSLog(@"Options: %@", options);
    
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
