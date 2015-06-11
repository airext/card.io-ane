package com.yuppablee.cardscan.helpers;

import android.graphics.Bitmap;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.adobe.fre.*;
import io.card.payment.CardIOActivity;
import io.card.payment.CardType;
import io.card.payment.CreditCard;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Max Rozdobudko on 6/8/15.
 */
public class ConversionRoutines
{
    public static JSONObject convertCreditCardToObject(CreditCard card) throws JSONException
    {
        JSONObject result = new JSONObject();

        result.put("cardNumber", card.cardNumber);
        result.put("redactedCardNumber", card.getRedactedCardNumber());
        result.put("cvv", card.cvv);
        result.put("postalCode", card.postalCode);
//        result.put("scanned", card.scanned);
        result.put("cardType", convertCreditCardTypeToString(card.getCardType()));
        result.put("expiryMonth", card.expiryMonth);
        result.put("expiryYear", card.expiryYear);

        return result;
    }

    @NonNull
    public static String convertCreditCardTypeToString(CardType cardType)
    {
        switch (cardType)
        {
            case AMEX: return "AmEx";

            case DINERSCLUB: return "DinersClub";

            case DISCOVER: return "Discover";

            case JCB: return "JCB";

            case MASTERCARD : return "Mastercard";

            case VISA: return "Visa";

            case INSUFFICIENT_DIGITS: return "Ambiguous";

            case UNKNOWN: default: return "Unknown";

        }
    }

    @NonNull
    public static CardType convertFREObjectToCardType(FREObject object)
    {
        try
        {
            String name = object.getAsString();

            if (name == "Ambiguous")
            {
                return CardType.INSUFFICIENT_DIGITS;
            }
            else
            {
                return CardType.fromString(name);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();

            return CardType.UNKNOWN;
        }
    }

    public static FREObject convertBitmapToFREBitmapData(Bitmap image)
    {
        Byte[] fillColor = {0,0,0,0};

        try
        {
            FREBitmapData bmd = FREBitmapData.newBitmapData(image.getWidth(), image.getHeight(), true, fillColor);

            bmd.acquire();
            image.copyPixelsToBuffer(bmd.getBits());
            bmd.release();

            return bmd;
        }
        catch (Exception e)
        {
            e.printStackTrace();

            return null;
        }
    }

    public static Map<String, Object> convertCardScanOptionsToHashMap(FREObject options)
    {
        HashMap<String, Object> map = new HashMap<String, Object>();

        // guideColor

        try
        {
            FREObject guideColor = options.getProperty("guideColor");

            map.put("guideColor", guideColor.getAsInt());
        }
        catch (Exception e) {}

        // languageOrLocale

        try
        {
            FREObject languageOrLocale = options.getProperty("languageOrLocale");

            map.put("languageOrLocale", languageOrLocale.getAsString());
        }
        catch (Exception e) {}

        // suppressScanConfirmation

        try
        {
            FREObject suppressScanConfirmation = options.getProperty("suppressScanConfirmation");

            map.put("suppressScanConfirmation", suppressScanConfirmation.getAsBool());
        }
        catch (Exception e) {}

        // scanInstructions

        try
        {
            FREObject scanInstructions = options.getProperty("scanInstructions");

            map.put("scanInstructions", scanInstructions.getAsString());
        }
        catch (Exception e) {}

        // hideLogo

        try
        {
            FREObject hideLogo = options.getProperty("hideLogo");

            map.put("hideLogo", hideLogo.getAsBool());
        }
        catch (Exception e) {}

        // requireExpiry

        try
        {
            FREObject requireExpiry = options.getProperty("requireExpiry");

            map.put("requireExpiry", requireExpiry.getAsBool());
        }
        catch (Exception e) {}

        // requireCVV

        try
        {
            FREObject requireCVV = options.getProperty("requireCVV");

            map.put("requireCVV", requireCVV.getAsBool());
        }
        catch (Exception e) {}

        // requirePostalCode

        try
        {
            FREObject requirePostalCode = options.getProperty("requirePostalCode");

            map.put("requirePostalCode", requirePostalCode.getAsBool());
        }
        catch (Exception e) {}

        // scanExpiry

        try
        {
            FREObject scanExpiry = options.getProperty("scanExpiry");

            map.put("scanExpiry", scanExpiry.getAsBool());
        }
        catch (Exception e) {}

        // useCardIOLogo

        try
        {
            FREObject useCardIOLogo = options.getProperty("useCardIOLogo");

            map.put("useCardIOLogo", useCardIOLogo.getAsBool());
        }
        catch (Exception e) {}

        // suppressManualEntry

        try
        {
            FREObject suppressManualEntry = options.getProperty("suppressManualEntry");

            map.put("suppressManualEntry", suppressManualEntry.getAsBool());
        }
        catch (Exception e) {}

//                // detectionMode
//
//                FREObject detectionMode = options.getProperty("detectionMode");
//
//                if (detectionMode != null)
//                {
//                    intent.putExtra(CardIOActivity.MODE, hideLogo.getAsBool());
//                }

        // Android specific

        // EXTRA_NO_CAMERA

        try
        {
            map.put(CardIOActivity.EXTRA_NO_CAMERA, options.getProperty(CardIOActivity.EXTRA_NO_CAMERA).getAsBool());
        }
        catch (Exception e) {}

        // EXTRA_SUPPRESS_SCAN

        try
        {
            map.put(CardIOActivity.EXTRA_SUPPRESS_SCAN, options.getProperty(CardIOActivity.EXTRA_SUPPRESS_SCAN).getAsBool());
        }
        catch (Exception e) {}

        // EXTRA_USE_PAYPAL_ACTIONBAR_ICON

        try
        {
            map.put(CardIOActivity.EXTRA_USE_PAYPAL_ACTIONBAR_ICON, options.getProperty(CardIOActivity.EXTRA_USE_PAYPAL_ACTIONBAR_ICON).getAsBool());
        }
        catch (Exception e) {}

        // EXTRA_KEEP_APPLICATION_THEME

        try
        {
            map.put(CardIOActivity.EXTRA_KEEP_APPLICATION_THEME, options.getProperty(CardIOActivity.EXTRA_KEEP_APPLICATION_THEME).getAsBool());
        }
        catch (Exception e) {}

        return map;
    }
}
