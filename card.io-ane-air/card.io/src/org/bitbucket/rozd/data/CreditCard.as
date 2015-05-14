/**
 * Created by Max Rozdobudko on 5/12/15.
 */
package org.bitbucket.rozd.data
{
import flash.display.BitmapData;

import org.bitbucket.rozd.CardIO;
import org.bitbucket.rozd.core.card_io;

use namespace card_io

/**
 * Contains information about a card.
 */
public class CreditCard
{
    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    private static const logosForCardType:Object = {};

    /**
     * Returns a 36x25 credit card logo, at a resolution appropriate for the device.
     *
     * @param cardType The card type.
     * @return 36x25 credit card logo.
     */
    public static function logoForCardType(cardType:String):BitmapData
    {
        if (!logosForCardType.hasOwnProperty(cardType))
        {
            logosForCardType[cardType] = CardIO.context.call("getLogoForCardType", cardType);
        }

        return logosForCardType[cardType];
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function CreditCard()
    {
        super();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  cardNumber
    //-------------------------------------

    /**
     * Card number
     */
    public var cardNumber:String;

    //-------------------------------------
    //  redactedCardNumber
    //-------------------------------------

    /**
     * Card number with all but the last four digits obfuscated
     */
    public var redactedCardNumber:String;

    //-------------------------------------
    //  expiryMonth
    //-------------------------------------

    /**
     * January == 1
     *
     * @note expiryMonth & expiryYear may be 0, if expiry information was not requested.
     */
    public var expiryMonth:Number;

    //-------------------------------------
    //  expiryYear
    //-------------------------------------

    /**
     * The full four digit year.
     *
     * @note expiryMonth & expiryYear may be 0, if expiry information was not requested.
     */
    public var expiryYear:Number;

    //-------------------------------------
    //  cvv
    //-------------------------------------

    /**
     * Security code (aka CSC, CVV, CVV2, etc.)
     *
     * @note May be null, if security code was not requested.
     */
    public var cvv:String;

    //-------------------------------------
    //  postalCode
    //-------------------------------------

    /**
     * Postal code. Format is country dependent
     *
     * @note May be nil, if postal code information was not requested.
     */
    public var postalCode:String;

    //-------------------------------------
    //  scanned
    //-------------------------------------

    /**
     * Was the card number scanned (as opposed to entered manually)?
     *
     * @note May be nil, if postal code information was not requested.
     */
    public var scanned:Boolean;

    //-------------------------------------
    //  cardType
    //-------------------------------------

    /**
     * Derived from cardNumber.
     *
     * @note CardIOCreditInfo objects will never return a cardType of CreditCardTypeAmbiguous.
     */
    public var cardType:CreditCardType;

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function toString():String
    {
        return '[CreditCard ' +
                'redactedCardNumber="' + redactedCardNumber + '"' +
                'expiryMonth="' + expiryMonth + '"' +
                'expiryYear="' + expiryYear + '"' +
                'expiryYear="' + expiryYear + '"' +
                'postalCode="' + postalCode + '"' +
                'scanned="' + scanned + '"' +
                'cardType="' + cardType + '"'
                + ']';
    }
}
}
