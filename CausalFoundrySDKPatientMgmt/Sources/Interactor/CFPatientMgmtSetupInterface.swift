//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation

protocol CFPatientMgmtSetupInterface {

    func trackSDKEvent<T: Codable>(eventType: PatientMgmtEventType,
                       logObject: T?,
                       isUpdateImmediately: Bool?,
                       eventTime: Int64?)

    func trackCatalogEvent(patientMgmtCatalogType: PatientMgmtCatalogSubject, catalogModel: Any)
}
