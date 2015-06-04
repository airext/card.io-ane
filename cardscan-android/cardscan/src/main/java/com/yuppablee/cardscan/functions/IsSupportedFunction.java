package com.yuppablee.cardscan.functions;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import io.card.payment.CardIOActivity;
import io.card.payment.CardType;

/**
 * Created by Max Rozdobudko on 5/25/15.
 */
public class IsSupportedFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] freObjects)
    {
        try
        {
            return FREObject.newObject(CardIOActivity.class != null);
        }
        catch (FREWrongThreadException e)
        {
            e.printStackTrace();
        }

        return null;
    }
}
