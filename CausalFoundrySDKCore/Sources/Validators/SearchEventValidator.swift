//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 28/8/24.
//

import Foundation

public class SearchEventValidator {

    static func validateSearchObject<T:Codable>(logObject: T?) -> SearchObject? {
        let eventObject: SearchObject? = {
            if let eventObject = logObject as? SearchObject {
                return eventObject
            } else {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Search.rawValue,
                                                       paramName: "SearchObject", className: "SearchObject")
                return nil
            }
        }()
        if let eventObject = eventObject {
            // Will throw an exception if the action provided is null or no action is provided at all.
            if eventObject.query == nil {
                ExceptionManager.throwIsRequiredException(eventType: CoreEventType.Search.rawValue, elementName: "search query")
            }else if (eventObject.searchModule.isEmpty) {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Search.rawValue,
                                                       paramName: String(describing: SearchModuleType.self),
                                                       className: String(describing: SearchModuleType.self))
            } else if !CoreConstants.shared.enumContains(SearchModuleType.self, name: eventObject.searchModule) {
                ExceptionManager.throwEnumException(eventType: CoreEventType.Search.rawValue,
                                                       className: String(describing: SearchModuleType.self))
            } else if eventObject.page < 0 {
                ExceptionManager.throwInvalidException(eventType: CoreEventType.Search.rawValue,
                                                       paramName: "page",
                                                       className: String(describing: Int.self))
            } else {
                
                let allItemsValid = eventObject.resultsList.allSatisfy { item in
                    CoreConstants.shared.isSearchItemModelObjectValid(itemValue: item,  eventType: CoreEventType.Search)
                }
                
                if(allItemsValid){
                    return eventObject
                }
            }
        }
        return nil
    }
    
    public static func mapStringToSearchObject(objectString: String) -> SearchObject? {
        guard let data = objectString.data(using: .utf8) else {return nil}
        return try? JSONDecoder().decode(SearchObject.self, from: data)
    }

}
