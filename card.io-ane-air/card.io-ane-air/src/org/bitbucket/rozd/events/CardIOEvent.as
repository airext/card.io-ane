/**
 * Created by Max Rozdobudko on 5/13/15.
 */
package org.bitbucket.rozd.events
{
import flash.events.Event;

import org.bitbucket.rozd.data.CreditCard;

public class CardIOEvent extends Event
{
    public static const SCAN_COMPLETE:String = "scanComplete";

    public function CardIOEvent(type:String, info:CreditCard, bubbles:Boolean = false, cancelable:Boolean = false)
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
        return new CardIOEvent(type, info, bubbles, cancelable);
    }
}
}
