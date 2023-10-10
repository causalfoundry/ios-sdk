//
//  CfLogRateEvent.swift
//
//
//  Created by khushbu on 10/10/23.
//

import Foundation


import Foundation

public class CfLogRateEvent {
    /**
     * CfLogRateEvent is required to log events related to providing rate experience for the
     * elements in the app. Rating the order placing experience, rating the course completing
     * experience or rating the overall app.
     */
    
    public struct Builder {
        var rateValue: Float?
        var type: String?
        var subjectId: String?
        var contentBlock: String
        var meta: Any?
        var updateImmediately: Bool
        
        
        /**
         * setContentBlock is used to specify the type of module the rate is applied to.
         * rate can be used for multiple modules i.e. core, e-commerce, e-learning, ...
         * SDK provides enum ContentBlockType to log the module, you can also use string function as
         * well in order to log the content block type. Below is the function for the usage of enum
         * type function.
         */
        
        public func setContentBlock(contentBlock: ContentBlock) -> Builder {
            var builder = self
            builder.contentBlock = contentBlock.rawValue
            return builder
        }
        /**
         * setContentBlock is used to specify the type of module the rate is applied to.
         * rate can be used for multiple modules i.e. core, e-commerce, e-learning, ...
         * SDK provides enum ContentBlockType to log the module, you can also use string function as
         * well in order to log the content block type. Below is the function for the usage of
         * content block type function. Remember to note that you need to use the same enum types
         * as provided by the enums or else the events will be discarded.
         */
        
        public func setContentBlock(contentBlock: String) -> Builder {
            var builder = self
            if CoreConstants.shared.enumContains(ContentBlock.self, name: contentBlock) {
                builder.contentBlock = contentBlock
            } else {
                ExceptionManager.throwEnumException(eventType: CoreEventType.rate.rawValue,className: String(describing:ContentBlock.self))
            }
            return builder
        }
        
        /**
         * setRateValue is for the providing the value for the rate. Should be in between 0 to 5,
         * if there are more elements like 0 to 10, make sure to divide the value by 2.
         */
        public func setRateValue(rateValue: Float) -> Builder {
            var builder = self
            builder.rateValue = rateValue
            return builder
        }
        
        /**
         * setRateType is for the providing the type of the element being rated. By default SDK
         * provides enum values for the rate type to log the events base don specific types but
         * you can also use string values as well. Below is the function for logging rate type
         * using string.Remember to use the same strings as provided in the enums or else the
         * event will be discarded.
         */
        
        public func setRateType(type: RateType) -> Builder {
            var builder = self
            builder.type = type.rawValue
            return builder
        }
        
        public func setRateType(type: String) -> Builder {
            var builder = self
            if CoreConstants.shared.enumContains(RateType.self,name:type) {
                builder.type = type
            } else {
                ExceptionManager.throwEnumException(eventType: CoreEventType.rate.rawValue, className: String(describing: RateType.self))
            }
            return builder
        }
        
        /**
         * setSubjectId is required to set the subject Id for the item being rated. It is required
         * in all cases, if the app is rated then provide the application id
         */
        public func setSubjectId(subjectId: String) -> Builder {
            var builder = self
            builder.subjectId = subjectId
            return builder
        }
        /**
         * You can pass any type of value in setMeta. It is for developer and partners to log
         * additional information with the log that they find would be helpful for logging and
         * providing more context to the log. Default value for the meta is null.
         */
        
        
        public func setMeta(meta: Any?) -> Builder {
            var builder = self
            builder.meta = meta
            return builder
        }
        /**
         * updateImmediately is responsible for updating the values ot the backend immediately.
         * By default this is set to false or whatever the developer has set in the SDK
         * initialisation block. This differs the time for which the logs will be logged, if true,
         * the SDK will log the content instantly and if false it will wait till the end of user
         * session which is whenever the app goes into background.
         */
        
        public  func updateImmediately(updateImmediately: Bool) -> Builder {
            var builder = self
            builder.updateImmediately = updateImmediately
            return builder
        }
        
        /**
         * build will validate all of the values provided and if passes will call the track
         * function and queue the events based on it's updateImmediately value and also on the
         * user's network resources.
         */
        public func build() {
            guard let rateValue = rateValue else {
                ExceptionManager.throwIsRequiredException(eventType: CoreEventType.rate.rawValue, elementName: "Rate Value")
                return
            }
            
            guard rateValue >= 0 && rateValue <= 5 else {
                ExceptionManager.throwIllegalStateException(eventType: CoreEventType.rate.rawValue, message: "Rate Value should be 0 to 5 (both inclusive)")
                return
            }
            
            guard let type = type, !type.isEmpty else {
                ExceptionManager.throwIsRequiredException(eventType: CoreEventType.rate.rawValue, elementName: "\(RateType.self)")
                return
            }
            
            guard let subjectId = subjectId, !subjectId.isEmpty else {
                ExceptionManager.throwIsRequiredException(eventType: CoreEventType.rate.rawValue, elementName: "subject_id")
                return
            }
            
            let rateObject = RateObject(rate_value: rateValue, type: type, subject_id: subjectId, meta: meta)
            CFSetup().track(contentBlockName: contentBlock, eventType: CoreEventType.rate.rawValue, logObject: rateObject,updateImmediately: updateImmediately)
        }
    }
}
