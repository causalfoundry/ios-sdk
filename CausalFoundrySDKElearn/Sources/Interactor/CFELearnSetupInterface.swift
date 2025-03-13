//
//  File.swift
//  
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation

protocol CFELearnSetupInterface {

    func trackSDKEvent<T: Codable>(eventType: ELearnEventType,
                       logObject: T?,
                       isUpdateImmediately: Bool?,
                       eventTime: Int64?)

}
