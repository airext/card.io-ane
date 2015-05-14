/**
 * Created by Max Rozdobudko on 5/13/15.
 */
package com.yuppablee.cardscan.core.assembler
{
import com.yuppablee.cardscan.core.card_scan;
import com.yuppablee.cardscan.data.CreditCard;
import com.yuppablee.cardscan.data.CreditCardType;

use namespace card_scan;

public class CreditCardDTO
{
    public function CreditCardDTO()
    {
        super();
    }

    public function toCreditCard(json:String):CreditCard
    {
        var dto:Object = JSON.parse(json);

        var info:CreditCard = new CreditCard();
        info.redactedCardNumber = dto.redactedCardNumber;
        info.cardNumber = dto.cardNumber;
        info.expiryMonth = dto.expiryMonth;
        info.expiryYear = dto.expiryYear;
        info.cvv = dto.cvv;
        info.postalCode = dto.postalCode;
        info.scanned = dto.scanned;
        info.cardType = CreditCardType.toCreditCardType(dto.cardType);

        return info;
    }
}
}
