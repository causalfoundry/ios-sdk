//
//  CfLogItemVerificationEvent.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation
import CasualFoundryCore

public class CfLogItemVerificationEvent {
    
    /**
     * CfLogItemVerificationEvent is used to log the event an item is verified/scanned by the user.
     */
    
    var scan_channel: String?
    var scan_type: String?
    var is_successful: Bool?
    var item_info: ItemInfoObject?
    var meta: Any?
    var update_immediately: Bool = CoreConstants.shared.updateImmediately
    
    
    public init() {
        
    }
    
    /**
     * setScanChannel is for the providing scan channel used for verification.
     */
    
    @discardableResult
    public func setScanChannel(_ scanChannel: ScanChannel) -> CfLogItemVerificationEvent {
        self.scan_channel = scanChannel.rawValue
        return self
    }
    
    @discardableResult
    public func setScanChannel(_ scanChannel: String) -> CfLogItemVerificationEvent {
        if CoreConstants.shared.enumContains(ScanChannel.self, name: scanChannel) {
            self.scan_channel = scanChannel
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.itemVerification.rawValue, className:String(describing:ScanChannel.self))
        }
        return self
    }
    /**
     * setScanType is for the providing scan Type used for verification.
     */
    
    
    @discardableResult
    public func setScanType(_ scanType: ScanType) -> CfLogItemVerificationEvent {
        self.scan_type = scanType.rawValue
        return self
    }
    
    @discardableResult
    public func setScanType(_ scanType: String) -> CfLogItemVerificationEvent {
        if CoreConstants.shared.enumContains(ScanType.self, name: scanType) {
            self.scan_type = scanType
        } else {
            ExceptionManager.throwEnumException(
                eventType:EComEventType.itemVerification.rawValue, className: String(describing: scanType.self))
        }
        return self
    }
    
    /**
     * isSuccessful is for the providing if verification was successful or not.
     */
    
    @discardableResult
    public func isSuccessful(_ successful: Bool) -> CfLogItemVerificationEvent {
        self.is_successful = successful
        return self
    }
    
    /**
     * setItemInfo is for the providing item info details returned by the verification.
     * The object should be based on the ItemInfoObject or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    
    @discardableResult
    public func setItemInfo(_ itemInfo: ItemInfoObject?) -> CfLogItemVerificationEvent {
        if let itemType = itemInfo?.type, CoreConstants.shared.enumContains(ItemType.self, name: itemType) {
            self.item_info = itemInfo
        } else {
            ExceptionManager.throwEnumException(
                eventType:  EComEventType.itemVerification.rawValue, className: String(describing: ItemType.self
               
            ))
        }
        return self
    }
    
    
    /**
     * setItemInfo is for the providing item info details returned by the verification.
     * The object should be based on the ItemInfoObject or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    
    @discardableResult
    public func setItemInfo(_ itemInfo: String) -> CfLogItemVerificationEvent {
        if let item = try? JSONDecoder().decode(ItemInfoObject.self, from: Data(itemInfo.utf8)) {
            self.item_info = item
        }
        return self
    }
    
    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    
    @discardableResult
    public func setMeta(_ meta: Any?) -> CfLogItemVerificationEvent {
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
    public func updateImmediately(_ updateImmediately: Bool) -> CfLogItemVerificationEvent {
        self.update_immediately = updateImmediately
        return self
    }
    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    
    public func build() {
        guard let scanChannel = scan_channel,
              let scanType = scan_type,
              let successful = is_successful
        else {
            ExceptionManager.throwIsRequiredException(
                eventType: EComEventType.itemVerification.rawValue,
                elementName: "scan_channel"
            )
            return
        }
        
        if successful && item_info != nil {
            guard let itemId = item_info?.id, !itemId.isEmpty else {
                ExceptionManager.throwIsRequiredException(
                    eventType: EComEventType.itemVerification.rawValue,
                    elementName: "item_id"
                )
                return
            }
            
            guard let itemType = item_info?.type, !itemType.isEmpty else {
                ExceptionManager.throwIsRequiredException(
                    eventType: EComEventType.itemVerification.rawValue,
                    elementName: "item_type"
                )
                return
            }
        } else if successful && item_info == nil {
            ExceptionManager.throwIsRequiredException(
                eventType: EComEventType.itemVerification.rawValue,
                elementName: "item_info"
            )
            return
        } else {
            item_info = nil
        }
        
        let itemVerificationObject = ItemVerificationObject(
            scan_channel: scanChannel,
            scan_type: scanType,
            is_successful: successful,
            item_info: item_info,
            meta: meta as? Encodable
        )
        
        CFSetup().track(
            contentBlockName: ECommerceConstants.contentBlockName,
            eventType: EComEventType.itemVerification.rawValue,
            logObject: itemVerificationObject,
            updateImmediately: update_immediately
        )
    }
}

