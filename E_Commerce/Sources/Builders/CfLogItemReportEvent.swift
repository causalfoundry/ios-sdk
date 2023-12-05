//
//  CfLogItemReportEvent.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation
import CasualFoundryCore

public class CfLogItemReportEvent {
    /**
     * CfLogItemReportEvent is used to log the event an item is reported.
     */
    var item_object: ItemTypeModel?
    var store_object: StoreObject?
    var report_object: ReportObject?
    var meta: Any?
    var update_immediately: Bool = CoreConstants.shared.updateImmediately
    
    
    public init() {
        
    }
    /**
     * setItem is for the providing item Id and type for the item in question.
     * The object should be based on the ItemTypeModel or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func setItem(item_object: ItemTypeModel) -> CfLogItemReportEvent {
        if CoreConstants.shared.enumContains(ItemType.self, name: item_object.item_type) {
            ECommerceConstants.isItemTypeObjectValid(itemValue: item_object, eventType: EComEventType.itemReport)
            self.item_object = item_object
        } else {
            ExceptionManager.throwEnumException(
                eventType: EComEventType.itemReport.rawValue,
                className: String(describing: ItemType.self)
            )
        }
        return self
    }
    /**
     * setItem is for the providing item Id and type for the item in question.
     * The object should be based on the ItemTypeModel or a string that can be
     * converted to the object with proper param names. in-case the names are not correct
     * the SDK will throw an exception. Below is the function for providing item as a string.
     */
    @discardableResult
    public func setItem(item_object: String) -> CfLogItemReportEvent  {
        if let item = try? JSONDecoder.new.decode(ItemTypeModel.self, from: item_object.data(using: .utf8)!) {
            setItem(item_object: item)
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
    public func setStoreObject(store_object: StoreObject) -> CfLogItemReportEvent {
        self.store_object = store_object
        return self
    }
    
    // Set store object using JSON string
    @discardableResult
    public func setStoreObject(store_object: String)-> CfLogItemReportEvent {
        if let store = try? JSONDecoder.new.decode(StoreObject.self, from: store_object.data(using: .utf8)!) {
            setStoreObject(store_object: store)
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
    public func setReportObject(report_object: ReportObject)-> CfLogItemReportEvent {
        self.report_object = report_object
        return self
    }
    
    // Set report object using JSON string
    @discardableResult
    public func setReportObject(report_object: String) -> CfLogItemReportEvent {
        if let report = try? JSONDecoder.new.decode(ReportObject.self, from: report_object.data(using: .utf8)!) {
            setReportObject(report_object: report)
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
    public func updateImmediately(update_immediately: Bool)-> CfLogItemReportEvent  {
        self.update_immediately = update_immediately
        return self
    }
    
    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        guard let item_object = item_object else {
            ExceptionManager.throwIsRequiredException(
                eventType: EComEventType.itemReport.rawValue,
                elementName: "item_object"
            )
            return
        }
        
        guard let store_object = store_object else {
            ExceptionManager.throwIsRequiredException(
                eventType: EComEventType.itemReport.rawValue,
                elementName: "store_object"
            )
            return
        }
        guard let report_object = report_object else {
            ExceptionManager.throwIsRequiredException(
                eventType: EComEventType.itemReport.rawValue,
                elementName: "report_object"
            )
            return
        }
        
        guard !store_object.id.isEmpty else {
            ExceptionManager.throwIsRequiredException(
                eventType: EComEventType.itemReport.rawValue,
                elementName: "store_id"
            )
            return
        }
        
        guard !report_object.id.isEmpty, !report_object.short_desc.isEmpty else {
            ExceptionManager.throwIsRequiredException(
                eventType: EComEventType.itemReport.rawValue,
                elementName: "report_id, report_short_desc"
            )
            return
        }
        
        let itemReportObject = ItemReportObject(
            item: item_object,
            store_info: store_object,
            report_info: report_object,
            meta: meta as? Encodable
        )
        
        CFSetup().track(
            contentBlockName: ECommerceConstants.contentBlockName,
            eventType: EComEventType.itemReport.rawValue,
            logObject: itemReportObject,
            updateImmediately: update_immediately
        )
    }
}


