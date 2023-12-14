//
//  IngestProtocol.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation
import UIKit

protocol IngestProtocol {
    func initalize(pauseSDK: Bool,
                   updateImmediately: Bool)

    func updateUserId(appUserId: String)

    func updateCoreCatalogItem(subject: CatalogSubject,
                               catalogObject: Data)

    func track<T: Codable>(contentBlockName: String,
                           eventType: String,
                           logObject: T?,
                           updateImmediately: Bool,
                           eventTime: Int64)
}
