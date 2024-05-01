//
//  CfLogItemEvent.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import CausalFoundrySDKCore
import Foundation

public class CfLogItemEvent {
    /**
     * CfLogItemEvent is required to log item related events which included when an item is viewed
     * and when an item's detail is viewed.
     */

    var itemActionValue: String = ""
    var itemObject: ItemModel = ItemModel(id: "", type: "", quantity: 1, price: -1.0, currency: "")
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
    public func setItemAction(itemAction: EComItemAction) -> CfLogItemEvent {
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
    public func setItemAction(itemActionValue: String) -> CfLogItemEvent {
        if CoreConstants.shared.enumContains(EComItemAction.self, name: itemActionValue) {
            self.itemActionValue = itemActionValue
        } else {
            ExceptionManager.throwEnumException(eventType: EComEventType.item.rawValue, className: String(describing: EComItemAction.self))
        }
        return self
    }

    /**
     * setItem can be used to pass the whole item as an object as well. You can use the POJO
     * ItemModel to parse the data int he required format and pass that to this function to
     * log the event.
     */
    @discardableResult
    public func setItem(item: ItemModel) -> CfLogItemEvent {
        if(ECommerceConstants.isItemValueObjectValid(itemValue: item, eventType: EComEventType.item)){
            self.itemObject = item
        }
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
    public func setItem(itemJsonString: String) -> CfLogItemEvent {
        if let data = itemJsonString.data(using: .utf8),
           let item = try? JSONDecoder.new.decode(ItemModel.self, from: data)
        {
            setItem(item: item)
        }
        return self
    }
    
    /**
     * setCatalog can be used to pass the whole catalog as an object as well. You can use the POJO
     * for that catalog to parse the data int he required format and pass that to this function to
     * log the event.
     */
    @discardableResult
    public func setCatalogProperties(catalogPropertiesString: String) -> CfLogItemEvent {
        switch self.itemObject.type {
        case ItemType.Drug.rawValue:
            if let drugCatalogModel = try? JSONDecoder.new.decode(DrugCatalogModel.self, from: Data(catalogPropertiesString.utf8)) {
                self.catalogModel = drugCatalogModel
            } else { fallthrough }
        case ItemType.Grocery.rawValue:
            if let groceryCatalogModel = try? JSONDecoder.new.decode(GroceryCatalogModel.self, from: Data(catalogPropertiesString.utf8)) {
                self.catalogModel = groceryCatalogModel
            } else { fallthrough }
        case ItemType.Blood.rawValue:
            if let bloodCatalogModel = try? JSONDecoder.new.decode(BloodCatalogModel.self, from: Data(catalogPropertiesString.utf8)) {
                self.catalogModel = bloodCatalogModel
            } else { fallthrough }
        case ItemType.Oxygen.rawValue:
            if let oxygenCatalogModel = try? JSONDecoder.new.decode(OxygenCatalogModel.self, from: Data(catalogPropertiesString.utf8)) {
                self.catalogModel = oxygenCatalogModel
            } else { fallthrough }
        case ItemType.MedicalEquipment.rawValue:
            if let medicalEquipmentCatalogModel = try? JSONDecoder.new.decode(MedicalEquipmentCatalogModel.self, from: Data(catalogPropertiesString.utf8)) {
                self.catalogModel = medicalEquipmentCatalogModel
            } else { fallthrough }
        case ItemType.Facility.rawValue:
            if let facilityCatalogModel = try? JSONDecoder.new.decode(FacilityCatalogModel.self, from: Data(catalogPropertiesString.utf8)) {
                self.catalogModel = facilityCatalogModel
            } else { fallthrough }
        default:
            ExceptionManager.throwIllegalStateException(eventType: "item catalog", message: "Please use correct catalog properties with provided item type", className: String(describing: CfEComCatalog.self))
        }
        return self
    }

    /**
     * setCatalog can be used to pass the whole catalog as an object as well. You can use the POJO
     * for that catalog to parse the data int he required format and pass that as string to this function to
     * log the event. You can use JSONDecoder to convert the JSON
     * string back to a POJO, so pass it in the log. This method should be used with caution
     * and is suitable for a React Native bridge.
     */
    @discardableResult
    public func setCatalogProperties(catalogProperties: Any) -> CfLogItemEvent {
        if(catalogProperties is String){
            setCatalogProperties(catalogPropertiesString: catalogProperties as! String)
        }else {
            self.catalogModel = catalogProperties
        }
        return self
    }

    /**
     * setSearchId is used to associate the search id with the item being viewed by the user.
     * It is required to track if the item is a result of some search performed by the user in
     * the app.
     */
    @discardableResult
    public func setSearchId(searchId: String) -> CfLogItemEvent {
        self.searchId = searchId
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developers and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is nil.
     */
    @discardableResult
    public func setMeta(meta: Any?) -> CfLogItemEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogItemEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    @discardableResult
    public func setCatalogProperties(catalogProperties: Any?) -> CfLogItemEvent {
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
            ExceptionManager.throwIsRequiredException(eventType: EComEventType.item.rawValue, elementName: String(describing: EComItemAction.self))
            return
        } else {
            let itemViewObject = ViewItemObject(action:itemActionValue, item: itemObject, searchId: searchId)
            CFSetup().track(contentBlockName: ECommerceConstants.contentBlockName, eventType: EComEventType.item.rawValue, logObject: itemViewObject, updateImmediately: updateImmediately)
            
            if(self.catalogModel != nil) {
                CfEComCatalog.callCatalogAPI(itemId:itemObject.id , itemType: itemObject.type, catalogModel: self.catalogModel as Any)
                
            }
            
        }
    }
}
