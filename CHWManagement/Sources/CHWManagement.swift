//
//  CfLogChwModuleEvent.swift
//
//
//  Created by khushbu on 25/10/23.
//

import Foundation
import  CasualFoundryCore


public class CfLogChwModuleEvent {
    /**
     * CfLogChwModuleEvent is required to log events related to selection of modules in a
     * chw management app screen. You can select the module type with the log values.
     */
    
    public struct Builder {
         var moduleType: String?
         var meta: Any?
         var updateImmediately: Bool = CoreConstants.shared.updateImmediately
        
        /**
         * setChwModuleEvent is for the providing the current module selected by the
         * user in the chw mgmt section on the main screen. You can use the default enum
         * provided in the SDK and can also use the string. Below is the function with
         * an enum as param.
         */
        
        public  mutating func setChwModuleEvent(_ chwModuleType: ChwModuleType) -> Builder {
            self.moduleType = chwModuleType.rawValue
            return self
        }
        
        /**
         * setChwModuleEvent is for the providing the current module selected by the
         * user in the chw mgmt section on the main screen. You can use the default enum
         * provided in the SDK and can also use the string. Below is the function with
         * an string as param.
         */
        
        public  mutating func setChwModuleEvent(_ chwModuleType: String) -> Builder {
            if CoreConstants.shared.enumContains(ChwModuleType.self, name: chwModuleType) {
                self.moduleType = chwModuleType
            } else {
                ExceptionManager.throwEnumException(
                    ChwMgmtEventType.module_selection.rawValue,
                    "ChwModuleType"
                )
                /Users/khushbu/Documents/CausalFoundry_ios_SDK/CHWManagement/Sources/Models            }
            return self
        }
        
        /**
         * You can pass any type of value in setMeta. It is for developer and partners to log
         * additional information with the log that they find would be helpful for logging and
         * providing more context to the log. Default value for the meta is null.
         */
        public mutating func setMeta(_ meta: Any?) -> Builder {
            self.meta = meta
            return self
        }
        
        /**
         * updateImmediately is responsible for updating the values ot the backend immediately.
         * By default this is set to false or whatever the developer has set in the SDK
         * initialisation block. This differs the time for which the logs will be logged, if true,
         * the SDK will log the content instantly and if false it will wait till the end of user
         * session which is whenever the app goes into background.
         */
        
        public  mutating func updateImmediately(_ updateImmediately: Bool) -> Builder {
            self.updateImmediately = updateImmediately
            return self
        }
        
        /**
         * build will validate all of the values provided and if passes will call the track
         * function and queue the events based on it's updateImmediately value and also on the
         * user's network resources.
         */
        
        public func build() {
            guard let moduleType = moduleType, !moduleType.isEmpty else {
                ExceptionManager.throwIsRequiredException(eventType:ChwMgmtEventType.module_selection.rawValue, elementName: "ChwModuleType")
                   return
            }
            
            if !CoreConstants.shared.enumContains(ChwModuleType.self,, name: self.moduleType){
                ExceptionManager.throwEnumException(
                    ChwMgmtEventType.module_selection.rawValue,
                    ChwModuleType.self.simpleName
                )
                return
            }
            
            let chwModelObject = ChwModelObject(moduleType: moduleType, meta: meta)
            CFSetup().track(
                ChwConstants.contentBlockName,
                ChwMgmtEventType.module_selection.rawValue,
                chwModelObject,
                updateImmediately
            )
        }
    }
}

