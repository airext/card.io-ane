/**
 * Created by Max Rozdobudko on 5/15/15.
 */
package com.yuppablee.cardscan.data
{
public class CardScanOptions
{
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

    /**
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
     */
    public var languageOrLocale:String = null;

    /**
     * Alter the card guide (bracket) color. Opaque colors recommended.
     * Defaults to -1; if -1, will use card.io green.
     */
    public var guideColor:int = -1;

    /**
     * If <code>true</code>, don't have the user confirm the scanned card, just return the results immediately.
     * Defaults to <code>false</code>.
     */
    public var suppressScanConfirmation:Boolean = false;

    /**
     * Set the scan instruction text. If nil, use the default text. Defaults to nil.
     * Use newlines as desired to control the wrapping of text onto multiple lines.
     */
    public var scanInstructions:String = null;

    /**
     * Hide the PayPal or card.io logo in the scan view.
     * Defaults to <code>false</code>.
     */
    public var hideLogo:Boolean = false;

    /**
     * Set to <code>false</code> if you don't need to collect the card expiration.
     * Defaults to <code>true</code>.
     */
    public var requireExpiry:Boolean = true;

    /**
     * Set to <code>false</code> if you don't need to collect the cvv from the user.
     * Defaults to <code>true</code>.
     */
    public var requireCVV:Boolean = true;

    /**
     *
     * Set to <code>true</code> if you need to collect the billing postal code.
     * Defaults to <code>false</code>.
     */
    public var requirePostalCode:Boolean = false;

    /**
     * Set to <code>false</code> if you don't want the camera to try to scan the
     * card expiration. Applies only if collectExpiry is also YES.
     * Defaults to <code>true</code>.
     */
    public var scanExpiry:Boolean = true;

    /**
     * Set to <code>true</code> to show the card.io logo over the camera view instead of the PayPal logo.
     * Defaults to <code>false</code>.
     */
    public var useCardIOLogo:Boolean = false;

    /**
     * Set to <code>true</code> to prevent card.io from showing its "Enter Manually" button.
     * Defaults to <code>true</code>.
     *
     * @note <strong>On iOS</strong>: If [CardIOUtilities canReadCardWithCamera] returns false, then if card.io is presented it will
     *       automatically display its manual entry screen.
     *       Therefore, if you want to prevent users from *ever* seeing card.io's manual entry screen,
     *       you should first check [CardIOUtilities canReadCardWithCamera] before initing the view controller.
     */
    public var suppressManualEntry:Boolean = false;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

}
}
