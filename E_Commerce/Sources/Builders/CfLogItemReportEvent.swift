//
//  CfLogItemReportEvent.swift
//
//
//  Created by khushbu on 01/11/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogItemReportEvent {
    /**
     * CfLogItemReportEvent is used to log the event an item is reported.
     */
    var itemObject: ItemTypeModel?
    var storeObject: StoreObject?
    var reportObject: ReportObject?
    var meta: Any?
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setItem is for the providing item Id and type for the item in question.
     * The object should be based on the ItemTypeModel or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    
    @discardableResult
    public func setItem(itemTypeModel: ItemTypeModel) -> CfLogItemReportEvent {
        if(!ECommerceConstants.isItemTypeObjectValid(itemValue: itemTypeModel, eventType: .itemReport)){
            return self
        }
        self.itemObject = itemTypeModel
        return self
    }

    /**
     * setItem is for the providing item Id and type for the item in question.
     * The object should be based on the ItemTypeModel or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func setItem(itemJsonString: String) -> CfLogItemReportEvent {
        if let itemData = itemJsonString.data(using: .utf8),
           let itemTypeModel = try? JSONDecoder.new.decode(ItemTypeModel.self, from: itemData)
        {
            if(!ECommerceConstants.isItemTypeObjectValid(itemValue: itemTypeModel, eventType: .itemReport)){
                return self
            }
            self.itemObject = itemTypeModel
        }
        return self
    }
    

    /**
     * setStoreObject is for the providing store object details for the item report if any.
     * The object should be based on the StoreObject or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func setStoreObject(storeObject: StoreObject) -> CfLogItemReportEvent {
        if(storeObject.id.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.itemReport.rawValue, elementName: "store_object.id")
            return self
        }
        self.storeObject = storeObject
        return self
    }
    
    // Set store object using JSON string
    @discardableResult
    public func setStoreObject(storeObjectString: String) -> CfLogItemReportEvent {
        if let store = try? JSONDecoder.new.decode(StoreObject.self, from: storeObjectString.data(using: .utf8)!) {
            setStoreObject(storeObject: store)
        }
        return self
    }

    /**
     * setReportObject is for the providing report object details for the item report if any.
     * The object should be based on the ReportObject or a string that can be
     * converted to the object with proper param names. In-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func setReportObject(reportObject: ReportObject) -> CfLogItemReportEvent {
        if(reportObject.id.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.itemReport.rawValue, elementName: "report_object.id")
            return self
        }else if(reportObject.shortDesc.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.itemReport.rawValue, elementName: "report_object.short_desc")
            return self
        }
        self.reportObject = reportObject
        return self
    }

    // Set report object using JSON string
    @discardableResult
    public func setReportObject(reportObjectString: String) -> CfLogItemReportEvent {
        if let report = try? JSONDecoder.new.decode(ReportObject.self, from: reportObjectString.data(using: .utf8)!) {
           setReportObject(reportObject: report)
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(meta: Any?) -> CfLogItemReportEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogItemReportEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        
        if(itemObject == nil){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.itemReport.rawValue, elementName: "item_object")
            return
        }else if(storeObject == nil){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.itemReport.rawValue, elementName: "store_object")
            return
        }else if(reportObject == nil){
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.itemReport.rawValue, elementName: "report_object")
            return
        }

        let itemReportObject = ItemReportObject(item: itemObject!, storeObject: storeObject!, reportObject: reportObject!, meta: meta as? Encodable)

        CFSetup().track(
            contentBlockName: ECommerceConstants.contentBlockName,
            eventType: EComEventType.itemReport.rawValue,
            logObject: itemReportObject,
            updateImmediately: updateImmediately
        )
    }
}
