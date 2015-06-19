/**
 * Created by Max Rozdobudko on 5/19/15.
 */
package com.yuppablee.cardscan.enum
{
public class CardScanDetectionMode
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    /**
     * iOS: The scanner must successfully identify the card number.
     */
    public static const CardImageAndNumber:CardScanDetectionMode = new CardScanDetectionMode(0, "CardImageAndNumber");

    /**
     * iOS:  don't scan the card, just detect a credit-card-shaped card.
     */
    public static const CardImageOnly:CardScanDetectionMode = new CardScanDetectionMode(1, "CardImageOnly");

    /**
     * iOS: start as CardImageAndNumber, but fall back to CardImageOnly if scanning has not succeeded within a reasonable time.
     */
    public static const Automatic:CardScanDetectionMode = new CardScanDetectionMode(2, "Automatic");

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function CardScanDetectionMode(value:int, name:String)
    {
        super();

        _value = value;
        _name = name;
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  value
    //-------------------------------------

    private var _value:int;
    public function get value():int
    {
        return _value;
    }

    //-------------------------------------
    //  name
    //-------------------------------------

    private var _name:String;
    public function get name():String
    {
        return _name;
    }
}
}
