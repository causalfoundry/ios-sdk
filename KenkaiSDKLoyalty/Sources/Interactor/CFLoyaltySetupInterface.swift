//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation

protocol CFLoyaltySetupInterface {

    func trackSDKEvent<T: Codable>(eventType: LoyaltyEventType,
                       logObject: T?,
                       isUpdateImmediately: Bool?,
                       eventTime: Int64?)

    func trackCatalogEvent<T: Codable>(loyaltyCatalogType: LoyaltyCatalogType, subjectId: String, catalogModel: T)
}
