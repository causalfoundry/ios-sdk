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
            if eventObject.page < 0 {
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

}
