package com.yuppablee.cardscan.functions;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.yuppablee.cardscan.activities.CardScanActivity;
import com.yuppablee.cardscan.helpers.ConversionRoutines;
import io.card.payment.CardIOActivity;

import java.util.Map;

/**
 * Created by Max Rozdobudko on 6/5/15.
 */
public class ScanForPaymentFunction implements FREFunction
{
    @Override
    public FREObject call(FREContext freContext, FREObject[] args)
    {
        Log.i("CardScan", "ScanForPayment");

        try
        {
            Activity activity = freContext.getActivity();

            Intent intent = new Intent(activity.getApplicationContext(), CardScanActivity.class);

            if (args != null && args.length > 0)
            {
                Map<String, Object> options = ConversionRoutines.convertCardScanOptionsToHashMap(args[0]);

                // guideColor

                if (options.containsKey("guideColor"))
                {
                    intent.putExtra(CardIOActivity.EXTRA_GUIDE_COLOR, (Integer) options.get("guideColor"));
                }

                // languageOrLocale

                if (options.containsKey("languageOrLocale"))
                {
                    intent.putExtra(CardIOActivity.EXTRA_LANGUAGE_OR_LOCALE, (String) options.get("languageOrLocale"));
                }

                // suppressScanConfirmation

                if (options.containsKey("suppressScanConfirmation"))
                {
                    intent.putExtra(CardIOActivity.EXTRA_SUPPRESS_CONFIRMATION, (Boolean) options.get("suppressScanConfirmation"));
                }

                // scanInstructions

                if (options.containsKey("scanInstructions"))
                {
                    intent.putExtra(CardIOActivity.EXTRA_SCAN_INSTRUCTIONS, (String) options.get("scanInstructions"));
                }

                // hideLogo

                if (options.containsKey("hideLogo"))
                {
                    intent.putExtra(CardIOActivity.EXTRA_HIDE_CARDIO_LOGO, (Boolean) options.get("hideLogo"));
                }

                // requireExpiry

                if (options.containsKey("requireExpiry"))
                {
                    intent.putExtra(CardIOActivity.EXTRA_REQUIRE_EXPIRY, (Boolean) options.get("requireExpiry"));
                }

                // requireCVV

                if (options.containsKey("requireCVV"))
                {
                    intent.putExtra(CardIOActivity.EXTRA_REQUIRE_CVV, (Boolean) options.get("requireCVV"));
                }

                // requirePostalCode

                if (options.containsKey("requirePostalCode"))
                {
                    intent.putExtra(CardIOActivity.EXTRA_REQUIRE_POSTAL_CODE, (Boolean) options.get("requirePostalCode"));
                }

                // scanExpiry

                if (options.containsKey("scanExpiry"))
                {
                    intent.putExtra(CardIOActivity.EXTRA_SCAN_EXPIRY, (Boolean) options.get("scanExpiry"));
                }

                // useCardIOLogo

                if (options.containsKey("useCardIOLogo"))
                {
                    intent.putExtra(CardIOActivity.EXTRA_USE_CARDIO_LOGO, (Boolean) options.get("useCardIOLogo"));
                }

                // suppressManualEntry

                if (options.containsKey("suppressManualEntry"))
                {
                    intent.putExtra(CardIOActivity.EXTRA_SUPPRESS_MANUAL_ENTRY, (Boolean) options.get("suppressManualEntry"));
                }

//                // detectionMode
//
//                if (options.containsKey("detectionMode"))
//                {
//                    intent.putExtra(CardIOActivity.MODE, (boolean) options.get("detectionMode"));
//                }

                // Android specific

                // EXTRA_NO_CAMERA

                if (options.containsKey(CardIOActivity.EXTRA_NO_CAMERA))
                {
                    intent.putExtra(CardIOActivity.EXTRA_NO_CAMERA, (Boolean) options.get(CardIOActivity.EXTRA_NO_CAMERA));
                }

                // EXTRA_SUPPRESS_SCAN

                if (options.containsKey(CardIOActivity.EXTRA_SUPPRESS_SCAN))
                {
                    intent.putExtra(CardIOActivity.EXTRA_SUPPRESS_SCAN, (Boolean) options.get(CardIOActivity.EXTRA_SUPPRESS_SCAN));
                }

                // EXTRA_USE_PAYPAL_ACTIONBAR_ICON

                if (options.containsKey(CardIOActivity.EXTRA_USE_PAYPAL_ACTIONBAR_ICON))
                {
                    intent.putExtra(CardIOActivity.EXTRA_USE_PAYPAL_ACTIONBAR_ICON, (Boolean) options.get(CardIOActivity.EXTRA_USE_PAYPAL_ACTIONBAR_ICON));
                }
                // EXTRA_KEEP_APPLICATION_THEME

                if (options.containsKey(CardIOActivity.EXTRA_KEEP_APPLICATION_THEME))
                {
                    intent.putExtra(CardIOActivity.EXTRA_KEEP_APPLICATION_THEME, (Boolean) options.get(CardIOActivity.EXTRA_KEEP_APPLICATION_THEME));
                }
            }

            intent.putExtra(CardScanActivity.EXTRA_REQUEST_CODE, CardScanActivity.SCAN_FOR_PAYMENT_REQUEST_CODE);

            activity.startActivity(intent);
        }
        catch (Exception error)
        {
            error.printStackTrace();
        }

        return null;
    }
}
