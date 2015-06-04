package com.yuppablee.cardscan;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/**
 * Created by Max Rozdobudko on 5/22/15.
 */
public class CardScan implements FREExtension
{

    @Override
    public void initialize()
    {

    }

    @Override
    public FREContext createContext(String s)
    {
        return new ExtensionContext();
    }

    @Override
    public void dispose()
    {

    }
}
