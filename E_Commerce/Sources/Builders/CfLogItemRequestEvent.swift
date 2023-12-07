//
//  CfLogItemRequestEvent.swift
//
//
//  Created by khushbu on 01/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public class CfLogItemRequestEvent {
    /**
     * CfLogItemRequestEvent is used to log the event an item is requested.
     */

    var itemRequestId: String = ""
    var itemName: String = ""
    var manufacturer: String = ""
    private var meta: Any?

    private var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setItemRequestId is for the providing Item name requested by the user.
     */
    @discardableResult
    public func setItemRequestId(itemRequestId: String) -> CfLogItemRequestEvent {
        self.itemRequestId = itemRequestId
        return self
    }

    /**
     * setItemName is for the providing Item name requested by the user.
     */

    @discardableResult
    public func setItemName(itemName: String) -> CfLogItemRequestEvent {
        self.itemName = itemName
        return self
    }

    /**
     * setItemManufacturer is for the providing manufacturer for the item requested by the user.
     */

    @discardableResult
    public func setItemManufacturer(manufacturer: String) -> CfLogItemRequestEvent {
        self.manufacturer = manufacturer
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */

    @discardableResult
    public func setMeta(meta: Any?) -> CfLogItemRequestEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogItemRequestEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */

    public func build() {
        
        if(itemRequestId.isEmpty){
            ExceptionManager.throwIsRequiredException( eventType: EComEventType.itemRequest.rawValue, elementName: "item_request_id")
            return
        }else if(itemName.isEmpty){
            ExceptionManager.throwIsRequiredException( eventType: EComEventType.itemRequest.rawValue, elementName: "item_name")
            return
        }else if(manufacturer.isEmpty){
            ExceptionManager.throwIsRequiredException( eventType: EComEventType.itemRequest.rawValue, elementName: "item_manufacturer")
            return
        }

        let itemRequestObject = ItemRequestObject(itemRequestId: itemRequestId, itemName: itemName, manufacturer: manufacturer,meta: meta as? Encodable)
        CFSetup().track(
            contentBlockName: ECommerceConstants.contentBlockName,
            eventType: EComEventType.itemRequest.rawValue,
            logObject: itemRequestObject,
            updateImmediately: updateImmediately
        )
    }
}
