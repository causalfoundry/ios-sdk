//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation

protocol CFEComSetupInterface {

    func trackSDKEvent<T: Codable>(eventType: EComEventType,
                       logObject: T?,
                       isUpdateImmediately: Bool?,
                       eventTime: Int64?)

    func trackCatalogEvent(catalogType: EComCatalogType, catalogModel: Any)
}
