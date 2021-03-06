package com.yuppablee.cardscan;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.yuppablee.cardscan.functions.*;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Max Rozdobudko on 5/25/15.
 */
public class ExtensionContext extends FREContext
{
    @Override
    public Map<String, FREFunction> getFunctions()
    {
        Map<String, FREFunction> functions = new HashMap<String, FREFunction>();

        functions.put("isSupported", new IsSupportedFunction());
        functions.put("libraryVersion", new LibraryVersionFunction());
        functions.put("canReadCardWithCamera", new CanReadCardWithCameraFunction());
        functions.put("preload", new PreloadFunction());

        functions.put("scanForPayment", new ScanForPaymentFunction());

        functions.put("getLogoForCardType", new GetLogoForCardTypeFunction());
        functions.put("getDisplayNameForCardType", new GetDisplayNameForCardTypeFunction());

        functions.put("getBlurredScreenImage", new GetBlurredScreenImageFunction());

        return functions;
    }

    @Override
    public void dispose()
    {

    }
}
