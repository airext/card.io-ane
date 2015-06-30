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
     * Scans for card image and number.
     *
     * <i>iOS</i>: the scanner must successfully identify the card number.
     *
     * <i>Android</i>: behaves as default
     */
    public static const CardImageAndNumber:CardScanDetectionMode = new CardScanDetectionMode(0, "CardImageAndNumber");

    /**
     * Scan for card image only.
     *
     * <i>iOS</i>: don't scan the card, just detect a credit-card-shaped card.
     *
     * <i>Android</i>:
     * sets CardIOActivity.EXTRA_SUPPRESS_SCAN and CardIOActivity.EXTRA_RETURN_CARD_IMAGE
     * to <code>true</code> to simulated image only scan.
     */
    public static const CardImageOnly:CardScanDetectionMode = new CardScanDetectionMode(1, "CardImageOnly");

    /**
     * Scan for card image and number, but could fallback to image only.
     *
     * <i>iOS</i>:
     * start as CardIODetectionModeCardImageAndNumber, but fall back to
     * CardIODetectionModeCardImageOnly if scanning has not succeeded within a
     * reasonable time.
     *
     * <i>Android</i>: does nothing
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
