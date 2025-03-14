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
        
        
        if let eventObject = validateELearnEvent(eventType: eventType, logObject: logObject){
            CFSetup().track(
                contentBlockName: ContentBlock.ELearning.rawValue,
                eventType: eventType.rawValue,
                logObject: eventObject,
                updateImmediately: isUpdateImmediately ?? CoreConstants.shared.updateImmediately,
                eventTime: eventTime ?? 0
            )
        }else{
            print("Unknown event object type")
        }
    }
    
    private func validateELearnEvent<T: Codable>(eventType: ELearnEventType, logObject: T?) -> T? {
        switch eventType {
        case .Question:
            return ELearnEventValidator.validateQuestionObject(logObject: logObject) as? T
        case .Module:
            return ELearnEventValidator.validateModuleObject(logObject: logObject) as? T
        case .Exam:
            return ELearnEventValidator.validateExamObject(logObject: logObject) as? T
        }
    }
}

