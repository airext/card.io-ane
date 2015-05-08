/**
 * Created by Max Rozdobudko on 5/8/15.
 */
package org.bitbucket.rozd
{
import flash.external.ExtensionContext;

import org.bitbucket.rozd.core.card_io;

use namespace card_io;

public class CardIO
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

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function CardIO()
    {
        super();
    }

}
}
