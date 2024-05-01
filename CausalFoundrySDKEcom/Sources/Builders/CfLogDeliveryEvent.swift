//
//  CfLogDeliveryEvent.swift
//
//
//  Created by khushbu on 29/10/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogDeliveryEvent {
    /**
     * CfLogDeliveryEvent is used to log the status for the delivery. It can be used to log the
     * delivered status of the order or a partial order. Details about the items in the specific
     * delivery should be provided in the catalog.
     */
    var orderId: String = ""
    var deliveryId: String = ""
    var action: String = ""
    var isUrgent: Bool = false
    var estDeliveryTsValue: Int64 = 0
    var deliveryCoordinatesObject: CoordinatesObject? = nil
    var dispatchCoordinatesObject: CoordinatesObject? = nil
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}
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
        self.action = action.rawValue
        return self
    }

    @discardableResult
    public func setDeliveryAction(action: String) -> CfLogDeliveryEvent {
        if CoreConstants.shared.enumContains(DeliveryAction.self, name: action) {
            self.action = action
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.delivery.rawValue, className: String(describing: DeliveryAction.self))
        }
        return self
    }
    
    /**
     * isUrgent is to mark the log if the delivery is scheduled to be an immediate or emergency
     * delivery.
     */

    @discardableResult
    public func isUrgent(isUrgent: Bool) -> CfLogDeliveryEvent {
        self.isUrgent = isUrgent
        return self
    }

    /**
     * The timestamp in time in milliseconds format for the date and time for which the
     * delivery is set to be scheduled
     */

    @discardableResult
    public func setDeliveryDateTime(deliveryTs: Int64) -> CfLogDeliveryEvent {
        self.estDeliveryTsValue = deliveryTs
        return self
    }

    @discardableResult
    public func setDeliveryDateTime(deliveryTsString: String) -> CfLogDeliveryEvent {
        if let deliveryTs = Int64(deliveryTsString) {
            self.estDeliveryTsValue = deliveryTs
        } else {
            ExceptionManager.throwRuntimeException(
                eventType: EComEventType.delivery.rawValue,
                message: "Unable to convert \(deliveryTsString) to Int64"
            )
        }
        return self
    }
    
    
    /**
     * setDeliveryCoordinates can be used to pass the whole Coordinates Object or as a
     * Json String as well. You can use the POJO CoordinatesObject to parse the data
     * in the required format and pass that to this function as a string to log the event.
     * You can use Gson to convert the object to string but SDK will parse the Json string
     * back to POJO so pass it in the log. This method should be used with caution and is
     * suitable for react native bridge.
     */
    public func setDeliveryCoordinates(deliveryCoordinates: CoordinatesObject)  -> CfLogDeliveryEvent {
        self.deliveryCoordinatesObject = deliveryCoordinates
        return self
    }

    public func setDeliveryCoordinates(deliveryCoordinatesJsonString: String?)  -> CfLogDeliveryEvent {
        if let data = deliveryCoordinatesJsonString?.data(using: .utf8),
           let item = try? JSONDecoder.new.decode(CoordinatesObject.self, from: data)
        {
            self.deliveryCoordinatesObject = item
        }
        return self
    }
    
    /**
     * setDeliveryCoordinates can be used to pass the whole Coordinates Object or as a
         * Json String as well. You can use the POJO CoordinatesObject to parse the data
         * in the required format and pass that to this function as a string to log the event.
         * You can use Gson to convert the object to string but SDK will parse the Json string
         * back to POJO so pass it in the log. This method should be used with caution and is
         * suitable for react native bridge.
         */
    public func setDispatchCoordinates(dispatchCoordinates: CoordinatesObject)  -> CfLogDeliveryEvent {
        self.dispatchCoordinatesObject = dispatchCoordinates
        return self
    }

    public func setDispatchCoordinates(dispatchCoordinatesJsonString: String?)  -> CfLogDeliveryEvent {
        if let data = dispatchCoordinatesJsonString?.data(using: .utf8),
           let item = try? JSONDecoder.new.decode(CoordinatesObject.self, from: data)
        {
            self.dispatchCoordinatesObject = item
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
    public func build() {
        
        if orderId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.delivery.rawValue, elementName: "order_id")
            return
        }else if deliveryId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.delivery.rawValue, elementName: "delivery_id")
            return
        }else if action.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.delivery.rawValue, elementName: "action")
            return
        }else if (estDeliveryTsValue < 1) {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.delivery.rawValue, elementName: "estDeliveryTsValue")
            return
        }else if (deliveryCoordinatesObject != nil && (deliveryCoordinatesObject?.lat == 0.0 ||
                                                       deliveryCoordinatesObject?.lon == 0.0)) {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.delivery.rawValue, elementName: "Invalid Delivery Coordinates provided")
            return
        }else if (dispatchCoordinatesObject != nil && (dispatchCoordinatesObject?.lat == 0.0 ||
                                                       dispatchCoordinatesObject?.lon == 0.0)) {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.delivery.rawValue, elementName: "Invalid Dispatch Coordinates provided")
            return
        }
        let deliverObject = DeliveryObject(
            deliveryId: deliveryId, orderId: orderId,
            action: action, isUrgent: isUrgent, estDeliveryTsValue: ECommerceConstants.getDateTime(milliSeconds: estDeliveryTsValue),
            deliveryCoordinates: deliveryCoordinatesObject,
            dispatchCoordinates: dispatchCoordinatesObject,
            meta: meta as? Encodable)
        CFSetup().track(contentBlockName: ECommerceConstants.contentBlockName, eventType: EComEventType.delivery.rawValue, logObject: deliverObject, updateImmediately: updateImmediately)
        
    }
}
