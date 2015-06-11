package com.yuppablee.cardscan;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/**
 * Created by Max Rozdobudko on 5/22/15.
 */
public class CardScan implements FREExtension
{
    //--------------------------------------------------------------------------
    //
    //  Class properties
    //
    //--------------------------------------------------------------------------

    private static FREContext context;

    public static FREContext getContext()
    {
        return context;
    }
    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    @Override
    public void initialize()
    {

    }

    @Override
    public FREContext createContext(String s)
    {
        context = new ExtensionContext();

        return context;
    }

    @Override
    public void dispose()
    {

    }
}
