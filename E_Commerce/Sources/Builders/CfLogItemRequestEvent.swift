//
//  CfLogItemRequestEvent.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation
import CasualFoundryCore


public class CfLogItemRequestEvent {
    
    /**
     * CfLogItemRequestEvent is used to log the event an item is requested.
     */
    
    var item_request_id: String?
    var item_name: String?
    var manufacturer: String?
    private var meta: Any?
    
    
    private var update_immediately: Bool = CoreConstants.shared.updateImmediately
    
    
    public init() {}
    
    /**
     * setItemRequestId is for the providing Item name requested by the user.
     */
    @discardableResult
    public func setItemRequestId(_ item_request_id: String) -> CfLogItemRequestEvent {
        self.item_request_id = item_request_id
        return self
    }
    /**
     * setItemName is for the providing Item name requested by the user.
     */
    
    
    @discardableResult
    public func setItemName(_ item_name: String) -> CfLogItemRequestEvent {
        self.item_name = item_name
        return self
    }
    
    /**
     * setItemManufacturer is for the providing manufacturer for the item requested by the user.
     */
    
    @discardableResult
    public func setItemManufacturer(_ manufacturer: String) -> CfLogItemRequestEvent {
        self.manufacturer = manufacturer
        return self
    }
    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    
    
    @discardableResult
    public func setMeta(_ meta: Any?) -> CfLogItemRequestEvent {
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
    public func updateImmediately(_ update_immediately: Bool) -> CfLogItemRequestEvent {
        self.update_immediately = update_immediately
        return self
    }
    
    
    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    
    func build() {
        guard let item_request_id = item_request_id else {
            ExceptionManager.throwIsRequiredException(
                eventType: EComEventType.itemRequest.rawValue,
                elementName: "item_request_id"
            )
            return
        }
        guard let item_name = item_name else {
            ExceptionManager.throwIsRequiredException(
                eventType: EComEventType.itemRequest.rawValue,
                elementName: "item_name"
            )
            return
        }
        guard let manufacturer = manufacturer else {
            ExceptionManager.throwIsRequiredException(
                eventType: EComEventType.itemRequest.rawValue,
                elementName: " manufacturer"
            )
            return
        }
        
        let itemRequestObject = ItemRequestObject(
            item_request_id: item_request_id,
            item_name: item_name,
            manufacturer: manufacturer,
            meta: meta as? Encodable
        )
        CFSetup().track(
            contentBlockName: ECommerceConstants.contentBlockName,
            eventType: EComEventType.itemRequest.rawValue,
            logObject: itemRequestObject,
            updateImmediately: update_immediately
        )
    }

}

