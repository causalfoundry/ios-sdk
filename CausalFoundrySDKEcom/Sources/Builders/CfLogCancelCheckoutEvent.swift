//
//  CfLogCancelCheckoutEvent.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

import CausalFoundrySDKCore
import Foundation

public class CfLogCancelCheckoutEvent {
    var checkoutId: String = ""
    var type: String = ""
    var itemList: [ItemTypeModel] = []
    var reason: String = ""
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately
    /**
     * CfLogCancelCheckoutEvent is used to log the event when the order/cart is canceled.
     */
    public init() {}

    /**
     * setCheckoutId can be used to log the orderId the event is logged for. if the order ID is
     * not there then it is recommended to include the unique cartId for the cart items so
     * that they can be tracked. In case the cart Id is also not there, you can use the userId
     * as a unique element for the order.
     */
    @discardableResult
    public func setCheckoutId(checkoutId: String) -> CfLogCancelCheckoutEvent {
        self.checkoutId = checkoutId
        return self
    }

    /**
     * setCancelType can be used to log the type of the checkout that is being cancelled.
     * It can be order or card but should reflect the correct type in correspondence to
     * the id provided.
     */
    @discardableResult
    public func setCancelType(cancelType: CancelType) -> CfLogCancelCheckoutEvent {
        type = cancelType.rawValue
        return self
    }
    @discardableResult
    public func setCancelType(cancelTypeString: String) -> CfLogCancelCheckoutEvent {
        if CoreConstants.shared.enumContains(CancelType.self, name: cancelTypeString) {
            self.type = cancelTypeString
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.CancelCheckout.rawValue, className: String(describing: CancelType.self))
        }
        return self
    }
    
    /**
     * addItem can be used to add the item being orders in to the checkout list. This log can
     * be used to add one item to the log at a time. Order item should be in a valid format.
     * With elements of the order as:
     * ItemTypeModel(itemID, type) You can add multiple addOrder functions to one event to include
     * all the items in the order.
     */

    @discardableResult
    public func addItem(itemTypeModel: ItemTypeModel) -> CfLogCancelCheckoutEvent {
        if(!ECommerceConstants.isItemTypeObjectValid(itemValue: itemTypeModel, eventType: .CancelCheckout)){
            return self
        }
        self.itemList.append(itemTypeModel)
        return self
    }

    /**
     * addItem can be used to pass the whole item as a Json String object as well. You can use
     * the POJO ItemTypeModel to parse the data int he required format and pass that to this
     * function as a string to log the event. You can use Gson to convert the object to string
     * but SDK will parse the Json string back to POJO so pass it in the log. This method
     * should be used with caution and is suitable for react native bridge.
     */

    @discardableResult
    public func addItem(itemJsonString: String) -> CfLogCancelCheckoutEvent {
        if let itemData = itemJsonString.data(using: .utf8),
           let itemTypeModel = try? JSONDecoder.new.decode(ItemTypeModel.self, from: itemData)
        {
            addItem(itemTypeModel: itemTypeModel)
        }
        return self
    }

    /**
     * addItemList can be used to add the whole list to the log at once, the format should be
     * ArrayList<ItemTypeModel> to log the event successfully. Order item should be in a valid format.
     * With elements of the orderObject as:
     * ItemTypeModel(itemID, type) You should use only one addItemList with event or else the list
     * will only save the later one.
     */

    @discardableResult
    public func addItemList(itemtypeList: [ItemTypeModel]) -> CfLogCancelCheckoutEvent {
        for item in itemtypeList {
            if(!ECommerceConstants.isItemTypeObjectValid(itemValue: item, eventType: .CancelCheckout)){
                return self
            }
        }
        self.itemList.append(contentsOf: itemtypeList)
        return self
    }

    /**
     * addItemList can be used to add the whole list to the log at once, the format should be
     * ArrayList<ItemTypeModel> to log the event successfully. But the input param is of type
     * string , this is special use case for react native logs where list can be passed as
     * Json string and can be used to log the event. Order item should be in a valid format.
     * With elements of the orderObject as:
     * ItemTypeModel(itemID, type) You should use only one addItemList with event or else the list
     * will only save the later one.
     */

    @discardableResult
    public func addItemList(itemListString: String) -> CfLogCancelCheckoutEvent {
        if let data = itemListString.data(using: .utf8),
           let itemtypeList = try? JSONDecoder.new.decode([ItemTypeModel].self, from: data)
        {
            addItemList(itemtypeList: itemtypeList)
        }
        return self
    }

    /**
     * setCancelReason is required to define the reason for which the item is being cancelled.
     */

    @discardableResult
    public func setCancelReason(reason: String) -> CfLogCancelCheckoutEvent {
        self.reason = reason
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */

    @discardableResult
    public func setMeta(meta: Any?) -> CfLogCancelCheckoutEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogCancelCheckoutEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        
        if checkoutId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.CancelCheckout.rawValue, elementName: "checkout_id")
            return
        }else if type.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.CancelCheckout.rawValue, elementName: "cancel_type")
            return
        }else if itemList.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.CancelCheckout.rawValue, elementName: "items_list")
            return
        }
        
        let cancelCheckoutObject = CancelCheckoutObject(id: checkoutId, type: type, itemsList: itemList, reason: reason, meta: meta as? Encodable)
        CFSetup().track(contentBlockName: ECommerceConstants.contentBlockName, eventType: EComEventType.CancelCheckout.rawValue, logObject: cancelCheckoutObject, updateImmediately: updateImmediately)
    }
}
