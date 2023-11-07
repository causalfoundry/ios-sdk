//
//  CfLogQuestionEvent.swift
//
//
//  Created by khushbu on 02/11/23.
//

import Foundation
import CasualFoundryCore

public class CfLogQuestionEvent {
    
    /**
     * CfLogQuestionEvent is required to log user answers to the questions. To log this event you
     * need to provide the question Id that User has attempted and also the id for the answer the
     * user has selected.
     */
    var questionId: String?
    var examId: String?
    var action: String?
    var answerId: String?
    private var meta: Any?
    private var updateImmediately: Bool = CoreConstants.shared.updateImmediately
    
    public init() {
        
    }
    
    /**
     * setQuestionId is required to log questionId for the Question on which user has attempted.
     * Question Id should be in a string format and must be in accordance to the catalog
     * provided.
     */
    @discardableResult
   public func setQuestionId(_ questionId: String) -> CfLogQuestionEvent {
        self.questionId = questionId
        return self
    }
    
    /**
     * setExamId is required to log exam_id for the exam the Question belongs to.
     * exam_id should be in a string format and must be in accordance to the catalog
     * provided.
     */
    @discardableResult
    public func setExamId(_ examId: String) -> CfLogQuestionEvent {
        self.examId = examId
        return self
    }
    /**
     * setQuestionAction is required to set the Action type for the Question event. SDK provides
     * enum classes to support available log types. 2 main are answer and skip.
     * SDK provides 2 approaches to log this event, one being enum type and the other is
     * string type. Below is the function to log type using enum.
     */
    @discardableResult
    public func setQuestionAction(_ action: QuestionAction) -> CfLogQuestionEvent {
        self.action = action.rawValue
        return self
    }
    /**
     * setQuestionAction is required to set the Action type for the Question event. SDK provides
     * enum classes to support available log types. 2 main are answer and skip.
     * SDK provides 2 approaches to log this event, one being enum type and the other is
     * string type. Below is the function to log type using string. Remember to note that
     * values provided using string should be the same as provided in enum or else the
     * events will be discarded.
     */
    @discardableResult
    public func setQuestionAction(_ action: String?) -> CfLogQuestionEvent {
        if let action = action {
            if CoreConstants.shared.enumContains(QuestionAction.self, name: action) {
                self.action = action
            } else {
                ExceptionManager.throwEnumException(
                    eventType: ELearnEventType.question.rawValue,
                    className:String(describing:QuestionAction.self)
                )
            }
        } else {
            self.action = action
        }
        return self
    }
    /**
     * setAnswerId is required to log answerId for the answer provided by the user for
     * the Question on which user has attempted. Answer Id should be in a string format and
     * must be in accordance to the catalog provided.
     */
    @discardableResult
    public func setAnswerId(_ answerId: String?) -> CfLogQuestionEvent {
        self.answerId = answerId
        return self
    }
    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public  func setMeta(_ meta: Any?) -> CfLogQuestionEvent {
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
    @discardableResult
    public func updateImmediately(_ updateImmediately: Bool) -> CfLogQuestionEvent {
        self.updateImmediately = updateImmediately
        return self
    }
    /**
     * build will validate all of the values provided and if passes will call the track
     * function and queue the events based on it's updateImmediately value and also on the
     * user's network resources.
     */
    public func build() {
        /**
         * Will throw and exception if the questionId provided is null or no value is
         * provided at all.
         */
        guard let questionId = questionId else {
            ExceptionManager.throwIsRequiredException(eventType:ELearnEventType.question.rawValue, elementName: "question_id")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no value is
         * provided at all.
         */
        guard let action = action else {
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.question.rawValue, elementName:String(describing: QuestionAction.self))
            return 
        }
        /**
         * Will throw and exception if the examId provided is null or no value is
         * provided at all.
         */
        guard let examId = examId else {
            ExceptionManager.throwIsRequiredException(eventType:ELearnEventType.question.rawValue, elementName:"exam_id")
            return
        }
        /**
         * Will throw and exception if the answerId provided is null or no value is
         * provided at all.
         */
        if action == QuestionAction.answer.rawValue && answerId == nil {
            ExceptionManager.throwIsRequiredException(eventType:ELearnEventType.question.rawValue, elementName: "answer_id")
            return
        }
        /**
         * Parsing the values into an object and passing to the setup block to queue
         * the event based on its priority.
         */
        let questionObject = QuestionObject(
            id: questionId, exam_id: examId, action: action, answer_id: answerId, meta: meta as? Encodable
        )
        
        CFSetup().track(
            contentBlockName: ELearningConstants.contentBlockName,
            eventType: ELearnEventType.question.rawValue,
            logObject: questionObject,
            updateImmediately: updateImmediately
        )
    }
}


