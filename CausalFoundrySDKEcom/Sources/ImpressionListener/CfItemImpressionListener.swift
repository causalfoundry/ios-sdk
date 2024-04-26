//
//  CfItemImpressionListener.swift
//
//
//  Created by moizhassankh on 07/12/23.
//
import CausalFoundrySDKCore
import Foundation
import UIKit


public class CfItemImpressionListener {

    var currentDataProviderValue: [ItemImpressionModel] = []
    var searchIdValue: String = ""

    public init() {}

    
    @discardableResult
    public func setSearchId(searchIdValue: String) -> CfItemImpressionListener {
        self.searchIdValue = searchIdValue
        return self
    }
    
    @discardableResult
    public func setImpressionProperties(itemImpressionModelList: [ItemImpressionModel]) -> CfItemImpressionListener {
        self.currentDataProviderValue.append(contentsOf: itemImpressionModelList)
        return self
    }

    @discardableResult
    public func setImpressionProperties(itemImpressionModelString: String) -> CfItemImpressionListener {
        if let data = itemImpressionModelString.data(using: .utf8),
           let itemModels = try? JSONDecoder.new.decode([ItemImpressionModel].self, from: data)
        {
            setImpressionProperties(itemImpressionModelList: itemModels)
        } else {
            // Handle JSON parsing error
        }
        return self
    }



    public func build() {
        for itemImpressionObject in currentDataProviderValue{
            
            if(!ECommerceConstants.isItemValueObjectValid(itemValue: itemImpressionObject.itemProperties, eventType: EComEventType.item)){
                return
            }
            
            let itemViewObject = ViewItemObject(action: EComItemAction.Impression.rawValue , item: itemImpressionObject.itemProperties,
                                                searchId : searchIdValue)
            
            CFSetup().track(contentBlockName: ECommerceConstants.contentBlockName, eventType: EComEventType.item.rawValue, logObject: itemViewObject, updateImmediately: false)
            
            if(itemImpressionObject.catalogProperties != nil){
                CfEComCatalog.callCatalogAPI(itemId: itemImpressionObject.itemProperties.id, itemType: itemImpressionObject.itemProperties.type, catalogModel: itemImpressionObject.catalogProperties as Any)
            }
        }
    }
}

