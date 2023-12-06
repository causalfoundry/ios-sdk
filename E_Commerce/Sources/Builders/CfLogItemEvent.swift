//
//  CfLogItemEvent.swift
//
//
//  Created by khushbu on 27/10/23.
//

import CasualFoundryCore
import Foundation

public class CfLogItemEvent {
    /**
     * CfLogItemEvent is required to log item related events which included when an item is viewed
     * and when an item's detail is viewed.
     */

    var itemActionValue: String = ""
    var itemValue: ItemModel = ItemModel(id: "", type: "", quantity: 1, price: -1.0, currency: "")
    var searchId: String = ""
    var catalogModel: Any? = nil
    var meta: Any? = nil
    var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setItemAction is required to set Type for the type of log in this case, if a user is viewing
     * an item or it's details. setType log is used to define if the log is about the item
     * itself or if the user id going into the details. you can provide the values using 2
     * different methods, one is for enum based and the other is for string based.
     * Below is the method for the enum based approach.
     */
    @discardableResult
    public func setItemAction(_ itemAction: ItemAction) -> CfLogItemEvent {
        itemActionValue = itemAction.rawValue
        return self
    }

    /**
     * setItemAction is required to set Type for the type of log in this case, if a user is viewing
     * an item or it's details. setType log is used to define if the log is about the item
     * itself or if the user id going into the details. you can provide the values using 2
     * different methods, one is for enum based and the other is for string based.
     * Below is the method for the string based approach. Remember to note that for string
     * input you need to use the same names as defined in the enum or else the events will
     * be discarded.
     */
    @discardableResult
    public func setItemAction(_ itemActionValue: String) -> CfLogItemEvent {
        if CoreConstants.shared.enumContains(ItemAction.self, name: itemActionValue) {
            self.itemActionValue = itemActionValue
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.item.rawValue, className: String(describing: ItemAction.self))
        }
        return self
    }

    /**
     * setItem can be used to pass the whole item as an object as well. You can use the POJO
     * ItemModel to parse the data int he required format and pass that to this function to
     * log the event.
     */
    @discardableResult
    public func setItem(_ item: ItemModel) -> CfLogItemEvent {
        itemValue = item
        return self
    }

    /**
     * setItem can be used to pass the whole item as a JSON String object as well. You can use
     * the POJO ItemModel to parse the data in the required format and pass that to this
     * function as a string to log the event. You can use JSONDecoder to convert the JSON
     * string back to a POJO, so pass it in the log. This method should be used with caution
     * and is suitable for a React Native bridge.
     */
    @discardableResult
    public func setItem(_ itemJsonString: String) -> CfLogItemEvent {
        if let data = itemJsonString.data(using: .utf8),
           let item = try? JSONDecoder.new.decode(ItemModel.self, from: data)
        {
            itemValue = item
        }
        return self
    }

    /**
     * setSearchId is used to associate the search id with the item being viewed by the user.
     * It is required to track if the item is a result of some search performed by the user in
     * the app.
     */
    @discardableResult
    public func setSearchId(_ searchId: String) -> CfLogItemEvent {
        self.searchId = searchId
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developers and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is nil.
     */
    @discardableResult
    public func setMeta(_ meta: Any?) -> CfLogItemEvent {
        self.meta = meta
        return self
    }

    /**
     * updateImmediately is responsible for updating the values ot the backend immediately.
     * By default this is set to false or whatever the developer has set in the SDK
     * initialization block. This differs the time for which the logs will be logged, if true,
     * the SDK will log the content instantly and if false it will wait till the end of the user
     * session which is whenever the app goes into the background.
     */
    @discardableResult
    public func updateImmediately(_ updateImmediately: Bool) -> CfLogItemEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    @discardableResult
    public func setCatalogProperties(_ catalogProperties: Any?) -> CfLogItemEvent {
        if catalogProperties != nil {
            if let catalogData = catalogProperties as? DrugCatalogModel {
                catalogModel = catalogData
            } else if let bloodCatalogData = catalogProperties as? BloodCatalogModel {
                catalogModel = bloodCatalogData
            } else if let oxygenCatalogModelData = catalogProperties as? OxygenCatalogModel {
                catalogModel = oxygenCatalogModelData
            } else if let medicalEquipmentCatalogData = catalogProperties as? MedicalEquipmentCatalogModel {
                catalogModel = medicalEquipmentCatalogData
            } else {
                ExceptionManager.throwIllegalStateException(eventType: EComEventType.item.rawValue, message: "Please use correct catalog properties with the provided item type", className: String(String(describing: CfLogItemEvent.self)))
            }
        }
        return self
    }

    public func build() {
        if itemActionValue.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.item.rawValue, elementName: String(describing: ItemAction.self))
            return
        } else if (!ECommerceConstants.isItemValueObjectValid(itemValue: itemValue, eventType: EComEventType.item)) {
            return
        }else {
            let itemObject = ViewItemObject(action:itemActionValue, item: itemValue)
            
            CFSetup().track(contentBlockName: ECommerceConstants.contentBlockName, eventType: EComEventType.item.rawValue, logObject: itemObject, updateImmediately: updateImmediately)
            
            
//            if itemActionValue == ItemAction.view.rawValue, let catalogModel = catalogModel {
//                guard let itemId = itemValue.id else { return  }
//                guard let itemType = itemValue.type else { return  }
//                CfEComCatalog.callCatalogAPI(itemId:itemId , itemType: itemType, catalogModel: catalogModel)
//                
//            }
            
        }
    }
}
