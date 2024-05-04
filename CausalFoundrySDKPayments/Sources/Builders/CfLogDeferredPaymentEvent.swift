//
//  CfLogDeferredPaymentEvent.swift
//
//
//  Created by khushbu on 02/11/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogDeferredPaymentEvent {
    /**
     * CfLogPaymentMethodEvent is to log events for payments. Which method of the payment is
     * selected for the order.
     */

    var orderId: String = ""
    var paymentId: String = ""
    var action: String = ""
    var paymentMethod: String = ""
    private var accountBalance: Float?
    var paymentAmount: Float?
    var currencyValue: String = ""
    private var isSuccessful: Bool = true
    private var meta: Any?
    private var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {} /**
     * setOrderId is required to set the id for the order in log, Id should be in string
     * and must be in accordance to the catalog provided.
     */
    @discardableResult
    public func setOrderId(orderId: String) -> CfLogDeferredPaymentEvent {
        self.orderId = orderId
        return self
    }

    /**
     * setPaymentId is required to set the id for the payment in log, Id should be in string
     * and must be in accordance to the catalog provided.
     */
    @discardableResult
    public func setPaymentId(paymentId: String) -> CfLogDeferredPaymentEvent {
        self.paymentId = paymentId
        return self
    }

    /**
     * setPaymentMethod is required to set the type of the payment is being selected
     */
    @discardableResult
    public func setPaymentMethod(paymentMethod: PaymentMethod) -> CfLogDeferredPaymentEvent {
        self.paymentMethod = paymentMethod.rawValue
        return self
    }

    @discardableResult
    public func setPaymentMethod(paymentMethod: String) -> CfLogDeferredPaymentEvent {
        if CoreConstants.shared.enumContains(PaymentMethod.self, name: paymentMethod) {
            self.paymentMethod = paymentMethod
        } else {
            ExceptionManager.throwEnumException(eventType: PaymentsEventType.deferred_payment.rawValue, className: String(describing: PaymentMethod.self))
        }
        return self
    }

    /**
     * setPaymentAction is used to specify the action performed on the payments screen,
     * there can be multiple types of actions that can include init payment process, cancel
     * payment processing or upload receipt to bank deposit. By default SDK provides enum
     * class to use as PaymentAction. Below function can be used to set action using enum.
     */

    @discardableResult
    public func setPaymentAction(action: PaymentAction) -> CfLogDeferredPaymentEvent {
        self.action = action.rawValue
        return self
    }

    @discardableResult
    public func setPaymentAction(action: String) -> CfLogDeferredPaymentEvent {
        if CoreConstants.shared.enumContains(PaymentAction.self, name: action) {
            self.action = action
        } else {
            ExceptionManager.throwEnumException(eventType: PaymentsEventType.deferred_payment.rawValue, className: String(describing: PaymentAction.self))
        }
        return self
    }

    /**
     * setCurrency is required to log the currency for for the payment logged. Currency should
     * be in ISO 4217 format. For Ease, SDK provides the enums to log the currency so that it
     * would be easy to log. You can also use the string function to provide the currency.
     * Below is the function for the logging currency using String. Remember to use the same
     * strings as provided in the enums or else the event will be discarded.
     */
    @discardableResult
    public func setCurrency(currency: String) -> CfLogDeferredPaymentEvent {
        if CoreConstants.shared.enumContains(CurrencyCode.self, name: currency) {
            currencyValue = currency
        } else {
            ExceptionManager.throwEnumException(eventType: PaymentsEventType.deferred_payment.rawValue, className: "currency")
        }
        return self
    }

    /**
     * setAccountBalance is required to log the current balance of the user. Amount format
     * should be in accordance to the currency selected.
     */
    @discardableResult
    public func setAccountBalance(accountBalance: Float) -> CfLogDeferredPaymentEvent {
        self.accountBalance = accountBalance
        return self
    }

    @discardableResult
    public func setAccountBalance(accountBalance: Int?) -> CfLogDeferredPaymentEvent {
        if let balance = accountBalance {
            self.accountBalance = Float(balance)
        }
        return self
    }

    @discardableResult
    public func setAccountBalance(accountBalance: Double) -> CfLogDeferredPaymentEvent {
        self.accountBalance = Float(accountBalance)
        return self
    }

    /**
     * setPaymentAmount is required to log the total price of the payment being logged. Amount format should be in accordance to the currency selected.
     */
    @discardableResult
    public func setPaymentAmount(paymentAmount: Float) -> CfLogDeferredPaymentEvent {
        self.paymentAmount = paymentAmount
        return self
    }

    @discardableResult
    public func setPaymentAmount(paymentAmount: Int?) -> CfLogDeferredPaymentEvent {
        if let amount = paymentAmount {
            self.paymentAmount = Float(amount)
        }
        return self
    }

    @discardableResult
    public func setPaymentAmount(paymentAmount: Double) -> CfLogDeferredPaymentEvent {
        self.paymentAmount = Float(paymentAmount)
        return self
    }

    /**
     * isSuccessful is required to log if the payment is processed successfully or not.
     */
    @discardableResult
    public func isSuccessful(isSuccessful: Bool) -> CfLogDeferredPaymentEvent {
        self.isSuccessful = isSuccessful
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(meta: Any?) -> CfLogDeferredPaymentEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogDeferredPaymentEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {

        if orderId.isEmpty{
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.deferred_payment.rawValue, elementName: "order_id")
            return
        }else if paymentId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.deferred_payment.rawValue, elementName: "payment_id")
            return
        }else if action.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.deferred_payment.rawValue, elementName: String(describing: PaymentAction.self))
            return
        }else if paymentMethod.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.deferred_payment.rawValue, elementName: String(describing: paymentMethod.self))
            return
        }else if currencyValue.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.deferred_payment.rawValue, elementName: "CurrencyCode")
            return
        }else if accountBalance == nil {
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.deferred_payment.rawValue, elementName: "account_balance")
            return
        }else if paymentAmount == nil {
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.deferred_payment.rawValue, elementName: "payment_amount")
            return
        }

        let paymentObject = DeferredPaymentObject(paymentId: paymentId, orderId: orderId, type: paymentMethod, action: action, accountBalance: accountBalance, paymentAmount: paymentAmount, currency: currencyValue, isSuccessful: isSuccessful, meta: meta as? Encodable)

        CFSetup().track(
            contentBlockName: PaymentsConstants.contentBlockName,
            eventType: PaymentsEventType.deferred_payment.rawValue,
            logObject: paymentObject,
            updateImmediately: self.updateImmediately)
    }
}
