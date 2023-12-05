//
//  CfLogExamEvent.swift
//
//
//  Created by khushbu on 02/11/23.
//

import CasualFoundryCore
import Foundation

public class CfLogExamEvent {
    /**
     * CfLogExamEvent is required to log actions related to e-learning module exams. which
     * includes the related to starting, retaking, reviewing and submit the exam. BsLogExamEvent
     * also updates the user level if they achieved a milestone.
     */
    var examId: String?
    var action: String?
    var durationValue: Int?
    var scoreValue: Float?
    var isPassed: Bool?
    private var meta: Any?
    private var updateImmediately: Bool = CoreConstants.shared.updateImmediately

    public init() {}

    /**
     * setExamId is required to log examId for the Exam on which user is performing actions.
     * Exam Id should be in a string format and must be in accordance to the catalog
     * provided.
     */
    @discardableResult
    public func setExamId(_ examId: String) -> CfLogExamEvent {
        self.examId = examId
        return self
    }

    /**
     * setExamAction is required to set the Action type for the Exam event. SDK provides
     * enum classes to support available log types. 3 main are start, submit and result.
     * SDK provides 2 approaches to log this event, one being enum type and the other is
     * string type. Below is the function to log type using enum.
     */

    @discardableResult
    public func setExamAction(_ action: ExamAction) -> CfLogExamEvent {
        self.action = action.rawValue
        return self
    }

    /**
     * setExamAction is required to set the Action type for the Exam event. SDK provides
     * enum classes to support available log types. 3 main are start, submit and result.
     * SDK provides 2 approaches to log this event, one being enum type and the other is
     * string type. Below is the function to log type using string. Remember to note that
     * values provided using string should be the same as provided in enum or else the
     * events will be discarded.
     */
    @discardableResult
    public func setExamAction(_ action: String) -> CfLogExamEvent {
        if CoreConstants.shared.enumContains(ExamAction.self, name: action) {
            self.action = action
        } else {
            ExceptionManager.throwEnumException(
                eventType: ELearnEventType.exam.rawValue,
                className: String(describing: ExamAction.self)
            )
        }
        return self
    }

    /**
     * setDuration is required to log the duration (time elapsed) by the user to complete the
     * exam. Duration should be in Seconds. This is required in case of examAction been submit.
     */

    @discardableResult
    public func setDuration(_ duration: Int?) -> CfLogExamEvent {
        durationValue = duration
        return self
    }

    /**
     * setScore is required if there is some score provided ot the user in result of the
     * exam submitted. This is required in case of examAction been result.
     */
    @discardableResult
    public func setScore(_ score: Float?) -> CfLogExamEvent {
        scoreValue = score
        return self
    }

    /**
     * isPassed is required if the user passed or failed the exam. This log is required only
     * in case when examAction is result
     */

    @discardableResult
    public func isPassed(_ isPassed: Bool?) -> CfLogExamEvent {
        self.isPassed = isPassed
        return self
    }

    /**
     * You can pass any type of value in setMeta. It is for developer and partners to log
     * additional information with the log that they find would be helpful for logging and
     * providing more context to the log. Default value for the meta is null.
     */
    @discardableResult
    public func setMeta(_ meta: Any?) -> CfLogExamEvent {
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
    public func updateImmediately(_ updateImmediately: Bool) -> CfLogExamEvent {
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
         * Will throw and exception if the examId provided is null or no value is
         * provided at all.
         */
        guard let examId = examId else {
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.exam.rawValue, elementName: "exam_id")
            return
        }
        /**
         * Will throw and exception if the action provided is null or no value is
         * provided at all.
         */
        guard let action = action else {
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.exam.rawValue, elementName: String(describing: ExamAction.self))
            return
        }

        if action == ExamAction.submit.rawValue, durationValue == nil {
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.exam.rawValue, elementName: "duration_value")
            return
        } else if action == ExamAction.result.rawValue, scoreValue == nil || isPassed == nil {
            ExceptionManager.throwIsRequiredException(eventType: ELearnEventType.exam.rawValue, elementName: "score")
            return
        } else {
            /**
             * Parsing the values into an object and passing to the setup block to queue
             * the event based on its priority.
             */
            let examObject = ExamObject(id: examId, action: action, duration: durationValue, score: scoreValue, isPassed: isPassed, meta: meta as? Encodable)
            CFSetup().track(
                contentBlockName: ELearningConstants.contentBlockName,
                eventType: ELearnEventType.exam.rawValue,
                logObject: examObject,
                updateImmediately: updateImmediately
            )
        }
    }
}
