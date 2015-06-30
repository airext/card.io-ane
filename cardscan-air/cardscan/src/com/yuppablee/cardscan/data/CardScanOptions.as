/**
 * Created by Max Rozdobudko on 5/15/15.
 */
package com.yuppablee.cardscan.data
{
import com.yuppablee.cardscan.core.card_scan;
import com.yuppablee.cardscan.enum.CardScanDetectionMode;

public class CardScanOptions
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

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

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function CardScanOptions()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    private var properties:Object = {};

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  languageOrLocale
    //-------------------------------------

    private var _languageOrLocale:String = null;

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
     * String extra. Optional. The preferred language for all strings appearing in the user
     * interface. If not set, or if set to null, defaults to the device's current language setting. <br/>
     * <br/>
     * Can be specified as a language code ("en", "fr", "zh-Hans", etc.) or as a locale ("en_AU",
     * "fr_FR", "zh-Hant_TW", etc.). <br/>
     * <br/>
     * If the library does not contain localized strings for a specified locale, then will fall back
     * to the language. E.g., "es_CO" -> "es". <br/>
     * If the library does not contain localized strings for a specified language, then will fall
     * back to American English. <br/>
     * <br/>
     * If you specify only a language code, and that code matches the device's currently preferred
     * language, then the library will attempt to use the device's current region as well. E.g.,
     * specifying "en" on a device set to "English" and "United Kingdom" will result in "en_GB". <br/>
     * <br/>
     * These localizations are currently included: <br/>
     * <p/>
     * da, de, en, en_AU, en_GB, es, es_MX, fr, he, is, it, ja, ko, nb, nl, pl, pt, pt_BR, ru,
     * sv, tr, zh-Hans, zh-Hant, zh-Hant_TW.
     */
    public function get languageOrLocale():String
    {
        return _languageOrLocale;
    }

    public function set languageOrLocale(value:String):void
    {
        _languageOrLocale = value;
        
        setProperty("languageOrLocale", value);
    }

    //-------------------------------------
    //  guideColor
    //-------------------------------------

    private var _guideColor:int = -1;

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
    public function get guideColor():int
    {
        return _guideColor;
    }

    public function set guideColor(value:int):void
    {
        _guideColor = value;

        setProperty("guideColor", value);
    }

    //-------------------------------------
    //  suppressScanConfirmation
    //-------------------------------------

    private var _suppressScanConfirmation:Boolean = false;

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
    public function get suppressScanConfirmation():Boolean
    {
        return _suppressScanConfirmation;
    }

    public function set suppressScanConfirmation(value:Boolean):void
    {
        _suppressScanConfirmation = value;

        setProperty("suppressScanConfirmation", value);
    }

    //-------------------------------------
    //  scanInstructions
    //-------------------------------------

    private var _scanInstructions:String = null;

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
    public function get scanInstructions():String
    {
        return _scanInstructions;
    }

    public function set scanInstructions(value:String):void
    {
        _scanInstructions = value;

        setProperty("scanInstructions", value);
    }

    //-------------------------------------
    //  hideLogo
    //-------------------------------------

    private var _hideLogo:Boolean = false;

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
    public function get hideLogo():Boolean
    {
        return _hideLogo;
    }

    public function set hideLogo(value:Boolean):void
    {
        _hideLogo = value;

        setProperty("hideLogo", value);
    }

    //-------------------------------------
    //  requireExpiry
    //-------------------------------------

    private var _requireExpiry:Boolean = true;

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
    public function get requireExpiry():Boolean
    {
        return _requireExpiry;
    }

    public function set requireExpiry(value:Boolean):void
    {
        _requireExpiry = value;

        setProperty("requireExpiry", value);
    }

    //-------------------------------------
    //  requireCVV
    //-------------------------------------

    private var _requireCVV:Boolean = true;

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
    public function get requireCVV():Boolean
    {
        return _requireCVV;
    }

    public function set requireCVV(value:Boolean):void
    {
        _requireCVV = value;

        setProperty("requireCVV", value);
    }

    //-------------------------------------
    //  requirePostalCode
    //-------------------------------------

    private var _requirePostalCode:Boolean = false;

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
    public function get requirePostalCode():Boolean
    {
        return _requirePostalCode;
    }

    public function set requirePostalCode(value:Boolean):void
    {
        _requirePostalCode = value;

        setProperty("requirePostalCode", value);
    }

    //-------------------------------------
    //  scanExpiry
    //-------------------------------------

    private var _scanExpiry:Boolean = true;

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
    public function get scanExpiry():Boolean
    {
        return _scanExpiry;
    }

    public function set scanExpiry(value:Boolean):void
    {
        _scanExpiry = value;

        setProperty("scanExpiry", value);
    }

    //-------------------------------------
    //  useCardIOLogo
    //-------------------------------------

    private var _useCardIOLogo:Boolean = false;

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
    public function get useCardIOLogo():Boolean
    {
        return _useCardIOLogo;
    }

    public function set useCardIOLogo(value:Boolean):void
    {
        _useCardIOLogo = value;

        setProperty("useCardIOLogo", value);
    }

    //-------------------------------------
    //  suppressManualEntry
    //-------------------------------------

    private var _suppressManualEntry:Boolean = false;

    /**
     * <i>iOS</i>:
     * Set to <code>true</code> to prevent card.io from showing its "Enter Manually" button.
     * Defaults to <code>true</code>.
     *
     * @note <strong>On iOS</strong>: If [CardIOUtilities canReadCardWithCamera] returns false, then if card.io is presented it will
     *       automatically display its manual entry screen.
     *       Therefore, if you want to prevent users from *ever* seeing card.io's manual entry screen,
     *       you should first check [CardIOUtilities canReadCardWithCamera] before initing the view controller.
     *
     * <br />
     *
     * <i>Android</i>:
     * Boolean extra. Optional. Defaults to <code>false</code>. Removes the keyboard button from the
     * scan screen.
     * <p/>
     * If scanning is unavailable, the {@link android.app.Activity} result will be {@link #RESULT_SCAN_NOT_AVAILABLE}.
     */
    public function get suppressManualEntry():Boolean
    {
        return _suppressManualEntry;
    }

    public function set suppressManualEntry(value:Boolean):void
    {
        _suppressManualEntry = value;
        
        setProperty("suppressManualEntry", value);
    }

    //-------------------------------------
    //  detectionMode
    //-------------------------------------

    private var _detectionMode:CardScanDetectionMode;

    /**
     * Specifies detection mode.
     *
     * <i>iOS</i>:
     * CardIODetectionModeCardImageAndNumber: the scanner must successfully identify the card number.
     * CardIODetectionModeCardImageOnly: don't scan the card, just detect a credit-card-shaped card.
     * CardIODetectionModeAutomatic: start as CardIODetectionModeCardImageAndNumber, but fall back to
     *        CardIODetectionModeCardImageOnly if scanning has not succeeded within a reasonable time.
     * Defaults to CardIODetectionModeCardImageAndNumber.
     *
     * @note Images returned in CardIODetectionModeCardImageOnly mode may be less focused, to accomodate scanning
     *       cards that are dominantly white (e.g., the backs of drivers licenses), and thus
     *       hard to calculate accurate focus scores for.
     *
     * <br />
     *
     * <i>Android</i>:
     * On Android this option is simulated, for image only detection mode it
     * sets CardIOActivity.EXTRA_SUPPRESS_SCAN and CardIOActivity.EXTRA_RETURN_CARD_IMAGE
     * to <code>true</code>.
     *
     */
    public function get detectionMode():CardScanDetectionMode
    {
        return _detectionMode;
    }

    public function set detectionMode(value:CardScanDetectionMode):void
    {
        _detectionMode = value;

        if (value != null)
        {
            setProperty("detectionMode", value.value);
        }
        else
        {
            properties["detectionMode"] = null;
            delete properties["detectionMode"];
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     * Sets option value
     *
     * @param name The name of option
     * @param value The value to set
     */
    public function setProperty(name:String, value:Object):void
    {
        properties[name] = value;
    }

    /**
     * Returns option value
     *
     * @param name The name of option
     * @return The option value
     */
    public function getProperty(name:String):*
    {
        return properties[name];
    }

    card_scan function toDTO():Object
    {
        return properties;
    }
}
}
