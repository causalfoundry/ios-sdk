//
//  CfLogScheduleDeliveryEvent.swift
//
//
//  Created by khushbu on 01/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public class CfLogScheduleDeliveryEvent {
    /**
     * CfLogScheduleDeliveryEvent is used to log the status for the delivery. It can be used to log the
     * delivered status of the order or a partial order. Details about the items in the specific
     * delivery should be provided in the catalog.
     */
    var orderId: String = ""
    var isUrgent: Bool = false
    var action: String = ""
    var deliveryTs: Int64 = 0
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setOrderId is required to associate the delivery event with the order. OrderId
     * should be a valid orderId and can be tracked from the checkout.
     */
    @discardableResult
    public func setOrderId(orderId: String) -> CfLogScheduleDeliveryEvent {
        self.orderId = orderId
        return self
    }

    /**
     * isUrgent is to mark the log if the delivery is scheduled to be an immediate or emergency
     * delivery.
     */

    @discardableResult
    public func isUrgent(isUrgent: Bool) -> CfLogScheduleDeliveryEvent {
        self.isUrgent = isUrgent
        return self
    }

    /**
     * setScheduleDeliveryAction is required to set the delivery action for the log. For the order
     * being prepared for delivery that if the item is being scheduled or updated in terms of
     * delivery elements
     */
    @discardableResult
    public func setScheduleDeliveryAction(action: ScheduleDeliveryAction) -> CfLogScheduleDeliveryEvent {
        self.action = action.rawValue
        return self
    }

    @discardableResult
    public func setScheduleDeliveryAction(action: String) -> CfLogScheduleDeliveryEvent {
        if CoreConstants.shared.enumContains(ScheduleDeliveryAction.self, name: action) {
            self.action = action
        } else {
            ExceptionManager.throwEnumException(
                eventType: EComEventType.scheduleDelivery.rawValue,
                className: String(describing: ScheduleDeliveryAction.self)
            )
        }
        return self
    }

    /**
     * The timestamp in time in milliseconds format for the date and time for which the
     * delivery is set to be scheduled
     */

    @discardableResult
    public func setDeliveryDateTime(deliveryTs: Int64) -> CfLogScheduleDeliveryEvent {
        self.deliveryTs = deliveryTs
        return self
    }

    @discardableResult
    public func setDeliveryDateTime(deliveryTsString: String) -> CfLogScheduleDeliveryEvent {
        if let deliveryTs = Int64(deliveryTsString) {
            self.deliveryTs = deliveryTs
        } else {
            ExceptionManager.throwRuntimeException(
                eventType: EComEventType.scheduleDelivery.rawValue,
                message: "Unable to convert \(deliveryTsString) to Int64"
            )
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(meta: Any?) -> CfLogScheduleDeliveryEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogScheduleDeliveryEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */

    public func build() {
        
        
        if orderId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.cart.rawValue, elementName: "orderId")
            return
        }else if action.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.cart.rawValue, elementName: "action")
            return
        }else if (deliveryTs < 1) {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.cart.rawValue, elementName: "delivery_ts")
            return
        }

        if deliveryTs < Int64((Date().timeIntervalSince1970 * 1000)-10000) {
            ExceptionManager.throwIllegalStateException(
                eventType: EComEventType.scheduleDelivery.rawValue,
                message: "Scheduled time should be in the future", className: String(describing: CfLogScheduleDeliveryEvent.self)
            )
            return
        }

        let scheduleDeliveryObject = ScheduleDeliveryObject(
            orderId: orderId,
            action: action,
            deliveryTimestamp: ECommerceConstants.getDateTime(milliSeconds: deliveryTs),
            isUrgentDelivery: isUrgent,
            meta: meta as? Encodable
        )

        CFSetup().track(
            contentBlockName: ECommerceConstants.contentBlockName,
            eventType: EComEventType.scheduleDelivery.rawValue,
            logObject: scheduleDeliveryObject, updateImmediately: updateImmediately
        )
    }
}
