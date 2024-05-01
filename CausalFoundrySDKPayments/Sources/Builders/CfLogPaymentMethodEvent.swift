//
//  CfLogPaymentMethodEvent.swift
//
//
//  Created by khushbu on 02/11/23.
//
import CausalFoundrySDKCore
import Foundation

public class CfLogPaymentMethodEvent {
    /**
     * CfLogPaymentMethodEvent is to log events for payments. Which method of the payment is
     * selected for the order.
     */
    var orderId: String = ""
    var paymentId: String = ""
    var paymentMethod: String = ""
    var paymentAction: String = ""
    var paymentAmount: Float?
    var currencyValue: String = ""
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setOrderId is required to set the id for the order in log, Id should be in string
     * and must be in accordance to the catalog provided.
     */

    @discardableResult
    public func setOrderId(orderId: String) -> CfLogPaymentMethodEvent {
        self.orderId = orderId
        return self
    }
    
    @discardableResult
    public func setPaymentId(paymentId: String) -> CfLogPaymentMethodEvent {
        self.paymentId = paymentId
        return self
    }
    
    /**
     * setPaymentAction is used to specify the action performed on the payments screen,
     * there can be multiple types of actions that can include init payment process, cancel
     * payment processing or upload receipt to bank deposit. By default SDK provides enum
     * class to use as PaymentAction. Below function can be used to set action using enum.
     */

    @discardableResult
    public func setPaymentAction(action: PaymentAction) -> CfLogPaymentMethodEvent {
        self.paymentAction = action.rawValue
        return self
    }

    @discardableResult
    public func setPaymentAction(action: String) -> CfLogPaymentMethodEvent {
        if CoreConstants.shared.enumContains(PaymentAction.self, name: action) {
            self.paymentAction = action
        } else {
            ExceptionManager.throwEnumException(eventType: PaymentsEventType.payment_method.rawValue, className: String(describing: PaymentAction.self))
        }
        return self
    }
    
    /**
     * setPaymentMethod is required to set the type of the payment is being selected
     */
    @discardableResult
    public func setPaymentMethod(paymentMethod: PaymentMethod) -> CfLogPaymentMethodEvent {
        self.paymentMethod = paymentMethod.rawValue
        return self
    }

    @discardableResult
    public func setPaymentMethod(paymentMethod: String) -> CfLogPaymentMethodEvent {
        if CoreConstants.shared.enumContains(PaymentMethod.self, name: paymentMethod) {
            self.paymentMethod = paymentMethod
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
    public func setCurrency(currencyValue: String) -> CfLogPaymentMethodEvent {
        if !currencyValue.isEmpty {
            if CoreConstants.shared.enumContains(CurrencyCode.self, name: currencyValue) {
                self.currencyValue = currencyValue
            } else {
                ExceptionManager.throwEnumException(
                    eventType: PaymentsEventType.payment_method.rawValue,
                    className: "CurrencyCode"
                )
            }
        }
        return self
    }

    @discardableResult
    public func setPaymentAmount(paymentAmount: Float) -> CfLogPaymentMethodEvent {
        self.paymentAmount = ((paymentAmount * 100.0).rounded() / 100.0)
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogPaymentMethodEvent {
        self.updateImmediately = updateImmediately
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
        if orderId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.payment_method.rawValue, elementName: "order_id")
            return
        }else if paymentId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.payment_method.rawValue, elementName: "payment_id")
            return
        }else if paymentMethod.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.payment_method.rawValue, elementName: String(describing: PaymentMethod.self))
            return
        }else if paymentAmount == nil {
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.payment_method.rawValue, elementName: "payment_amount")
            return
        }else if currencyValue.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.payment_method.rawValue, elementName: String(describing: CurrencyCode.self))
            return
        }else if paymentAction.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: PaymentsEventType.payment_method.rawValue, elementName: "payment_action")
            return
        }
        
        let paymentMethodObject = PaymentMethodObject(paymentId: paymentId, orderId: orderId, type: paymentMethod, action: paymentAction, paymentAmount: paymentAmount!, currency: currencyValue, meta: meta as? Encodable)
        CFSetup().track(
            contentBlockName: PaymentsConstants.contentBlockName,
            eventType: PaymentsEventType.payment_method.rawValue,
            logObject: paymentMethodObject,
            updateImmediately: updateImmediately
        )
    }

}
