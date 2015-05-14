/**
 * Created by Max Rozdobudko on 5/13/15.
 */
package org.bitbucket.rozd.core.dto
{
import org.bitbucket.rozd.core.card_io;
import org.bitbucket.rozd.data.CreditCard;
import org.bitbucket.rozd.data.CreditCardType;

use namespace card_io;

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
