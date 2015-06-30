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

    /**
     * Returns card.io library version.
     *
     * @return Human-readable version of card.io library.
     */
    public static function get libraryVersion():String
    {
        return context.call("libraryVersion") as String;
    }

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  isSupported
    //-------------------------------------

    /**
     * Indicates it CardScan extension is supported on current platform.
     *
     * @return @return <code>true</code> if extension is supported. <code>false</code> otherwise.
     */
    public static function isSupported():Boolean
    {
        return context != null && context.call("isSupported");
    }

    //-------------------------------------
    //  preload
    //-------------------------------------

    /**
     * <i>iOS</i>:
     * The preload method prepares card.io to launch faster. Calling preload is optional but suggested.
     * On an iPhone 5S, for example, preloading makes card.io launch ~400ms faster.
     * The best time to call preload is when displaying a view from which card.io might be launched;
     * e.g., inside your view controller's viewWillAppear: method.
     * preload works in the background; the call to preload returns immediately.
     *
     * <br />
     *
     * <i>Android</i>: Does nothing.
     */
    public static function preload():void
    {
        context.call("preload");
    }

    /**
     * <i>iOS</i>:
     * Determine whether this device supports camera-based card scanning, considering
     * factors such as hardware support and OS version.
     * card.io automatically provides manual entry of cards as a fallback,
     * so it is not typically necessary for your app to check this.
     *
     * <br />
     *
     * <i>Android</i>:
     * Determine if the device supports card scanning.
     * <br><br>
     * An ARM7 processor and Android SDK 8 or later are required. Additional checks for specific
     * misbehaving devices may also be added.
     *
     * @return <code>true</code> if camera is supported. <code>false</code> otherwise.
     */
    public static function canReadCardWithCamera():Boolean
    {
        return context.call("canReadCardWithCamera");
    }

    //-------------------------------------
    //  sharedInstance
    //-------------------------------------

    private static var instance:CardScan;

    /**
     * @return Shared instance.
     */
    public static function sharedInstance():CardScan
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

    /**
     * Initiates scan process.
     *
     * <i>iOS</i>:
     * Starts scan with CardIOPaymentViewController
     *
     * <br />
     *
     * <i>Android</i>:
     * Starts scan with CardIOActivity
     *
     * @param options
     */
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
