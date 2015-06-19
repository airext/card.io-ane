/**
 * Created by Max Rozdobudko on 5/8/15.
 */
package com.yuppablee.cardscan
{
import com.yuppablee.cardscan.data.CardScanOptions;

import flash.events.ErrorEvent;
import flash.events.Event;

import flash.events.EventDispatcher;

import flash.events.StatusEvent;

import flash.external.ExtensionContext;

import com.yuppablee.cardscan.core.card_scan;
import com.yuppablee.cardscan.core.assembler.CreditCardDTO;
import com.yuppablee.cardscan.data.CreditCard;
import com.yuppablee.cardscan.events.CardScanEvent;

use namespace card_scan;

[Event(name="scanComplete", type="com.yuppablee.cardscan.events.CardScanEvent")]

[Event(name="cancel", type="flash.events.Event")]

[Event(name="error", type="flash.events.ErrorEvent")]

public class CardScan extends EventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    card_scan static const EXTENSION_ID:String = "com.yuppablee.cardscan";

    //--------------------------------------------------------------------------
    //
    //  Class properties
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  context
    //-------------------------------------

    private static var _context:ExtensionContext;

    card_scan static function get context():ExtensionContext
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

    private static var instance:CardScan;

    public static function getInstance():CardScan
    {
        if (instance == null)
        {
            new CardScan();
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

    public function CardScan()
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

    public function scanForPayment(options:CardScanOptions):void
    {
        context.call("scanForPayment", options ? options.toDTO() : null);
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
            case "CardScan.ScanForPayment.Complete" :

                    var info:CreditCard = new CreditCardDTO().toCreditCard(event.level);

                    dispatchEvent(new CardScanEvent(CardScanEvent.SCAN_COMPLETE, info));

                break;

            case "CardScan.ScanForPayment.Canceled" :

                    dispatchEvent(new Event(Event.CANCEL));

                break;

            case "CardScan.ScanForPayment.Failed" :

                    dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, event.level));

                break;
        }
    }
}
}
