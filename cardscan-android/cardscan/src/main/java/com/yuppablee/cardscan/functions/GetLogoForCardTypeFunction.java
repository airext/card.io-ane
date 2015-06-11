package com.yuppablee.cardscan.functions;

import android.graphics.Bitmap;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.yuppablee.cardscan.helpers.ConversionRoutines;
import io.card.payment.CardType;

/**
 * Created by Max Rozdobudko on 6/9/15.
 */
public class GetLogoForCardTypeFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] args)
    {
        CardType cardType = ConversionRoutines.convertFREObjectToCardType(args[0]);

        Bitmap bmp = cardType.imageBitmap(freContext.getActivity().getApplicationContext());

        return ConversionRoutines.convertBitmapToFREBitmapData(bmp);
    }
}
