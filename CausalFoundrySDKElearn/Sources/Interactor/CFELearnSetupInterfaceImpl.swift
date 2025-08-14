//
//  File.swift
//
//
//  Created by MOIZ HASSAN KHAN on 27/8/24.
//

import Foundation
import CausalFoundrySDKCore

internal class CFELearnSetupInterfaceImpl: CFELearnSetupInterface {
    
    
    // Singleton instance
    static let shared = CFELearnSetupInterfaceImpl()
    
    // Private initializer to prevent external instantiation
    private init() {}
    
    
    func trackSDKEvent<T: Codable>(eventType: ELearnEventType,
                                   logObject: T?,
                                   isUpdateImmediately: Bool? = CoreConstants.shared.updateImmediately,
                                   eventTime: Int64? = 0) {
        
        if CoreConstants.shared.pauseSDK {
            return
        }
        
        
        validateELearnEvent(eventType: eventType, logObject: logObject, isUpdateImmediately: isUpdateImmediately, eventTime: eventTime)
    }
    
    private func validateELearnEvent<T: Codable>(eventType: ELearnEventType, logObject: T?, isUpdateImmediately: Bool?, eventTime: Int64?) {
        
        switch eventType {
        case .Question:
            if let eventObject = ELearnEventValidator.validateQuestionObject(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: eventObject.action,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .Module:
            if let eventObject = ELearnEventValidator.validateModuleObject(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: eventObject.action,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        case .Exam:
            if let eventObject = ELearnEventValidator.validateExamObject(logObject: logObject){
                CFSetup().track(
                    eventName: eventType.rawValue,
                    eventProperty: eventObject.action,
                    eventCtx: eventObject,
                    updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                    eventTime: eventTime ?? 0
                )
            }
        }
    }
}

