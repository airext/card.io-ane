card.io-ane 
==========

## Overview

ScanCard is AIR native extension for [card.io](http://card.io) credit card scanning SDK.

## Installation
You can get latest cardscan.ane binary from bin directory or built it for yourself as described in build's readme. Next add cardscan.ane to your project ([more info](http://help.adobe.com/en_US/air/build/WS597e5dadb9cc1e0253f7d2fc1311b491071-8000.html)) and declare it in your application descriptor:
```xml
    <extensions>
        <extensionID>com.yuppablee.cardscan</extensionID>
    </extensions>
```

#### On Android you also need to modify your application descriptor

1. Edit `<manifestAdditions>` section of your application descriptor. We're going to add a few additional items in here:

```xml
    <uses-sdk android:minSdkVersion="8" />
```

2. Also in your `<manifest>` element, make sure the following permissions and features are present:

```xml
    <!-- Permission to vibrate - recommended, allows vibration feedback on scan -->
    <uses-permission android:name="android.permission.VIBRATE" />

    <!-- Permission to use camera - required -->
    <uses-permission android:name="android.permission.CAMERA" />

    <!-- Camera features - recommended -->
    <uses-feature android:name="android.hardware.camera" android:required="false" />
    <uses-feature android:name="android.hardware.camera.autofocus" android:required="false" />
    <uses-feature android:name="android.hardware.camera.flash" android:required="false" />
```

3. Within the `<application>` element, add activity entries:

```xml
    <!-- Activities responsible for gathering payment info -->
    <activity android:name="io.card.payment.CardIOActivity" android:configChanges="keyboardHidden|orientation" />
    <activity android:name="io.card.payment.DataEntryActivity" />
	<activity android:name="com.yuppablee.cardscan.activities.CardScanActivity" />
```

You can get more info about installation on Android from [card.io-Android-SDK](https://github.com/card-io/card.io-Android-SDK)' repository. 

**Note** that `CardScanActivity` is an internal CardScan's Activity that used for receive data from `CardIOActivity` and it should be declared too.

## Scan For Payment
The `CardScan.sharedInstance().scanForPayment` method allow User scan (or manually input) its credit card, when scanning is done you receive `CardScanEvent.SCAN_COMPLETE` event, or `Event.CANCEL` if scan process has been cancelled.

```as3
	var scanComplete:Function = function (event:CardScanEvent):void
	{
		CardScan.sharedInstance().removeEventListener(CardScanEvent.SCAN_COMPLETE, scanComplete);
		CardScan.sharedInstance().removeEventListener(Event.CANCEL, scanCanceled);
		
		trace(event.info); // event.info contains CreditCard instance that describes scanned credit card.
	};

	var scanCanceled:Function = function (event:Event):void
	{
		CardScan.sharedInstance().removeEventListener(CardScanEvent.SCAN_COMPLETE, scanComplete);
		CardScan.sharedInstance().removeEventListener(Event.CANCEL, scanCanceled);

		trace("Cancelled");
	};

	CardScan.sharedInstance().addEventListener(CardScanEvent.SCAN_COMPLETE, scanComplete);
	CardScan.sharedInstance().addEventListener(Event.CANCEL, scanCanceled);

	CardScan.sharedInstance().scanForPayment(new CardScanOptions());
```

## Known issues and limitations
 * not support scanned images for CreditCard, due to requirement do not store credit card data;
 * changing scan overlay on Android is not tested;
 * changing scan overlay on iOS is not supported;
 * scan with CardIOView on iOS is not supported.

## Public API

`CardScan` class is a Facade that provide access to all functionality of the library:

```as3
	/**
	 * Returns card.io library version.
	 *
	 * @return Human-readable version of card.io library.
	 */
	public static function get libraryVersion():String;

	/**
	 * Indicates it CardScan extension is supported on current platform.
	 *
	 * @return @return <code>true</code> if extension is supported. <code>false</code> otherwise.
	 */
	public static function isSupported():Boolean;

	/**
	 * <i>iOS</i>:
	 * The preload method prepares card.io to launch faster. Calling preload is optional but suggested.
	 * On an iPhone 5S, for example, preloading makes card.io launch ~400ms faster.
	 * The best time to call preload is when displaying a view from which card.io might be launched;
	 * e.g., inside your view controller's viewWillAppear: method.
	 * preload works in the background; the call to preload returns immediately.
	 *
	 * <br />
	 *
	 * <i>Android</i>: Does nothing.
	 */
	public static function preload():void;

	/**
	 * <i>iOS</i>:
	 * Determine whether this device supports camera-based card scanning, considering
	 * factors such as hardware support and OS version.
	 * card.io automatically provides manual entry of cards as a fallback,
	 * so it is not typically necessary for your app to check this.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * Determine if the device supports card scanning.
	 * <br><br>
	 * An ARM7 processor and Android SDK 8 or later are required. Additional checks for specific
	 * misbehaving devices may also be added.
	 *
	 * @return <code>true</code> if camera is supported. <code>false</code> otherwise.
	 */
	public static function canReadCardWithCamera():Boolean;

	/**
	 * <i>iOS</i>: Returns a doubly Gaussian-blurred screenshot, intended for screenshots when backgrounding.
	 * @return Blurred screenshot.
	 *
	 * <i>Android</i>: N/A returns <code>null</code>.
	 */
	public static function getBlurredScreenImage():BitmapData;

	/**
	 * @return Shared instance.
	 */
	public static function sharedInstance():CardScan;

	/** Constructor*/
	public function CardScan();

	/**
	 * Initiates scan process.
	 *
	 * <i>iOS</i>:
	 * Starts scan with CardIOPaymentViewController
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * Starts scan with CardIOActivity
	 *
	 * @param options
	 */
	public function scanForPayment(options:CardScanOptions):void;
```

`CardScanOptions` class describes options for ScanForPayment functionality:
```as3
	//-------------------------------------
	//  Class constants: iOS specific keys
	//-------------------------------------

	/**
	 * Boolean property.
	 *
	 * If YES, the status bar's style will be kept as whatever your app has set it to.
	 * If NO, the status bar style will be set to the default style.
	 * Defaults to NO.
	 */
	public static const IOS_KEEP_STATUS_BAR_STYLE:String = "keepStatusBarStyle";

	/**
	 * UIBarStyle property.
	 *
	 * The default appearance of the navigation bar is navigationBarStyle == UIBarStyleDefault;
	 * tintColor == nil (pre-iOS 7), barTintColor == nil (iOS 7).
	 * Set either or both of these properties if you want to override these defaults.
	 * @see navigationBarTintColor
	 */
	public static const IOS_NAVIGATION_BAR_STYLE:String = "navigationBarStyle";

	/**
	 * Number property.
	 *
	 * The default appearance of the navigation bar is navigationBarStyle == UIBarStyleDefault;
	 * tintColor == nil (pre-iOS 7), barTintColor == nil (iOS 7).
	 * Set either or both of these properties if you want to override these defaults.
	 * @see navigationBarStyle
	 */
	public static const IOS_NAVIGATION_BAR_TINT_COLOR:String = "navigationBarTintColor";

	/**
	 * Boolean property.
	 *
	 * Normally, card.io blurs the screen when the app is backgrounded,
	 * to obscure card details in the iOS-saved screenshot.
	 * If your app already does its own blurring upon backgrounding,
	 * you might choose to disable this behavior.
	 * Defaults to NO.
	 */
	public static const IOS_DISABLE_BLUR_WHEN_BACKGROUNDING:String = "disableBlurWhenBackgrounding";

	/**
	 * Boolean property.
	 *
	 * If YES, instead of displaying the image of the scanned card,
	 * present the manual entry screen with the scanned card number prefilled.
	 * Defaults to NO.
	 */
	public static const IOS_SUPPRESS_SCANNED_CARD_IMAGE:String = "suppressScannedCardImage";

	/**
	 * Boolean property.
	 *
	 * Mask the card number digits as they are manually entered by the user. Defaults to NO.
	 */
	public static const IOS_MASK_MANUAL_ENTRY_DIGITS:String = "maskManualEntryDigits";

    /**
     * Unsupported feature.
     * 
     * A custom view that will be overlaid atop the entire scan view. Defaults to nil.
     * If you set a scanOverlayView, be sure to:
     *
     *  * Consider rotation. Be sure to test on the iPad with rotation both enabled and disabled.
     *    To make rotation synchronization easier, whenever a scanOverlayView is set, and card.io does an
     *    in-place rotation (rotates its UI elements relative to their containers), card.io will generate
     *    rotation notifications; see CardIOScanningOrientationDidChangeNotification
     *    and associated userInfo key documentation below.
     *    As with UIKit, the initial rotation is always UIInterfaceOrientationPortrait.
     *
     *  * Be sure to pass touches through to the superview as appropriate. Note that the entire camera
     *    preview responds to touches (triggers refocusing). Test the light button and the toolbar buttons.
     *
     *  * Minimize animations, redrawing, or any other CPU/GPU/memory intensive activities
     */
	public static const IOS_SCAN_OVERLAY_VIEW:String = "scanOverlayView"; // Unsupported feature

	/**
	 * Boolean property.
	 * 
	 * By default, in camera view the card guide and the buttons always rotate to match the device's orientation.
	 *   All four orientations are permitted, regardless of any app or viewcontroller constraints.
	 * If you wish, the card guide and buttons can instead obey standard iOS constraints, including
	 *   the UISupportedInterfaceOrientations settings in your app's plist.
	 * Set to NO to follow standard iOS constraints. Defaults to YES. (Does not affect the manual entry screen.)
	 */
	public static const IOS_ALLOW_FREELY_ROTATING_CARD_GUIDE:String = "allowFreelyRotatingCardGuide";

	//-------------------------------------
	//  Class constants: Android specific keys
	//-------------------------------------

	/**
	 * Boolean extra. Optional. Defaults to <code>false</code>. If set, the card will not be scanned
	 * with the camera.
	 */
	public static const ANDROID_NO_CAMERA:String = "io.card.payment.noCamera";

		/**
		 * Integer extra. Optional. If this value is provided the view will be inflated and will overlay
		 * the camera during the scan process. The integer value must be the id of a valid layout
		 * resource.
		 */
		public static const ANDROID_SCAN_OVERLAY_LAYOUT_ID:String = "io.card.payment.scanOverlayLayoutId";

	/**
	 * Boolean extra. Optional. Use the PayPal icon in the ActionBar.
	 */
	public static const ANDROID_USE_PAYPAL_ACTIONBAR_ICON:String = "io.card.payment.intentSenderIsPayPal";

	/**
	 * Boolean extra. Optional. If this value is set to <code>true</code>, and the application has a theme,
	 * the theme for the card.io {@link android.app.Activity}s will be set to the theme of the application.
	 */
	public static const ANDROID_KEEP_APPLICATION_THEME:String = "io.card.payment.keepApplicationTheme";

	/** Constructor */
	public function CardScanOptions()
	{
		super();
	}

	/**
	 * The preferred language for all strings appearing in the user interface.
	 *
	 * <i>iOS</i>:
	 * The preferred language for all strings appearing in the user interface.
	 * If not set, or if set to nil, defaults to the device's current language setting.
	 *
	 * Can be specified as a language code ("en", "fr", "zh-Hans", etc.) or as a locale ("en_AU", "fr_FR", "zh-Hant_HK", etc.).
	 * If card.io does not contain localized strings for a specified locale, then it will fall back to the language. E.g., "es_CO" -> "es".
	 * If card.io does not contain localized strings for a specified language, then it will fall back to American English.
	 *
	 * If you specify only a language code, and that code matches the device's currently preferred language,
	 * then card.io will attempt to use the device's current region as well.
	 * E.g., specifying "en" on a device set to "English" and "United Kingdom" will result in "en_GB".
	 *
	 * These localizations are currently included:
	 * ar,da,de,en,en_AU,en_GB,es,es_MX,fr,he,is,it,ja,ko,ms,nb,nl,pl,pt,pt_BR,ru,sv,th,tr,zh-Hans,zh-Hant,zh-Hant_TW.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 *
	 */
	public function get languageOrLocale():String;

	/**
	 * Color of the guide overlay.
	 *
	 * <i>iOS</i>:
	 * Alter the card guide (bracket) color. Opaque colors recommended.
	 * Defaults to -1; if -1, will use card.io green.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * Integer extra. Optional. Defaults to {@link Color#GREEN}. Changes the
	 * color of the guide overlay on the camera.
	 */
	public function get guideColor():int;

	/**
	 * <i>iOS</i>:
	 * If <code>true</code>, don't have the user confirm the scanned card, just
	 * return the results immediately. Defaults to <code>false</code>.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * Boolean extra. Optional. If this value is set to <code>true</code> the
	 * user will not be prompted to confirm their card number after processing.
	 */
	public function get suppressScanConfirmation():Boolean;

	/**
	 * <i>iOS</i>:
	 * Set the scan instruction text. If nil, use the default text. Defaults to nil.
	 * Use newlines as desired to control the wrapping of text onto multiple lines.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * String extra. Optional. Used to display instructions to the user while they are scanning
	 * their card.
	 */
	public function get scanInstructions():String;

	/**
	 * <i>iOS</i>:
	 * Hide the PayPal or card.io logo in the scan view.
	 * Defaults to <code>false</code>.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * Boolean extra. Optional. Defaults to <code>false</code>. When set to <code>true</code>
	 * the card.io logo will not be shown overlaid on the camera.
	 */
	public function get hideLogo():Boolean;

	/**
	 * <i>iOS</i>:
	 * Set to <code>false</code> if you don't need to collect the card expiration.
	 * Defaults to <code>true</code>.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * Boolean extra. Optional. Defaults to <code>false</code>. If
	 * set to <code>false</code>, expiry information will not be required.
	 */
	public function get requireExpiry():Boolean;

	/**
	 * <i>iOS</i>:
	 * Set to <code>false</code> if you don't need to collect the cvv from the user.
	 * Defaults to <code>true</code>.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * Boolean extra. Optional. Defaults to <code>false</code>. If set, the user will be prompted
	 * for the card CVV.
	 */
	public function get requireCVV():Boolean;

	/**
	 * <i>iOS</i>:
	 * Set to <code>true</code> if you need to collect the billing postal code.
	 * Defaults to <code>false</code>.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * Boolean extra. Optional. Defaults to <code>false</code>. If set, the user will be prompted
	 * for the card billing postal code.
	 */
	public function get requirePostalCode():Boolean;

	/**
	 * <i>iOS</i>:
	 * Set to <code>false</code> if you don't want the camera to try to scan the
	 * card expiration. Applies only if collectExpiry is also YES.
	 * Defaults to <code>true</code>.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * Boolean extra. Optional. Defaults to <code>true</code>. If
	 * set to <code>true</code>, and {@link #EXTRA_REQUIRE_EXPIRY} is <code>true</code>,
	 * an attempt to extract the expiry from the card image will be made.
	 */
	public function get scanExpiry():Boolean;

	/**
	 * <i>iOS</i>:
	 * Set to <code>true</code> to show the card.io logo over the camera view instead of the PayPal logo.
	 * Defaults to <code>false</code>.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * Boolean extra. Optional. Defaults to <code>false</code>. If set, the card.io logo will be
	 * shown instead of the PayPal logo.
	 */
	public function get useCardIOLogo():Boolean;

	/**
	 * <i>iOS</i>:
	 * Set to <code>true</code> to prevent card.io from showing its "Enter Manually" button.
	 * Defaults to <code>true</code>.
	 *
	 * @note <strong>On iOS</strong>: If [CardIOUtilities canReadCardWithCamera] returns false, then if card.io
	 * is presented it will automatically display its manual entry screen. Therefore, if you want to prevent
	 * users from *ever* seeing card.io's manual entry screen, you should first check 
	 * [CardIOUtilities canReadCardWithCamera] before initing the view controller.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * Boolean extra. Optional. Defaults to <code>false</code>. Removes the keyboard button from the
	 * scan screen.
	 * <p/>
	 * If scanning is unavailable, the {@link android.app.Activity} result will be 
	 * {@link #RESULT_SCAN_NOT_AVAILABLE}.
	 */
	public function get suppressManualEntry():Boolean;

	/**
	 * Specifies detection mode.
	 *
	 * <i>iOS</i>:
	 * CardIODetectionModeCardImageAndNumber: the scanner must successfully identify the card number.
	 * CardIODetectionModeCardImageOnly: don't scan the card, just detect a credit-card-shaped card.
	 * CardIODetectionModeAutomatic: start as CardIODetectionModeCardImageAndNumber, but fall back to
	 * CardIODetectionModeCardImageOnly if scanning has not succeeded within a reasonable time.
	 * Defaults to CardIODetectionModeCardImageAndNumber.
	 *
	 * @note Images returned in CardIODetectionModeCardImageOnly mode may be less focused, to accomodate  
	 * scanning cards that are dominantly white (e.g., the backs of drivers licenses), and thus
	 * hard to calculate accurate focus scores for.
	 *
	 * <br />
	 *
	 * <i>Android</i>:
	 * On Android this option is simulated, for image only detection mode it
	 * sets CardIOActivity.EXTRA_SUPPRESS_SCAN and CardIOActivity.EXTRA_RETURN_CARD_IMAGE
	 * to <code>true</code>.
	 *
	 */
	public function get detectionMode():CardScanDetectionMode;

	/**
	 * Sets option value
	 *
	 * @param name The name of option
	 * @param value The value to set
	 */
	public function setProperty(name:String, value:Object):void;

	/**
	 * Returns option value
	 *
	 * @param name The name of option
	 * @return The option value
	 */
	public function getProperty(name:String):*;
```

`CreditCard` class contains information about a credit card received throudh scan proccess:
```as3
	/** Constructor */
	public function CreditCard()
	{
		super();
	}

	/**
	 * Card number
	 */
	public var cardNumber:String;

	/**
	 * Card number with all but the last four digits obfuscated
	 */
	public var redactedCardNumber:String;

	/**
	 * January == 1
	 *
	 * @note expiryMonth & expiryYear may be 0, if expiry information was not requested.
	 */
	public var expiryMonth:Number;

	/**
	 * The full four digit year.
	 *
	 * @note expiryMonth & expiryYear may be 0, if expiry information was not requested.
	 */
	public var expiryYear:Number;

	/**
	 * Security code (aka CSC, CVV, CVV2, etc.)
	 *
	 * @note May be null, if security code was not requested.
	 */
	public var cvv:String;

	/**
	 * Postal code. Format is country dependent
	 *
	 * @note May be nil, if postal code information was not requested.
	 */
	public var postalCode:String;

	/**
	 * Was the card number scanned (as opposed to entered manually)?
	 *
	 * @note May be nil, if postal code information was not requested.
	 */
	public var scanned:Boolean;

	/**
	 * Derived from cardNumber.
	 *
	 * @note CardIOCreditInfo objects will never return a cardType of CreditCardTypeAmbiguous.
	 */
	public var cardType:CreditCardType;
```