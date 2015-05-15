/**
 * Created by Max Rozdobudko on 5/13/15.
 */
package com.yuppablee.cardscan.events
{
import flash.events.Event;

import com.yuppablee.cardscan.data.CreditCard;

public class CardScanEvent extends Event
{
    public static const SCAN_COMPLETE:String = "scanComplete";

    public function CardScanEvent(type:String, info:CreditCard, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);

        _info = info;
    }

    private var _info:CreditCard;
    public function get info():CreditCard
    {
        return _info;
    }

    override public function clone():Event
    {
        return new CardScanEvent(type, info, bubbles, cancelable);
    }
}
}
