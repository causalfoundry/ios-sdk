//
//  CfLogDeliveryEvent.swift
//
//
//  Created by khushbu on 29/10/23.
//

import Foundation
import CausalFoundryCore

public class CfLogDeliveryEvent {
    
    /**
     * CfLogDeliveryEvent is used to log the status for the delivery. It can be used to log the
     * delivered status of the order or a partial order. Details about the items in the specific
     * delivery should be provided in the catalog.
     */
    var orderId: String?
    var deliveryId: String?
    var action: String?
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately
    
    
    public init() { }
    /**
     * setOrderId is required to associate the delivery event with the order. OrderId should
     * be a valid orderId and can be tracked from the checkout.
     */
    
    @discardableResult
    public func setOrderId(orderId: String) -> CfLogDeliveryEvent {
        self.orderId = orderId
        return self
    }
    /**
     * setDeliveryId is required to associate the rating obtained for the order. deliveryId should
     * be a valid deliveryId and can be tracked from the catalog for the items in that
     * specific delivery.
     */
    @discardableResult
    public func setDeliveryId(deliveryId: String) -> CfLogDeliveryEvent {
        self.deliveryId = deliveryId
        return self
    }
    /**
     * setDeliveryAction is required to set the delivery action for the log. For the order
     * being prepared for delivery or left the shipment center or delivered to the customer.
     */
    @discardableResult
    public func setDeliveryAction(action: DeliveryAction) -> CfLogDeliveryEvent {
        self.action = action.name
        return self
    }
    
    @discardableResult
    public func setDeliveryAction(action: String) -> CfLogDeliveryEvent {
        if CoreConstants.shared.enumContains(DeliveryAction.self, name: action) {
            self.action = action
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.delivery.name, className: DeliveryAction.self)
        }
        return self
    }
    
    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    
    @discardableResult
    public func setMeta(meta: Any?) -> CfLogDeliveryEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogDeliveryEvent {
        self.updateImmediately = updateImmediately
        return self
    }
    
    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    @discardableResult
    public func build() {
        if orderId == nil || orderId!.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.delivery.rawValue, elementName:"order_id")
        } else if deliveryId == nil || deliveryId!.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.delivery.rawValue, elementName: "delivery_id")
        } else if action == nil || action!.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.delivery.name, elementName:DeliveryAction.self)
        } else {
            let deliveryObject = DeliveryObject(deliveryId: deliveryId!, orderId: orderId!, action: action!, meta: meta)
            CFSetup().track(ECommerceConstants.contentBlockName, event: EComEventType.delivery.rawValue, object: deliveryObject, updateImmediately: updateImmediately)
        }
    }
    
}
