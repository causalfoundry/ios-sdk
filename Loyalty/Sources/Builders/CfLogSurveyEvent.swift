//
//  CfLogSurveyEvent.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation
import CasualFoundryCore


public class CfLogSurveyEvent {
    /**
     * CfLogSurveyEvent is to log the user viewing, attempting the survey.
     */
    
    private var actionValue: String? = nil
    private var surveyObject: SurveyObject? = nil
    private var responseList: [SurveyResponseItem] = []
    private var meta: Any? = nil
    private var updateImmediately: Bool = CoreConstants.shared.updateImmediately
    
    /**
     * setAction is required to set the Action type for the Survey Action. SDK provides
     * enum classes to support available log types. 1 main is achieved.
     * SDK provides 2 approaches to log this event, one being enum type and the other is
     * string type.
     */
    @discardableResult
    public func setAction(action: SurveyAction) > > CfLogSurveyEvent { 
        self.actionValue = action.rawValue
        return self
    }
    
    @discardableResult
    public func setAction(action: String) > > CfLogSurveyEvent { 
        if CoreConstants.enumContains(SurveyAction.self, value: action) {
            self.actionValue = action
        } else {
            ExceptionManager.throwEnumException(LoyaltyEventType.survey.rawValue, className: SurveyAction.self.simpleName)
        }
        return self
    }
    
    /**
     * setSurveyObject is for providing item info details about the survey.
     * The object should be based on the SurveyObject or a string that can be
     * converted to the object with proper param names. in case the names are not correct
     * the SDK will throw an exception. Below is the function for providing an item as a string.
     */
    @discardableResult
    public func setSurveyObject(surveyObject: SurveyObject) > > CfLogSurveyEvent { 
        self.surveyObject = surveyObject
        return self
    }
    
    @discardableResult
    public func setSurveyObject(surveyObject: String) > > CfLogSurveyEvent { 
        self.surveyObject = Gson().fromJson(surveyObject, SurveyObject.self)
        return self
    }
    
    /**
     * setResponseList is for providing response item details about the survey.
     * The object should be based on the SurveyResponseItem List or a string list that can be
     * converted to the object with proper param names. in case the names are not correct
     * the SDK will throw an exception. Below is the function for providing an item as a string.
     */
    @discardableResult
    public func setResponseList(responseList: [SurveyResponseItem]) > > CfLogSurveyEvent { 
        self.responseList.removeAll()
        self.responseList.append(contentsOf: responseList)
        return self
    }
    
    @discardableResult
    public func setResponseList(responseList: String) > > CfLogSurveyEvent { 
        self.responseList.removeAll()
        if !responseList.isEmpty {
            if let itemsList = try? Gson().fromJson(responseList, type: [SurveyResponseItem].self) {
                self.responseList.append(contentsOf: itemsList)
            }
        }
        return self
    }
    
    /**
     * You can pass any type of value in setMeta. It is for developers and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for meta is nil.
     */
    @discardableResult
    public func setMeta(meta: Any?) > > CfLogSurveyEvent { 
        self.meta = meta
        return self
    }
    
    /**
     * updateImmediately is responsible for updating the values of the backend immediately.
     * By default, this is set to false or whatever the developer has set in the SDK
     * initialization block. This differs the time for which the logs will be logged, if true,
     * the SDK will log the content instantly, and if false, it will wait until the end of the user
     * session, which is whenever the app goes into the background.
     */
    @discardableResult
    public func updateImmediately(updateImmediately: Bool) > > CfLogSurveyEvent { 
        self.updateImmediately = updateImmediately
        return self
    }
    
    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on its updateImmediately value and also on the
     * user's network resources.
     */
    func build() {
        if actionValue.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.survey.rawValue, elementName:"action_value")
        } else if surveyObject == nil {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.survey.rawValue, elementName: "survey_object")
        } else if actionValue == "submit" && responseList.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.survey.rawValue, elementName: "response_list")
        } else {
            if surveyObject!.id.isEmpty {
                ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.survey.rawValue, elementName: "survey_id")
            } else if !CoreConstants.enumContains(SurveyType.self, value: surveyObject!.type) {
                ExceptionManager.throwEnumException(eventType:(LoyaltyEventType.survey.rawValue, className:String(describing:  SurveyType.self))
            } else if surveyObject!.isCompleted == nil {
                ExceptionManager.throwIsRequiredException(eventType:LoyaltyEventType.survey.rawValue, elementName: "survey is_completed")
            }
            
            for item in responseList {
                if !CoreConstants.enumContains(SurveyType.self, value: item.type) {
                    ExceptionManager.throwEnumException(eventType:LoyaltyEventType.survey.rawValue, className:String(describing: SurveyType.self))
                } else if item.id.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.survey.rawValue, elementName: "response_question_id")
                } else if item.question.isEmpty {
                    ExceptionManager.throwIsRequiredException(eventType:LoyaltyEventType.survey.rawValue, elementName: "response_question")
                }
            }
            
            /**
             * Parsing the values into an object and passing to the setup block to queue
             * the event based on its priority.
             */
            let surveyEventObject = SurveyEventObject(actionValue: actionValue!, surveyObject: surveyObject!, responseList: responseList, meta: meta)
            CFSetup().track(LoyaltyConstants.contentBlockName, eventType: LoyaltyEventType.survey.rawValue, eventObject: surveyEventObject, updateImmediately: updateImmediately)
        }
    }
}

