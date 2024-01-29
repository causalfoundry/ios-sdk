//
//  CfLogSurveyEvent.swift
//
//
//  Created by khushbu on 07/11/23.
//
import CausalFoundrySDKCore
import Foundation

public class CfLogSurveyEvent {
    /**
     * CfLogSurveyEvent is to log the user viewing, attempting the survey.
     */

    private var actionValue: String = ""
    private var surveyObject: SurveyObject?
    private var sureveyResponseList: [SurveyResponseItem] = []
    private var meta: Any?
    private var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setAction is required to set the Action type for the Survey Action. SDK provides
     * enum classes to support available log types. 1 main is achieved.
     * SDK provides 2 approaches to log this event, one being enum type and the other is
     * string type.
     */
    @discardableResult
    public func setAction(action: SurveyAction) -> CfLogSurveyEvent {
        actionValue = action.rawValue
        return self
    }

    @discardableResult
    public func setAction(action: String) -> CfLogSurveyEvent {
        if CoreConstants.shared.enumContains(SurveyAction.self, name: action) {
            actionValue = action
        } else {
            ExceptionManager.throwEnumException(eventType: LoyaltyEventType.survey.rawValue, className: String(describing: SurveyAction.self))
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
    public func setSurveyObject(surveyObject: SurveyObject) -> CfLogSurveyEvent {
        if(LoyaltyConstants.isSurveyObjectValid(surveyObject: surveyObject, eventType: LoyaltyEventType.survey)){
            self.surveyObject = surveyObject
        }
        return self
    }

    @discardableResult
    public func setSurveyObject(surveyObject: String) -> CfLogSurveyEvent {
        if let surveuyData = surveyObject.data(using: .utf8),
           let surveyObject = try? JSONDecoder.new.decode(SurveyObject.self, from: surveuyData)
        {
            setSurveyObject(surveyObject: surveyObject)
        }
        return self
    }

    /**
     * setResponseList is for providing response item details about the survey.
     * The object should be based on the SurveyResponseItem List or a string list that can be
     * converted to the object with proper param names. in case the names are not correct
     * the SDK will throw an exception. Below is the function for providing an item as a string.
     */
    @discardableResult
    public func setResponseList(responseList: [SurveyResponseItem]) -> CfLogSurveyEvent {
        self.sureveyResponseList.removeAll()
        self.sureveyResponseList.append(contentsOf: responseList)
        return self
    }

    @discardableResult
    public func setResponseList(responseList: String) -> CfLogSurveyEvent {
        if let itemsList = try? JSONDecoder.new.decode([SurveyResponseItem].self, from: Data(responseList.utf8)) {
            setResponseList(responseList: itemsList)
        }
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developers and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for meta is nil.
     */
    @discardableResult
    public func setMeta(meta: Any?) -> CfLogSurveyEvent {
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
    public func updateImmediately(updateImmediately: Bool) -> CfLogSurveyEvent {
        self.updateImmediately = updateImmediately
        return self
    }

    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on its updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        if actionValue.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.survey.rawValue, elementName: "action_value")
        } else if surveyObject == nil {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.survey.rawValue, elementName: "survey_object")
        } else if actionValue == "submit", sureveyResponseList.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: LoyaltyEventType.survey.rawValue, elementName: "response_list")
        } else if(LoyaltyConstants.isSurveyResponseListValid(responseList: sureveyResponseList, eventType: LoyaltyEventType.survey)) {
            let surveyEventObject = SurveyEventObject(action: actionValue, survey: surveyObject!, response: sureveyResponseList, meta: meta as? Encodable)
            CFSetup().track(contentBlockName: LoyaltyConstants.contentBlockName, eventType: LoyaltyEventType.survey.rawValue, logObject: surveyEventObject, updateImmediately: updateImmediately)
        }
    }
}
