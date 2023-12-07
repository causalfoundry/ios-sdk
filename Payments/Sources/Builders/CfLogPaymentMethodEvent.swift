//
//  CfLogPaymentMethodEvent.swift
//
//
//  Created by khushbu on 02/11/23.
//
#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public class CfLogPaymentMethodEvent {
    /**
     * CfLogPaymentMethodEvent is to log events for payments. Which method of the payment is
     * selected for the order.
     */
    var order_id: String?
    var payment_method: String?
    var payment_amount: Float?
    var currency_value: String?
    var meta: Any?
    var update_immediately: Bool = CoreConstants.shared.updateImmediately
    private var paymentMethodObject: PaymentMethodObject?

    public init() {}

    /**
     * setOrderId is required to set the id for the order in log, Id should be in string
     * and must be in accordance to the catalog provided.
     */

    @discardableResult
    public func setOrderId(order_id: String) -> CfLogPaymentMethodEvent {
        self.order_id = order_id
        return self
    }

    /**
     * setPaymentMethod is required to set the type of the payment is being selected
     */
    @discardableResult
    public func setPaymentMethod(payment_method: PaymentMethod) -> CfLogPaymentMethodEvent {
        self.payment_method = payment_method.rawValue
        return self
    }

    @discardableResult
    public func setPaymentMethod(payment_method: String) -> CfLogPaymentMethodEvent {
        if CoreConstants.shared.enumContains(PaymentMethod.self, name: payment_method) {
            self.payment_method = payment_method
        } else {
            ExceptionManager.throwEnumException(
                eventType: PaymentsEventType.payment_method.rawValue,
                className: String(describing: PaymentMethod.self)
            )
        }
        return self
    }

    /**
     * setCurrency is required to log the currency for for the payment logged. Currency should
     * be in ISO 4217 format. For ease, SDK provides the enums to log the currency so that it
     * would be easy to log. You can also use the string function to provide the currency.
     * Below is the function for the logging currency using enum CurrencyCode.
     */

    @discardableResult
    public func setCurrency(currency: String) -> CfLogPaymentMethodEvent {
        if !currency.isEmpty {
            if CoreConstants.shared.enumContains(InternalCurrencyCode.self, name: currency) {
                currency_value = currency
            } else {
                ExceptionManager.throwEnumException(
                    eventType: PaymentsEventType.payment_method.rawValue,
                    className: "InternalCurrencyCode"
                )
            }
        }
        return self
    }

    @discardableResult
    public func setPaymentAmount(payment_amount: Float) -> CfLogPaymentMethodEvent {
        self.payment_amount = ((payment_amount * 100.0).rounded() / 100.0)
        return self
    }

    /**
     * setPaymentAmount is required to log the total price of the payment being logged. Amount
     * format should be in accordance to the currency selected.
     */
    @discardableResult
    public func setPaymentAmount(payment_amount: Int?) -> CfLogPaymentMethodEvent {
        if let amount = payment_amount {
            self.payment_amount = Float(amount)
        }
        return self
    }

    @discardableResult
    public func setPaymentAmount(payment_amount: Double) -> CfLogPaymentMethodEvent {
        self.payment_amount = Float((payment_amount * 100.0).rounded() / 100.0)
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */

    @discardableResult
    public func setMeta(meta: Any?) -> CfLogPaymentMethodEvent {
        self.meta = meta
        return self
    }

    /**
     * updateImmediately is responsible for updating the values ot the backend immediately.
     * By default this is set to false or whatever the developer has set in the SDK
     * initialisation block. This differs the time for which the logs will be logged, if true,
     * the SDK will log the content instantly and if false it will wait till the end of user
     * session which is whenever the app goes into background.
     */

    @discardableResult
    public func updateImmediately(update_immediately: Bool) -> CfLogPaymentMethodEvent {
        self.update_immediately = update_immediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        /**
         * Will throw and exception if the orderId provided is null or no value is
         * provided at all.
         */
        guard let order_id = order_id else {
            ExceptionManager.throwIsRequiredException(
                eventType: PaymentsEventType.payment_method.rawValue,
                elementName: "order_id"
            )
            return
        }
        /**
         * Will throw and exception if the payment method Type provided is null or no value is
         * provided at all.
         */
        guard let payment_method = payment_method else {
            ExceptionManager.throwIsRequiredException(
                eventType: PaymentsEventType.payment_method.rawValue,
                elementName: String(describing: PaymentMethod.self)
            )
            return
        }
        /**
         * Will throw and exception if the payment_amount provided is null or no value is
         * provided at all.
         */
        guard let payment_amount = payment_amount else {
            ExceptionManager.throwIsRequiredException(
                eventType: PaymentsEventType.payment_method.rawValue,
                elementName: "payment_amount"
            )
            return
        }
        /**
         * Will throw and exception if the currency provided is null or no value is
         * provided at all.
         */
        guard let currency_value = currency_value else {
            ExceptionManager.throwIsRequiredException(
                eventType: PaymentsEventType.payment_method.rawValue,
                elementName: String(describing: InternalCurrencyCode.self)
            )
            return
        }
        /**
         * Parsing the values into an object and passing to the setup block to queue
         * the event based on its priority.
         */

        paymentMethodObject = PaymentMethodObject(order_id: order_id, type: payment_method, payment_amount: payment_amount, currency: currency_value, usd_rate: nil, meta: meta as? Encodable)

        if currency_value == InternalCurrencyCode.USD.rawValue {
            paymentMethodObject?.usd_rate = 1.0
            CFSetup().track(
                contentBlockName: PaymentsConstants.contentBlockName,
                eventType: PaymentsEventType.payment_method.rawValue,
                logObject: paymentMethodObject,
                updateImmediately: update_immediately
            )
        } else {
            let value = CFSetup().getUSDRate(fromCurrency: currency_value)
            self.paymentMethodObject?.usd_rate = value
            CFSetup().track(
                contentBlockName: PaymentsConstants.contentBlockName,
                eventType: PaymentsEventType.deferred_payment.rawValue,
                logObject: self.paymentMethodObject,
                updateImmediately: self.update_immediately
            )
        }
    }

    private func getUSDRateAndLogEvent(usdRate: Float) {
        paymentMethodObject?.usd_rate = usdRate
        CFSetup().track(
            contentBlockName: PaymentsConstants.contentBlockName,
            eventType: PaymentsEventType.payment_method.rawValue,
            logObject: paymentMethodObject,
            updateImmediately: update_immediately
        )
    }
}
