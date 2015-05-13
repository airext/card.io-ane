/**
 * Created by Max Rozdobudko on 5/8/15.
 */
package org.bitbucket.rozd
{
import flash.events.ErrorEvent;
import flash.events.Event;

import flash.events.EventDispatcher;

import flash.events.StatusEvent;

import flash.external.ExtensionContext;
import flash.net.registerClassAlias;

import org.bitbucket.rozd.core.card_io;
import org.bitbucket.rozd.core.dto.CreditCardDTO;
import org.bitbucket.rozd.data.CreditCard;
import org.bitbucket.rozd.events.CardIOEvent;

use namespace card_io;

[Event(name="scanComplete", type="org.bitbucket.rozd.events.CardIOEvent")]

[Event(name="cancel", type="flash.events.Event")]

[Event(name="error", type="flash.events.ErrorEvent")]

public class CardIO extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    card_io static const EXTENSION_ID:String = "org.bitbucket.rozd.CardIO";

    //--------------------------------------------------------------------------
    //
    //  Class properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  context
    //-------------------------------------

    private static var _context:ExtensionContext;

    card_io static function get context():ExtensionContext
    {
        if (_context == null)
        {
            _context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
        }

        return _context;
    }

    //-------------------------------------
    //  libraryVersion
    //-------------------------------------

    public static function get libraryVersion():String
    {
        return context.call("libraryVersion") as String;
    }

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    public static function isSupported():Boolean
    {
        return context != null && context.call("isSupported");
    }

    public static function preload():void
    {
        context.call("preload");
    }

    private static var instance:CardIO;

    public static function getInstance():CardIO
    {
        if (instance == null)
        {
            new CardIO();
        }

        return instance;
    }

    //--------------------------------------------------------------------------
    //
    //  Static initialization
    //
    //--------------------------------------------------------------------------

    {

    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function CardIO()
    {
        super();

        instance = this;

        context.addEventListener(StatusEvent.STATUS, statusHandler);
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function scanForPayment(options:Object):void
    {
        context.call("scanForPayment");
    }

    //--------------------------------------------------------------------------
    //
    //  Handlers
    //
    //--------------------------------------------------------------------------

    private function statusHandler(event:StatusEvent):void
    {
        switch (event.code)
        {
            case "CardIO.ScanForPayment.Complete" :

                    var info:CreditCard = new CreditCardDTO().toCreditCard(event.level);

                    dispatchEvent(new CardIOEvent(CardIOEvent.SCAN_COMPLETE, info));

                break;

            case "CardIO.ScanForPayment.Canceled" :

                    dispatchEvent(new Event(Event.CANCEL));

                break;

            case "CardIO.ScanForPayment.Failed" :

                    dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, event.level));

                break;
        }
    }
}
}
