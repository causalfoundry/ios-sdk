//
//  CfLogItemVerificationEvent.swift
//
//
//  Created by khushbu on 01/11/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogItemVerificationEvent {
    /**
     * CfLogItemVerificationEvent is used to log the event an item is verified/scanned by the user.
     */

    var scanChannel: String = ""
    var scanType: String = ""
    var isSuccessful: Bool = false
    var itemInfoObject: ItemInfoModel? = ItemInfoModel(id: "", type: "")
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setScanChannel is for the providing scan channel used for verification.
     */

    @discardableResult
    public func setScanChannel(scanChannel: ScanChannel) -> CfLogItemVerificationEvent {
        self.scanChannel = scanChannel.rawValue
        return self
    }

    @discardableResult
    public func setScanChannel(scanChannel: String) -> CfLogItemVerificationEvent {
        if CoreConstants.shared.enumContains(ScanChannel.self, name: scanChannel) {
            self.scanChannel = scanChannel
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.itemVerification.rawValue, className: String(describing: ScanChannel.self))
        }
        return self
    }

    /**
     * setScanType is for the providing scan Type used for verification.
     */

    @discardableResult
    public func setScanType(scanType: ScanType) -> CfLogItemVerificationEvent {
        self.scanType = scanType.rawValue
        return self
    }

    @discardableResult
    public func setScanType(scanType: String) -> CfLogItemVerificationEvent {
        if CoreConstants.shared.enumContains(ScanType.self, name: scanType) {
            self.scanType = scanType
        } else {
            ExceptionManager.throwEnumException(
                eventType: EComEventType.itemVerification.rawValue, className: String(describing: scanType.self)
            )
        }
        return self
    }

    /**
     * isSuccessful is for the providing if verification was successful or not.
     */

    @discardableResult
    public func isSuccessful(isSuccessful: Bool) -> CfLogItemVerificationEvent {
        self.isSuccessful = isSuccessful
        return self
    }

    /**
     * setItemInfo is for the providing item info details returned by the verification.
     * The object should be based on the ItemInfoObject or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */

    @discardableResult
    public func setItemInfo(itemInfoObject: ItemInfoModel) -> CfLogItemVerificationEvent {
        if(itemInfoObject.id.isEmpty){
            ExceptionManager.throwEnumException(eventType: EComEventType.itemVerification.rawValue, className: "item_info.id")
            return self
        }else if (!CoreConstants.shared.enumContains(ItemType.self, name:itemInfoObject.type)) {
            ExceptionManager.throwEnumException(eventType: EComEventType.itemVerification.rawValue, className: "item_info.type")
            return self
        }
        self.itemInfoObject = itemInfoObject
        return self
    }

    /**
     * setItemInfo is for the providing item info details returned by the verification.
     * The object should be based on the ItemInfoObject or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */

    @discardableResult
    public func setItemInfo(itemInfoObjectString: String) -> CfLogItemVerificationEvent {
        if let item = try? JSONDecoder.new.decode(ItemInfoModel.self, from: Data(itemInfoObjectString.utf8)) {
            setItemInfo(itemInfoObject: item)
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */

    @discardableResult
    public func setMeta(meta: Any?) -> CfLogItemVerificationEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogItemVerificationEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */

    public func build() {
        
        if(scanChannel.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.itemVerification.rawValue,elementName: "scan_channel")
            return
        }else if(scanType.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.itemVerification.rawValue,elementName: "scan_type")
            return
        }else if(isSuccessful && itemInfoObject == nil){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.itemVerification.rawValue,elementName: "item_info")
            return
        }else if(isSuccessful && itemInfoObject != nil && itemInfoObject!.id.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.itemVerification.rawValue,elementName: "item_info id")
            return
        }else if(isSuccessful && itemInfoObject != nil && itemInfoObject!.type.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.itemVerification.rawValue,elementName: "item_info type")
            return
        }
        
        
        if(!isSuccessful){
            itemInfoObject = nil
        }
        

        let itemVerificationObject = ItemVerificationObject(
            scanChannel: scanChannel,
            scanType: scanType,
            isSuccessful: isSuccessful,
            itemInfo: itemInfoObject,
            meta: meta as? Encodable
        )

        CFSetup().track(
            contentBlockName: ECommerceConstants.contentBlockName,
            eventType: EComEventType.itemVerification.rawValue,
            logObject: itemVerificationObject,
            updateImmediately: updateImmediately
        )
    }
}
