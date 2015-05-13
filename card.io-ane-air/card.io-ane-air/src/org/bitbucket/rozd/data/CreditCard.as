/**
 * Created by Max Rozdobudko on 5/12/15.
 */
package org.bitbucket.rozd.data
{
public class CreditCard
{
    public function CreditCard()
    {
    }

    public var cardNumber:String;

    public var redactedCardNumber:String;

    public var expiryMonth:Number;

    public var expiryYear:Number;

    public function toString():String
    {
        return '[CreditCard ' +
                'cardNumber="' + cardNumber + '"' +
                'redactedCardNumber="' + redactedCardNumber + '"' +
                'expiryMonth="' + expiryMonth + '"' +
                'expiryYear="' + expiryYear + '"' + ']';
    }
}
}
