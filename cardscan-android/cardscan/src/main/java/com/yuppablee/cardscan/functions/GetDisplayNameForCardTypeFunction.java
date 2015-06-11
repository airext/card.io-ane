package com.yuppablee.cardscan.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.yuppablee.cardscan.helpers.ConversionRoutines;
import io.card.payment.CardType;

/**
 * Created by Max Rozdobudko on 6/9/15.
 */
public class GetDisplayNameForCardTypeFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] args)
    {
        try
        {
            CardType cardType = ConversionRoutines.convertFREObjectToCardType(args[0]);

            String languageOrLocale = args[1].getAsString();

            String displayName = cardType.getDisplayName(languageOrLocale);

            return FREObject.newObject(displayName);
        }
        catch (Exception e)
        {
            e.printStackTrace();

            return  null;
        }
    }
}
