/**
 * Created by Max Rozdobudko on 5/19/15.
 */
package com.yuppablee.cardscan.enum
{
public class CardScanDetectionMode
{
    public static const CardImageAndNumber:CardScanDetectionMode = new CardScanDetectionMode(0, "CardImageAndNumber");

    public static const CardImageOnly:CardScanDetectionMode = new CardScanDetectionMode(1, "CardImageOnly");

    public static const Automatic:CardScanDetectionMode = new CardScanDetectionMode(2, "Automatic");

    public function CardScanDetectionMode(value:int, name:String)
    {
        super();

        _value = value;
        _name = name;
    }

    private var _value:int;
    public function get value():int
    {
        return _value;
    }

    private var _name:String;
    public function get name():String
    {
        return _name;
    }
}
}
