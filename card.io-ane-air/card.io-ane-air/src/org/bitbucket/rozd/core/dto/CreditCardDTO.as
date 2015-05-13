/**
 * Created by Max Rozdobudko on 5/13/15.
 */
package org.bitbucket.rozd.core.dto
{
import org.bitbucket.rozd.data.CreditCard;

public class CreditCardDTO
{
    public function CreditCardDTO()
    {
    }

    public function toCreditCard(json:String):CreditCard
    {
        var dto:Object = JSON.parse(json);

        var info:CreditCard = new CreditCard();
        info.redactedCardNumber = dto.redactedCardNumber;
        info.cardNumber = dto.cardNumber;
        info.expiryMonth = dto.expiryMonth;
        info.expiryYear = dto.expiryYear;

        return info;
    }
}
}
