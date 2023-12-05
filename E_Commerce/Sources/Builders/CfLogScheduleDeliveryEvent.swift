//
//  CfLogScheduleDeliveryEvent.swift
//
//
//  Created by khushbu on 01/11/23.
//

import CasualFoundryCore
import Foundation

public class CfLogScheduleDeliveryEvent {
    /**
     * CfLogScheduleDeliveryEvent is used to log the status for the delivery. It can be used to log the
     * delivered status of the order or a partial order. Details about the items in the specific
     * delivery should be provided in the catalog.
     */
    var order_id: String?
    var is_urgent: Bool?
    var action: String?
    var delivery_ts: Int64?
    var meta: Any?
    var update_immediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setOrderId is required to associate the delivery event with the order. OrderId
     * should be a valid orderId and can be tracked from the checkout.
     */
    @discardableResult
    public func setOrderId(_ order_id: String) -> CfLogScheduleDeliveryEvent {
        var builder = self
        builder.order_id = order_id
        return self
    }

    /**
     * isUrgent is to mark the log if the delivery is scheduled to be an immediate or emergency
     * delivery.
     */

    @discardableResult
    public func isUrgent(_ is_urgent: Bool) -> CfLogScheduleDeliveryEvent {
        var builder = self
        builder.is_urgent = is_urgent
        return self
    }

    /**
     * setScheduleDeliveryAction is required to set the delivery action for the log. For the order
     * being prepared for delivery that if the item is being scheduled or updated in terms of
     * delivery elements
     */
    @discardableResult
    public func setScheduleDeliveryAction(_ action: ScheduleDeliveryAction) -> CfLogScheduleDeliveryEvent {
        var builder = self
        builder.action = action.rawValue
        return self
    }

    @discardableResult
    public func setScheduleDeliveryAction(_ action: String) -> CfLogScheduleDeliveryEvent {
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
    public func setDeliveryDateTime(_ delivery_ts: Int64) -> CfLogScheduleDeliveryEvent {
        var builder = self
        builder.delivery_ts = delivery_ts
        return self
    }

    @discardableResult
    public func setDeliveryDateTime(_ delivery_ts_string: String) -> CfLogScheduleDeliveryEvent {
        var builder = self
        if let deliveryTs = Int64(delivery_ts_string) {
            builder.delivery_ts = deliveryTs
        } else {
            ExceptionManager.throwRuntimeException(
                eventType: EComEventType.scheduleDelivery.rawValue,
                message: "Unable to convert \(delivery_ts_string) to Int64"
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
    public func setMeta(_ meta: Any?) -> CfLogScheduleDeliveryEvent {
        var builder = self
        builder.meta = meta
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
    public func updateImmediately(_ update_immediately: Bool) -> CfLogScheduleDeliveryEvent {
        var builder = self
        builder.update_immediately = update_immediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */

    public func build() {
        guard let order_id = order_id, let is_urgent = is_urgent, let action = action, let delivery_ts = delivery_ts else {
            ExceptionManager.throwIsRequiredException(
                eventType: EComEventType.scheduleDelivery.rawValue,
                elementName: "order_id, is_urgent, action, or delivery_ts"
            )
            return
        }

        if delivery_ts < Int64(Date().timeIntervalSince1970 - 10000) {
            ExceptionManager.throwIllegalStateException(
                eventType: EComEventType.scheduleDelivery.rawValue,
                message: "Scheduled time should be in the future", className: String(describing: CfLogScheduleDeliveryEvent.self)
            )
            return
        }

        let scheduleDeliveryObject = ScheduleDeliveryObject(
            orderId: order_id, isUrgent: is_urgent,
            action: action, deliveryTimestamp: ECommerceConstants.getDateTime(milliSeconds: delivery_ts),
            meta: meta as? Encodable
        )

        CFSetup().track(
            contentBlockName: ECommerceConstants.contentBlockName,
            eventType: EComEventType.scheduleDelivery.rawValue,
            logObject: scheduleDeliveryObject, updateImmediately: update_immediately
        )
    }
}
