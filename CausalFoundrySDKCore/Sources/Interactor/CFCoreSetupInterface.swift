//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation

protocol CFCoreSetupInterface {

    func trackSDKEvent<T: Codable>(eventName: CoreEventType,
                       logObject: T?,
                       isUpdateImmediately: Bool?,
                       eventTime: Int64?)

    func trackCatalogEvent(coreCatalogType: CoreCatalogSubject, catalogModel: Any)
}
