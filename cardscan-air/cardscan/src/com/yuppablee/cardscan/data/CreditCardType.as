/**
 * Created by Max Rozdobudko on 5/13/15.
 */
package com.yuppablee.cardscan.data
{
import flash.display.BitmapData;

import com.yuppablee.cardscan.CardScan;

import com.yuppablee.cardscan.core.card_scan;

use namespace card_scan;

public class CreditCardType
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    public static const AMEX:CreditCardType = new CreditCardType("AmEx");
    public static const DINERSCLUB:CreditCardType = new CreditCardType("DinersClub");
    public static const DISCOVER:CreditCardType = new CreditCardType("Discover");
    public static const JCB:CreditCardType = new CreditCardType("JCB");
    public static const MASTERCARD:CreditCardType = new CreditCardType("MasterCard");
    public static const VISA:CreditCardType = new CreditCardType("Visa");
    public static const MAESTRO:CreditCardType = new CreditCardType("Maestro");
    public static const AMBIGUOUS:CreditCardType = new CreditCardType("Ambiguous");

    public static const UNKNOWN:CreditCardType = new CreditCardType("Unknown");

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
    public static function logoForCardType(cardType:CreditCardType):BitmapData
    {
        if (cardType == null)
            return null;

        if (!logosForCardType.hasOwnProperty(cardType.name))
        {
            logosForCardType[cardType.name] = CardScan.context.call("getLogoForCardType", cardType.name);
        }

        return logosForCardType[cardType.name];
    }

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    card_scan static function toCreditCardType(name:String):CreditCardType
    {
        switch (name)
        {
            case "AmEx" :       return AMEX; break;
            case "DinersClub" : return DINERSCLUB; break;
            case "Discover" :   return DISCOVER; break;
            case "JCB" :        return JCB; break;
            case "MasterCard" : return MASTERCARD; break;
            case "Visa" :       return VISA; break;
            case "Maestro" :    return MAESTRO; break;
            case "Ambiguous" :  return AMBIGUOUS; break;

            default : return UNKNOWN; break;
        }
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function CreditCardType(name:String)
    {
        super();

        _name = name;
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  name
    //-------------------------------------

    private var _name:String;

    public function get name():String
    {
        return _name;
    }

    //-------------------------------------
    //  logo
    //-------------------------------------

    private var _logo:BitmapData;

    public function get logo():BitmapData
    {
        if (_logo == null)
        {
            _logo = logoForCardType(this);
        }

        return _logo;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function getDisplayName(languageOrLocale:String):String
    {
        return CardScan.context.call("getDisplayNameForCardType", _name, languageOrLocale) as String;
    }
    
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function toString():String
    {
        return _name;
    }
}
}
