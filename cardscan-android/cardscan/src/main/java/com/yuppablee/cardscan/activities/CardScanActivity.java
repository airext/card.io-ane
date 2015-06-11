package com.yuppablee.cardscan.activities;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import com.yuppablee.cardscan.CardScan;
import com.yuppablee.cardscan.helpers.ConversionRoutines;
import io.card.payment.CardIOActivity;
import io.card.payment.CreditCard;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * Created by Max Rozdobudko on 6/5/15.
 */
public class CardScanActivity extends Activity
{
    public static final String EXTRA_REQUEST_CODE = "requestCode";

    public static final int DEFAULT_REQUEST_CODE = 0;

    public static final int SCAN_FOR_PAYMENT_REQUEST_CODE = 1001;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        Intent intent = new Intent(this, CardIOActivity.class);

        intent.putExtras(this.getIntent().getExtras());

        int requestCode = this.getIntent().getIntExtra(EXTRA_REQUEST_CODE, DEFAULT_REQUEST_CODE);

        startActivityForResult(intent, requestCode);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == SCAN_FOR_PAYMENT_REQUEST_CODE)
        {
            String resultDisplayStr;

            if (data != null && data.hasExtra(CardIOActivity.EXTRA_SCAN_RESULT))
            {
                try
                {
                    CreditCard scanResult = data.getParcelableExtra(CardIOActivity.EXTRA_SCAN_RESULT);

                    JSONObject json = ConversionRoutines.convertCreditCardToObject(scanResult);

                    CardScan.getContext().dispatchStatusEventAsync("CardScan.ScanForPayment.Complete", json.toString());
                }
                catch (JSONException e)
                {
                    CardScan.getContext().dispatchStatusEventAsync("CardScan.ScanForPayment.Failed", e.toString());

                    e.printStackTrace();
                }
            }
            else
            {
                CardScan.getContext().dispatchStatusEventAsync("CardScan.ScanForPayment.Canceled", "status");
            }
        }

        finish();
    }
}
